﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using System.Web;
using System.IO;
using System.Reflection;
using System.Threading;
using Amazon.S3;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.YouTube.v3;
using Google.Apis.YouTube.v3.Data;
using Video = EventZone.Models.Video;

namespace EventZone.Controllers
{
    public class EventController : Controller
    {
        private readonly EventZoneEntities db = new EventZoneEntities();
        //
        // GET: /Event
        // GET: Event
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryId", "CategoryName");
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateEvent(CreateEventModel model)
        {
            if (ModelState.IsValid)
            {
                var locationName = model.LocationName;
                var lattitude = model.Lattitude;
                var longitude = model.Longitude;
                string[] locationList = Regex.Split(locationName, ";");
                string[] lattitudeList = Regex.Split(lattitude, ";");
                string[] longitudeList = Regex.Split(longitude, ";");
                var locationId = new List<double>();
                List<EventPlace> listEventPlaces = new List<EventPlace>();

                //Search for duplicated location before adding new location to database
                for (var i = 0; i < locationList.Length - 1; i++)
                {
                    double locationIdIndex = LocationHelpers.Instance.FindLocationByAllData(double.Parse(longitudeList[i]),
                        double.Parse(lattitudeList[i]),
                        locationList[i]);
                    if (
                        locationIdIndex == -1)
                    {
                        var newLocation = new Location();
                        newLocation.LocationName = locationList[i];
                        newLocation.Latitude = double.Parse(lattitudeList[i]);
                        newLocation.Longitude = double.Parse(longitudeList[i]);
                        db.Locations.Add(newLocation);
                        db.SaveChanges();
                        locationIdIndex = LocationHelpers.Instance.FindLocationByAllData(double.Parse(longitudeList[i]),
                            double.Parse(lattitudeList[i]),
                            locationList[i]);
                    }
                    locationId.Add(locationIdIndex);
                }

                //Adding new event to database
                var newEvent = new Event();
                newEvent.EventName = model.Title;
                var userChannel =
                    db.Channels.ToList().Find(c => c.UserID.Equals(long.Parse(Session["UserId"].ToString())));
                newEvent.ChannelID = userChannel.ChannelID;
                newEvent.EventStartDate = model.StartTime;
                newEvent.EventEndDate = model.EndTime;
                newEvent.EventDescription = model.Description;
                newEvent.EventRegisterDate = DateTime.Now;
                newEvent.View = 0;
                newEvent.CategoryID = model.CategoryID;
                newEvent.Privacy = model.Privacy;
                newEvent.Avatar = null;
                newEvent.EditBy = long.Parse(Session["UserId"].ToString());
                newEvent.EditTime = DateTime.Now;
                newEvent.EditContent = null;
                newEvent.Status = true;
                // insert Event to Database
                db.Events.Add(newEvent);
                db.SaveChanges();

                //Insert to Event Place
                for (var i = 0; i < locationId.Count; i++)
                {
                    var newEventPlace = new EventPlace();
                    newEventPlace.LocationID = (long)locationId[i];
                    newEventPlace.EventID = newEvent.EventID;
                    db.EventPlaces.Add(newEventPlace);
                    db.SaveChanges();
                    listEventPlaces.Add(newEventPlace);
                }

                //Add Event Rank

                EventRank newEventRank = new EventRank();
                newEventRank.EventId = newEvent.EventID;
                newEventRank.Score = 0;
                db.EventRanks.Add(newEventRank);
                db.SaveChanges();

                // Create Video if it is live event
                if (model.IsLive)
                {
                    string[] viewDataResult =
                        new EventController().Run(model.Title, model.StartTime, model.EndTime, model.Quality,
                            model.PrivacyYoutube).Result;
                    ViewData["StreamName"] = viewDataResult[0];
                    ViewData["PrimaryServerURL"] = viewDataResult[1];
                    ViewData["BackupServerURL"] = viewDataResult[2];
                    ViewData["YoutubeURL"] = viewDataResult[3];
                    var video = new Video();
                    video.StartTime = model.StartTime;
                    video.EndTime = model.EndTime;
                    video.Privacy = model.PrivacyYoutube;
                    for (int i = 0; i < locationList.Length; i++)
                    {
                        if (locationList[i].Equals(model.LocationLiveName))
                        {
                            foreach (EventPlace item in listEventPlaces)
                            {
                                if (item.LocationID ==
                                    LocationHelpers.Instance.FindLocationByAllData(double.Parse(longitudeList[i]),
                                        double.Parse(lattitudeList[i]),
                                        locationList[i]))
                                {
                                    video.EventPlaceID = item.EventPlaceID;
                                }
                            }
                        }
                    }
                    video.VideoLink = viewDataResult[3];
                    db.Videos.Add(video);
                    db.SaveChanges();
                }
                return RedirectToAction("Details", "Event", new { id = newEvent.EventID });
            }
            // If we got this far, something failed, redisplay form
            return RedirectToAction("Create", "Event");
        }

        private async Task<string[]> Run(String broadcastTitle, DateTime startTime, DateTime endTime, String quality, int privacyYoutube)
        {

            UserCredential credential = null;

            String path = Path.Combine(HttpRuntime.AppDomainAppPath, "Controllers/client_secrets_for_YoutubeAPI.json");
            using (var stream = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                credential = await GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    // This OAuth 2.0 access scope allows an application to upload files to the
                    // authenticated user's YouTube channel, but doesn't allow other types of access.
                    new[] { YouTubeService.Scope.Youtube },
                    Environment.UserName,
                    CancellationToken.None
                    );

            }

            var youtubeService = new YouTubeService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = Assembly.GetExecutingAssembly().GetName().Name
            });

            //Set Snippet
            LiveBroadcastSnippet broadcastSnippet = new LiveBroadcastSnippet();
            broadcastSnippet.Title = broadcastTitle;
            if (startTime.CompareTo(DateTime.Now) < 0)
            {
                startTime = DateTime.Now;
            }
            broadcastSnippet.ScheduledStartTime = startTime;
            broadcastSnippet.ScheduledEndTime = endTime;

            // Set the broadcast's privacy status to "private". See:
            // https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#status.privacyStatus
            LiveBroadcastStatus status = new LiveBroadcastStatus();
            if (privacyYoutube == 0)
            {
                status.PrivacyStatus = "public";
            }
            else if (privacyYoutube == 1)
            {
                status.PrivacyStatus = "unlisted";
            }
            else
            {
                status.PrivacyStatus = "private";
            }

            //Set LiveBroadcast
            LiveBroadcast broadcast = new LiveBroadcast();
            broadcast.Kind = "youtube#liveBroadcast";
            broadcast.Snippet = broadcastSnippet;
            broadcast.Status = status;
            LiveBroadcastsResource.InsertRequest liveBroadcastInsert = youtubeService.LiveBroadcasts.Insert(broadcast, "snippet,status");
            LiveBroadcast returnBroadcast = liveBroadcastInsert.Execute();

            //Set LiveStream Snippet
            LiveStreamSnippet streamSnippet = new LiveStreamSnippet();
            streamSnippet.Title = broadcastTitle + "Stream Title";
            CdnSettings cdnSettings = new CdnSettings();
            cdnSettings.Format = quality;
            cdnSettings.IngestionType = "rtmp";

            //Set LiveStream
            LiveStream streamLive = new LiveStream();
            streamLive.Kind = "youtube#liveStream";
            streamLive.Snippet = streamSnippet;
            streamLive.Cdn = cdnSettings;
            LiveStream returnLiveStream = youtubeService.LiveStreams.Insert(streamLive, "snippet,cdn").Execute();
            LiveBroadcastsResource.BindRequest liveBroadcastBind = youtubeService.LiveBroadcasts.Bind(
                returnBroadcast.Id, "id,contentDetails");
            liveBroadcastBind.StreamId = returnLiveStream.Id;
            returnBroadcast = liveBroadcastBind.Execute();
            //Return Value
            String streamName = returnLiveStream.Cdn.IngestionInfo.StreamName;
            String primaryServerUrl = returnLiveStream.Cdn.IngestionInfo.IngestionAddress;
            String backupServerUrl = returnLiveStream.Cdn.IngestionInfo.BackupIngestionAddress;
            String youtubeUrl = "https://www.youtube.com/watch?v=" + returnBroadcast.Id;
            string[] result = new string[] { streamName, primaryServerUrl, backupServerUrl, youtubeUrl };

            return result;
        }
        public ActionResult Details(long? id)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Event evt = EventDatabaseHelper.Instance.GetEventByID(id);
            if (evt == null)
            {
                return View("FailedLoadEvent");
            }
            ViewDetailEventModel viewDetail = new ViewDetailEventModel();

            viewDetail.eventId = evt.EventID;
            viewDetail.eventName = evt.EventName;
            if (viewDetail.eventAvatar != null)
            {
                viewDetail.eventAvatar = EventDatabaseHelper.Instance.GetImageByID(evt.Avatar).ImageLink;
            }
            viewDetail.eventDescription = evt.EventDescription;
            viewDetail.StartTime = evt.EventStartDate;
            viewDetail.EndTime = evt.EventEndDate;
            viewDetail.isOwningEvent = false;
            viewDetail.NumberLike = EventDatabaseHelper.Instance.CountLike(evt.EventID);
            viewDetail.NumberDisLike = EventDatabaseHelper.Instance.CountDisLike(evt.EventID);
            viewDetail.NumberFowllower = EventDatabaseHelper.Instance.CountFollowerOfEvent(evt.EventID);
            viewDetail.eventLocation = EventDatabaseHelper.Instance.GetEventLocation(evt.EventID);
            viewDetail.eventImage = EventDatabaseHelper.Instance.GetEventImage(evt.EventID);
            viewDetail.eventVideo = EventDatabaseHelper.Instance.GetEventVideo(evt.EventID);
            viewDetail.eventComment = EventDatabaseHelper.Instance.GetListComment(evt.EventID);
            viewDetail.FindLike = new LikeDislike();
            viewDetail.FindLike.Type = EventZoneConstants.NotRate;
            viewDetail.FindLike.EventID = evt.EventID;
            if (user != null)
            {
                viewDetail.isOwningEvent = EventDatabaseHelper.Instance.IsEventOwnedByUser(evt.EventID, user.UserID);
                viewDetail.FindLike = UserDatabaseHelper.Instance.FindLike(user.UserID, evt.EventID);
                if (viewDetail.FindLike == null)
                {
                    viewDetail.FindLike = new LikeDislike();
                    viewDetail.FindLike.Type = EventZoneConstants.NotRate;
                }
                viewDetail.isFollowing = UserDatabaseHelper.Instance.IsFollowingEvent(user.UserID, evt.EventID);
            }
            viewDetail.Privacy = evt.Privacy;
            if (TempData["EventDetailTask"] == null)
            {
                ViewData["EventDetailTask"] = "EventDetail";
                if (user == null || EventDatabaseHelper.Instance.GetAuthorEvent(evt.EventID).UserID != user.UserID)
                {
                    EventDatabaseHelper.Instance.AddViewEvent(evt.EventID);
                }
                return View(viewDetail);
            }
            else
            {
                ViewData["EventDetailTask"] = "EditEvent";
                return View(viewDetail);
            }
        }

        public ActionResult ImageUpload(HttpPostedFileBase file, long eventID)
        {
            
            User user= UserHelpers.GetCurrentUser(Session);
            Event evt = db.Events.Find(eventID);
        
            if (user == null) {
                TempData["ImageUploadError"] = "You have to login to do this feature";
                return RedirectToAction("Details", "Event", new { id=evt.EventID });
            }
            Image photo = new Image();
            if (file != null)
            {
                string[] whiteListedExt = { ".jpg", ".gif", ".png", ".tiff" };
                Stream stream = file.InputStream;
                string extension = Path.GetExtension(file.FileName);
                if (whiteListedExt.Contains(extension))
                {
                    string pic = Guid.NewGuid()+ eventID.ToString() + extension;
                    using (AmazonS3Client s3Client = new AmazonS3Client(Amazon.RegionEndpoint.USWest2))
                        EventZoneUtility.FileUploadToS3("eventzone", pic, stream, true, s3Client);
                    photo.EventID = eventID;
                    photo.ImageLink = "https://s3-us-west-2.amazonaws.com/eventzone/"+pic;
                    photo.UploadDate = DateTime.Today;
                    photo.UserID = UserHelpers.GetCurrentUser(Session).UserID;
                    EventDatabaseHelper.Instance.AddImage(photo);
                    TempData["ImageUploadError"] = null; // success
                }
                else
                {
                    TempData["ImageUploadError"] = "File is not supported! Please select an image file";
                }
            }
            else
            {
                TempData["ImageUploadError"] = "Your must select a file to upload";
            }
            return RedirectToAction("Details", "Event", new { id = evt.EventID });
        }
         public ActionResult Comment(int eventID, string commentContent)
        {
            List<EventZone.Models.Comment> listComment = EventDatabaseHelper.Instance.GetListComment(eventID);
            CommentViewModel comment = new CommentViewModel { eventID = eventID, listComment = listComment };
            User user = UserHelpers.GetCurrentUser(Session);
            if (user != null)
            {
                if (EventDatabaseHelper.Instance.AddCommentToEvent(eventID, user.UserID, commentContent))
                {
                    comment.listComment = EventDatabaseHelper.Instance.GetListComment(eventID);
                    return PartialView("_CommentPartial", comment);
                };
            }
            return PartialView("_CommentPartial", comment);
        }   
    
    }
}
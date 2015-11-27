﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using EventZone.Helpers;
using EventZone.Models;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.YouTube.v3;
using Google.Apis.YouTube.v3.Data;
using Channel = EventZone.Models.Channel;
using Comment = EventZone.Models.Comment;
using Video = EventZone.Models.Video;
using Amazon.S3;

namespace EventZone.Helpers
{
    /// <summary>
    ///     All functions related to User
    /// </summary>
    public class UserDatabaseHelper : SingletonBase<UserDatabaseHelper>
    {
        private readonly EventZoneEntities db;

        private UserDatabaseHelper()
        {
            db = new EventZoneEntities();
        }

        /// <summary>
        ///     Check is user exists in database or not. If yes return true, else return false.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool ValidateUser(string userName, string password)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count == 0)
            {
                return false;
                
            }
            if (user[0].UserPassword != password)
            {
                return false;
            }
            return true;
        }
        public void AddNewUser(SignUpViewModel model, User user)
        {
            user.UserEmail = model.Email;
            user.UserName = model.UserName;
            user.UserPassword = model.Password;
            user.UserDOB = model.UserDOB;
            user.UserFirstName = model.UserFirstName;
            user.DataJoin = DateTime.Today;
            if (model.UserLastName != null && model.UserLastName != "")
            {
                user.UserLastName = model.UserLastName;
            }
            user.AccountStatus = EventZoneConstants.ActiveUser; //set Active account
            if (user.Avartar == null) //set default avatar
            {
                user.Avartar = 10032;
            }
            user.UserRoles = EventZoneConstants.User; //set UserRole
            // insert user to Database
            db.Users.Add(user);
            db.SaveChanges();
        }

        /// <summary>
        ///     Check is user's status locked or not. If user's status is locked, return true else return false
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public bool isLookedUser(string userName)
        {
            
            var user = (from a in db.Users where a.UserName==userName select a).ToList()[0];
           
            if (user==null)
            {
                return false;
            }
            db.Entry(user).Reload();
            if (user.AccountStatus == EventZoneConstants.LockedUser)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        ///     Create a default channel for user when they signup first time. return true if success, else return false
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public bool CreateUserChannel(User user)
        {
            try
            {
                var channel = new Channel();
                channel.UserID = user.UserID;
                channel.ChannelName = user.UserFirstName +
                                      (user.UserLastName == "" || user.UserLastName == null
                                          ? ""
                                          : " " + user.UserLastName);
                channel.ChannelDescription = "";
                db.Channels.Add(channel);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// user change avatar
        /// </summary>
        /// <param name="imageId"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
        public bool UpdateAvatar(User user, Image image)
        {
            try {
                db.Images.Add(image);
                db.SaveChanges();
                user.Avartar = image.ImageID;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                return true;
            }catch{
                return false;
            }
        }

        /// <summary>
        ///     get all channel in DB
        /// </summary>
        /// <returns></returns>
        public List<Channel> GetAllChannel()
        {
            return db.Channels.ToList();
        }

        /// <summary>
        ///     get Channel by userID
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public Channel GetUserChannel(long userID)
        {
            var channel = new Channel();
            channel = GetAllChannel().FindAll(i => i.UserID == userID)[0];
            return channel;
        }


        /// <summary>
        /// get list following categoryID by user
        /// </summary>
        public List<long> GetListFollowingCategoryByUser (long userID){
            try
            {
                List<long> result = (from a in db.CategoryFollows where a.FollowerID == userID select a.CategoryID).ToList();
                return result;
            }
            catch {
                return null;
            }

        }
        /// <summary>
        ///     count numbers event of user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public int CountOwnedEvent(long userID, bool owner=false)
        {
            try
            {
                var k=GetUserEvent(userID, -1, owner).Count;
                return k;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        ///     get thumb list user from list user for viewing
        /// </summary>
        /// <param name="listUser"></param>
        /// <returns></returns>
        public List<ViewThumbUserModel> GetUserThumbByList(List<User> listUser)
        {
            var listView = new List<ViewThumbUserModel>();
            if (listUser == null)
            {
                return null;
            }
            foreach (var item in listUser)
            {
                
                var view = new ViewThumbUserModel();
                view.UserID = item.UserID;
                view.Avatar = item.Avartar;
                view.Name = item.UserFirstName +
                            (item.UserLastName == null || item.UserLastName == "" ? "" : item.UserLastName);
                view.NumberFollower = NumberFollower(item.UserID);
                view.NumberOwnedEvent = Instance.CountOwnedEvent(item.UserID);
                listView.Add(view);
            }
            return listView;
        }

        public Report IsReportedEvent(long userID, long eventID)
        {
            try {
                Report result = (from a in db.Reports where a.SenderID == userID && a.EventID == eventID select a).ToList()[0];
                if (result != null) {
                    return result;
                }
                   
            }
            catch { 
            }
            return null;
        }
       
        /// <summary>
        ///     Check is user following another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool IsFollowingUser(long FollowerID, long FollowingID)
        {
            var people =
                (from a in db.PeopleFollows
                 where a.FollowerUserID == FollowerID && a.FollowingUserID == FollowingID
                 select a).ToList()[0];
            if (people != null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        ///     User Follows another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool FollowingPeople(long FollowerID, long FollowingID)
        {
            try
            {
                
                var ppfollow = new PeopleFollow();
                ppfollow.FollowerUserID = FollowerID;
                ppfollow.FollowingUserID = FollowingID;
                db.PeopleFollows.Add(ppfollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public Report ReportEvent(long userID, long eventID, int reportID, string reportContent) {

            Report newReport = new Report
            {
                EventID = eventID,
                SenderID = userID,
                ReportType= reportID,
                ReportContent=reportContent,
                ReportStatus=EventZoneConstants.Pending,
                ReportDate=DateTime.Now,
            };
            try
            {
                db.Reports.Add(newReport);
                db.SaveChanges();
                return newReport;
            }
            catch {
                return null;
            }
        }
        /// <summary>
        ///     Check is user following a event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool IsFollowingEvent(long userID, long eventID)
        {
            try
            {
                var evtFollow =
                    (from a in db.EventFollows where a.FollowerID == userID && a.EventID == eventID select a).ToList()[0
                        ];
                if (evtFollow != null)
                {
                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     User follows event
        /// </summary>
        /// <param name="useID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool FollowEvent(long useID, long eventID)
        {
            try
            {
                if (IsFollowingEvent(useID, eventID))
                {
                    UnFollowEvent(useID, eventID);
                    return true;
                }
                var evtFollow = new EventFollow();
                evtFollow.EventID = eventID;
                evtFollow.FollowerID = useID;
                db.EventFollows.Add(evtFollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// user unfollow event
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="eventId"></param>
        /// <returns></returns>
        public bool UnFollowEvent(long userId, long eventId)
        {
            try
            {
                var follow =
                    (from a in db.EventFollows where a.FollowerID == userId && a.EventID == eventId select a).ToList()[0];
                db.EventFollows.Remove(follow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// get all event is created by a given user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public List<Event> GetUserEvent(long userID, int numberEvent=-1,bool isOwner=true) {
            
            List<Event> myEvent = new List<Event>();
            try { 
                long channelID= GetUserChannel(userID).ChannelID;
                
                myEvent = (from a in db.Events where a.ChannelID == channelID select a).ToList();
                if (!isOwner) {
                    myEvent.RemoveAll(o => (o.Privacy != EventZoneConstants.publicEvent) || (o.Status != EventZoneConstants.Active));
                }
                 if (numberEvent != -1) {
                    myEvent = myEvent.Take(numberEvent).ToList();
                }
            }
            catch { }
            return myEvent;
        }
        public List<Event> GetFollowingEvent(long userID)
        {
            try
            {
                List<Event> result= new List<Event>();
                List<long> listEventID = (from a in db.EventFollows where a.FollowerID == userID select a.EventID).ToList();
                if (listEventID != null)
                {
                    foreach (var eventID in listEventID) {
                        try
                        {
                            result.Add(EventDatabaseHelper.Instance.GetEventByID(eventID));
                        }
                        catch {
                            continue;
                        }
                    }
                }
                return result;

            }
            catch {
                return null;
            }
        }
        /// <summary>
        ///     Check xem user like or dislike event. Nếu chưa like hoặc dislike trả lại 0;
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public LikeDislike FindLike(long userId, long eventID)
        {
            try
            {
                var like =
                    (from a in db.LikeDislikes where a.UserID == userId && a.EventID == eventID select a).ToList()[0];
                if (like != null)
                {
                    return like;
                }
                return null;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Like event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertLike(long userID, long eventID)
        {
            try
            {
                //Check user liked this event or not		
                var findLike = FindLike(userID, eventID);
                //Check user liked this event or not		
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Like;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    db.Entry(findLike).Reload();
                    return true;
                }
                //If user dont like or dislike this event before		
                var like = new LikeDislike();
                like.Type = EventZoneConstants.Like;
                like.UserID = userID;
                like.EventID = eventID;
                db.LikeDislikes.Add(like);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     dislike event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertDislike(long userID, long eventID)
        {
            try
            {
                //Check user liked this event or not		
                var findLike = FindLike(userID, eventID);
                //Check user liked this event or not		
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Dislike;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    db.Entry(findLike).Reload();
                    return true;
                }
                //If user dont like or dislike this event before		
                var like = new LikeDislike();
                like.Type = EventZoneConstants.Dislike;
                like.UserID = userID;
                like.EventID = eventID;
                db.LikeDislikes.Add(like);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     count number follower of user
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public int NumberFollower(long UserID)
        {
            try
            {
                var k = (from a in db.PeopleFollows where a.FollowingUserID == UserID select a).Count();
                return k;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        ///     Check is user following a category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool IsFollowingCategory(long userID, long categoryID)
        {
            try
            {
                var carFollow =
                    (from a in db.CategoryFollows where a.FollowerID == userID && a.CategoryID == categoryID select a).ToList()[0];
                if (carFollow != null)
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        /// <summary>
        ///    Follow category if user doest now follow it, unfollow category if user is following this category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool FollowCategory(long userID, long categoryID)
        {
            try
            {
                var catFollow = new CategoryFollow();
                if (IsFollowingCategory(userID, categoryID))
                {
                    catFollow = (from a in db.CategoryFollows where a.CategoryID == categoryID && a.FollowerID == userID select a).ToList()[0];
                    db.CategoryFollows.Remove(catFollow);
                    db.SaveChanges();
                    return true;
                }
                catFollow.FollowerID = userID;
                catFollow.CategoryID = categoryID;
                db.CategoryFollows.Add(catFollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     find user by email, return null if not found
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public User GetUserByEmail(string email)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserEmail == email);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }

        /// <summary>
        ///     get user by user name, return null if not found
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public User GetUserByUserName(string userName)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }
        /// <summary>
        /// get user by account information
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public User GetUserByAccount(string userName, string password) {
            User result = null;
            try
            {
                result = (from a in db.Users where a.UserName == userName && a.UserPassword == password select a).ToList()[0];  
            }
            catch { }
            return result;
        }
        /// <summary>
        ///     Get user by userId, return null if not found
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public User GetUserByID(long? userID)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserID == userID);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }
        /// <summary>
        /// Get All user in database
        /// </summary>
        /// <returns></returns>
        public List<User> GetAllUser(){
            List<User> result = null;
            try {
                EventZoneEntities db = new EventZoneEntities();
                result = (from a in db.Users select a).ToList();
            }
            catch { }
            return result;
        }
        /// <summary>
        ///     Update User to database
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public bool UpdateUser(User user)
        {
            try
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     Change user password
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool ResetPassword(string email, string password)
        {
            var user = GetUserByEmail(email);
            if (user != null)
            {
                user.UserPassword = password;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                return true;
            }
            return false;
        }

        /// <summary>
        ///     Search user By keyword
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<User> SearchUserByKeyword(string keyword)
        {
            var listResult = new List<User>();
            if (keyword == "" || keyword == null)
            {
                listResult = db.Users.ToList();
                return listResult;
            }
            keyword = keyword.ToLower();
            var retrievedResult = (from x in db.Users
                                   where x.UserFirstName.ToLower().Contains(keyword) || x.UserLastName.ToLower().Contains(keyword)
                                   select x).ToList();
            return retrievedResult;
        }
        public bool ChangePassword(User user, string password) {
            try
            {
                user.UserPassword = password;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                return true;
            }
            catch {
                return false;
            }
        }
        public string GetUserDisplayName(long UserID) {
            string result = "";
            try {
                User user = GetUserByID(UserID);
                result = user.UserFirstName + " "+(string.IsNullOrEmpty(user.UserLastName) ? "" : user.UserLastName);
            }
            catch
            {
            }
            return result;
        }

        public User ReloadUser(User user)
        {
            db.Entry(user).Reload();
            return user;
        }
        /// <summary>
        /// get all following of an user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public List<User> GetListFollowingOfUser(long userID)
        {
            try{
            List<User> result= (from a in db.Users join b in db.PeopleFollows on a.UserID equals b.FollowingUserID where b.FollowerUserID==userID select a).ToList();
            return result;
            }catch{}
            return null;
        }
        /// <summary>
        /// get list follower of an user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public List<User> GetListFollowerOfUser(long userID)
        {
            try
            {
                List<User> result = (from a in db.Users join b in db.PeopleFollows on a.UserID equals b.FollowerUserID where b.FollowingUserID == userID select a).ToList();
                return result;
            }
            catch { }
            return null;
        }
    }

    /// <summary>
    ///     All function related to Event
    /// </summary>
    public class EventDatabaseHelper : SingletonBase<EventDatabaseHelper>
    {
        private readonly EventZoneEntities db;

        private EventDatabaseHelper()
        {
            db = new EventZoneEntities();
        }

        public List<Event> GetAllEvent() {
            List<Event> result = new List<Event>();
            try {
                EventZoneEntities db = new EventZoneEntities();
                result = (from a in db.Events select a).ToList();
            }
            catch { }
            return result;
        }
        /// <summary>
        ///     get all event of an user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public List<Event> GetEventsByUser(long? userID)
        {
            var listChannel = db.Channels.ToList();
            if (listChannel.FindAll(i => i.UserID == userID).Count == 0)
            {
                return null;
            }
            var mychannel = listChannel.FindAll(i => i.UserID == userID)[0];
            var listEvent = db.Events.ToList();
            var myEvent = listEvent.FindAll(i => i.ChannelID == mychannel.ChannelID);
            return myEvent;
        }

        /// <summary>
        ///     get all locations of an event
        /// </summary>
        public List<Location> GetEventLocation(long EventID)
        {
            var listEventPlace = db.EventPlaces.ToList(); //load all event place
            var listEventLocation = listEventPlace.FindAll(i => i.EventID == EventID);
            //select current event places
            var listLocation = db.Locations.ToList();
            var result = new List<Location>();
            foreach (var item in listEventLocation)
            {
                var loc = listLocation.FindAll(i => i.LocationID == item.LocationID)[0];
                result.Add(loc);
            }
            return result;
        }

        /// <summary>
        ///     Get event by eventID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Event GetEventByID(long? id)
        {
            try
            {
                Event evt = db.Events.Find(id);
                db.Entry(evt).Reload();
                return evt;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Inscrease number view of event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool AddViewEvent(long eventID)
        {
            
            var evt = Instance.GetEventByID(eventID);
            if (evt != null)
            {
                evt.View += 1;
                db.Entry(evt).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(evt).Reload();                  
                return true;
            }
            return false;
        }

        /// <summary>
        ///     Get all image of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<Image> GetEventImage(long? id)
        {
            try
            {
                List<EventImage> eventImage = (from a in db.EventImages where a.EventID == id select a).ToList();
                if (eventImage != null) {
                    var listImage = new List<Image>();
                        foreach (var item in eventImage) {
                            listImage.Add(GetImageByID(item.ImageID));
                        }
                        
                return listImage;
                    
                    
                }
            }
            catch {
                return null;
            }
            
            
           
            
            return null;
        }

        /// <summary>
        ///     Get all video of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns> </returns>
        public List<Video> GetEventVideo(long? id)
        {
            var eventVideo = new List<Video>();

            List<EventPlace> listEventPlace = (from a in db.EventPlaces where a.EventID == id select a).ToList();

            if (listEventPlace.Count != 0) { 
                foreach(var item in listEventPlace){
                    List<Video> video = (from a in db.Videos where a.EventPlaceID == item.EventPlaceID select a).ToList();
                    eventVideo.AddRange(video);
                }
            }
            eventVideo = eventVideo.Distinct().ToList();
            return eventVideo;
        }
        /// <summary>
        ///     Get all comment of an event
        /// </summary>
        /// <returns></returns>
        public List<Comment> GetEventComment(long? id)
        {
            var eventComment = new List<Comment>();
            var allComment = db.Comments.ToList();

            if (allComment.Count != 0)
            {
                eventComment = allComment.FindAll(i => i.EventID == id);
                return eventComment;
            }

            return null;
        }

        ///
        /// 
        public String GetEventCategory(long? id)
        {
             try
            {
                 Event evt= db.Events.Find(id);
                 Category category= (from a in db.Categories where a.CategoryID==evt.CategoryID select a).ToList()[0];
                 return category.CategoryName;
            }
            catch
            {
                return null;
            }
        }
        /// <summary>
        ///     Lay thong tin nguoi dang event
        /// </summary>
        /// <param name="eventId"></param>
        /// <returns></returns>
        public User GetAuthorEvent(long? eventId)
        {
            var evt = db.Events.Find(eventId);
            var listChannel = db.Channels.ToList(); // retrieve all Channel fromm table Channel
            var authorChannel = listChannel.FindAll(i => i.ChannelID == evt.ChannelID)[0];
            if (evt != null)
            {
                var listUser = db.Users.ToList(); //retrieve all user from table user
                var user = listUser.FindAll(i => i.UserID == authorChannel.UserID)[0];
                if (user != null) return user;
                return null;
            }
            return null;
        }
        /// <summary>
        /// get event place by eventPlaceID
        /// </summary>
        /// <param name="eventPlaceID"></param>
        /// <returns></returns>
        public EventPlace GetEventPlaceByID(long eventPlaceID)
        {
            EventPlace result = new EventPlace();
            try {
                result = db.EventPlaces.Find(eventPlaceID);
                
            }
            catch { }
            return result;

        }
        //Check is event owned by user or not
        public bool IsEventOwnedByUser(long eventID, long UserID)
        {
            try
            {
                var channel = UserDatabaseHelper.Instance.GetUserChannel(UserID);
                if (channel != null)
                {
                    var evt = db.Events.Find(eventID);
                    if (channel.ChannelID == evt.ChannelID) return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// count number of unique user comment on event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountUniqueUserComment(long eventID) {
            int count = 0;
            try
            {
                count = (from a in db.Comments where a.EventID == eventID select a.UserID).Distinct().ToList().Count();
            }
            catch { 
            }
            return count;
        }
        /// <summary>
        /// calculate event score to rank it, each view will be calculate as 1 point, like(or dislike) = 2 , unique user comment = 3 point, follow = 4 point.
        /// </summary>
        /// <param name="eventId"></param>
        /// <returns></returns>
        public long CalculateEventScore(long eventId) {
            long score = 0;
            try {
                score = GetEventByID(eventId).View * 4 + (CountDisLike(eventId) + CountLike(eventId))*20 + CountUniqueUserComment(eventId) * 30 + CountFollowerOfEvent(eventId) * 40;
            }
            catch
            {
            }
            return score;
        }

        /// <summary>
        ///     trả lại event có tên, địa điểm hoặc description trùng với keyword, keyword = null thi tra lai toan bo event
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchEventByKeyword(string keyword)
        {
            if (keyword == "" || keyword == null)
            {
                return db.Events.ToList();
            }
            keyword = keyword.ToLower();
            var listResult = new List<Event>();
            var retrievedResult = (from x in db.Events
                                   where x.EventName.ToLower().Contains(keyword) || x.EventDescription.ToLower().Contains(keyword)
                                   select x).ToList();
            return retrievedResult;
        }
        /// <summary>
        /// check is live streaming video or not?
        /// </summary>
        /// <param name="video"></param>
        /// <returns></returns>
        public bool IsLiveVideo(Video video) {
            try
            {
                DateTime currentTime = DateTime.Now;
                var start = video.StartTime;
                var end = video.EndTime;
                if (end != null && start.CompareTo(currentTime) <= 0 && currentTime.CompareTo(end) < 0)
                {
                    return true;
                }
            }
            catch { }
            return false;
        }
        /// <summary>
        /// get list event Place by event ID
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public List<EventPlace> GetEventPlaceByEvent(long eventID){
            List<EventPlace> result = new List<EventPlace>();
            try
            {
                result = (from a in db.EventPlaces where a.EventID == eventID select a).ToList();
            }
            catch { 

            }
            return result;
        }
        /// <summary>
        /// get all reported event
        /// </summary>
        /// <returns></returns>
        public List<Event> GetAllReportedEvent() {
            try {
                List<Event> result = (from evt in db.Events join report in db.Reports on evt.EventID equals report.EventID select evt).Distinct().ToList();
                return result;
            }
            catch { 
            
            }
            return null;
        }

        /// <summary>
        /// get list report of event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public List<Report> GetListReportOfEvent(long eventID) {

            try {
                List<Report> result = (from a in db.Reports where a.EventID == eventID select a).OrderByDescending(m => m.ReportDate).ToList();
                return result;
            }
            catch { 
            
            }
            return null;
        }
        /// <summary>
        /// add Video to DB
        /// </summary>
        /// <param name="video"></param>
        /// <returns></returns>
        public bool AddVideo(Video video) {
            try
            {
                db.Videos.Add(video);
                db.SaveChanges();
                return true;
            }
            catch { 
            
            }
            return false; 
        }
        
        /// <summary>
        /// Get List Live streaming video in list video
        /// </summary>
        /// <returns></returns>
        public List<Video> GetListLiveVideo(List<Video> listVideo) {
            List<Video> result = new List<Video>();
            try
            {
                foreach (var video in listVideo)
                {
                    if (IsLiveVideo(video)) result.Add(video);
                }
            }
            catch { }
            result = result.Distinct().ToList();
            return result;

        }
        /// <summary>
        ///     trả lại live event
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchLiveStreamByKeyword(string keyword)
        {
            var listEvent = SearchEventByKeyword(keyword);
            var currentStream = new List<Event>();
            foreach (var item in listEvent)
            {
                if (isLive(item.EventID))
                {
                    currentStream.Add(item);
                }
            }
            return currentStream;
        }

        /// <summary>
        ///     Check does event Live or not
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool isLive(long? eventID)
        {
            var listEventPlace = db.EventPlaces.ToList(); //load all eventPlace
            var myEvenPlace = listEventPlace.FindAll(i => i.EventID == eventID);
            // load event place of this event
            var video = db.Videos.ToList();
            foreach (var item in myEvenPlace)
            {
                var videoInPlace = video.FindAll(i => i.EventPlaceID == item.EventPlaceID).ToList();
                var currTime = DateTime.Now;
                foreach (var item1 in videoInPlace)
                {
                    var start = item1.StartTime;
                    var end = item1.EndTime;
                    if (end != null && start.CompareTo(currTime) <= 0 && currTime.CompareTo(end) < 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        /// <summary>
        /// Get Thumb Event List By List Event
        /// </summary>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<ViewThumbEventModel> GetThumbEventListByListEvent(List<Event> listEvent)
        {
            var listThumbEvent = new List<ViewThumbEventModel>();
            if (listEvent == null) return listThumbEvent;
            try
            {
                foreach (var item in listEvent)
                {
                    ViewThumbEventModel thumbEventModel = new ViewThumbEventModel();
                    thumbEventModel.evt = item;
                    thumbEventModel.numberLike = EventDatabaseHelper.Instance.CountLike(item.EventID);
                    thumbEventModel.numberDislike = EventDatabaseHelper.Instance.CountDisLike(item.EventID);
                    thumbEventModel.numberFollow = EventDatabaseHelper.Instance.CountFollowerOfEvent(item.EventID);
                    thumbEventModel.location = EventDatabaseHelper.Instance.GetEventLocation(item.EventID);
                    listThumbEvent.Add(thumbEventModel);
                }
            }
            catch { 
            
            }
            return listThumbEvent;
        }
        /// <summary>
        /// get all reports of an event
        /// </summary>
        /// <returns></returns>
        public List<Report> GetEventReport(long eventID) {
            List<Report> result = new List<Report>();
            try {
                result = (from a in db.Reports where a.EventID == eventID select a).ToList();
                foreach (var item in result) {
                    db.Entry(item).Reload();
                }
            }
            catch { }
            return result;
        }

        /// <summary>
        ///     get Image by ID
        /// </summary>
        /// <param name="imageID"></param>
        /// <returns></returns>
        public Image GetImageByID(long? imageID)
        {   
            return db.Images.Find(imageID);
        }
        /// <summary>
        /// Search all event by CategoryID
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public List<Event> SearchEventByCategoryID(long categoryID)
        {
            List<Event> listEvent = new List<Event>();
            try {
                listEvent = (from a in db.Events where a.CategoryID == categoryID select a).ToList();
            }
            catch { 
            }
            return listEvent;

        }


        /// <summary>
        /// add image to event
        /// </summary>
        /// <param name="image"></param>
        /// <param name="evtID"></param>
        /// <returns></returns>
        public bool AddImageToEvent(Image image, long evtID) {
            try
            {
                db.Images.Add(image);
                db.SaveChanges();
                EventImage evtImage = new EventImage { EventID=evtID,ImageID=image.ImageID};
                db.EventImages.Add(evtImage);
                db.SaveChanges();
                return true;
                
            }
            catch {
                return false;
            }
        }


        /// <summary>
        ///     Lọc event theo nhóm category từ list event
        /// </summary>
        /// <param name="listEvent"></param>
        /// <param name="listCategory"></param>
        /// <returns></returns>
        public List<Event> SearchByListCategory(List<Event> listEvent, long[] listCategory)
        {
            if (listCategory.Length == 0)
            {
                return listEvent;
            }
            if (listEvent.Count == 0)
            {
                return null;
            }

            var result = new List<Event>();
            for (var i = 0; i < listCategory.Length; i++)
            {
                var item = listEvent.FindAll(m => m.CategoryID == listCategory[i]);
                foreach (var evt in item)
                {
                    result.Add(evt);
                }
            }
            return result;
        }

        /// <summary>
        /// Get list new event
        /// </summary>
        /// <returns></returns>
        public List<Event> GetListNewEvent() { 
            List<Event> result= new List<Event>();
            try
            {
                 DateTime floorDateTime = DateTime.Today.Date - TimeSpan.FromDays(7);
                 result = (from a in db.Events where a.EventRegisterDate >= floorDateTime select a).ToList();
                 result = result.OrderByDescending(o => o.EventRegisterDate).ToList();
            }
            catch { }
            return result;
        }
        /// <summary>
        /// get list new event by User (result is all new event which that user is following by category)
        /// </summary>
        /// <returns></returns>
        public List<Event> GetListNewEventByUser (long userID){
            List<Event> result = new List<Event>();
            List<Event> newEvent = GetListNewEvent();
            try
            {
                long[] listCategoryID = UserDatabaseHelper.Instance.GetListFollowingCategoryByUser(userID).ToArray();
                result = SearchByListCategory(newEvent, listCategoryID);
            }
            catch { 
            }
            result = result.OrderByDescending(o => o.EventRegisterDate).ToList();
            if (result.Count < 5)
            {
                result.AddRange(newEvent.Take(5).ToList());
            }
            result=result.Distinct().ToList();
            return result;
        }
        public List<ThumbEventHomePage> GetThumbEventHomepage(List<Event> ListEvent)
        {
            List<ThumbEventHomePage> listThumb = new List<ThumbEventHomePage>();
            if (ListEvent == null) {
                return null;
            }
            foreach (var item in ListEvent) {
                ThumbEventHomePage thumbevt = new ThumbEventHomePage();
                thumbevt.EventID = item.EventID;
                thumbevt.EventName = item.EventName; 
                thumbevt.avatar = GetImageByID(item.Avatar).ImageLink;
                thumbevt.StartDate = item.EventStartDate;
                if (item.EventEndDate != null) {
                    thumbevt.EndDate = item.EventEndDate;
                }
                thumbevt.listLocation = EventDatabaseHelper.Instance.GetEventLocation(item.EventID);
                listThumb.Add(thumbevt);
            }
            return listThumb;

        }
        /// <summary>
        /// Select public and avaiable event(avaiable is event not locked)
        /// </summary>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        /// 
        public List<Event> RemoveLockedEventInList(List<Event> listEvent)
        {
            try
            {
                List<Event> result = new List<Event>();
                listEvent.RemoveAll(o => (o.Privacy != EventZoneConstants.publicEvent) || (o.Status != EventZoneConstants.Active));
                result = listEvent;
                return result;
            }
            catch {
                return listEvent;
            }
        }
        /// <summary>
        /// Take 50 hotest event
        /// </summary>
        /// <returns></returns>
        public List<Event> GetHotEvent() {
            List<Event> result = new List<Event>();
            try {
                List<long> listEventID;
                db.EventRanks.Load();
                listEventID = (from a in db.EventRanks orderby a.Score descending select a.EventId).Take(50).ToList();
                foreach (var item in listEventID) {
                    Event evt = db.Events.Find(item);
                    if (evt != null) {
                        db.Entry(evt).Reload();
                        result.Add(evt);
                    }
                }
                return result;
            }
            catch {
                result = (from a in db.Events select a).Take(50).ToList();
                return result;
            }
            
        }
        /// <summary>
        ///     dem so like cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountLike(long eventID)
        {
            try
            {
                var countLike =
                    (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Like select a)
                        .Count();
                return countLike;
            }
            catch { return 0;}
        }

        /// <summary>
        ///     dem so dislike cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountDisLike(long eventID)
        {
            try
            {
                var disLike =
                    (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Dislike select a)
                        .Count();
                return disLike;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        ///     Count number followers of an event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountFollowerOfEvent(long eventID)
        {
            try
            {
                var NumberFollower = (from a in db.EventFollows where a.EventID == eventID select a).ToList().Count;
                return NumberFollower;
            }
            catch {
                return 0;
            }
           
        }

        /// <summary>
        ///     Tim kiem Su kien xung quanh 1 dia diem, default ban kinh = 20km
        /// </summary>
        /// <param name="location"></param>
        /// <param name="distance"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventAroundLocation(Location seachlocation, double distance = 20,
            List<Event> listEvent = null)
        {
            if (listEvent == null)
            {
                return null;
            }
            var result = new List<Event>();
            foreach (var item in listEvent)
            {
                var eventLocation = Instance.GetEventLocation(item.EventID);
                foreach (var location in eventLocation)
                {
                    if (LocationHelpers.Instance.CalculateDistance(location, seachlocation) <= distance)
                    {
                        if (!result.Contains(item))
                            result.Add(item);
                    }
                }
            }
            return result;
        }
        public List<Event> GetLiveEventByListEvent(List<Event> listEvent) {
            List<Event> result= new List<Event>();
            if (listEvent != null) { 
                foreach(var item in listEvent){
                    if (isLive(item.EventID)) {
                        result.Add(item);
                    }  
                }
            }
            return result;
        
        }
        /// <summary>
        /// add comment to event
        /// </summary>
        /// <param name="eventID"></param>
        /// <param name="userID"></param>
        /// <param name="commentContent"></param>
        /// <returns></returns>
        public Comment AddCommentToEvent(long eventID, long userID, string commentContent)
        {

            Comment comment = new Comment();
            comment.EventID = eventID;
            comment.UserID = userID;
            comment.CommentContent = commentContent;
            comment.DateIssue = DateTime.Now;
            try
            {
                db.Comments.Add(comment);
                db.SaveChanges();
                return comment;
            }
            catch { return null; }
        }

        /// <summary>
        ///     get list comment of event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public List<Comment> GetListComment(long eventID)
        {
            try
            {
                var listComment = (from a in db.Comments where a.EventID == eventID select a).ToList();
                return listComment;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     get event in date range from event list
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventInDateRange(DateTime startDate, DateTime endDate, List<Event> listEvent = null)
        {
            if (listEvent == null)
            {
                return null;
            }
            var result = new List<Event>();
            DateTime today = DateTime.Now;
            foreach (var item in listEvent)
            {
                if (item.EventStartDate.CompareTo(startDate) >= 0 && item.EventEndDate.CompareTo(endDate) <= 0)
                    result.Add(item);
            }

            return result;
        }
        /// <summary>
        /// Upload image to amazone
        /// </summary>
        /// <param name="file"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
        public Image UserAddImage(HttpPostedFileBase file, long userID)
        {
            User user = db.Users.Find(userID);
            if (user == null)
            {
                return null;
            }
            else {
                Image photo = new Image();
                try
                {
                    if (file != null)
                    {
                        string[] whiteListedExt = { ".jpg", ".gif", ".png", ".tiff" };
                        Stream stream = file.InputStream;
                        string extension = Path.GetExtension(file.FileName);
                        if (whiteListedExt.Contains(extension))
                        {
                            string pic = Guid.NewGuid() + user.UserID.ToString() + extension;
                            using (AmazonS3Client s3Client = new AmazonS3Client(Amazon.RegionEndpoint.USWest2))
                                EventZoneUtility.FileUploadToS3("eventzone", pic, stream, true, s3Client);
                            Image image = new Image();
                            image.ImageLink = "https://s3-us-west-2.amazonaws.com/eventzone/" + pic;
                            image.UserID = user.UserID;
                            image.UploadDate = DateTime.Today;
                            try
                            {
                                db.Images.Add(image);
                                db.SaveChanges();
                                return image;
                            }
                            catch {
                            }
                        } 
                    }
                }
                catch
                {
                }
            }
            return null;
        }
        /// <summary>
        /// add new event to database
        /// </summary>
        /// <param name="model"></param>
        /// <param name="userid"></param>
        /// <returns></returns>
        public Event AddNewEvent(CreateEventModel model, HttpPostedFileBase file,long userid)
        {
            var newEvent = new Event();
            newEvent.EventName = model.Title;
            var userChannel =
            db.Channels.ToList().Find(c => c.UserID==userid);
            newEvent.ChannelID = userChannel.ChannelID;
            newEvent.EventStartDate = model.StartTime;
            newEvent.EventEndDate = model.EndTime;
            newEvent.EventDescription = model.Description;
            newEvent.EventRegisterDate = DateTime.Now;
            newEvent.View = 0;
            newEvent.CategoryID = model.CategoryID;
            newEvent.Privacy = model.Privacy;
                newEvent.Avatar = CommonDataHelpers.Instance.GetCategoryById(model.CategoryID).CategoryAvatar;
                Image newImage = UserAddImage(file,userid);
                if (newImage != null) newEvent.Avatar = newImage.ImageID;
            newEvent.EditBy = userid;
            newEvent.EditTime = DateTime.Now;
            newEvent.EditContent = null;
            newEvent.Status = EventZoneConstants.Active; 
            // insert Event to Database
            try
            {
                db.Events.Add(newEvent);
                db.SaveChanges();
                EventRank eventRank = new EventRank { EventId = newEvent.EventID, Score = 0 };
                db.EventRanks.Add(eventRank);
                db.SaveChanges();
            }
            catch {
                return null;
            }
            return newEvent;
        }


        public List<EventPlace> AddEventPlace(List<Location> listLocation, Event newEvent)
        {
            List<EventPlace> listEventPlaces = new List<EventPlace>();
            for (var i = 0; i < listLocation.Count; i++)
            {
                var newEventPlace = new EventPlace();
                newEventPlace.LocationID = listLocation[i].LocationID;
                newEventPlace.EventID = newEvent.EventID;
                db.EventPlaces.Add(newEventPlace);
                db.SaveChanges();
                listEventPlaces.Add(newEventPlace);
            }
            return listEventPlaces;
        }
    }

    /// <summary>
    ///     All function related to Location
    /// </summary>
    public class LocationHelpers : SingletonBase<LocationHelpers>
    {
        private readonly EventZoneEntities db;

        private LocationHelpers()
        {
            db = new EventZoneEntities();
        }
        /// <summary>
        ///     get all location in db
        /// </summary>
        /// <returns></returns>
        public List<Location> GetAllLocation()
        {
            return db.Locations.ToList();
        }
        /// <summary>
        /// add new Location from location list. If there is location in database dont add it
        /// </summary>
        /// <param name="locationList"></param>
        /// <returns></returns>
        /// 
        public Location GetLocationByEventPlaceID(long eventPlaceID) {
            try
            {
                Location result = new Location();
                EventPlace evtPlace = db.EventPlaces.Find(eventPlaceID);
                if (evtPlace != null)
                {
                    result = db.Locations.Find(evtPlace.LocationID);
                    
                }
                return result;
            }
            catch {
                return null;
            }
        }
        public List<Location> AddNewLocation(List<Location> locationList )
        {
            var Location = new List<Location>();
            //Search for duplicated location before adding new location to database
            for (var i = 0; i < locationList.Count; i++)
            {
                Location tmpLocation = locationList[i];
                long locationIdIndex =LocationHelpers.Instance.FindLocationByAllData(tmpLocation.Longitude,
                                        tmpLocation.Latitude,
                                        tmpLocation.LocationName);
                if (locationIdIndex == -1)
                {
                    Location newLocation = new Location();
                    newLocation.LocationName = tmpLocation.LocationName;
                    newLocation.Latitude = tmpLocation.Latitude;
                    newLocation.Longitude = tmpLocation.Longitude;
                    db.Locations.Add(newLocation);
                    db.SaveChanges();
                    locationIdIndex = LocationHelpers.Instance.FindLocationByAllData(tmpLocation.Longitude,
                        tmpLocation.Latitude,
                        tmpLocation.LocationName);
                }
                Location.Add(GetLocationById(locationIdIndex));
            }
            return Location;
        }
    
        /// <summary>
        ///     get Location by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Location GetLocationById(long id)
        {
            try
            {
                Location loc = db.Locations.Find(id);
                return loc;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Find Location by longtitude, latitude and Location name
        /// </summary>
        /// <param name="longitude"></param>
        /// <param name="latitude"></param>
        /// <param name="locationName"></param>
        /// <returns></returns>
        public long FindLocationByAllData(double longitude, double latitude, string locationName)
        {
            var listLocation = (from a in db.Locations
                                where
                                    a.Latitude.Equals(latitude) && a.Longitude.Equals(longitude) && a.LocationName.Equals(locationName)
                                select a).ToList();
            if (listLocation.Count == 0)
                return -1;
            return listLocation[0].LocationID;
        }

        /// <summary>
        ///     Tinh khoang cach giua 2 location
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public double CalculateDistance(Location p1, Location p2)
        {
            // using formula in http://www.movable-type.co.uk/scripts/latlong.html
            double R = 6371; // distance of the earth in km
            var dLatitude = Radians(p1.Latitude - p2.Latitude); // different in Rad of latitude
            var dLongitude = Radians(p1.Longitude - p2.Longitude); // different in Rad of longitude

            var a = Math.Sin(dLatitude / 2) * Math.Sin(dLatitude / 2) +
                    Math.Cos(Radians(p1.Latitude)) * Math.Cos(Radians(p2.Latitude))
                    * Math.Sin(dLongitude / 2) * Math.Sin(dLongitude / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1.0 - a));
            return R * c;
        }

        private double Radians(double x)
        {
            return x * Math.PI / 180.0;
        }

        public List<EventPlace> GetAllEventPlace()
        {
            List<EventPlace> listeventPlace = db.EventPlaces.ToList();
            return listeventPlace;
        }


    }

    public class CommonDataHelpers : SingletonBase<CommonDataHelpers>
    {
        private readonly EventZoneEntities db;

        private CommonDataHelpers()
        {
            db = new EventZoneEntities();
        }
        /// <summary>
        /// get all category in database
        /// </summary>
        /// <returns></returns>
        public List<Category> GetAllCategory()
        {
            try
            {
                List<Category> listCate = db.Categories.ToList();
                return listCate;
            }
            catch { }
            return null;
        }
        public List<ReportDefine> GetAllReportType() {
            try
            {
                List<ReportDefine> listReport = db.ReportDefines.ToList();
                return listReport;
            }
            catch {
                return null;
            }

        }

        /// <summary>
        /// get category by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Category GetCategoryById(long id) {
            try
            {
                Category cate = db.Categories.Find(id);
                return cate;
            }
            catch { }
            return null;
        }
        /// <summary>
        /// count new event by category(new event is event that be defined as event is created in recent 7 days)
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public int CountNewEventByCategory(long categoryID)
        {
            int count = 0;
            DateTime floorDateTime = DateTime.Today.Date - TimeSpan.FromDays(7);
            count = (from a in db.Events where a.CategoryID == categoryID && (floorDateTime <= a.EventRegisterDate) select a).Count();
            return count;
        }
        /// <summary>
        ///  count live event by category(which event has streaming)
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public int CountLiveEventByCategory(long categoryID)
        {
            int count = 0;
            var listEvent = (from a in db.Events where a.CategoryID == categoryID select a).ToList();
            try
            {
                foreach (var item in listEvent)
                {
                    if (EventDatabaseHelper.Instance.isLive(item.EventID))
                    {
                        count = count + 1;
                    }
                }
            }
            catch (Exception)
            {
                return count;
            }
            return count;
        }

        public int CountFollowerByCategory(long categoryID)
        {
            var numberFollower = (from a in db.CategoryFollows where a.CategoryID == categoryID select a).ToList().Count;
            return numberFollower;
        }

        public List<Video> GetVideoInLocation(List<Video> listVideo, Location location) {
            List<Video> result = new List<Video>();
            try {
                List<EventPlace> listEventPlace = new List<EventPlace>();
                foreach (var video in listVideo) {
                    var eventPlace = (from a in db.EventPlaces where a.EventPlaceID == video.EventPlaceID select a).ToList()[0];
                    if (eventPlace != null) {
                        listEventPlace.Add(eventPlace);
                    }
                }
                foreach (var item in listEventPlace) {
                    if (item.LocationID == location.LocationID) {
                        foreach (var video in listVideo) {
                            if (video.EventPlaceID == item.EventPlaceID) {
                                result.Add(video);
                            }
                        } 
                    }
                }
            }
            catch { }
            result=result.Distinct().ToList();
            return result;
        }
        public int CountNumberReport() {
            int result = 0;
            try {
                result = (from a in db.Reports select a).ToList().Count;
            }
            catch {
            } 
            return result;
        }
        public int CountUnHandleReport()
        {
            int result = 0;
            try
            {
                result = (from a in db.Reports where a.ReportStatus == EventZoneConstants.Pending select a).ToList().Count();
            }
            catch { 
            }
            return result;
        }

        public List<Report> GetAllReport()
        {
            try {
                List<Report> result = db.Reports.OrderByDescending(model=>model.ReportDate).ToList();
                return result;
            }
            catch { }
            return null;
        }
    }
    public class AdminDataHelpers : SingletonBase<AdminDataHelpers> { 
        private static EventZoneEntities db;
        /// <summary>
        /// constructor
        /// </summary>
        private AdminDataHelpers()
        {
            db = new EventZoneEntities();
        }
        public User FindAdmin(string userName, string password) {
            User admin = UserDatabaseHelper.Instance.GetUserByAccount(userName,password);
            if (admin != null) {
                if (admin.UserRoles == EventZoneConstants.Admin||admin.UserRoles==EventZoneConstants.RootAdmin)
                {
                    return admin;
                }
            }
            return null;
        }
        /// <summary>
        /// Admin lock an event
        /// </summary>
        /// <param name="adminID"></param>
        /// <param name="EventID"></param>
        /// <returns></returns>
        public bool LockEvent(long adminID, long eventID, string reason) {
            try {
                Event evt = db.Events.Find(eventID);
                evt.Status = EventZoneConstants.Lock;
                evt.EditBy = adminID;
                evt.EditContent = reason;
                evt.EditTime = DateTime.Now;
                db.Entry(evt).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(evt).Reload();
                TrackingAction newAction = new TrackingAction { SenderID=adminID,
                                                                SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                                                                ReceiverID=EventDatabaseHelper.Instance.GetAuthorEvent(eventID).UserID,
                                                                ReceiverType = EventDatabaseHelper.Instance.GetAuthorEvent(eventID).UserRoles,
                                                                ActionID=EventZoneConstants.LockEvent,
                                                                ActionTime=DateTime.Now
                                                               };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch {
            }
            return false;
        }
        /// <summary>
        /// admin unlock Event
        /// </summary>
        /// <param name="adminID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool UnlockEvent(long adminID, long eventID)
        {
            try
            {
                Event evt = db.Events.Find(eventID);
                evt.Status = EventZoneConstants.Active;
                evt.EditBy = adminID;
                evt.EditContent = "";
                evt.EditTime = DateTime.Now;
                db.Entry(evt).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(evt).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = EventDatabaseHelper.Instance.GetAuthorEvent(eventID).UserID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(eventID).UserRoles,
                    ActionID = EventZoneConstants.UnlockEvent,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// Admin Lock User
        /// </summary>
        /// <param name="adminID"></param>
        /// <returns></returns>
        public bool LockUser(long adminID,long userID) {
            try
            {
                User user = db.Users.Find(userID);
                user.AccountStatus = EventZoneConstants.Lock;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.LockEvent,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        public bool UnlockUser(long adminID, long userID)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.AccountStatus = EventZoneConstants.Active;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.UnLockUser,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }

        public bool ChangeUserEmail(long adminID, long userID, string email)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.UserEmail = email;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.ChangeUserEmail,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// set user to mod
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public bool SetMod(long adminID, long userID)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.UserRoles = EventZoneConstants.Mod;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.SetMod,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// set mod to user
        /// </summary>
        /// <param name="adminID"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
        public bool UnSetMod(long adminID, long userID)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.UserRoles = EventZoneConstants.User;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = UserDatabaseHelper.Instance.GetUserByID(adminID).UserRoles,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.UnSetMod,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// set user to admin, only root admin can use this feature
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public bool SetAdmin(long adminID, long userID)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.UserRoles = EventZoneConstants.Admin;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = EventZoneConstants.RootAdmin,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.SetAdmin,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// set admin to user, only root admin can use this feature
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public bool UnSetAdmin(long adminID, long userID)
        {
            try
            {
                User user = db.Users.Find(userID);
                user.UserRoles = EventZoneConstants.User;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                db.Entry(user).Reload();
                TrackingAction newAction = new TrackingAction
                {
                    SenderID = adminID,
                    SenderType = EventZoneConstants.RootAdmin,
                    ReceiverID = userID,
                    ReceiverType = UserDatabaseHelper.Instance.GetUserByID(userID).UserRoles,
                    ActionID = EventZoneConstants.UnSetAdmin,
                    ActionTime = DateTime.Now
                };
                db.TrackingActions.Add(newAction);
                db.SaveChanges();
                return true;
            }
            catch
            {
            }
            return false;
        }
        /// <summary>
        /// admin approve report
        /// </summary>
        /// <param name="adminID"></param>
        /// <param name="reportID"></param>
        /// <returns></returns>
        public Report ApproveReport(long adminID, long reportID)
        {
            try { 
               Report currReport= db.Reports.Find(reportID);
               Event evt = (from a in db.Events where a.EventID==currReport.EventID select a).ToList()[0];
               var some = db.Reports.Where(x => x.EventID == evt.EventID).ToList();
               some.ForEach(a => a.ReportStatus = EventZoneConstants.Closed);
               db.SaveChanges();
               currReport.ReportStatus = EventZoneConstants.Approved;
               currReport.HandleDate = DateTime.Now;
               currReport.HandleBy = adminID;
               db.Entry(currReport).State = EntityState.Modified;
               db.SaveChanges();
               evt.Status = EventZoneConstants.Lock;
               db.Entry(evt).State = EntityState.Modified;
               db.SaveChanges();

               return currReport;
            }   
            catch { }
            return null;
        }

        public Report RejectReport(long adminID, long reportID)
        {
            try
            {
                Report currReport = db.Reports.Find(reportID);
                currReport.ReportStatus = EventZoneConstants.Rejected;
                currReport.HandleDate = DateTime.Now;
                currReport.HandleBy = adminID;
                db.Entry(currReport).State = EntityState.Modified;
                db.SaveChanges();
                return currReport;
            }
            catch { }
            return null;
        }
    }
}
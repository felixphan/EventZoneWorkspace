﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.Helpers
{
    public class EventZoneConstants
    {
        public static string DatetimeFormat = "yyyy-MM-dd HH:mm:ss";
        public static string DateFormat = "yyyy-MM-dd";
        public static int UploadedImageMaxWidthPixcel = 800;
        public static int UploadedImageMaxHeightPixcel = 800;
        public static string[] ImageFileExtensions = { ".jpg", ".png", ".jpeg" };
        public static int RecordsPerPage = 20;

        public static int IsUser = 0;
        public static int IsMod = 1;

        public static int IsEventZoneAccount = 0;
        public static int IsGoogleAccount = 1;

        public static int PlanGeneral = 0;
        public static int PlanTimeline = 1;

        public static int isMale = 0;
        public static int isFemale = 1;


        public static bool IsUserActive = true;
        public static bool IsUserLock = false;
    }
}
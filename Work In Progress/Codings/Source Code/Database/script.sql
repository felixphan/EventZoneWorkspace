USE [EventZone]
GO
/****** Object:  Table [dbo].[Action]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ActionID] [int] NOT NULL,
	[ActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ActorAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appeal]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appeal](
	[AppealID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[AppealContent] [nvarchar](max) NOT NULL,
	[AppealStatus] [int] NOT NULL,
	[SendDate] [date] NOT NULL,
	[ResultDate] [date] NULL,
 CONSTRAINT [PK_Appeal] PRIMARY KEY CLUSTERED 
(
	[AppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryFollow]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFollow](
	[CategoryFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[FollowerID] [bigint] NOT NULL,
 CONSTRAINT [PK_CategoryFollow] PRIMARY KEY CLUSTERED 
(
	[CategoryFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Channel]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channel](
	[ChannelID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ChannelName] [nvarchar](512) NOT NULL,
	[ChannelDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_Channel] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Event]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EventID] [bigint] IDENTITY(1,1) NOT NULL,
	[ChannelID] [bigint] NOT NULL,
	[EventName] [nvarchar](1024) NOT NULL,
	[EventStartDate] [datetime] NOT NULL,
	[EventEndDate] [datetime] NOT NULL,
	[EventDescription] [nvarchar](max) NULL,
	[EventRegisterDate] [datetime] NOT NULL,
	[View] [bigint] NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[Privacy] [int] NOT NULL,
	[Avatar] [bigint] NULL,
	[EditBy] [bigint] NULL,
	[EditTime] [datetime] NULL,
	[EditContent] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventFollow]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventFollow](
	[EventFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[FollowerID] [bigint] NOT NULL,
 CONSTRAINT [PK_EventFollow] PRIMARY KEY CLUSTERED 
(
	[EventFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventPlace]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPlace](
	[EventPlaceID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[LocationID] [bigint] NOT NULL,
 CONSTRAINT [PK_EventPlace] PRIMARY KEY CLUSTERED 
(
	[EventPlaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventRank]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventRank](
	[EventRankId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventId] [bigint] NOT NULL,
	[Score] [bigint] NOT NULL,
 CONSTRAINT [PK_EventRank_1] PRIMARY KEY CLUSTERED 
(
	[EventRankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Image]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ImageLink] [nvarchar](256) NOT NULL,
	[UploadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Gallery] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeDislike]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeDislike](
	[LikeDislikeID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_LikeDislike_1] PRIMARY KEY CLUSTERED 
(
	[LikeDislikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Location]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [bigint] IDENTITY(1,1) NOT NULL,
	[Longitude] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[LocationName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PeopleFollow]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeopleFollow](
	[PeopleFollowID] [bigint] IDENTITY(1,1) NOT NULL,
	[FollowerUserID] [bigint] NOT NULL,
	[FollowingUserID] [bigint] NOT NULL,
 CONSTRAINT [PK_PeopleFollow] PRIMARY KEY CLUSTERED 
(
	[PeopleFollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Report]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[SenderID] [bigint] NOT NULL,
	[ReportType] [nvarchar](128) NOT NULL,
	[ReportContent] [nvarchar](max) NULL,
	[ReportStatus] [int] NOT NULL,
	[ReportDate] [datetime] NOT NULL,
	[ResultDate] [datetime] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingAppeals]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingAppeals](
	[TrackingAppealsID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActorID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingAppeals] PRIMARY KEY CLUSTERED 
(
	[TrackingAppealsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingEvents]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingEvents](
	[TrackingEventID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActorID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingEvents] PRIMARY KEY CLUSTERED 
(
	[TrackingEventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingReports]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingReports](
	[TrackingReportID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActorID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingReports] PRIMARY KEY CLUSTERED 
(
	[TrackingReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingUsers]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingUsers](
	[TrackingUsersID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActorID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingAction] PRIMARY KEY CLUSTERED 
(
	[TrackingUsersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserFirstName] [nvarchar](32) NULL,
	[UserLastName] [nvarchar](32) NULL,
	[UserEmail] [nvarchar](64) NULL,
	[UserDOB] [date] NULL,
	[IDCard] [nvarchar](16) NULL,
	[UserRoles] [int] NOT NULL,
	[Phone] [nvarchar](max) NULL,
	[Place] [nvarchar](max) NULL,
	[AccountStatus] [bit] NOT NULL,
	[Gender] [int] NULL,
	[AvatarLink] [nvarchar](100) NULL,
	[DataJoin] [date] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Video]    Script Date: 11/8/2015 10:35:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[VideoID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventPlaceID] [bigint] NOT NULL,
	[VideoLink] [nvarchar](256) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Privacy] [int] NOT NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Event1]
GO
ALTER TABLE [dbo].[CategoryFollow]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFollow_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoryFollow] CHECK CONSTRAINT [FK_CategoryFollow_Category]
GO
ALTER TABLE [dbo].[CategoryFollow]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFollow_User] FOREIGN KEY([FollowerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CategoryFollow] CHECK CONSTRAINT [FK_CategoryFollow_User]
GO
ALTER TABLE [dbo].[Channel]  WITH CHECK ADD  CONSTRAINT [FK_Channel_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Channel] CHECK CONSTRAINT [FK_Channel_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Event1]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Category]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Channel1] FOREIGN KEY([ChannelID])
REFERENCES [dbo].[Channel] ([ChannelID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Channel1]
GO
ALTER TABLE [dbo].[EventFollow]  WITH CHECK ADD  CONSTRAINT [FK_EventFollow_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventFollow] CHECK CONSTRAINT [FK_EventFollow_Event1]
GO
ALTER TABLE [dbo].[EventFollow]  WITH CHECK ADD  CONSTRAINT [FK_EventFollow_User] FOREIGN KEY([FollowerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[EventFollow] CHECK CONSTRAINT [FK_EventFollow_User]
GO
ALTER TABLE [dbo].[EventPlace]  WITH CHECK ADD  CONSTRAINT [FK_EventPlace_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventPlace] CHECK CONSTRAINT [FK_EventPlace_Event1]
GO
ALTER TABLE [dbo].[EventPlace]  WITH CHECK ADD  CONSTRAINT [FK_EventPlace_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[EventPlace] CHECK CONSTRAINT [FK_EventPlace_Location]
GO
ALTER TABLE [dbo].[EventRank]  WITH CHECK ADD  CONSTRAINT [FK_EventRank_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventRank] CHECK CONSTRAINT [FK_EventRank_Event]
GO
ALTER TABLE [dbo].[Image]  WITH CHECK ADD  CONSTRAINT [FK_Gallery_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Gallery_Event1]
GO
ALTER TABLE [dbo].[Image]  WITH CHECK ADD  CONSTRAINT [FK_Gallery_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Image] CHECK CONSTRAINT [FK_Gallery_User]
GO
ALTER TABLE [dbo].[LikeDislike]  WITH CHECK ADD  CONSTRAINT [FK_LikeDislike_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[LikeDislike] CHECK CONSTRAINT [FK_LikeDislike_Event1]
GO
ALTER TABLE [dbo].[LikeDislike]  WITH CHECK ADD  CONSTRAINT [FK_LikeDislike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[LikeDislike] CHECK CONSTRAINT [FK_LikeDislike_User]
GO
ALTER TABLE [dbo].[PeopleFollow]  WITH CHECK ADD  CONSTRAINT [FK_PeopleFollow_User] FOREIGN KEY([FollowerUserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PeopleFollow] CHECK CONSTRAINT [FK_PeopleFollow_User]
GO
ALTER TABLE [dbo].[PeopleFollow]  WITH CHECK ADD  CONSTRAINT [FK_PeopleFollow_User3] FOREIGN KEY([FollowingUserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PeopleFollow] CHECK CONSTRAINT [FK_PeopleFollow_User3]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_Event]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([SenderID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[TrackingAppeals]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAppeals_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingAppeals] CHECK CONSTRAINT [FK_TrackingAppeals_Action]
GO
ALTER TABLE [dbo].[TrackingAppeals]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAppeals_Appeal] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Appeal] ([AppealID])
GO
ALTER TABLE [dbo].[TrackingAppeals] CHECK CONSTRAINT [FK_TrackingAppeals_Appeal]
GO
ALTER TABLE [dbo].[TrackingAppeals]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAppeals_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAppeals] CHECK CONSTRAINT [FK_TrackingAppeals_User]
GO
ALTER TABLE [dbo].[TrackingEvents]  WITH CHECK ADD  CONSTRAINT [FK_TrackingEvents_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingEvents] CHECK CONSTRAINT [FK_TrackingEvents_Action]
GO
ALTER TABLE [dbo].[TrackingEvents]  WITH CHECK ADD  CONSTRAINT [FK_TrackingEvents_Event] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[TrackingEvents] CHECK CONSTRAINT [FK_TrackingEvents_Event]
GO
ALTER TABLE [dbo].[TrackingEvents]  WITH CHECK ADD  CONSTRAINT [FK_TrackingEvents_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingEvents] CHECK CONSTRAINT [FK_TrackingEvents_User]
GO
ALTER TABLE [dbo].[TrackingReports]  WITH CHECK ADD  CONSTRAINT [FK_TrackingReports_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingReports] CHECK CONSTRAINT [FK_TrackingReports_Action]
GO
ALTER TABLE [dbo].[TrackingReports]  WITH CHECK ADD  CONSTRAINT [FK_TrackingReports_Report] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Report] ([ReportID])
GO
ALTER TABLE [dbo].[TrackingReports] CHECK CONSTRAINT [FK_TrackingReports_Report]
GO
ALTER TABLE [dbo].[TrackingReports]  WITH CHECK ADD  CONSTRAINT [FK_TrackingReports_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingReports] CHECK CONSTRAINT [FK_TrackingReports_User]
GO
ALTER TABLE [dbo].[TrackingUsers]  WITH CHECK ADD  CONSTRAINT [FK_TrackingUsers_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingUsers] CHECK CONSTRAINT [FK_TrackingUsers_Action]
GO
ALTER TABLE [dbo].[TrackingUsers]  WITH CHECK ADD  CONSTRAINT [FK_TrackingUsers_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingUsers] CHECK CONSTRAINT [FK_TrackingUsers_User]
GO
ALTER TABLE [dbo].[TrackingUsers]  WITH CHECK ADD  CONSTRAINT [FK_TrackingUsers_User1] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingUsers] CHECK CONSTRAINT [FK_TrackingUsers_User1]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_EventPlace] FOREIGN KEY([EventPlaceID])
REFERENCES [dbo].[EventPlace] ([EventPlaceID])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_EventPlace]
GO

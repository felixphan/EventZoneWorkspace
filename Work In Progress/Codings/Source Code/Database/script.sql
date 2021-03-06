USE [master]
GO
/****** Object:  Database [EventZone]    Script Date: 12/13/2015 1:30:49 SA ******/
CREATE DATABASE [EventZone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EventZone', FILENAME = N'B:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EventZone.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EventZone_log', FILENAME = N'B:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EventZone_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EventZone] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EventZone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EventZone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EventZone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EventZone] SET ARITHABORT OFF 
GO
ALTER DATABASE [EventZone] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EventZone] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EventZone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EventZone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EventZone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EventZone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EventZone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EventZone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EventZone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EventZone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EventZone] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EventZone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EventZone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EventZone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EventZone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EventZone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EventZone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EventZone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EventZone] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EventZone] SET  MULTI_USER 
GO
ALTER DATABASE [EventZone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EventZone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EventZone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EventZone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EventZone]
GO
/****** Object:  Table [dbo].[Action]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ActorAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appeal]    Script Date: 12/13/2015 1:30:49 SA ******/
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
	[HandleBy] [bigint] NULL,
 CONSTRAINT [PK_Appeal] PRIMARY KEY CLUSTERED 
(
	[AppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](256) NOT NULL,
	[CategoryAvatar] [bigint] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryFollow]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[Channel]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
	[DateIssue] [datetime] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Event]    Script Date: 12/13/2015 1:30:49 SA ******/
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
	[IsVerified] [bit] NOT NULL,
	[LockedReason] [nvarchar](100) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventFollow]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[EventImage]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventImage](
	[EventImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NULL,
	[ImageID] [bigint] NULL,
	[Approve] [bit] NULL,
 CONSTRAINT [PK_EventImage] PRIMARY KEY CLUSTERED 
(
	[EventImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventPlace]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[EventRank]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventRank](
	[EventId] [bigint] NOT NULL,
	[Score] [bigint] NOT NULL,
 CONSTRAINT [PK_EventRank] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Image]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[ImageLink] [nvarchar](256) NOT NULL,
	[UploadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Gallery] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeDislike]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationChange]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationChange](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NotificationObjectID] [bigint] NOT NULL,
	[ActorID] [bigint] NULL,
	[EventID] [bigint] NULL,
	[IsRead] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationChange] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationObject]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationObject](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NotificationID] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Notification_object] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PeopleFollow]    Script Date: 12/13/2015 1:30:49 SA ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[SenderID] [bigint] NOT NULL,
	[ReportType] [int] NOT NULL,
	[ReportContent] [nvarchar](max) NULL,
	[ReportStatus] [int] NOT NULL,
	[ReportDate] [datetime] NOT NULL,
	[HandleDate] [datetime] NULL,
	[HandleBy] [bigint] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportDefine]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportDefine](
	[ReportTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ReportTypeName] [nvarchar](50) NULL,
	[ReportDefine] [nvarchar](200) NULL,
 CONSTRAINT [PK_ReportDefine] PRIMARY KEY CLUSTERED 
(
	[ReportTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Share]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Share](
	[ShareID] [bigint] IDENTITY(1,1) NOT NULL,
	[EventID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
 CONSTRAINT [PK_Share] PRIMARY KEY CLUSTERED 
(
	[ShareID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackingAction]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingAction](
	[TrackingID] [bigint] IDENTITY(1,1) NOT NULL,
	[SenderID] [bigint] NOT NULL,
	[ReceiverID] [bigint] NOT NULL,
	[SenderType] [int] NOT NULL,
	[ReceiverType] [int] NULL,
	[ActionID] [int] NOT NULL,
	[ActionTime] [datetime] NOT NULL,
 CONSTRAINT [PK_TrackingAction] PRIMARY KEY CLUSTERED 
(
	[TrackingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/13/2015 1:30:49 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserFirstName] [nvarchar](32) NOT NULL,
	[UserLastName] [nvarchar](32) NULL,
	[UserEmail] [nvarchar](64) NOT NULL,
	[UserDOB] [date] NOT NULL,
	[IDCard] [nvarchar](16) NULL,
	[UserRoles] [int] NOT NULL,
	[Phone] [nvarchar](max) NULL,
	[Place] [nvarchar](max) NULL,
	[AccountStatus] [bit] NOT NULL,
	[Gender] [int] NOT NULL,
	[Avartar] [bigint] NULL,
	[DataJoin] [date] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Video]    Script Date: 12/13/2015 1:30:49 SA ******/
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
	[PrimaryServer] [nvarchar](50) NULL,
	[BackupServer] [nvarchar](50) NULL,
	[StreamName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Action] ON 

INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1, N'Lock Event')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (2, N'Unlock Event')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (3, N'Lock User')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (4, N'UnlockUser')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (5, N'ChangeUserEmail')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1005, N'Set Mod')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1006, N'UnSet Mod')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1007, N'Set Admin')
INSERT [dbo].[Action] ([ActionID], [ActionName]) VALUES (1008, N'Unset Admin')
SET IDENTITY_INSERT [dbo].[Action] OFF
SET IDENTITY_INSERT [dbo].[Appeal] ON 

INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (1, 2, N' 124253424', 1, CAST(0xB93A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (2, 4, N' 4123535', 2, CAST(0xBC3A0B00 AS Date), NULL, 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (3, 3, N' 42515', 2, CAST(0xB93A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (4, 5, N'please review my event. That all report not true', 1, CAST(0xBA3A0B00 AS Date), CAST(0xBA3A0B00 AS Date), 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (5, 2, N'demo 2/11', 0, CAST(0xBC3A0B00 AS Date), NULL, NULL)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (6, 6, N'hello', 1, CAST(0xBC3A0B00 AS Date), NULL, 13)
INSERT [dbo].[Appeal] ([AppealID], [EventID], [AppealContent], [AppealStatus], [SendDate], [ResultDate], [HandleBy]) VALUES (7, 78, N'demo 2', 0, CAST(0xBC3A0B00 AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Appeal] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (1, N'Music', 10035)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (2, N'Food & Drink', 10034)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (3, N'Classes', 10039)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (4, N'Arts', 10033)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (5, N'Parties', 10037)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (6, N'Sport & Wellness', 10038)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryAvatar]) VALUES (7, N'Networking', 10036)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[CategoryFollow] ON 

INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (1, 6, 12)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (2, 2, 12)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (15, 1, 13)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (16, 5, 13)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (10021, 6, 13)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (10022, 7, 13)
SET IDENTITY_INSERT [dbo].[CategoryFollow] OFF
SET IDENTITY_INSERT [dbo].[Channel] ON 

INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (1, 2, N'', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (2, 4, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (3, 7, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (4, 8, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (5, 9, N'cuong fiiuouo', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (6, 11, N'Vu Phan', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (7, 12, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (8, 13, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (9, 14, N'cug', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (10, 15, N'2151 512', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (11, 16, N'14125 211521', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (12, 17, N'712957 892751', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (13, 18, N'14', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (14, 19, N'38575 21', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (15, 20, N'cuong 24', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (16, 21, N'cuong 2871', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (17, 22, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (18, 23, N'1 4567', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (19, 24, N'cuong 211 ', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (20, 25, N'cuong 214', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (21, 26, N'cuong 59128591', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (22, 27, N'cuong nguyen van', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (23, 28, N'125151 23535', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (24, 29, N'cuong 2114', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (25, 30, N'cuong 2198', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (26, 31, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (27, 32, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (28, 33, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (29, 36, N'cuong', N'')
SET IDENTITY_INSERT [dbo].[Channel] OFF
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (1, 1, 12, N'Hello', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (2, 1, 12, N'How are you?', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (3, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (4, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (5, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (6, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (7, 1, 12, N'124124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (8, 1, 12, N'4124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (9, 1, 12, N'512512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (10, 1, 12, N'551251251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (11, 1, 12, N'412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (12, 1, 12, N'41251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (13, 1, 12, N'41252512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (14, 1, 12, N'53462464', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (15, 1, 12, N'4124241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (16, 1, 12, N'152515', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (17, 1, 13, N'412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (18, 1, 13, N'512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (19, 1, 13, N'512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (20, 1, 13, N'42512512', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (21, 1, 13, N'day la gi', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (22, 1, 13, N'543762', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (23, 1, 13, N'54363626', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (24, 1, 13, N'412412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (25, 1, 13, N'41241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (26, 1, 13, N'555', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (27, 1, 13, N'hello', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (28, 1, 13, N'435351', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (29, 1, 13, N'5125125152', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (30, 1, 13, N'54236246346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (31, 1, 13, N'i26u34oi62j3o632462346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (32, 1, 13, N'634634', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (33, 1, 13, N'632462', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (34, 1, 13, N'632462346', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (35, 1, 13, N'41241', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (36, 1, 13, N'41251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (37, 1, 13, N'125346235', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (38, 1, 13, N'4124124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (39, 1, 13, N'421', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (40, 2, 13, N'551', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (41, 2, 13, N'51251251', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (42, 1, 13, N'31412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (43, 1, 13, N'63146146', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (44, 2, 13, N'eqwee12412124', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (45, 1, 13, N'412412', CAST(0x0000A52D00000000 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (48, 1, 13, N'Hello', NULL)
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (49, 1, 13, N'It''s me', NULL)
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (50, 1, 13, N'How are your', CAST(0x0000A54D017C6426 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (51, 1, 13, N'4124', CAST(0x0000A54D017C81DB AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (52, 1, 13, N'4124', CAST(0x0000A54D017D0C56 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (53, 1, 13, N'Hello
', CAST(0x0000A54D017FB2EE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (54, 1, 13, N'it''s me', CAST(0x0000A54D017FBBBC AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (55, 1, 13, N'hello', CAST(0x0000A54D01800933 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (56, 1, 13, N'41241', CAST(0x0000A54D01800E1C AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (57, 1, 13, N'Hello', CAST(0x0000A54E000537A9 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (58, 1, 13, N'1', CAST(0x0000A54E00055292 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (59, 1, 13, N'1', CAST(0x0000A54E00055B74 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (60, 1, 13, N'21512515', CAST(0x0000A54E0005608D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (61, 1, 13, N'51251251', CAST(0x0000A54E000563CF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (62, 1, 13, N'1', CAST(0x0000A54E000576E0 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (63, 1, 13, N'foaisfa', CAST(0x0000A54E0005865E AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (64, 1, 13, N'515125161', CAST(0x0000A54E00058ACE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (65, 9, 13, N'hello', CAST(0x0000A54E0036AE55 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (66, 1, 13, N'4
', CAST(0x0000A54E0099998D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (67, 1, 13, N'333333333', CAST(0x0000A54E00999FA5 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (68, 1, 13, N'4', CAST(0x0000A54E0099B102 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (69, 1, 13, N'41241', CAST(0x0000A54E009FFC3A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (70, 1, 13, N'1', CAST(0x0000A54E00A00081 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (71, 1, 13, N'1', CAST(0x0000A54E00A00E41 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (72, 1, 13, N'12', CAST(0x0000A54E00A01225 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (73, 1, 13, N'1251251', CAST(0x0000A54E00A0175D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (74, 1, 13, N'512512', CAST(0x0000A54E00A01A7A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (75, 1, 13, N'.', CAST(0x0000A54E00A01EEF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (76, 0, 13, N'12124124141', CAST(0x0000A54E01239515 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (77, 1, 13, N'51515151512', CAST(0x0000A55201298584 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (78, 1, 13, N'412511', CAST(0x0000A55201298A9A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (79, 1, 13, N'5151515', CAST(0x0000A552012990BA AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (80, 1, 13, N'515', CAST(0x0000A552012B7858 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (81, 18, 13, N'52151', CAST(0x0000A559015A7DDD AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (82, 10108, 13, N'41251', CAST(0x0000A55D011D2E19 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (83, 10108, 13, N'52453', CAST(0x0000A55D011D30CA AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (84, 10108, 13, N'4352334646356
', CAST(0x0000A55D011D51E0 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (85, 10109, 13, N'24124', CAST(0x0000A56100098D93 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (86, 10111, 13, N'Hi
', CAST(0x0000A56200F478E4 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (87, 10111, 2, N'hi
', CAST(0x0000A56200F49A6B AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (88, 10111, 13, N'how are you?', CAST(0x0000A56200F51A4A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (89, 10111, 13, N'fine', CAST(0x0000A56200F542F1 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (90, 10, 13, N'125351', CAST(0x0000A56200FE6E02 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (91, 10111, 13, N'you there?', CAST(0x0000A5620101495C AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (92, 10, 13, N'11111', CAST(0x0000A5620103BC81 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (93, 10, 2, N'413566439248263', CAST(0x0000A5620103DEE6 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (94, 10, 13, N'41675645', CAST(0x0000A5620103EE48 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (95, 10, 2, N'534498640948364', CAST(0x0000A5620103F919 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (96, 10111, 2, N'hi there', CAST(0x0000A562011D3E0D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (97, 10111, 13, N'125151', CAST(0x0000A562011D5672 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (98, 1, 13, N'hello', CAST(0x0000A56300506629 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (99, 1, 4, N'hi', CAST(0x0000A56300512B2E AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (100, 1, 13, N'132345352', CAST(0x0000A56400CD9013 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (101, 1, 13, N'12
', CAST(0x0000A56400CD9AE4 AS DateTime))
GO
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (102, 1, 13, N'3253', CAST(0x0000A56400CE9CAF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (103, 10110, 13, N'2151251', CAST(0x0000A56400CF7FDB AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (104, 10110, 13, N'353546346434', CAST(0x0000A56400CF85C3 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (105, 10110, 13, N'23', CAST(0x0000A56400CF87B0 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (106, 10110, 13, N'345675434', CAST(0x0000A56400CF8A20 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (107, 10112, 13, N'2114', CAST(0x0000A56400D00292 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (108, 10112, 13, N'34512', CAST(0x0000A56400D16656 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (109, 10112, 13, N'5934', CAST(0x0000A56400D1686D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (110, 10112, 13, N'5897139867649', CAST(0x0000A56400D169FC AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (111, 10111, 13, N'2111', CAST(0x0000A56400DC0087 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (112, 10111, 13, N'2111', CAST(0x0000A56400DC048D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (113, 10111, 13, N'141241', CAST(0x0000A56400DC4D32 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (114, 10111, 13, N'41241241', CAST(0x0000A56400DC5E50 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (115, 10111, 13, N'4142141', CAST(0x0000A56400DC9058 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (116, 1, 13, N'1', CAST(0x0000A56400DDC0B5 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (117, 1, 13, N'1', CAST(0x0000A56400DDC54F AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (118, 1, 13, N'2', CAST(0x0000A56400DDE7A1 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (119, 1, 13, N'33', CAST(0x0000A56400DE08CC AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (120, 1, 13, N'215151', CAST(0x0000A56400DE2860 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (121, 1, 13, N'41241', CAST(0x0000A56400DF09BE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (122, 1, 13, N'41241', CAST(0x0000A56400DF1B38 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (123, 1, 13, N'1241241', CAST(0x0000A56400E01B3A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (124, 10111, 13, N'1242141', CAST(0x0000A56400E141E1 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (125, 10111, 13, N'hello', CAST(0x0000A56400E155C4 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (126, 10111, 13, N'abc', CAST(0x0000A56400E15D74 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (127, 10111, 13, N'215125', CAST(0x0000A56400E162E9 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (128, 10111, 13, N'241', CAST(0x0000A56400E2DEE2 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (129, 10111, 13, N'4151', CAST(0x0000A56400E34C4F AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (130, 10111, 13, N'65', CAST(0x0000A56400E59198 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (131, 10111, 13, N'1535', CAST(0x0000A56400E5A9D5 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (132, 10111, 13, N'hello', CAST(0x0000A56400E5AD27 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (133, 0, 13, N'hello', CAST(0x0000A5650155AE3E AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (134, 0, 13, N'hello', CAST(0x0000A5650155B092 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (135, 0, 13, N'hello', CAST(0x0000A5650155B512 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (136, 0, 13, N'what', CAST(0x0000A5650155C57C AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (137, 0, 13, N'214', CAST(0x0000A5650155DFE6 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (138, 10116, 13, N'1111', CAST(0x0000A56800B09E28 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (139, 10116, 13, N'1', CAST(0x0000A56800B2A1DA AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (140, 10116, 13, N'1', CAST(0x0000A56800B631A9 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (141, 10116, 13, N'1', CAST(0x0000A56800B639A5 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (142, 10116, 13, N'1', CAST(0x0000A56800B950BF AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (143, 10116, 13, N'1241', CAST(0x0000A56800B95392 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (144, 72, 13, N'21', CAST(0x0000A56800BE9EEE AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (145, 0, 13, N'42', CAST(0x0000A56801666B7A AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (146, 0, 13, N'241', CAST(0x0000A56A0000D87C AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (147, 10117, 2, N'1412412', CAST(0x0000A56A00EF445D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (148, 3, 13, N'nice album', CAST(0x0000A56A018A1724 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (149, 10116, 13, N'1241', CAST(0x0000A56B001F9C2D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (150, 10114, 27, N'Nice', CAST(0x0000A56B001FDDC4 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (151, 10114, 13, N'Ai đi không?', CAST(0x0000A56B001FEE74 AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (152, 10114, 27, N'Có', CAST(0x0000A56B0020113E AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (153, 10114, 27, N'215125125', CAST(0x0000A56B00FA680F AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (154, 10114, 27, N'12511', CAST(0x0000A56B00FA840D AS DateTime))
INSERT [dbo].[Comment] ([CommentID], [EventID], [UserID], [CommentContent], [DateIssue]) VALUES (155, 10114, 27, N'215125', CAST(0x0000A56B00FA9459 AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (0, 8, N'Test Location', CAST(0x0000A45800A02030 AS DateTime), CAST(0x0000A51000A06680 AS DateTime), N'Enter your description', CAST(0x0000A54B00A053B6 AS DateTime), 42, 7, 0, 3, 13, CAST(0x0000A56A01757681 AS DateTime), N'', 1, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (1, 2, N'LadyByNight', CAST(0x0000A53600000000 AS DateTime), CAST(0x0000A53700000000 AS DateTime), N'Lady by night được tổ chức hàng năm vào ngày 20/10 - DH FPT', CAST(0x0000A53600000000 AS DateTime), 1187, 5, 0, 3, 13, CAST(0x0000A56A000FC4F4 AS DateTime), N'', 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (2, 8, N'Final ESL ', CAST(0x0000A4F100A4CB80 AS DateTime), CAST(0x0000A5100127CE90 AS DateTime), N'Giai dau dota', CAST(0x0000A54A01287DC2 AS DateTime), 38, 1, 0, 3, 13, CAST(0x0000A56D0016D61F AS DateTime), N'I dont want your event in my website xD', 0, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (3, 8, N'Quiz Pay', CAST(0x0000A52E004A2860 AS DateTime), CAST(0x0000A52E004A2860 AS DateTime), N'Quiz thanh toan', CAST(0x0000A54B004A0EF5 AS DateTime), 16, 7, 0, 3, 13, CAST(0x0000A56900D9EDCF AS DateTime), N'', 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (4, 8, N'Quiz ktw', CAST(0x0000A43C005192D0 AS DateTime), CAST(0x0000A5100051D920 AS DateTime), N'Enter your description', CAST(0x0000A54B0051CDD8 AS DateTime), 7, 7, 0, 3, 13, CAST(0x0000A554003DA89C AS DateTime), N'', 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (5, 8, N'252151', CAST(0x0000A4580052F260 AS DateTime), CAST(0x0000A510005338B0 AS DateTime), N'251251', CAST(0x0000A54B0053188A AS DateTime), 4, 7, 0, 3, 13, CAST(0x0000A56200DA3824 AS DateTime), N'I dont want your event in my website xD', 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (6, 8, N'56789', CAST(0x0000A47700D827F0 AS DateTime), CAST(0x0000A56B00D86E40 AS DateTime), N'4567890', CAST(0x0000A54C00D88167 AS DateTime), 38, 3, 0, 3, 13, CAST(0x0000A55400380EAC AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (7, 8, N'1125125', CAST(0x0000A5460032CFD0 AS DateTime), CAST(0x0000A54900331620 AS DateTime), N'41241', CAST(0x0000A54E00337717 AS DateTime), 3, 1, 0, 3, 13, CAST(0x0000A55400383AF3 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (8, 8, N'demo1241', CAST(0x0000A5480033A2C0 AS DateTime), CAST(0x0000A54D0033E910 AS DateTime), NULL, CAST(0x0000A54E00341728 AS DateTime), 6, 1, 0, 3, 13, CAST(0x0000A55400355B53 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (9, 8, N'51251', CAST(0x0000A549003548A0 AS DateTime), CAST(0x0000A54E00358EF0 AS DateTime), N'Enter your description2', CAST(0x0000A54E003615FF AS DateTime), 3, 2, 0, 3, 13, CAST(0x0000A54E003615FF AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10, 8, N'4125151', CAST(0x0000A477003DCC50 AS DateTime), CAST(0x0000A41E003E12A0 AS DateTime), N'41241241', CAST(0x0000A54E003E6159 AS DateTime), 15, 1, 0, 3, 13, CAST(0x0000A54E003E6159 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (11, 8, N'41251251', CAST(0x0000A495003F7230 AS DateTime), CAST(0x0000A459003FB880 AS DateTime), N'41241', CAST(0x0000A54E003FAAEE AS DateTime), 2, 1, 0, 3, 13, CAST(0x0000A54E003FAAEE AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (12, 8, N'5125125', CAST(0x0000A52E00404520 AS DateTime), CAST(0x0000A52F00408B70 AS DateTime), N'512512512', CAST(0x0000A54E00409AD0 AS DateTime), 1, 4, 0, 3, 13, CAST(0x0000A54E00409AD0 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (13, 1, N'ewesdrfghuji', CAST(0x0000A56B011EBE40 AS DateTime), CAST(0x0000A41E011EBE40 AS DateTime), N'412', CAST(0x0000A54E011EF426 AS DateTime), 4, 1, 0, 3, 13, CAST(0x0000A55E013ED9AF AS DateTime), N'', 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (14, 8, N'DEmo 2', CAST(0x0000A5540120AA70 AS DateTime), CAST(0x0000A5590120F0C0 AS DateTime), N'Demo', CAST(0x0000A55101211BEC AS DateTime), 1, 5, 0, 3, 13, CAST(0x0000A55101211BEC AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (15, 8, N'Demo24124', CAST(0x0000A55401225050 AS DateTime), CAST(0x0000A55D012296A0 AS DateTime), NULL, CAST(0x0000A551012287D3 AS DateTime), 6, 2, 0, 3, 13, CAST(0x0000A551012287D3 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (16, 8, N'demo 3', CAST(0x0000A55101259C10 AS DateTime), CAST(0x0000A5530125E260 AS DateTime), N'Demo', CAST(0x0000A5510125DF6B AS DateTime), 2, 3, 0, 3, 13, CAST(0x0000A5510125DF6B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (17, 8, N'Demo 6', CAST(0x0000A55101373010 AS DateTime), CAST(0x0000A55301377660 AS DateTime), NULL, CAST(0x0000A55101375D8D AS DateTime), 0, 5, 0, 3, 13, CAST(0x0000A55101376089 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (18, 8, N'demo 7', CAST(0x0000A551014604F0 AS DateTime), CAST(0x0000A55401464B40 AS DateTime), NULL, CAST(0x0000A55101465B8C AS DateTime), 3, 6, 0, 3, 13, CAST(0x0000A55101465B8C AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (19, 8, N'Demo_art', CAST(0x0000A552002BABB0 AS DateTime), CAST(0x0000A554002BF200 AS DateTime), N'Demo Arts+ avatar', CAST(0x0000A552002BFC4C AS DateTime), 0, 4, 0, 10033, 13, CAST(0x0000A552002BFC59 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (20, 8, N'Demo default avatar', CAST(0x0000A550002C3850 AS DateTime), CAST(0x0000A554002C7EA0 AS DateTime), N'Demo default avatar', CAST(0x0000A552002C7705 AS DateTime), 0, 2, 0, 10034, 13, CAST(0x0000A552002C7706 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (21, 8, N'Demo location', CAST(0x0000A552002D5190 AS DateTime), CAST(0x0000A554002D97E0 AS DateTime), N'Demo location', CAST(0x0000A552002E308B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552002E308C AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (22, 8, N'demo add live 1', CAST(0x0000A553004E00C0 AS DateTime), CAST(0x0000A554004E4710 AS DateTime), N'demo add live 1', CAST(0x0000A552004E55CD AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004E55CF AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (23, 8, N'demo live 2', CAST(0x0000A552004ED3B0 AS DateTime), CAST(0x0000A555004F1A00 AS DateTime), N'demo live 2', CAST(0x0000A552004F360A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004F360B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (24, 8, N'demo live 3', CAST(0x0000A552004FA6A0 AS DateTime), CAST(0x0000A554004FECF0 AS DateTime), N'Demo live 2', CAST(0x0000A552004FE421 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552004FE422 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (25, 8, N'demo live 3', CAST(0x0000A552004FA6A0 AS DateTime), CAST(0x0000A554004FECF0 AS DateTime), N'Demo live 2', CAST(0x0000A55200500E63 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55200500E63 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (26, 8, N'Đồ án Fall 2015', CAST(0x0000A55200D33650 AS DateTime), CAST(0x0000A55400D37CA0 AS DateTime), N'Demo 12 50', CAST(0x0000A55200D395F7 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A56A014B278A AS DateTime), N'I dont want your event in my website xD', 0, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (27, 8, N'Demo12151', CAST(0x0000A552011C8BC0 AS DateTime), CAST(0x0000A554011CD210 AS DateTime), N'Demo 111', CAST(0x0000A552011CF078 AS DateTime), 3, 1, 0, 10035, 13, CAST(0x0000A552011CF079 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (28, 8, N'Hello', CAST(0x0000A552011DEB50 AS DateTime), CAST(0x0000A554011E31A0 AS DateTime), N'Demo', CAST(0x0000A552011E0CFB AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552011E0CFC AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (29, 8, N'e82759375', CAST(0x0000A552011EBE40 AS DateTime), CAST(0x0000A555011F0490 AS DateTime), N'Demo', CAST(0x0000A552011EE955 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A552011EE956 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (30, 8, N'de mo', CAST(0x0000A5520120AA70 AS DateTime), CAST(0x0000A5550120AA70 AS DateTime), N'Demo', CAST(0x0000A5520120B972 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520120B973 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (31, 8, N'thu vien', CAST(0x0000A5520123F630 AS DateTime), CAST(0x0000A55401243C80 AS DateTime), N'demo', CAST(0x0000A5520124214F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201242151 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (32, 8, N'thu vien 2', CAST(0x0000A552012555C0 AS DateTime), CAST(0x0000A55701259C10 AS DateTime), N'Demo thu vien 2', CAST(0x0000A552012581C8 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552012581C9 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (33, 8, N'thu vien 3', CAST(0x0000A5520125E260 AS DateTime), CAST(0x0000A554012628B0 AS DateTime), N'demo', CAST(0x0000A55201261B76 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201261B77 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (34, 8, N'1251512512', CAST(0x0000A5520126B550 AS DateTime), CAST(0x0000A5540126FBA0 AS DateTime), N'3825793287293', CAST(0x0000A5520126D99F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520126D9A0 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (35, 8, N'Demo15185', CAST(0x0000A5520146D7E0 AS DateTime), CAST(0x0000A55C0146D7E0 AS DateTime), N'Demo41241', CAST(0x0000A5520146FA71 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520146FA72 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (36, 8, N'dota2', CAST(0x0000A5520148C410 AS DateTime), CAST(0x0000A5550148C410 AS DateTime), N'15125151', CAST(0x0000A5520148D01D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520148D01F AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (38, 8, N'412151', CAST(0x0000A55201549380 AS DateTime), CAST(0x0000A5550154D9D0 AS DateTime), NULL, CAST(0x0000A5520154F862 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520154FA8B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (39, 8, N'1512521', CAST(0x0000A5520159CB70 AS DateTime), CAST(0x0000A554015A11C0 AS DateTime), N'41415', CAST(0x0000A552015A04D4 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A552015A04D5 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (40, 8, N'515151251', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A55B015E76C0 AS DateTime), NULL, CAST(0x0000A552015E5829 AS DateTime), 7, 1, 0, 10035, 13, CAST(0x0000A552015E5922 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (41, 8, N'5151515', CAST(0x0000A55201629570 AS DateTime), CAST(0x0000A5540162DBC0 AS DateTime), N'Enter your description515', CAST(0x0000A5520162B01D AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5520162B01E AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (42, 8, N'512511', CAST(0x0000A55201643B50 AS DateTime), CAST(0x0000A55401643B50 AS DateTime), NULL, CAST(0x0000A5520164450D AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5520164450D AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (43, 8, N'895710', CAST(0x0000A55201650E40 AS DateTime), CAST(0x0000A55401655490 AS DateTime), NULL, CAST(0x0000A55201655435 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55201655436 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (44, 8, N'195810', CAST(0x0000A55201659AE0 AS DateTime), CAST(0x0000A5540165E130 AS DateTime), NULL, CAST(0x0000A5520165CCFC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5520165CCFE AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (45, 8, N'5125151', CAST(0x0000A5520165E130 AS DateTime), CAST(0x0000A55401662780 AS DateTime), NULL, CAST(0x0000A5520165F855 AS DateTime), 4, 3, 0, 10039, 13, CAST(0x0000A5520165F855 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (46, 8, N'523462326', CAST(0x0000A5520166FA70 AS DateTime), CAST(0x0000A55C016740C0 AS DateTime), NULL, CAST(0x0000A552016720C7 AS DateTime), 1, 4, 0, 10033, 13, CAST(0x0000A552016720C9 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (47, 8, N'5125151', CAST(0x0000A552016740C0 AS DateTime), CAST(0x0000A55501678710 AS DateTime), N'5151', CAST(0x0000A55201677DAC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55201677DAD AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (48, 8, N'1251515', CAST(0x0000A55500E556F0 AS DateTime), CAST(0x0000A55600E556F0 AS DateTime), NULL, CAST(0x0000A55500E57545 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E57546 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (49, 8, N'25361361362', CAST(0x0000A55500000000 AS DateTime), CAST(0x0000A55600E629E0 AS DateTime), NULL, CAST(0x0000A55500E62724 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E62726 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (50, 8, N'51361343643', CAST(0x0000A55500E67030 AS DateTime), CAST(0x0000A55600E6B680 AS DateTime), NULL, CAST(0x0000A55500E6FB0B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E6FB0C AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (51, 8, N'51251616', CAST(0x0000A55500E6FCD0 AS DateTime), CAST(0x0000A55600E74320 AS DateTime), NULL, CAST(0x0000A55500E71EA4 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500E71EA5 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (52, 8, N'89571958', CAST(0x0000A55500EA0240 AS DateTime), CAST(0x0000A55600EA4890 AS DateTime), NULL, CAST(0x0000A55500EA2918 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500EA291A AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (53, 8, N'156354676890-', CAST(0x0000A55500EB61D0 AS DateTime), CAST(0x0000A55600EBA820 AS DateTime), NULL, CAST(0x0000A55500EBB427 AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A55500EBB429 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (54, 8, N'151515151515', CAST(0x0000A55500EC34C0 AS DateTime), CAST(0x0000A55600EC7B10 AS DateTime), NULL, CAST(0x0000A55500EC62B8 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500EC62BA AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (55, 8, N'5152151616', CAST(0x0000A55500EF3A30 AS DateTime), CAST(0x0000A55600EF8080 AS DateTime), NULL, CAST(0x0000A55500EF5A18 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500EF5A1B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (56, 8, N'5136236', CAST(0x0000A55500EFC6D0 AS DateTime), CAST(0x0000A55600F00D20 AS DateTime), NULL, CAST(0x0000A55500EFEEDE AS DateTime), 4, 1, 0, 10035, 13, CAST(0x0000A55500EFEEE2 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (57, 8, N'153465768654342', CAST(0x0000A55500F1B300 AS DateTime), CAST(0x0000A55600F1F950 AS DateTime), NULL, CAST(0x0000A55500F1E6FC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500F1E700 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (58, 8, N'51345676352', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55D00F285F0 AS DateTime), NULL, CAST(0x0000A55500F25628 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55500F25629 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (59, 8, N'5456765463542', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55600F285F0 AS DateTime), NULL, CAST(0x0000A55500F26EB2 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A55500F26EB4 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (60, 22, N'demo212376', CAST(0x0000A5550107F250 AS DateTime), CAST(0x0000A556010838A0 AS DateTime), NULL, CAST(0x0000A5550108240D AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A5550108240F AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (61, 8, N'251251251', CAST(0x0000A559015D1730 AS DateTime), CAST(0x0000A55A015D5D80 AS DateTime), N'5125125125', CAST(0x0000A559015E70C5 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559015E70C6 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (62, 8, N'12525126', CAST(0x0000A559015E76C0 AS DateTime), CAST(0x0000A55B015EBD10 AS DateTime), N'51251', CAST(0x0000A559015ECE6E AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A559015EDFC0 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (63, 8, N'2859715', CAST(0x0000A5590162DBC0 AS DateTime), CAST(0x0000A55B01632210 AS DateTime), N'25121161', CAST(0x0000A55901631F3F AS DateTime), 0, 1, 0, 10044, 13, CAST(0x0000A55901633CE8 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (64, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BD7C7 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BD839 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (65, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BD96B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BD9D3 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (66, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BDC66 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BDD1B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (67, 8, N'21251', CAST(0x0000A559016BA5C0 AS DateTime), CAST(0x0000A55C016BA5C0 AS DateTime), NULL, CAST(0x0000A559016BEC47 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016BECCE AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (68, 8, N'915918', CAST(0x0000A559016E1E90 AS DateTime), CAST(0x0000A55B016E64E0 AS DateTime), NULL, CAST(0x0000A559016E7C0A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016E7C0B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (69, 8, N'15161', CAST(0x0000A559016E64E0 AS DateTime), CAST(0x0000A55B016EAB30 AS DateTime), NULL, CAST(0x0000A559016EA3BC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016EA3BE AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (70, 8, N'155161', CAST(0x0000A559016EAB30 AS DateTime), CAST(0x0000A55A016EF180 AS DateTime), N'Enter your description', CAST(0x0000A559016F2016 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559016F2017 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (71, 8, N'29581098601', CAST(0x0000A5590170DDB0 AS DateTime), CAST(0x0000A55B0170DDB0 AS DateTime), N'5151251', CAST(0x0000A5590170EB68 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590170EB6A AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (72, 8, N'8927519510', CAST(0x0000A55901712400 AS DateTime), CAST(0x0000A55B01712400 AS DateTime), NULL, CAST(0x0000A55901715A57 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901715A58 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (73, 8, N'125151', CAST(0x0000A5590171B0A0 AS DateTime), CAST(0x0000A55B0171F6F0 AS DateTime), NULL, CAST(0x0000A5590171F36C AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590171F36E AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (74, 8, N'15251', CAST(0x0000A5590171F6F0 AS DateTime), CAST(0x0000A55B01723D40 AS DateTime), NULL, CAST(0x0000A559017211AC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017211AD AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (75, 8, N'41251251', CAST(0x0000A55901742970 AS DateTime), CAST(0x0000A55A01746FC0 AS DateTime), NULL, CAST(0x0000A5590174747E AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A55901747480 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (76, 8, N'156573', CAST(0x0000A5590174B610 AS DateTime), CAST(0x0000A55B0174FC60 AS DateTime), NULL, CAST(0x0000A5590174C5E8 AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A5590174C5EA AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (77, 8, N'156573', CAST(0x0000A5590174B610 AS DateTime), CAST(0x0000A55B0174FC60 AS DateTime), N'Enter your description', CAST(0x0000A5590176248A AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590176248C AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (78, 8, N'1345625', CAST(0x0000A5590176A240 AS DateTime), CAST(0x0000A55B0176E890 AS DateTime), N'12534623', CAST(0x0000A5590176DB4D AS DateTime), 2, 1, 0, 10035, 13, CAST(0x0000A5590176DB4F AS DateTime), NULL, 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (79, 8, N'12345623', CAST(0x0000A5590176E890 AS DateTime), CAST(0x0000A55B0176E890 AS DateTime), N'512263626', CAST(0x0000A5590176F842 AS DateTime), 1, 1, 0, 10035, 13, CAST(0x0000A5590176F843 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (80, 8, N'1533464434', CAST(0x0000A55A01777530 AS DateTime), CAST(0x0000A55B0177BB80 AS DateTime), NULL, CAST(0x0000A55901778248 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590177824B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (81, 8, N'512646', CAST(0x0000A55901777530 AS DateTime), CAST(0x0000A55B0177BB80 AS DateTime), NULL, CAST(0x0000A5590177B8FA AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590177B8FD AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (82, 8, N'5345623', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55C0178D4C0 AS DateTime), NULL, CAST(0x0000A5590178BB20 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590178BB23 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (83, 8, N'3465235', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55B0178D4C0 AS DateTime), NULL, CAST(0x0000A5590178D312 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590178D313 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (84, 8, N'87358374592', CAST(0x0000A55901791B10 AS DateTime), CAST(0x0000A55A01796160 AS DateTime), NULL, CAST(0x0000A55901795A21 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901795A25 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (85, 8, N'547633', CAST(0x0000A55901796160 AS DateTime), CAST(0x0000A55C0179A7B0 AS DateTime), NULL, CAST(0x0000A55901798DD0 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901798DD3 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (86, 8, N'12552352', CAST(0x0000A559017A7AA0 AS DateTime), CAST(0x0000A55A017AC0F0 AS DateTime), NULL, CAST(0x0000A559017AC75E AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017AC760 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (87, 8, N'iu3895', CAST(0x0000A559017AC0F0 AS DateTime), CAST(0x0000A55B017B0740 AS DateTime), NULL, CAST(0x0000A559017B2104 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017B2105 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (88, 8, N'5125151', CAST(0x0000A559017B93E0 AS DateTime), CAST(0x0000A55B017BDA30 AS DateTime), NULL, CAST(0x0000A559017BBD0B AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017BBD10 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (89, 8, N'36545356', CAST(0x0000A559017C2080 AS DateTime), CAST(0x0000A55C017C66D0 AS DateTime), NULL, CAST(0x0000A559017C439F AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A559017C43A1 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (90, 8, N'251125', CAST(0x0000A559017D39C0 AS DateTime), CAST(0x0000A55B017D39C0 AS DateTime), NULL, CAST(0x0000A559017D4050 AS DateTime), 0, 2, 0, 10034, 13, CAST(0x0000A559017D4055 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (91, 8, N'165678', CAST(0x0000A55901841790 AS DateTime), CAST(0x0000A55C01845DE0 AS DateTime), NULL, CAST(0x0000A55901845BF6 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901845BF8 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (92, 8, N'21354567365', CAST(0x0000A5590184A430 AS DateTime), CAST(0x0000A55D0184EA80 AS DateTime), NULL, CAST(0x0000A5590184E733 AS DateTime), 0, 1, 0, 10045, 13, CAST(0x0000A5590184EAC0 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (93, 8, N'54675', CAST(0x0000A5590184EA80 AS DateTime), CAST(0x0000A55C018530D0 AS DateTime), NULL, CAST(0x0000A55901850B69 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901850B6B AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (94, 8, N'452457', CAST(0x0000A5590185BD70 AS DateTime), CAST(0x0000A55B018603C0 AS DateTime), NULL, CAST(0x0000A5590185FE36 AS DateTime), 0, 1, 0, 10046, 13, CAST(0x0000A559018601AA AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (95, 8, N'423463', CAST(0x0000A559018603C0 AS DateTime), CAST(0x0000A55C01864A10 AS DateTime), NULL, CAST(0x0000A559018643FF AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901864404 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (96, 8, N'346563', CAST(0x0000A55C01871D00 AS DateTime), CAST(0x0000A55D01876350 AS DateTime), NULL, CAST(0x0000A5590187626D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901876271 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (97, 8, N'4656513', CAST(0x0000A55901883640 AS DateTime), CAST(0x0000A55C01887C90 AS DateTime), NULL, CAST(0x0000A55901886BCC AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55901886BD0 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (98, 8, N'534653', CAST(0x0000A559018995D0 AS DateTime), CAST(0x0000A55C0189DC20 AS DateTime), NULL, CAST(0x0000A5590189BBE5 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A5590189BBE8 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (99, 22, N'235678762143453465763524145367', CAST(0x0000A55A009FD9E0 AS DateTime), CAST(0x0000A55C009FD9E0 AS DateTime), N'13245678980', CAST(0x0000A55A00A04203 AS DateTime), 2, 1, 0, 10035, 27, CAST(0x0000A55A00A04205 AS DateTime), NULL, 1, 0, NULL)
GO
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (100, 22, N'235678762143453465763524145367', CAST(0x0000A55A009FD9E0 AS DateTime), CAST(0x0000A55C009FD9E0 AS DateTime), N'5767867969679679679', CAST(0x0000A55A00A06637 AS DateTime), 3, 1, 0, 10035, 13, CAST(0x0000A55D011BDB88 AS DateTime), N'I dont want your event in my website xD', 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (101, 22, N'143235', CAST(0x0000A55A00F6A4A0 AS DateTime), CAST(0x0000A55C00F6EAF0 AS DateTime), NULL, CAST(0x0000A55A00F6B95E AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F6B961 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (102, 22, N'345462', CAST(0x0000A55A00F84A80 AS DateTime), CAST(0x0000A55C00F890D0 AS DateTime), NULL, CAST(0x0000A55A00F85BB9 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F85BBE AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (103, 22, N'413265', CAST(0x0000A55A00F8D720 AS DateTime), CAST(0x0000A55B00F91D70 AS DateTime), NULL, CAST(0x0000A55A00F914C2 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00F914C6 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (104, 22, N'123465', CAST(0x0000A55A00FA36B0 AS DateTime), CAST(0x0000A55B00FA7D00 AS DateTime), NULL, CAST(0x0000A55A00FA6CB0 AS DateTime), 0, 1, 0, 10035, 27, CAST(0x0000A55A00FA6CB1 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (105, 8, N'1253463', CAST(0x0000A55B00B54640 AS DateTime), CAST(0x0000A55C00B58C90 AS DateTime), N'25151', CAST(0x0000A55B00B5945D AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55B00B5945F AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (106, 8, N'demo follow', CAST(0x0000A55B00B58C90 AS DateTime), CAST(0x0000A55D00B5D2E0 AS DateTime), N'demo', CAST(0x0000A55B00B5DB71 AS DateTime), 1, 5, 0, 10037, 13, CAST(0x0000A55B00B5DB74 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (107, 22, N'1345655', CAST(0x0000A55B00D6C860 AS DateTime), CAST(0x0000A55C00D70EB0 AS DateTime), N'215475', CAST(0x0000A55B00D6E16A AS DateTime), 0, 6, 0, 10048, 27, CAST(0x0000A55B00D6E403 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (108, 8, N'423582658732658236', CAST(0x0000A55C00EE6740 AS DateTime), CAST(0x0000A55D00EEAD90 AS DateTime), N'2543654756', CAST(0x0000A55C00EEC423 AS DateTime), 0, 1, 0, 10035, 13, CAST(0x0000A55C00EEC426 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (109, 8, N'demo 12184', CAST(0x0000A55D00317040 AS DateTime), CAST(0x0000A55D0031B690 AS DateTime), N'abc', CAST(0x0000A55C00F77B33 AS DateTime), 0, 1, 0, 10054, 13, CAST(0x0000A56001811546 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10108, 8, N'demo 27', CAST(0x0000A55D01163A90 AS DateTime), CAST(0x0000A55E011680E0 AS DateTime), N'demo 27', CAST(0x0000A55D011690B6 AS DateTime), 4, 1, 0, 20055, 13, CAST(0x0000A55D01169563 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10109, 8, N'43245674', CAST(0x0000A55E010087E0 AS DateTime), CAST(0x0000A5600100CE30 AS DateTime), N'&lt;ol&gt;&lt;ol&gt;&lt;li style=''text-align: center; ''&gt;&lt;img src=''http://i.imgur.com/vCBNmUy.gif'' style=''width: 215px;''&gt;&lt;span style=''background-color: rgb(247, 247, 247);''&gt;512512151&lt;/span&gt;&lt;/li&gt;&lt;/ol&gt;&lt;/ol&gt;', CAST(0x0000A55E0100DDF4 AS DateTime), 4, 1, 0, 10035, 13, CAST(0x0000A55E0100DE15 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10110, 8, N'332546', CAST(0x0000A5600182FE50 AS DateTime), CAST(0x0000A562018344A0 AS DateTime), N'&lt;p&gt;35251&lt;/p&gt;', CAST(0x0000A56001834DAD AS DateTime), 5, 1, 0, 10035, 13, CAST(0x0000A56001834DCA AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10111, 8, N'hello demo', CAST(0x0000A56200ABA950 AS DateTime), CAST(0x0000A56A00ABEFA0 AS DateTime), N'&lt;p&gt;21435&lt;/p&gt;', CAST(0x0000A56200ABD2B8 AS DateTime), 65, 1, 0, 20073, 13, CAST(0x0000A5680186E4AE AS DateTime), N'', 1, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10112, 8, N'1533534', CAST(0x0000A56200C301E0 AS DateTime), CAST(0x0000A57200C34830 AS DateTime), N'&lt;p&gt;21151&lt;/p&gt;', CAST(0x0000A56200C339B3 AS DateTime), 8, 1, 0, 10035, 13, CAST(0x0000A56200C339B9 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10113, 8, N'3263452', CAST(0x0000A56600F9F060 AS DateTime), CAST(0x0000A57000FA36B0 AS DateTime), N'&lt;p&gt;21511251&lt;/p&gt;', CAST(0x0000A56600FA0FB0 AS DateTime), 3, 1, 0, 10035, 13, CAST(0x0000A56600FA0FB4 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10114, 8, N'Giao lưu với Yui Aragaki', CAST(0x0000A5660039ADA0 AS DateTime), CAST(0x0000A5700039F3F0 AS DateTime), N'&lt;p&gt;Giao lưu với Yui&lt;/p&gt;', CAST(0x0000A56600FFD2D2 AS DateTime), 29, 1, 0, 20076, 13, CAST(0x0000A56A00F44BC6 AS DateTime), N'', 1, 1, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10115, 8, N'1211241241', CAST(0x0000A566010419F0 AS DateTime), CAST(0x0000A57001046040 AS DateTime), N'&lt;p&gt;21141241&lt;/p&gt;', CAST(0x0000A56601047AA6 AS DateTime), 5, 1, 0, 10035, 13, CAST(0x0000A56800B42BA8 AS DateTime), N'I dont want your event in my website xD', 0, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10116, 8, N'1211241241', CAST(0x0000A566010419F0 AS DateTime), CAST(0x0000A57001046040 AS DateTime), N'&lt;p&gt;21141241&lt;/p&gt;', CAST(0x0000A56601047B76 AS DateTime), 20, 1, 0, 10035, 13, CAST(0x0000A56601047B79 AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10117, 22, N'test live', CAST(0x0000A567001339E0 AS DateTime), CAST(0x0000A56F00138030 AS DateTime), N'&lt;p&gt;test live&lt;/p&gt;', CAST(0x0000A56700136847 AS DateTime), 8, 1, 0, 10035, 27, CAST(0x0000A5670013685C AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10118, 8, N'ha noi', CAST(0x0000A57E00DCD340 AS DateTime), CAST(0x0000A58000DD1990 AS DateTime), NULL, CAST(0x0000A56B00DCED6C AS DateTime), 0, 1, 1, 10035, 13, CAST(0x0000A56B00DCED6E AS DateTime), NULL, 1, 0, NULL)
INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status], [IsVerified], [LockedReason]) VALUES (10119, 8, N'ha noi', CAST(0x0000A57E00DCD340 AS DateTime), CAST(0x0000A58000DD1990 AS DateTime), NULL, CAST(0x0000A56B00DCEEB8 AS DateTime), 1, 1, 1, 10035, 13, CAST(0x0000A56B00DCEEBA AS DateTime), NULL, 1, 0, NULL)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[EventFollow] ON 

INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (7, 1, 3)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (8, 1, 5)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (59, 1, 4)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10072, 1, 12)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10098, 6, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10106, 2, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10116, 3, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10119, 15, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (10124, 104, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20130, 10109, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20132, 10108, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20134, 10111, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20135, 0, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20136, 10110, 13)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (20138, 105, 13)
SET IDENTITY_INSERT [dbo].[EventFollow] OFF
SET IDENTITY_INSERT [dbo].[EventImage] ON 

INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (1, 1, 3, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (7, 9, 10022, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (12, 40, 10040, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (13, 2, 10041, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (14, 2, 10047, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (15, 56, 10049, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (17, 10108, 20056, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (18, 108, 20057, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (19, 108, 20058, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (25, 1, 20065, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (27, 10111, 20067, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (30, 10110, 20068, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (31, 1, 20069, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (32, 9, 20070, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (33, 1, 20071, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (36, 10117, 20077, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (37, 45, 20078, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (38, 3, 20079, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (39, 3, 20080, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (40, 3, 20081, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (41, 10114, 20082, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (42, 10114, 20083, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (43, 10115, 20084, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (44, 10116, 20085, 0)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (45, 10114, 20086, 1)
INSERT [dbo].[EventImage] ([EventImageID], [EventID], [ImageID], [Approve]) VALUES (46, 10114, 20087, 1)
SET IDENTITY_INSERT [dbo].[EventImage] OFF
SET IDENTITY_INSERT [dbo].[EventPlace] ON 

INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (1, 0, 7)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (2, 1, 2)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (3, 2, 8)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (4, 3, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (5, 4, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (6, 5, 9)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (8, 6, 11)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (9, 7, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10, 8, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (11, 8, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (12, 8, 15)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (13, 9, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (14, 9, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (15, 10, 17)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (16, 11, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (17, 12, 18)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (18, 13, 19)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (19, 14, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (20, 15, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (21, 16, 20)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (22, 17, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (23, 18, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (24, 19, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (25, 20, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (26, 21, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (27, 21, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (28, 22, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (29, 23, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (30, 24, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (31, 25, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (32, 25, 21)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (33, 25, 22)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (34, 26, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (35, 27, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (36, 27, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (37, 28, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (38, 29, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (39, 30, 24)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (40, 31, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (41, 32, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (42, 33, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (43, 34, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (44, 35, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (45, 36, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (46, 38, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (47, 39, 25)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (48, 40, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (49, 41, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (50, 42, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (51, 43, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (52, 44, 13)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (53, 45, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (54, 46, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (55, 47, 26)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (56, 48, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (57, 49, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (58, 50, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (59, 51, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (60, 52, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (61, 53, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (62, 54, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (63, 55, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (64, 56, 28)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (65, 57, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (66, 58, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (67, 59, 30)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (68, 60, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (69, 61, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (70, 62, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (71, 63, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (72, 64, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (73, 65, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (74, 66, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (75, 67, 32)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (76, 68, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (77, 69, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (78, 70, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (79, 71, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (80, 72, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (81, 72, 33)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (82, 72, 34)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (83, 73, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (84, 74, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (85, 75, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (86, 76, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (87, 77, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (88, 78, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (89, 79, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (90, 80, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (91, 81, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (92, 82, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (93, 83, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (94, 84, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (95, 85, 35)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (96, 86, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (97, 87, 34)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (98, 88, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (99, 89, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (100, 90, 27)
GO
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (101, 91, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (102, 92, 36)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (103, 93, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (104, 94, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (105, 95, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (106, 96, 37)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (107, 97, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (108, 98, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (109, 99, 38)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (110, 100, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (111, 101, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (112, 102, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (113, 103, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (114, 104, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (115, 105, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (116, 106, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (117, 107, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (118, 108, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10118, 10108, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10119, 10109, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10120, 109, 39)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10121, 10110, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10123, 10112, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10124, 10113, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10126, 10115, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10127, 10116, 23)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10128, 10117, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10129, 10114, 40)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10131, 10111, 39)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10132, 10111, 16)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10133, 10114, 41)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10134, 10114, 42)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10135, 26, 40)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10136, 26, 29)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10137, 0, 14)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10138, 10118, 27)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (10139, 10119, 27)
SET IDENTITY_INSERT [dbo].[EventPlace] OFF
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (0, 1258506)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (1, 2486888)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (2, 1252381)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (3, 226656)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (4, 8575)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (5, 4900)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (6, 253599)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (7, 3675)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (8, 7350)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (9, 417774)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10, 18389)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (11, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (12, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (13, 4900)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (14, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (15, 7353)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (16, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (17, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (18, 3682)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (19, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (20, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (21, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (22, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (23, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (24, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (25, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (26, 1001225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (27, 3675)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (28, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (29, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (30, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (31, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (32, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (33, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (34, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (35, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (36, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (38, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (39, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (40, 215621)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (41, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (42, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (43, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (44, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (45, 4900)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (46, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (47, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (48, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (49, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (50, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (51, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (52, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (53, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (54, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (55, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (56, 4900)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (57, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (58, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (59, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (60, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (61, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (62, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (63, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (64, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (65, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (66, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (67, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (68, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (69, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (70, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (71, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (72, 7)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (73, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (74, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (75, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (76, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (77, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (78, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (79, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (80, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (81, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (82, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (83, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (84, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (85, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (86, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (87, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (88, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (89, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (90, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (91, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (92, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (93, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (94, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (95, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (96, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (97, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (98, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (99, 2450)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (100, 3675)
GO
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (101, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (102, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (103, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (104, 3)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (105, 3)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (106, 1225)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (107, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (108, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (109, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10108, 4910)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10109, 4910)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10110, 6135)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10111, 1077192)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10112, 9807)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10113, 3675)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10114, 1241360)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10115, 6125)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10116, 23282)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10117, 215628)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10118, 0)
INSERT [dbo].[EventRank] ([EventId], [Score]) VALUES (10119, 1225)
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (3, 2, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A53700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10005, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10006, 12, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10007, 12, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54700000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10008, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54800000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10009, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10010, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10011, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10012, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10013, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10014, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10015, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10016, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10017, 13, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A54A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10018, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/9568e4e3-403d-423a-a2ad-feb43e39a12013.png', CAST(0x0000A54B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10019, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/97c1388f-142c-411c-9d66-1477a98f52c91.png', CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10020, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2ae405b3-7952-4a54-b53b-3c753370caef1.png', CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10022, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/d188cd66-c815-443e-b394-8bd2779540fe9.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10024, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/3ee11985-1ad4-4d17-9589-3d4c09a0182a13.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10032, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/default-avatar.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10033, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Arts.png', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10034, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Food+%26+Drink.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10035, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Music.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10036, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Networking.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10037, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Parties.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10038, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/Sport+%26+Wellness.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10039, 1, N'https://s3-us-west-2.amazonaws.com/eventzone/classes.jpg', CAST(0x0000A54E00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10040, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/b672c910-e09b-4aed-9fcf-fcba68d3e46440.jpg', CAST(0x0000A55300000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10041, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/82f5254b-ce01-4e4f-9056-a1f11c9988f12.jpg', CAST(0x0000A55500000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10042, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/9986c768-fa95-4c10-9f37-26ca4c064b1d13.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10043, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/cde4eb01-981c-4e95-8297-1c1f5bef689713.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10044, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/fb3ae843-4288-4f8d-8a27-4178c472140613.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10045, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/3c54a1d4-ec19-41a0-9d98-454e6ec63e8d13.jpg', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10046, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2c241ce8-3eca-4525-8c11-96005ca1291613.png', CAST(0x0000A55900000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10047, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/c3236635-00d5-4c7c-a439-86bcff0141632.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10048, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/867b9adc-2e19-4011-8446-67c00bea1e7027.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10049, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/f6090171-470e-4a81-a25b-7263f7c520fd56.jpg', CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10050, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/a155a75d-a705-44dc-93dd-74607d1aac4e13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10051, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/a5552686-0e32-49aa-b632-172ae44c22b413.png', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10052, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/c95701d0-715e-4017-a205-13607cfc2bfd13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10053, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/2150c1f9-8395-42f3-a063-b05b03da93b113.png', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (10054, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/bfb4d751-6e99-465e-afd8-de093353fa0b13.jpg', CAST(0x0000A55C00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20055, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/69ce9775-ed56-429a-be06-11f63fc5285413.png', CAST(0x0000A55D00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20056, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/bcfbdaef-4498-4068-8304-3a2c37491a4710108.jpg', CAST(0x0000A55D00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20057, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/1ec927d3-004e-4ff6-9cca-67e4246fa909108.jpg', CAST(0x0000A56000000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20058, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/e731ba69-e0da-454b-9873-171c98532085108.jpg', CAST(0x0000A56000000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20059, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/db38c90f-ac5d-451b-bf41-4cecb077f8a613.jpg', CAST(0x0000A56200000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20065, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/7eab89fe-1d7e-469d-88d3-4242fd03c38b1.jpg', CAST(0x0000A56500000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20067, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/d70b7227-76c6-420d-a104-e2d90914ad2d10111.jpg', CAST(0x0000A56500000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20068, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/c788cd4f-4c4c-4d71-a10e-b353822c63f710110.jpg', CAST(0x0000A56500000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20069, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/af08ea42-616b-4960-9041-43e24b6bb57c1.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20070, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/192343e6-9500-4a28-b33e-273d8ea05b039.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20071, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/c3b2c1ff-d77c-4c3a-b7aa-33fa1affba171.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20072, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/7cc27674-c7a4-4a0e-90a8-0da99c93094d13.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20073, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/586db74b-1a32-4769-b606-37c6e0c3248013.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20076, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/8238c1e6-7788-4646-957a-84a06953de5513.jpg', CAST(0x0000A56600000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20077, 2, N'https://s3-us-west-2.amazonaws.com/eventzone/e316bcf1-d0e6-4f9f-a29e-c06a04baa9b110117.jpg', CAST(0x0000A56A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20078, 2, N'https://s3-us-west-2.amazonaws.com/eventzone/8aea4c6a-c3ea-46bf-a7bb-13efec7af73b45.png', CAST(0x0000A56A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20079, 2, N'https://s3-us-west-2.amazonaws.com/eventzone/2a64d694-0e3d-4c18-bc46-816a8b069e0c3.jpg', CAST(0x0000A56A00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20080, 2, N'https://s3-us-west-2.amazonaws.com/eventzone/d3a04227-29d3-481b-82f5-cf87b90b76e23.png', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20081, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/192548e9-f092-4185-acda-778d03e83dc23.png', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20082, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/267fc020-e0c4-4f66-9529-a45192d649b910114.jpg', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20083, 2, N'https://s3-us-west-2.amazonaws.com/eventzone/d29016da-2209-4794-9228-5088b6c322cd10114.png', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20084, 13, N'https://s3-us-west-2.amazonaws.com/eventzone/4f02ae69-3ab6-4e31-90c3-4d1c44ecd66d10115.jpg', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20085, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/db567522-e589-4dc2-9ea6-2ebaaf789d4310116.jpg', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20086, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/39cf1882-1082-4856-b6a9-70407048834910114.jpg', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20087, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/79d49349-98e6-4db6-b013-5dc9e5400a2d10114.jpg', CAST(0x0000A56B00000000 AS DateTime))
INSERT [dbo].[Image] ([ImageID], [UserID], [ImageLink], [UploadDate]) VALUES (20088, 27, N'https://s3-us-west-2.amazonaws.com/eventzone/8f2a9143-0fdb-4ed7-9b92-854546c5e6b427.png', CAST(0x0000A56B00000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[Image] OFF
SET IDENTITY_INSERT [dbo].[LikeDislike] ON 

INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (1, 1, 2, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (2, 1, 3, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (3, 1, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (4, 1, 12, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (5, 2, 13, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (6, 3, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (7, 0, 13, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (8, 6, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (9, 9, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (10, 9, 27, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (11, 1, 27, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (12, 40, 27, -1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (13, 10114, 13, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (14, 10117, 2, 1)
SET IDENTITY_INSERT [dbo].[LikeDislike] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (2, 105.837017, 21.030379, N'Bảo tàng Mỹ thuật Việt Nam, 66 Nguyễn Thái Học, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (3, 105.84899, 21.022947, N'Trung tâm Giao lưu Văn hóa Nhật Bản tại Việt Nam 27 Quang Trung, Hoàn Kiếm, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (4, 105.856258, 21.024564, N'Swing 21 Tràng Tiền, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (5, 105.876266, 21.047961, N'Tầng 2, 292 Tây Sơn, Tòa nhà Kinh Đô, Quận Đống Đa, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (7, 105.526555, 21.013629, N'Đại học FPT thạch thất hà nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (8, 105.52655549999996, 21.0136289, N'FPT University, Thạch Thất, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (9, 105.83415979999997, 21.0277644, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (10, 152.93236019999995, -27.7369652, N'Queensland, 4124, Úc')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (11, 105.86075069999993, 21.0090571, N'Hai Bà Trưng, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (12, 75.87663329999998, 29.6507626, N'125120, Ấn Độ')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (13, 105.83415979999995, 21.0277644, N'Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (14, 105.52106070000002, 20.9891204, N'Hòa Lạc, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (15, 105.81716359999996, 21.0316851, N'FPT Hà Nội, Vạn Bảo, Ngọc Khánh, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (16, 105.54157550000002, 21.0075179, N'Hoa Lac Hi-Tech Park, tt. Liên Quan, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (17, 7.2499212000000171, 51.0489965, N'51515, Kürten, Đức')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (18, 105.84276879999993, 21.0278995, N'21412 Hà Nội, Cửa Nam, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (19, 105.97880110000006, 21.0792026, N'VSIP Bắc Ninh, tx. Từ Sơn, Bắc Ninh, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (20, 105.85230590000003, 21.0137888, N'Ha Tay Co., Ltd, Ngô Thì Nhậm, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (21, 105.85725189999994, 21.0228524, N'Cua Long Shop, Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (22, 105.84878679999997, 21.0368623, N'Ha Long Hotel, Hàng Mã, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (23, 105.84260710000001, 21.0252277, N'Hà Nội, Cửa Nam, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (24, 105.8529595, 21.0323006, N'Democracy Hotel, Cầu Gỗ, Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (25, 105.83616970000003, 21.0546707, N'H Mart, Yên Phụ, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (26, 105.84415190000004, 21.0267781, N'Hà Nội branch, Hai Bà Trưng, Cửa Nam, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (27, 105.83415979999995, 21.0277644, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (28, 105.84778640000002, 21.0098302, N'Hoa Lư, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (29, 105.54157550000002, 21.0075179, N'Khu Công nghệ cao Hòa Lạc, tt. Liên Quan, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (30, 105.84598789999996, 20.9964525, N'124 Đại La, Đại La, Trương Định, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (31, 105.83415979999995, 21.0277644, N'Hanoi Vietnam, Đường Thành, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (32, 105.54157550000002, 21.0075179, N'ha noi')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (33, 105.7822605, 21.0285295, N'FPT University, Mỹ Đình 2, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (34, 105.52748889999998, 21.0136689, N'FPT University, Thạch Thất, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (35, 3.9118720000000167, 51.8031945, N'3253 Ouddorp, Hà Lan')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (36, 105.85101320000001, 21.027964, N'Hoàn Kiếm, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (37, 105.852666, 21.008647, N'536 Trần Khát Chân, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (38, 18.08470710000006, 59.2363294, N'123 46 Stockholm, Thuỵ Điển')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (39, 105.8341598, 21.0277644, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (40, 105.8341598, 21.0277644, N'Hà Noi, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (41, 105.5210607, 20.9891204, N'Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (42, 105.5210607, 20.9891204, N'Hòa Lạc, Hà Nội, Việt Nam')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (43, 0, 0, N'Remove Location')
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (1, 13)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (2, 36)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (3, 2)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (4, 4)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (5, 12)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (6, 33)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (7, 31)
INSERT [dbo].[Notification] ([ID], [UserID]) VALUES (8, 27)
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[NotificationChange] ON 

INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (3, 2, 13, 10111, 1, CAST(0x0000A56200ABDEF0 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (4, 3, 13, 10111, 1, CAST(0x0000A56200ABDF06 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (5, 2, 13, 10112, 1, CAST(0x0000A56200C33A91 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (6, 3, 13, 10112, 1, CAST(0x0000A56200C33AA6 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (7, 4, 2, 10, 1, CAST(0x0000A56200D7DC77 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (8, 4, 34, 10, 1, CAST(0x0000A56200D82D30 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (9, 5, 13, 5, 1, CAST(0x0000A56200DA39B7 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (10, 6, 13, 1, 1, CAST(0x0000A56200EFF3A8 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (11, 7, 13, 1, 1, CAST(0x0000A56200EFF6BA AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (19, 8, 2, 10, 1, CAST(0x0000A5620103DF03 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (20, 9, 13, 10, 1, CAST(0x0000A5620103EE61 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (21, 8, 2, 10, 1, CAST(0x0000A5620103F93A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (23, 1, 33, NULL, 1, CAST(0x0000A56201133C87 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (26, 1, 2, NULL, 1, CAST(0x0000A562011CB14D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (27, 1, 31, NULL, 1, CAST(0x0000A562011AC58B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (28, 8, 2, 10111, 1, CAST(0x0000A562011D3E2A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (29, 9, 13, 10111, 1, CAST(0x0000A562011D5690 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (30, 10, 13, 1, 1, CAST(0x0000A56300506711 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (31, 11, 13, NULL, 0, CAST(0x0000A5630050E36A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (32, 10, 4, 1, 1, CAST(0x0000A56300512B4A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (33, 8, 4, 1, 1, CAST(0x0000A56300512B52 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (34, 12, 13, 1, 1, CAST(0x0000A56400CD9173 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (35, 10, 13, 1, 1, CAST(0x0000A56400CD917E AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (36, 12, 13, 1, 1, CAST(0x0000A56400CD9AEE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (37, 10, 13, 1, 1, CAST(0x0000A56400CD9AF2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (38, 12, 13, 1, 1, CAST(0x0000A56400CE9CB6 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (39, 10, 13, 1, 1, CAST(0x0000A56400CE9CBC AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (40, 9, 13, 10111, 1, CAST(0x0000A56400DC03F2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (41, 9, 13, 10111, 1, CAST(0x0000A56400DC049B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (42, 9, 13, 10111, 1, CAST(0x0000A56400DC4D53 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (43, 9, 13, 10111, 1, CAST(0x0000A56400DC5E60 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (44, 9, 13, 10111, 1, CAST(0x0000A56400DC906B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (45, 12, 13, 1, 1, CAST(0x0000A56400DDC0C6 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (46, 10, 13, 1, 1, CAST(0x0000A56400DDC0D1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (47, 12, 13, 1, 1, CAST(0x0000A56400DDC576 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (48, 10, 13, 1, 1, CAST(0x0000A56400DDC57A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (49, 12, 13, 1, 1, CAST(0x0000A56400DDE7C9 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (50, 10, 13, 1, 1, CAST(0x0000A56400DDE7D3 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (51, 12, 13, 1, 1, CAST(0x0000A56400DE08F1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (52, 10, 13, 1, 1, CAST(0x0000A56400DE08F9 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (53, 12, 13, 1, 1, CAST(0x0000A56400DE2874 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (54, 10, 13, 1, 1, CAST(0x0000A56400DE287D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (55, 12, 13, 1, 1, CAST(0x0000A56400DF0A0D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (56, 10, 13, 1, 1, CAST(0x0000A56400DF0A25 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (57, 12, 13, 1, 1, CAST(0x0000A56400DF1B6F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (58, 10, 13, 1, 1, CAST(0x0000A56400DF1B73 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (59, 12, 13, 1, 1, CAST(0x0000A56400E01B41 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (60, 10, 13, 1, 1, CAST(0x0000A56400E01B43 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (61, 9, 13, 10111, 1, CAST(0x0000A56400E14201 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (62, 9, 13, 10111, 1, CAST(0x0000A56400E155E7 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (63, 9, 13, 10111, 1, CAST(0x0000A56400E15D7C AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (64, 9, 13, 10111, 1, CAST(0x0000A56400E16302 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (65, 9, 13, 10111, 1, CAST(0x0000A56400E2DF03 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (66, 9, 13, 10111, 1, CAST(0x0000A56400E34C75 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (67, 9, 13, 10111, 1, CAST(0x0000A56400E591C3 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (68, 9, 13, 10111, 1, CAST(0x0000A56400E5A9E2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (69, 9, 13, 10111, 1, CAST(0x0000A56400E5AD48 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (70, 2, 13, 10113, 0, CAST(0x0000A56600FA0FFA AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (71, 13, 13, 10113, 0, CAST(0x0000A56600FA101A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (72, 14, 13, 10113, 0, CAST(0x0000A56600FA101F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (73, 3, 13, 10113, 1, CAST(0x0000A56600FA1021 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (74, 2, 13, 10114, 0, CAST(0x0000A56600FFF70F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (75, 13, 13, 10114, 0, CAST(0x0000A56600FFF719 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (76, 14, 13, 10114, 0, CAST(0x0000A56600FFF71B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (77, 3, 13, 10114, 1, CAST(0x0000A56600FFF71D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (78, 2, 13, 10115, 0, CAST(0x0000A56601047AD9 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (79, 13, 13, 10115, 0, CAST(0x0000A56601047ADE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (80, 14, 13, 10115, 0, CAST(0x0000A56601047AE1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (81, 3, 13, 10115, 1, CAST(0x0000A56601047AE4 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (82, 2, 13, 10116, 0, CAST(0x0000A56601047BA6 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (83, 13, 13, 10116, 0, CAST(0x0000A56601047BA8 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (84, 14, 13, 10116, 0, CAST(0x0000A56601047BAB AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (85, 3, 13, 10116, 1, CAST(0x0000A56601047BAC AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (86, 5, 13, 0, 1, CAST(0x0000A56700F55515 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (87, 15, 13, 0, 1, CAST(0x0000A56700F556FE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (88, 6, 13, 1, 0, CAST(0x0000A56800A8B60F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (89, 7, 13, 1, 0, CAST(0x0000A56800A8B74E AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (90, 5, 13, 10115, 1, CAST(0x0000A56800B3D344 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (91, 15, 13, 10115, 1, CAST(0x0000A56800B3D458 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (92, 5, 13, 10115, 1, CAST(0x0000A56800B3D698 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (93, 15, 13, 10115, 1, CAST(0x0000A56800B3D928 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (94, 5, 13, 10115, 1, CAST(0x0000A56800B3DD3E AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (95, 15, 13, 10115, 1, CAST(0x0000A56800B3DFE9 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (96, 5, 13, 10115, 1, CAST(0x0000A56800B3E886 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (97, 15, 13, 10115, 1, CAST(0x0000A56800B4234E AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (98, 5, 13, 10115, 1, CAST(0x0000A56800B42BB5 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (99, 5, 13, 0, 1, CAST(0x0000A56801476520 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (100, 5, 13, 0, 1, CAST(0x0000A5680147658A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (101, 5, 13, 0, 1, CAST(0x0000A56801477253 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (102, 15, 13, 0, 1, CAST(0x0000A568014872AA AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (103, 5, 13, 0, 1, CAST(0x0000A568014874F1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (104, 15, 13, 0, 1, CAST(0x0000A5680148770F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (105, 15, 13, 0, 1, CAST(0x0000A568014883CF AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (106, 5, 13, 0, 1, CAST(0x0000A5680148B3A3 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (107, 5, 13, 0, 1, CAST(0x0000A5680148C7CE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (108, 15, 13, 0, 1, CAST(0x0000A5680148CA07 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (109, 5, 13, 0, 1, CAST(0x0000A568014908AA AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (110, 5, 13, 0, 1, CAST(0x0000A56801491F10 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (111, 15, 13, 0, 1, CAST(0x0000A568014966E5 AS DateTime))
GO
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (112, 5, 13, 0, 1, CAST(0x0000A568014972F8 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (113, 15, 13, 0, 1, CAST(0x0000A5680169C4C7 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (114, 5, 13, 0, 1, CAST(0x0000A5680169C7B5 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (115, 15, 13, 0, 1, CAST(0x0000A5680169D982 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (116, 5, 13, 0, 1, CAST(0x0000A56801726430 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (117, 15, 13, 0, 1, CAST(0x0000A568017266EB AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (118, 5, 13, 0, 1, CAST(0x0000A568017268BD AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (119, 5, 13, 0, 1, CAST(0x0000A56801727B87 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (120, 15, 13, 0, 1, CAST(0x0000A5680172BE0B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (121, 15, 13, 0, 1, CAST(0x0000A5680172D815 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (122, 5, 13, 0, 1, CAST(0x0000A568017668E2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (123, 15, 13, 0, 1, CAST(0x0000A56801776059 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (124, 5, 13, 0, 1, CAST(0x0000A56801777112 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (125, 5, 13, 10114, 1, CAST(0x0000A56801867BC1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (126, 15, 13, 10114, 1, CAST(0x0000A568018688F8 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (127, 5, 13, 10111, 1, CAST(0x0000A5680186DE3F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (128, 15, 13, 10111, 1, CAST(0x0000A5680186E4E0 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (129, 5, 13, 26, 1, CAST(0x0000A56900D90EE6 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (130, 15, 13, 26, 1, CAST(0x0000A56900D9112A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (131, 15, 13, 26, 1, CAST(0x0000A56900D917A2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (132, 5, 13, 26, 1, CAST(0x0000A56900D91A43 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (133, 15, 13, 26, 1, CAST(0x0000A56900D91BD4 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (134, 5, 13, 26, 1, CAST(0x0000A56900D91FCB AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (135, 15, 13, 0, 1, CAST(0x0000A56900D92DCD AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (136, 5, 13, 0, 1, CAST(0x0000A56900D99006 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (137, 15, 13, 0, 1, CAST(0x0000A56900D99325 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (138, 15, 13, 2, 1, CAST(0x0000A56900D9C7E8 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (139, 15, 13, 2, 1, CAST(0x0000A56900D9D686 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (140, 15, 13, 3, 1, CAST(0x0000A56900D9EDE5 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (141, 5, 13, 0, 1, CAST(0x0000A56900DA4CAA AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (142, 6, 13, 1, 0, CAST(0x0000A56900DC9649 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (143, 15, 13, 0, 1, CAST(0x0000A56900DD7F69 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (144, 5, 13, 0, 1, CAST(0x0000A56900DD8870 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (145, 15, 13, 0, 1, CAST(0x0000A56A0005621D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (146, 5, 13, 0, 1, CAST(0x0000A56A000564FE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (147, 15, 13, 0, 1, CAST(0x0000A56A000D0B9B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (148, 5, 13, 0, 1, CAST(0x0000A56A000D1BF1 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (149, 15, 13, 0, 1, CAST(0x0000A56A000D2018 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (150, 5, 13, 0, 1, CAST(0x0000A56A000D218C AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (151, 5, 13, 2, 1, CAST(0x0000A56A000D2A0B AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (152, 15, 13, 0, 1, CAST(0x0000A56A000FC440 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (153, 7, 13, 1, 0, CAST(0x0000A56A000FC513 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (154, 15, 13, 2, 1, CAST(0x0000A56A000FC7BF AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (155, 16, 2, 3, 1, CAST(0x0000A56A0189BE4D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (156, 16, 2, 3, 1, CAST(0x0000A56B00017701 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (157, 16, 27, 3, 1, CAST(0x0000A56B0001BF0D AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (158, 16, 27, 10114, 1, CAST(0x0000A56B0002C659 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (159, 16, 2, 10114, 1, CAST(0x0000A56B0002F3F0 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (160, 16, 27, 10114, 1, CAST(0x0000A56B001E3CBE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (161, 17, 13, 10114, 1, CAST(0x0000A56B001FEE9A AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (162, 8, 27, 10114, 1, CAST(0x0000A56B00201190 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (163, 2, 13, 10118, 0, CAST(0x0000A56B00DCEE4E AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (164, 13, 13, 10118, 0, CAST(0x0000A56B00DCEE61 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (165, 14, 13, 10118, 0, CAST(0x0000A56B00DCEE63 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (166, 3, 13, 10118, 0, CAST(0x0000A56B00DCEE66 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (167, 2, 13, 10119, 0, CAST(0x0000A56B00DCEEED AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (168, 13, 13, 10119, 0, CAST(0x0000A56B00DCEEEE AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (169, 14, 13, 10119, 0, CAST(0x0000A56B00DCEEF0 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (170, 3, 13, 10119, 0, CAST(0x0000A56B00DCEEF2 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (171, 8, 27, 10114, 1, CAST(0x0000A56B00FA6842 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (172, 8, 27, 10114, 1, CAST(0x0000A56B00FA8422 AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (173, 8, 27, 10114, 1, CAST(0x0000A56B00FA945F AS DateTime))
INSERT [dbo].[NotificationChange] ([ID], [NotificationObjectID], [ActorID], [EventID], [IsRead], [CreatedDate]) VALUES (174, 5, 13, 2, 1, CAST(0x0000A56D0016D694 AS DateTime))
SET IDENTITY_INSERT [dbo].[NotificationChange] OFF
SET IDENTITY_INSERT [dbo].[NotificationObject] ON 

INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (1, 1, 4)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (2, 2, 1)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (3, 3, 1)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (4, 1, 3)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (5, 1, 6)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (6, 4, 6)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (7, 4, 7)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (8, 1, 2)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (9, 3, 2)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (10, 5, 2)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (11, 4, 4)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (12, 4, 2)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (13, 6, 1)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (14, 7, 1)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (15, 1, 7)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (16, 1, 5)
INSERT [dbo].[NotificationObject] ([ID], [NotificationID], [Type]) VALUES (17, 8, 2)
SET IDENTITY_INSERT [dbo].[NotificationObject] OFF
SET IDENTITY_INSERT [dbo].[PeopleFollow] ON 

INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (3, 13, 3)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (18, 36, 13)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (20, 13, 1)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (23, 13, 2)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (34, 33, 13)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (35, 31, 13)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (36, 2, 13)
INSERT [dbo].[PeopleFollow] ([PeopleFollowID], [FollowerUserID], [FollowingUserID]) VALUES (37, 13, 4)
SET IDENTITY_INSERT [dbo].[PeopleFollow] OFF
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (1, 1, 13, 1, N'', 1, CAST(0x0000A55B0025A8F3 AS DateTime), CAST(0x0000A55C0020391E AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (2, 2, 13, 1, N'', 3, CAST(0x0000A55B002B325A AS DateTime), CAST(0x0000A55E013F1FAB AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (3, 13, 13, 1, N'', 1, CAST(0x0000A55B002B747A AS DateTime), CAST(0x0000A56100BB494E AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (4, 6, 13, 1, N'', 1, CAST(0x0000A55B002CA0C1 AS DateTime), CAST(0x0000A55E01769CA7 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (5, 1, 2, 1, N'', 3, CAST(0x0000A55B002D784C AS DateTime), CAST(0x0000A55C000F8796 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (6, 3, 2, 1, N'', 1, CAST(0x0000A55B002E533B AS DateTime), CAST(0x0000A55E0173EB1F AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (7, 4, 2, 1, N'', 1, CAST(0x0000A55B00320256 AS DateTime), CAST(0x0000A55E017384CF AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (8, 5, 2, 1, N'', 1, CAST(0x0000A55B00328397 AS DateTime), CAST(0x0000A55E01767085 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (9, 8, 2, 1, N'', 2, CAST(0x0000A55B003302DD AS DateTime), CAST(0x0000A5610013EC3C AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (10, 7, 2, 1, N'', 2, CAST(0x0000A55B003371CD AS DateTime), CAST(0x0000A56100BB217D AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (11, 11, 2, 2, N'', 0, CAST(0x0000A55B0033F8A2 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (12, 15, 2, 2, N'', 0, CAST(0x0000A55B0034C417 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (13, 41, 2, 2, N'', 0, CAST(0x0000A55B003545F6 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (14, 42, 2, 1, N'', 0, CAST(0x0000A55B0035F78B AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (15, 62, 2, 1, N'', 0, CAST(0x0000A55B00367663 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (16, 76, 2, 2, N'', 0, CAST(0x0000A55B003777E6 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (17, 16, 2, 2, N'', 0, CAST(0x0000A55B00388915 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (18, 56, 2, 1, N'', 0, CAST(0x0000A55B00398363 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (19, 75, 2, 1, N'', 0, CAST(0x0000A55B003B63BD AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (20, 78, 2, 8, N'', 1, CAST(0x0000A55B003BA28E AS DateTime), CAST(0x0000A56100BB6406 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (21, 79, 2, 9, N'', 0, CAST(0x0000A55B003BE78B AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (22, 26, 2, 9, N'', 0, CAST(0x0000A55B003CB262 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (23, 1, 27, 1, N'', 3, CAST(0x0000A55B00D65C31 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (24, 2, 27, 2, N'252465512346', 3, CAST(0x0000A55B00D6916D AS DateTime), CAST(0x0000A55C00167FDB AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (25, 2, 33, 1, N'', 1, CAST(0x0000A5610045C5AB AS DateTime), CAST(0x0000A56100A3F006 AS DateTime), 13)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (26, 10108, 36, 1, N'', 0, CAST(0x0000A561014D2F92 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (27, 10, 2, 1, N'', 0, CAST(0x0000A56200D7DC22 AS DateTime), NULL, NULL)
INSERT [dbo].[Report] ([ReportID], [EventID], [SenderID], [ReportType], [ReportContent], [ReportStatus], [ReportDate], [HandleDate], [HandleBy]) VALUES (28, 10, 34, 1, N'', 0, CAST(0x0000A56200D82D18 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Report] OFF
SET IDENTITY_INSERT [dbo].[ReportDefine] ON 

INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (1, N'Sexual content', N'Includes graphic sexual activity, nudity, and other sexual content.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (2, N'Violent or repulsive content', N'Violent or graphic content, or content posted to shock viewers.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (8, N'Hateful or abusive content', N'Content that promotes hatred against protected groups, abuses vulnerable individuals, or engages in cyberbullying.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (9, N'Harmful dangerous acts', N'Content that includes acts that may result in physical harm')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (10, N'Child abuse', N'Content that includes sexual, predatory or abusive communications towards minors.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (11, N'Spam or misleading', N'Content that is massively posted or otherwise misleading in nature.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (12, N'Infringes my rights', N'Privacy, copyright and other legal complaints.')
INSERT [dbo].[ReportDefine] ([ReportTypeID], [ReportTypeName], [ReportDefine]) VALUES (13, N'Other', N'Other violation')
SET IDENTITY_INSERT [dbo].[ReportDefine] OFF
SET IDENTITY_INSERT [dbo].[TrackingAction] ON 

INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (7, 13, 13, 2, 0, 1, CAST(0x0000A5540028077D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (8, 13, 13, 2, 0, 1, CAST(0x0000A55400280C89 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (9, 13, 4, 2, 0, 1, CAST(0x0000A55400281135 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10, 13, 13, 2, 0, 1, CAST(0x0000A55400291263 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (11, 13, 13, 2, 0, 1, CAST(0x0000A554002B137E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (12, 13, 13, 2, 0, 1, CAST(0x0000A554002B176F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (13, 13, 13, 2, 0, 1, CAST(0x0000A554002D35F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (14, 13, 4, 2, 0, 1, CAST(0x0000A554002DDD85 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (15, 13, 4, 2, 0, 1, CAST(0x0000A554002E7B7C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (16, 13, 4, 2, 0, 1, CAST(0x0000A554002F7A57 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (17, 13, 13, 2, 0, 1, CAST(0x0000A5540032505C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (18, 13, 13, 2, 0, 1, CAST(0x0000A5540035504A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (19, 13, 13, 2, 0, 1, CAST(0x0000A55400355B74 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20, 13, 13, 2, 0, 1, CAST(0x0000A5540037E92B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (21, 13, 13, 2, 0, 1, CAST(0x0000A55400380ECE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (22, 13, 13, 2, 0, 1, CAST(0x0000A554003826F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (23, 13, 13, 2, 0, 1, CAST(0x0000A55400383B06 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (24, 13, 13, 2, 0, 1, CAST(0x0000A5540038A036 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (25, 13, 4, 2, 0, 1, CAST(0x0000A5540038E93C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (26, 13, 13, 2, 0, 1, CAST(0x0000A5540038FB69 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (27, 13, 13, 2, 0, 1, CAST(0x0000A5540038FF8E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (28, 13, 13, 2, 0, 1, CAST(0x0000A554003A17F8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (29, 13, 13, 2, 0, 1, CAST(0x0000A554003A9E6E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (30, 13, 13, 2, 0, 2, CAST(0x0000A554003CD738 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (31, 13, 4, 2, 0, 2, CAST(0x0000A554003D33AE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (32, 13, 13, 2, 0, 2, CAST(0x0000A554003DA2E3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (33, 13, 13, 2, 0, 2, CAST(0x0000A554003DA4F7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (34, 13, 13, 2, 0, 2, CAST(0x0000A554003DA8B0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (35, 13, 13, 2, 0, 1, CAST(0x0000A554003DBE8D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (36, 13, 13, 2, 0, 2, CAST(0x0000A554003DC128 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (37, 13, 13, 2, 0, 1, CAST(0x0000A554003DC2EF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (38, 13, 13, 2, 0, 2, CAST(0x0000A554003DC757 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (39, 13, 13, 2, 0, 1, CAST(0x0000A554003DC899 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (40, 13, 13, 2, 0, 2, CAST(0x0000A554003DCE55 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (41, 13, 13, 2, 0, 1, CAST(0x0000A554003DD031 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (42, 13, 13, 2, 0, 2, CAST(0x0000A554003DD168 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (43, 13, 13, 2, 0, 1, CAST(0x0000A554003DE96F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (44, 13, 13, 2, 0, 2, CAST(0x0000A554003DEAEF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (45, 13, 13, 2, 0, 1, CAST(0x0000A554003DEC46 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (46, 13, 13, 2, 0, 2, CAST(0x0000A554003DEDEC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (47, 13, 13, 2, 0, 1, CAST(0x0000A554003DEF39 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (48, 13, 13, 2, 0, 2, CAST(0x0000A554003DF094 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (49, 13, 13, 2, 0, 1, CAST(0x0000A554003DF1DD AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (50, 13, 13, 2, 0, 2, CAST(0x0000A554003DF2FB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (51, 13, 13, 2, 0, 1, CAST(0x0000A554003DF431 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (52, 13, 13, 2, 0, 2, CAST(0x0000A554003DF73F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (53, 13, 4, 2, 0, 1, CAST(0x0000A554003DF942 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (54, 13, 4, 2, 0, 1, CAST(0x0000A554003F1C4F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (55, 13, 4, 2, 0, 2, CAST(0x0000A55400406D07 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (56, 13, 4, 2, 0, 1, CAST(0x0000A554004512C8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (57, 13, 4, 2, 0, 2, CAST(0x0000A554004555CE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (58, 13, 4, 2, 0, 1, CAST(0x0000A55400455CD8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (59, 13, 4, 2, 0, 2, CAST(0x0000A55400456C62 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (60, 13, 4, 2, 0, 1, CAST(0x0000A55400458CD1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (61, 13, 4, 2, 0, 1, CAST(0x0000A554004745A8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (62, 13, 4, 2, 0, 2, CAST(0x0000A554004753F0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (63, 13, 4, 2, 0, 1, CAST(0x0000A5540047E0CA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (64, 13, 4, 2, 0, 2, CAST(0x0000A5540047E291 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (65, 13, 13, 2, 0, 1, CAST(0x0000A554004AC7E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (66, 13, 13, 2, 0, 2, CAST(0x0000A554004AC9BB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (67, 13, 1, 2, 0, 4, CAST(0x0000A554005CD761 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (68, 13, 1, 2, 0, 4, CAST(0x0000A554005CE58D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (69, 13, 1, 2, 0, 4, CAST(0x0000A554005D697E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (70, 13, 1, 2, 0, 4, CAST(0x0000A554005D6DEF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (71, 13, 1, 2, 0, 4, CAST(0x0000A554005D6F71 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (72, 13, 1, 2, 0, 1, CAST(0x0000A554005E0A6D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (73, 13, 2, 2, 0, 1, CAST(0x0000A554005E5291 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (74, 13, 1, 2, 0, 4, CAST(0x0000A554005F90D1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (75, 13, 1, 2, 0, 1, CAST(0x0000A554005F971F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (76, 13, 1, 2, 0, 4, CAST(0x0000A554005F9C89 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (77, 13, 2, 2, 0, 4, CAST(0x0000A554005FAB96 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10067, 13, 1, 2, 0, 1, CAST(0x0000A55400E7A165 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (10068, 13, 1, 2, 0, 4, CAST(0x0000A5540104B9C8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20068, 13, 13, 2, 0, 1, CAST(0x0000A5540115C0EA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20069, 13, 13, 2, 0, 2, CAST(0x0000A5540115C691 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20070, 13, 1, 2, 0, 1, CAST(0x0000A5540115CF37 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20071, 13, 1, 2, 0, 4, CAST(0x0000A5540115D111 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20072, 13, 13, 2, 0, 1, CAST(0x0000A55A000EE26B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20073, 13, 13, 2, 0, 2, CAST(0x0000A55A000EE7EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20074, 13, 1, 2, 0, 1, CAST(0x0000A55A000F08CC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20075, 13, 1, 2, 0, 4, CAST(0x0000A55A000F0BE6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20076, 13, 1, 2, 0, 1, CAST(0x0000A55A008DEC55 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20077, 13, 1, 2, 0, 4, CAST(0x0000A55A008DEF1F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20078, 13, 1, 2, 0, 5, CAST(0x0000A55A008E789F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20079, 13, 1, 2, 0, 5, CAST(0x0000A55A008EA193 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20080, 13, 1, 2, 0, 5, CAST(0x0000A55A008FE574 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20081, 13, 1, 2, 0, 5, CAST(0x0000A55A00902E41 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20082, 13, 1, 2, 0, 5, CAST(0x0000A55A0092D640 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20083, 13, 1, 2, 0, 5, CAST(0x0000A55A00938544 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20084, 13, 1, 2, 0, 5, CAST(0x0000A55A0095B424 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20085, 13, 1, 2, 0, 5, CAST(0x0000A55A00963133 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20086, 13, 1, 2, 0, 5, CAST(0x0000A55A009D3A36 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20087, 13, 3, 2, 0, 1, CAST(0x0000A55A00B192C4 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20088, 13, 3, 2, 0, 4, CAST(0x0000A55A00B19570 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20089, 13, 1, 2, 0, 5, CAST(0x0000A55A00B35399 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20090, 13, 1, 2, 0, 5, CAST(0x0000A55A00B36F2D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20091, 13, 9, 2, 0, 5, CAST(0x0000A55A00B3C009 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20092, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3D131 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20093, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3D410 AS DateTime))
GO
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20094, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3DD16 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20095, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3DED9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20096, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3E06A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20097, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3E39C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20098, 13, 1, 2, 0, 1, CAST(0x0000A55A00B3ECC0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20099, 13, 1, 2, 0, 4, CAST(0x0000A55A00B3F228 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20100, 13, 4, 2, 0, 1, CAST(0x0000A55A00B41BFE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20101, 13, 4, 2, 0, 2, CAST(0x0000A55A00B427EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20102, 13, 4, 2, 0, 1, CAST(0x0000A55A00B433EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20103, 13, 4, 2, 0, 2, CAST(0x0000A55A00B442C6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20104, 13, 1, 2, 0, 1, CAST(0x0000A55A00B5D0C7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20105, 13, 1, 2, 0, 4, CAST(0x0000A55A00B5D3E3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20106, 13, 1, 2, 0, 5, CAST(0x0000A55A00FAE3BE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20107, 13, 1, 2, 0, 1005, CAST(0x0000A55A0108A4BD AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20108, 13, 2, 2, 0, 1005, CAST(0x0000A55A0108B826 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20109, 13, 3, 2, 0, 1005, CAST(0x0000A55A010A2FCA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20116, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EAA40 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20117, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EB178 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20118, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EB536 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20119, 13, 1, 2, 0, 1006, CAST(0x0000A55A010ECBD3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20120, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EDD35 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20121, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EE1AF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20122, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EE5A8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20123, 13, 1, 2, 0, 1006, CAST(0x0000A55A010EE912 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20124, 13, 1, 2, 0, 1005, CAST(0x0000A55A010EF066 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20125, 13, 1, 2, 0, 1006, CAST(0x0000A55A011092E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20126, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110AC04 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20127, 13, 3, 2, 0, 1006, CAST(0x0000A55A0110B190 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20128, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110BFD2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20129, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110D029 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20130, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110DA97 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20131, 13, 1, 2, 0, 1005, CAST(0x0000A55A0110E5AC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20132, 13, 1, 2, 0, 1006, CAST(0x0000A55A0110EEBF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20133, 13, 1, 2, 0, 1005, CAST(0x0000A55A01115166 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20134, 13, 1, 2, 0, 1006, CAST(0x0000A55A01119686 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20135, 13, 1, 2, 0, 1005, CAST(0x0000A55A01123EC1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20136, 13, 1, 2, 0, 1006, CAST(0x0000A55A0112479B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20137, 13, 2, 2, 0, 1005, CAST(0x0000A55A01131C4A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20138, 13, 2, 2, 0, 1006, CAST(0x0000A55A011320A6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20139, 13, 2, 2, 0, 1005, CAST(0x0000A55A01132448 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20140, 13, 2, 2, 0, 1006, CAST(0x0000A55A01132756 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20141, 13, 1, 2, 0, 1005, CAST(0x0000A55A01132B4F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20142, 13, 2, 2, 0, 1005, CAST(0x0000A55A01135D1B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20143, 13, 1, 2, 0, 1006, CAST(0x0000A55A01139515 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20144, 13, 2, 2, 0, 1006, CAST(0x0000A55A011398D3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20145, 13, 1, 2, 0, 1005, CAST(0x0000A55A0113A07D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20146, 13, 1, 2, 0, 1006, CAST(0x0000A55A0113A4A7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20147, 13, 1, 2, 0, 1005, CAST(0x0000A55A0113A77A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20148, 13, 1, 2, 0, 1006, CAST(0x0000A55A0113AD53 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20149, 13, 1, 2, 0, 1005, CAST(0x0000A55A01191BD3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20150, 13, 1, 2, 0, 1006, CAST(0x0000A55A0119202C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20151, 13, 1, 2, 0, 1, CAST(0x0000A55A01192D25 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20152, 13, 1, 2, 0, 4, CAST(0x0000A55A0119307F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20153, 13, 1, 2, 0, 1, CAST(0x0000A55A01193256 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20154, 13, 1, 2, 0, 4, CAST(0x0000A55A0119357F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20155, 13, 1, 2, 0, 1005, CAST(0x0000A55A01193864 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20156, 13, 1, 2, 0, 1, CAST(0x0000A55A01193B5F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20157, 13, 1, 2, 0, 4, CAST(0x0000A55A01193DC5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20158, 13, 1, 2, 0, 1006, CAST(0x0000A55A011940C0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20159, 13, 1, 2, 0, 5, CAST(0x0000A55A01195AA8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20160, 13, 1, 2, 0, 5, CAST(0x0000A55A01196CDB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20161, 13, 1, 2, 0, 1005, CAST(0x0000A55A01197B9A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20162, 13, 1, 2, 0, 1006, CAST(0x0000A55A01198076 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20163, 30, 1, 3, 0, 1, CAST(0x0000A55A017C2256 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20164, 30, 1, 3, 0, 4, CAST(0x0000A55A017C257E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20165, 30, 1, 3, 0, 1007, CAST(0x0000A55A017C294E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20166, 30, 1, 3, 0, 1007, CAST(0x0000A55A017C339B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20167, 30, 1, 3, 0, 1007, CAST(0x0000A55A0185A78F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20168, 30, 1, 3, 2, 1008, CAST(0x0000A55A018829FA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20169, 30, 1, 3, 2, 1005, CAST(0x0000A55A01883069 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20170, 30, 2, 3, 0, 1007, CAST(0x0000A55A018833F1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20171, 30, 2, 3, 0, 1008, CAST(0x0000A55A0189B319 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20172, 13, 2, 3, 0, 1, CAST(0x0000A55A0189CF70 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20173, 13, 2, 3, 0, 4, CAST(0x0000A55A0189FF2B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20174, 13, 2, 3, 0, 1, CAST(0x0000A55A018ABAEE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20175, 13, 2, 3, 0, 4, CAST(0x0000A55B0001A7AF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20176, 13, 2, 3, 0, 1, CAST(0x0000A55B000313F1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20177, 13, 2, 3, 0, 4, CAST(0x0000A55B00039BF0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20178, 13, 2, 3, 0, 1, CAST(0x0000A55B0004E322 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20179, 13, 2, 3, 0, 4, CAST(0x0000A55B0006EB5D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20180, 13, 2, 3, 0, 1, CAST(0x0000A55B000701D1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20181, 13, 2, 3, 0, 4, CAST(0x0000A55B0007687C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20182, 13, 2, 3, 0, 1, CAST(0x0000A55B000792E7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20183, 13, 2, 3, 0, 4, CAST(0x0000A55B0008BAE3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20184, 13, 2, 3, 0, 1, CAST(0x0000A55B0008D171 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20185, 13, 2, 3, 0, 4, CAST(0x0000A55B0008E8E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20186, 13, 2, 3, 0, 1, CAST(0x0000A55B0008F333 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20187, 13, 2, 3, 0, 4, CAST(0x0000A55B000944E0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20188, 13, 2, 3, 0, 1, CAST(0x0000A55B00095B7A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20189, 13, 2, 3, 0, 4, CAST(0x0000A55B000A8685 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20190, 13, 2, 3, 0, 1007, CAST(0x0000A55B00D5425D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20191, 13, 2, 3, 0, 1008, CAST(0x0000A55B00D5481C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20192, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5562A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20193, 13, 4, 3, 0, 1, CAST(0x0000A55B00F56E20 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20194, 13, 4, 3, 1, 2, CAST(0x0000A55B00F57033 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20195, 13, 13, 3, 3, 1, CAST(0x0000A55B00F57214 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20196, 13, 13, 3, 3, 1, CAST(0x0000A55B00F58103 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20197, 13, 13, 3, 0, 2, CAST(0x0000A55B00F58270 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20198, 13, 13, 3, 3, 1, CAST(0x0000A55B00F58434 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20199, 13, 13, 3, 0, 2, CAST(0x0000A55B00F58578 AS DateTime))
GO
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20200, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5877D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20201, 13, 13, 3, 3, 1, CAST(0x0000A55B00F59ED3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20202, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5ACA5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20203, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5AEA9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20204, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5B036 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20205, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5B19A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20206, 13, 4, 3, 0, 1, CAST(0x0000A55B00F5B342 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20207, 13, 4, 3, 1, 2, CAST(0x0000A55B00F5B4FA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20208, 13, 13, 3, 3, 1, CAST(0x0000A55B00F5B899 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20209, 13, 13, 3, 0, 2, CAST(0x0000A55B00F5BA01 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20210, 13, 1, 3, 1, 1, CAST(0x0000A55B00F5C8A7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20211, 13, 1, 3, 1, 4, CAST(0x0000A55B00F5CA31 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20212, 13, 1, 3, 1, 1, CAST(0x0000A55B00F5CBF4 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20213, 13, 1, 3, 1, 4, CAST(0x0000A55B00F5D083 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20214, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5D7DA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20215, 13, 2, 3, 0, 1007, CAST(0x0000A55B00F5DC29 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20216, 13, 2, 3, 0, 1008, CAST(0x0000A55B00F5E106 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20217, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5E6AA AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20218, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5EAAF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20219, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5EF23 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20220, 13, 2, 3, 0, 1005, CAST(0x0000A55B00F5F3EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20221, 13, 2, 3, 0, 1006, CAST(0x0000A55B00F5FB3C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20222, 13, 2, 3, 0, 1, CAST(0x0000A55B010151DF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20223, 13, 2, 3, 0, 4, CAST(0x0000A55B01015490 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20224, 13, 13, 3, 3, 1, CAST(0x0000A55B0189E382 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20225, 13, 4, 3, 0, 1, CAST(0x0000A55B018A0A33 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20226, 13, 4, 3, 1, 2, CAST(0x0000A55C0003B0E7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20227, 13, 4, 3, 1, 2, CAST(0x0000A55C001FE278 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20228, 13, 13, 3, 0, 2, CAST(0x0000A55C001FE467 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20229, 13, 13, 3, 0, 2, CAST(0x0000A55C001FE6E1 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20230, 13, 4, 3, 1, 2, CAST(0x0000A55C00E24F63 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20231, 13, 13, 3, 3, 1, CAST(0x0000A55D00027CE3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20232, 13, 2, 3, 0, 1, CAST(0x0000A55D0003CDD2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20233, 13, 29, 3, 0, 1, CAST(0x0000A55D011B6349 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20234, 13, 27, 3, 0, 1, CAST(0x0000A55D011BDBAC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20235, 13, 2, 3, 3, 2, CAST(0x0000A55E013ED9B6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20236, 13, 13, 3, 3, 1, CAST(0x0000A5610013669D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20237, 13, 13, 3, 3, 1, CAST(0x0000A56200DA392C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20238, 13, 4, 3, 0, 1, CAST(0x0000A56200EFF34A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20239, 13, 4, 3, 1, 2, CAST(0x0000A56200EFF6B6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20240, 13, 1, 3, 1, 1, CAST(0x0000A56700F53F4B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20241, 13, 1, 3, 1, 4, CAST(0x0000A56700F54276 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20242, 13, 13, 3, 3, 1, CAST(0x0000A56700F55497 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20243, 13, 13, 3, 0, 1, CAST(0x0000A56700F556E7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20244, 13, 4, 3, 3, 1, CAST(0x0000A56800A8B561 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20245, 13, 4, 3, 3, 1, CAST(0x0000A56800A8B74A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20246, 13, 13, 3, 0, 1, CAST(0x0000A56800B3D2F0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20247, 13, 13, 3, 0, 1, CAST(0x0000A56800B3D450 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20248, 13, 13, 3, 0, 1, CAST(0x0000A56800B3D68D AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20249, 13, 13, 3, 0, 1, CAST(0x0000A56800B3D905 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20250, 13, 13, 3, 0, 1, CAST(0x0000A56800B3DD23 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20251, 13, 13, 3, 0, 1, CAST(0x0000A56800B3DFE0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20252, 13, 13, 3, 0, 1, CAST(0x0000A56800B3E87E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20253, 13, 13, 3, 0, 1, CAST(0x0000A56800B42344 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20254, 13, 13, 3, 0, 1, CAST(0x0000A56800B42BA7 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20255, 13, 1, 3, 1, 1007, CAST(0x0000A56800B51B52 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20256, 13, 1, 3, 1, 1006, CAST(0x0000A56800B52543 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20257, 13, 1, 3, 1, 1008, CAST(0x0000A56800B52AF0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20258, 13, 1, 3, 1, 1006, CAST(0x0000A56800B53882 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20259, 13, 13, 3, 0, 1, CAST(0x0000A56801476251 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20260, 13, 13, 3, 0, 1, CAST(0x0000A56801476585 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20261, 13, 13, 3, 0, 1, CAST(0x0000A56801477230 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20262, 13, 13, 3, 3, 2, CAST(0x0000A56801487233 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20263, 13, 13, 3, 3, 1, CAST(0x0000A568014874EC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20264, 13, 13, 3, 3, 2, CAST(0x0000A56801487704 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20265, 13, 13, 3, 3, 2, CAST(0x0000A56801488392 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20266, 13, 13, 3, 3, 1, CAST(0x0000A5680148B359 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20267, 13, 13, 3, 3, 1, CAST(0x0000A5680148C79C AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20268, 13, 13, 3, 3, 2, CAST(0x0000A5680148C9DF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20269, 13, 13, 3, 3, 1, CAST(0x0000A568014908A2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20270, 13, 13, 3, 3, 1, CAST(0x0000A56801491EFE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20271, 13, 13, 3, 3, 2, CAST(0x0000A568014966C6 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20272, 13, 13, 3, 3, 1, CAST(0x0000A568014972CF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20273, 13, 13, 3, 3, 2, CAST(0x0000A5680169C423 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20274, 13, 13, 3, 3, 1, CAST(0x0000A5680169C790 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20275, 13, 13, 3, 3, 2, CAST(0x0000A5680169D973 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20276, 13, 13, 3, 3, 1, CAST(0x0000A56801726398 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20277, 13, 13, 3, 3, 2, CAST(0x0000A568017266D0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20278, 13, 13, 3, 3, 1, CAST(0x0000A568017268B0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20279, 13, 13, 3, 3, 1, CAST(0x0000A56801727B72 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20280, 13, 13, 3, 3, 2, CAST(0x0000A5680172BDE8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20281, 13, 13, 3, 3, 2, CAST(0x0000A5680172D7F9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20282, 13, 13, 3, 3, 1, CAST(0x0000A56801763F20 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20283, 13, 13, 3, 3, 2, CAST(0x0000A56801775F9F AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20284, 13, 13, 3, 3, 1, CAST(0x0000A56801777107 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20285, 13, 13, 3, 3, 1, CAST(0x0000A56801867B4E AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20286, 13, 13, 3, 3, 2, CAST(0x0000A568018688DF AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20287, 13, 13, 3, 3, 1, CAST(0x0000A5680186DE29 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20288, 13, 13, 3, 3, 2, CAST(0x0000A5680186E4AE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20289, 13, 13, 3, 3, 1, CAST(0x0000A56900D90DC5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20290, 13, 13, 3, 3, 2, CAST(0x0000A56900D91109 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20291, 13, 13, 3, 3, 2, CAST(0x0000A56900D91784 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20292, 13, 13, 3, 3, 1, CAST(0x0000A56900D91A3B AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20293, 13, 13, 3, 3, 2, CAST(0x0000A56900D91BCB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20294, 13, 13, 3, 3, 1, CAST(0x0000A56900D91FA5 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20295, 13, 13, 3, 3, 2, CAST(0x0000A56900D92DB3 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20296, 13, 13, 3, 3, 1, CAST(0x0000A56900D98FEB AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20297, 13, 13, 3, 3, 2, CAST(0x0000A56900D99307 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20298, 13, 13, 3, 3, 2, CAST(0x0000A56900D9C7DC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20299, 13, 13, 3, 3, 2, CAST(0x0000A56900D9D665 AS DateTime))
GO
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20300, 13, 13, 3, 3, 2, CAST(0x0000A56900D9EDCD AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20301, 13, 13, 3, 3, 1, CAST(0x0000A56900DA4CA0 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20302, 13, 4, 3, 0, 1, CAST(0x0000A56900DC95B2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20303, 13, 13, 3, 3, 2, CAST(0x0000A56900DD7ECE AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20304, 13, 13, 3, 3, 1, CAST(0x0000A56900DD8854 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20305, 13, 1, 3, 0, 1, CAST(0x0000A569011E1D54 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20306, 13, 13, 3, 3, 2, CAST(0x0000A56A0005617A AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20307, 13, 13, 3, 3, 1, CAST(0x0000A56A000564F9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20308, 13, 13, 3, 3, 2, CAST(0x0000A56A000D0B81 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20309, 13, 13, 3, 3, 1, CAST(0x0000A56A000D1BDC AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20310, 13, 13, 3, 3, 2, CAST(0x0000A56A000D1FE4 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20311, 13, 13, 3, 3, 1, CAST(0x0000A56A000D2177 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20312, 13, 13, 3, 3, 1, CAST(0x0000A56A000D29F9 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20313, 13, 13, 3, 3, 2, CAST(0x0000A56A000FC398 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20314, 13, 4, 3, 0, 2, CAST(0x0000A56A000FC4F2 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20315, 13, 13, 3, 3, 2, CAST(0x0000A56A000FC7A8 AS DateTime))
INSERT [dbo].[TrackingAction] ([TrackingID], [SenderID], [ReceiverID], [SenderType], [ReceiverType], [ActionID], [ActionTime]) VALUES (20316, 13, 13, 3, 3, 1, CAST(0x0000A56D0016D61D AS DateTime))
SET IDENTITY_INSERT [dbo].[TrackingAction] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (1, N'cuongnv764119', N'489845d6089a0710bff1d4f99a0acc86', N'Cuong1', N'Nguyen Van', N'441@g4.cc', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 0, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (2, N'cuongnvse02837', N'489845d6089a0710bff1d4f99a0acc86', N'cuong2', NULL, N'cuongnvse02837@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (3, N'cuong1111', N'489845d6089a0710bff1d4f99a0acc86', N'cuong3', NULL, N'cuongnv1412@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (4, N'cuong111111', N'489845d6089a0710bff1d4f99a0acc86', N'cuong4', NULL, N'cuong.nv764119@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (5, N'hinatahyuga1412', N'Scylla7601', N'ニコニコ', N'動画', N'hinatahyuga1412@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (6, N'cuong1234', N'Scylla7601', N'cuong', NULL, N'cuon.gnv764119@gmail.com', CAST(0xE2150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (7, N'cuong6666', N'Scylla7601', N'cuong', NULL, N'cuongnv.764119@gmail.com', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (8, N'cuongnv76', N'Scylla7601', N'cuong', NULL, N'cuong.nv76.4119@gmail.com', CAST(0x2A1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (9, N'cuongnvse02837555', N'Scylla7601', N'cuong', N'fiiuouo', N'123456@1244.cc', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (10, N'felixphan1394', N'JOX0D028', N'Phan Thanh', N'Vũ', N'vupt94@gmail.com', CAST(0xD6150B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (11, N'felixphan', N'heaven13', N'Vu', N'Phan', N'VuPTSE61276@fpt.edu.vn', CAST(0xFF370B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (12, N'cuongnvse028377', N'Scylla7601', N'cuong', N'nguyen van', N'cuongnvse0283.7@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (13, N'cuongnvse0283777', N'489845d6089a0710bff1d4f99a0acc86', N'Nguyen Van', N'Cuong', N'cuong.nv.se02837@fpt.edu.vn', CAST(0x0C1C0B00 AS Date), N'145465', 3, N'01648080401', N'ha noi', 1, 0, 10053, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (14, N'cuongnvse0283799999999', N'b13cb53261ce5815a2a126117dd01a87', N'cug', NULL, N'cuong@nma.cn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (15, N'cuongnvse0283774', N'489845d6089a0710bff1d4f99a0acc86', N'2151', N'512', N'3579357293@wr.c', CAST(0xD6160300 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA13A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (16, N'21546462626', N'Scylla7601', N'14125', N'211521', N'cuong.nv14.12@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (17, N'359812510', N'Scylla7601', N'712957', N'892751', N'cuongnv.1412@gmail.com', CAST(0x53030000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (18, N'41241251', N'Scylla7601', N'14', NULL, N'c.uongnv1412@gmail.com', CAST(0x73040000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (19, N'51251251251', N'Scylla7601', N'38575', N'21', N'c.uongnv.1412@gmail.com', CAST(0x7C780200 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (20, N'412515215261', N'Scylla7601', N'cuong', N'24', N'cuon.g.nv1412@gmail.com', CAST(0x9A4D0000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (21, N'cuong125125125', N'Scylla7601', N'cuong', N'2871', N'2@gmai.co', CAST(0x23100000 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA23A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (22, N'cuong12323', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'cuon@gmail.com', CAST(0xBC1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (23, N'cuong5678', N'25d55ad283aa400af464c76d713c07ad', N'1', N'4567', N'ewrdtf@gmail.com', CAST(0xA83A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (24, N'412151251', N'25d55ad283aa400af464c76d713c07ad', N'cuong', N'211 ', N'cuong@gmail.dds', CAST(0xA13A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (25, N'41241241', N'25d55ad283aa400af464c76d713c07ad', N'cuong', N'214', N'123@gmail.com', CAST(0xA03A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 3, CAST(0xA63A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (26, N'2109869509863403', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'59128591', N'32852@io3ut3.c', CAST(0x971A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (27, N'14127601', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'nguyen van', N'2151@32598.co', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 20088, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (28, N'5136576246462', N'489845d6089a0710bff1d4f99a0acc86', N'125151', N'23535', N'co@cc.co', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (29, N'4154655423', N'Scylla7601', N'cuong', N'2114', N'12345@3263.cc', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 0, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (30, N'415643651', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', N'2198', N'cc@351.c', CAST(0x9F1A0B00 AS Date), NULL, 3, NULL, NULL, 1, 0, 10032, CAST(0xB03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (31, N'adminaskfj', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'cu@of.cc', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (32, N'982353425345', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'asf@dd.cc', CAST(0x791A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (33, N'446576512254', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'5358727@gmail.com', CAST(0x7D1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBA3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (34, N'cuong112', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'24@cc.c', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBC3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (36, N'cuongnvse02837777', N'489845d6089a0710bff1d4f99a0acc86', N'cuong', NULL, N'cuongnvse028371@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBC3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (37, N'demo2951993', N'489845d6089a0710bff1d4f99a0acc86', N'Nguyen Van', N'Tien', N'kisuke3960@gmail.com', CAST(0x163C0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xBD3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [Avartar], [DataJoin]) VALUES (38, N'cuong28975', N'489845d6089a0710bff1d4f99a0acc86', N'Gosu Dota 2', N'Ranked Match', N'clone7604@gmail.com', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, 0, 10032, CAST(0xC63A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Video] ON 

INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (2, 20, N'https://www.youtube.com/watch?v=xsHfZA-gGLE', CAST(0x0000A55401225050 AS DateTime), CAST(0x0000A55501225050 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (3, 22, N'https://www.youtube.com/watch?v=3vqaaozEXwk', CAST(0x0000A55101373010 AS DateTime), CAST(0x0000A55201373010 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10, 47, N'https://www.youtube.com/watch?v=ooK9qdKjZXI', CAST(0x0000A5520159CB70 AS DateTime), CAST(0x0000A552016A4630 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (11, 48, N'https://www.youtube.com/watch?v=xeukX7nGhyI', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A552016EAB30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (12, 48, N'https://www.youtube.com/watch?v=dfFdZqvl7MQ', CAST(0x0000A552015E3070 AS DateTime), CAST(0x0000A552016EAB30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (13, 49, N'https://www.youtube.com/watch?v=LYFC-K2AFd0', CAST(0x0000A55201629570 AS DateTime), CAST(0x0000A55201731030 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (15, 52, N'https://www.youtube.com/watch?v=bKH_9Aq5eEQ', CAST(0x0000A55201659AE0 AS DateTime), CAST(0x0000A552017615A0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (16, 54, N'https://www.youtube.com/watch?v=U7CKrJaZskY', CAST(0x0000A5520166FA70 AS DateTime), CAST(0x0000A55201777530 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (17, 65, N'https://www.youtube.com/watch?v=cmudyoVVyxk', CAST(0x0000A55500F1F950 AS DateTime), CAST(0x0000A55600F1F950 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (18, 67, N'https://www.youtube.com/watch?v=sHZSqRAYNlM', CAST(0x0000A55500F23FA0 AS DateTime), CAST(0x0000A55600F23FA0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (19, 68, N'https://www.youtube.com/watch?v=xyfrQDBXDlo', CAST(0x0000A5550107F250 AS DateTime), CAST(0x0000A5560107F250 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', NULL)
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (20, 71, N'https://www.youtube.com/watch?v=Fd3pSKJwgqI', CAST(0x0000A55901632210 AS DateTime), CAST(0x0000A55A01632210 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.2skk-kh5z-11gg-62c2')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (21, 75, N'https://www.youtube.com/watch?v=Uis9Is1ixLU', CAST(0x0000A559016BEC10 AS DateTime), CAST(0x0000A55A016BEC10 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.ghgk-17j3-cyq1-d0uk')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (22, 79, N'https://www.youtube.com/watch?v=7eajeQvpy7c', CAST(0x0000A5590170DDB0 AS DateTime), CAST(0x0000A55A0170DDB0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.esxm-67kc-sbcz-4brz')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (23, 82, N'https://www.youtube.com/watch?v=YGzqbRKGZF4', CAST(0x0000A55901712400 AS DateTime), CAST(0x0000A55A01712400 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.x8yg-brx0-g368-23h1')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (24, 83, N'https://www.youtube.com/watch?v=UyEOdnB_Ifs', CAST(0x0000A5590171B0A0 AS DateTime), CAST(0x0000A55A0171B0A0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.73kt-t1me-gvue-5f77')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (25, 85, N'https://www.youtube.com/watch?v=w2r10SS9qD8', CAST(0x0000A55901746FC0 AS DateTime), CAST(0x0000A55A01746FC0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.tyhg-jjj2-60me-b5zs')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (26, 88, N'https://www.youtube.com/watch?v=XgxZPlAYIVU', CAST(0x0000A5590176A240 AS DateTime), CAST(0x0000A55A0176A240 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.f56e-tjvf-yjga-17yp')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (27, 90, N'https://www.youtube.com/watch?v=KofBiIanCdw', CAST(0x0000A55901777530 AS DateTime), CAST(0x0000A55A01777530 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.k8gf-fpuc-xa34-bdfq')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (28, 92, N'https://www.youtube.com/watch?v=BJuwPnPbHek', CAST(0x0000A55901788E70 AS DateTime), CAST(0x0000A55A01788E70 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.rghg-y7bg-1ywm-9mty')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (29, 94, N'https://www.youtube.com/watch?v=1lxS7wHEC-o', CAST(0x0000A55901791B10 AS DateTime), CAST(0x0000A55A01791B10 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.8ahx-6prs-evq8-1vh8')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (30, 96, N'https://www.youtube.com/watch?v=ytsswzXTFI4', CAST(0x0000A559017AC0F0 AS DateTime), CAST(0x0000A55A017AC0F0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.g0tb-j6cw-kw0u-fu0k')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (31, 98, N'https://www.youtube.com/watch?v=383ZV_0i-TY', CAST(0x0000A559017C2080 AS DateTime), CAST(0x0000A55A017C2080 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.x684-r2e6-q21f-1ws3')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (32, 102, N'https://www.youtube.com/watch?v=SwShNKQkzWg', CAST(0x0000A5590184EA80 AS DateTime), CAST(0x0000A55A0184EA80 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.6ypt-0vzh-qr0d-9dee')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (33, 104, N'https://www.youtube.com/watch?v=4pM0GdaXy_c', CAST(0x0000A559018603C0 AS DateTime), CAST(0x0000A55A018603C0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.gey5-2g5e-m7xd-fhy1')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (34, 105, N'https://www.youtube.com/watch?v=1mAtWdGkORs', CAST(0x0000A5590186D6B0 AS DateTime), CAST(0x0000A55A0186D6B0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.38sd-mm2g-yumk-drgj')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (35, 107, N'https://www.youtube.com/watch?v=-oFE9-G3VgA', CAST(0x0000A55901887C90 AS DateTime), CAST(0x0000A55A01887C90 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.6vgd-5fe7-13fe-27t7')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (36, 110, N'https://www.youtube.com/watch?v=hAPdCHUyBqs', CAST(0x0000A55A00A06680 AS DateTime), CAST(0x0000A55B00A06680 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.pebq-kcrk-ccmj-8c6d')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (37, 115, N'https://www.youtube.com/watch?v=NwvCPk3l3eY', CAST(0x0000A55B00B58C90 AS DateTime), CAST(0x0000A55C00B58C90 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.jsd9-f23a-sbpu-9jpa')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (38, 116, N'https://www.youtube.com/watch?v=jkHLjTEZQVA', CAST(0x0000A55B00B5D2E0 AS DateTime), CAST(0x0000A55C00B5D2E0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.hy5y-vmk0-9asc-bq1e')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10039, 10118, N'https://www.youtube.com/watch?v=ifVVCpnVedY', CAST(0x0000A55D011680E0 AS DateTime), CAST(0x0000A55E011680E0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.ga1f-rwb5-qt7c-cjvv')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10040, 10120, N'https://www.youtube.com/watch?v=Yx-9Dgg86q4', CAST(0x0000A5600181E510 AS DateTime), CAST(0x0000A5610181E510 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.tc32-pe20-zgja-1xfc')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10045, 10123, N'https://www.youtube.com/watch?v=YHdYN9b0SdM', CAST(0x0000A56600F42BD0 AS DateTime), CAST(0x0000A56700F42BD0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.7j5x-e1r5-vkw0-9adm')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10047, 10128, N'https://www.youtube.com/watch?v=n5ni9PaL_9w', CAST(0x0000A567001D6370 AS DateTime), CAST(0x0000A568001D6370 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.0f9u-vht7-1wae-4g7j')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10055, 10128, N'https://www.youtube.com/watch?v=yk8Saw-SRHk', CAST(0x0000A56700218220 AS DateTime), CAST(0x0000A56800218220 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.by4p-2s6z-k6s0-fvr2')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10057, 10128, N'https://www.youtube.com/watch?v=575VPZp5ADM', CAST(0x0000A5660139EF30 AS DateTime), CAST(0x0000A5670139EF30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.ja90-03b0-0chh-1w9e')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10058, 10128, N'https://www.youtube.com/watch?v=EPEYx1qFP5U', CAST(0x0000A5660139EF30 AS DateTime), CAST(0x0000A5670139EF30 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.md0h-h48z-r8yy-420r')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10059, 10127, N'https://www.youtube.com/watch?v=G57ob-heAYU', CAST(0x0000A568003F2BE0 AS DateTime), CAST(0x0000A569003F2BE0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.je1h-9k8f-ya5a-eaw4')
INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy], [PrimaryServer], [BackupServer], [StreamName]) VALUES (10060, 42, N'https://www.youtube.com/watch?v=ZXmSe2PnXE0', CAST(0x0000A56A005F94C0 AS DateTime), CAST(0x0000A56B005F94C0 AS DateTime), 0, N'rtmp://a.rtmp.youtube.com/live2', N'rtmp://b.rtmp.youtube.com/live2?backup=1', N'clone7602.bbz0-dqh9-w962-9rxy')
SET IDENTITY_INSERT [dbo].[Video] OFF
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_DateIssue]  DEFAULT (getdate()) FOR [DateIssue]
GO
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_IsVerified]  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_LockedReason]  DEFAULT (N'Your event against our Term Of Service') FOR [LockedReason]
GO
ALTER TABLE [dbo].[EventImage] ADD  CONSTRAINT [DF_EventImage_Approve]  DEFAULT ((1)) FOR [Approve]
GO
ALTER TABLE [dbo].[NotificationChange] ADD  CONSTRAINT [DF_NotificationChange_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[NotificationChange] ADD  CONSTRAINT [DF_NotificationChange_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TrackingAction] ADD  CONSTRAINT [DF_TrackingAction_ActionTime]  DEFAULT (getdate()) FOR [ActionTime]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_DataJoin]  DEFAULT (getdate()) FOR [DataJoin]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_Event1]
GO
ALTER TABLE [dbo].[Appeal]  WITH CHECK ADD  CONSTRAINT [FK_Appeal_User] FOREIGN KEY([HandleBy])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Appeal] CHECK CONSTRAINT [FK_Appeal_User]
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
ALTER TABLE [dbo].[EventImage]  WITH CHECK ADD  CONSTRAINT [FK_EventImage_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[EventImage] CHECK CONSTRAINT [FK_EventImage_Event]
GO
ALTER TABLE [dbo].[EventImage]  WITH CHECK ADD  CONSTRAINT [FK_EventImage_Image] FOREIGN KEY([ImageID])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[EventImage] CHECK CONSTRAINT [FK_EventImage_Image]
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
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_Event]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_NotificationObject] FOREIGN KEY([NotificationObjectID])
REFERENCES [dbo].[NotificationObject] ([ID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_NotificationObject]
GO
ALTER TABLE [dbo].[NotificationChange]  WITH CHECK ADD  CONSTRAINT [FK_NotificationChange_User] FOREIGN KEY([ActorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[NotificationChange] CHECK CONSTRAINT [FK_NotificationChange_User]
GO
ALTER TABLE [dbo].[NotificationObject]  WITH CHECK ADD  CONSTRAINT [FK_NotificationObject_Notification] FOREIGN KEY([NotificationID])
REFERENCES [dbo].[Notification] ([ID])
GO
ALTER TABLE [dbo].[NotificationObject] CHECK CONSTRAINT [FK_NotificationObject_Notification]
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
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_ReportDefine] FOREIGN KEY([ReportType])
REFERENCES [dbo].[ReportDefine] ([ReportTypeID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_ReportDefine]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([SenderID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[Share]  WITH CHECK ADD  CONSTRAINT [FK_Share_Event1] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Share] CHECK CONSTRAINT [FK_Share_Event1]
GO
ALTER TABLE [dbo].[Share]  WITH CHECK ADD  CONSTRAINT [FK_Share_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Share] CHECK CONSTRAINT [FK_Share_User]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_ActorAction] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_ActorAction]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User2] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User2]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User3] FOREIGN KEY([SenderID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User3]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Image] FOREIGN KEY([Avartar])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Image]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_EventPlace] FOREIGN KEY([EventPlaceID])
REFERENCES [dbo].[EventPlace] ([EventPlaceID])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_EventPlace]
GO
USE [master]
GO
ALTER DATABASE [EventZone] SET  READ_WRITE 
GO

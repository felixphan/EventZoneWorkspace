USE [master]
GO
/****** Object:  Database [EventZone]    Script Date: 04/11/2015 4:51:04 CH ******/
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
/****** Object:  Table [dbo].[Action]    Script Date: 04/11/2015 4:51:04 CH ******/
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
/****** Object:  Table [dbo].[Appeal]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[CategoryFollow]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Channel]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Event]    Script Date: 04/11/2015 4:51:05 CH ******/
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
	[Privacy] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[EventFollow]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[EventPlace]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[EventRank]    Script Date: 04/11/2015 4:51:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventRank](
	[EventId] [bigint] NULL,
	[Score] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Image]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[LikeDislike]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[PeopleFollow]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Share]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[TrackingAction]    Script Date: 04/11/2015 4:51:05 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingAction](
	[TrackingID] [bigint] NOT NULL,
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
/****** Object:  Table [dbo].[User]    Script Date: 04/11/2015 4:51:05 CH ******/
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
/****** Object:  Table [dbo].[Video]    Script Date: 04/11/2015 4:51:05 CH ******/
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
	[Privacy] [bit] NOT NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'Music')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Food & Drink')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (3, N'Classes')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (4, N'Arts')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (5, N'Parites')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (6, N'Sport & Wellness')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (7, N'Networking')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[CategoryFollow] ON 

INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (1, 6, 12)
INSERT [dbo].[CategoryFollow] ([CategoryFollowID], [CategoryID], [FollowerID]) VALUES (2, 2, 12)
SET IDENTITY_INSERT [dbo].[CategoryFollow] OFF
SET IDENTITY_INSERT [dbo].[Channel] ON 

INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (1, 2, N'', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (2, 4, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (3, 7, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (4, 8, N'cuong', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (5, 9, N'cuong fiiuouo', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (6, 11, N'Vu Phan', N'')
INSERT [dbo].[Channel] ([ChannelID], [UserID], [ChannelName], [ChannelDescription]) VALUES (7, 12, N'cuong nguyen van', N'')
SET IDENTITY_INSERT [dbo].[Channel] OFF
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([EventID], [ChannelID], [EventName], [EventStartDate], [EventEndDate], [EventDescription], [EventRegisterDate], [View], [CategoryID], [Privacy], [Avatar], [EditBy], [EditTime], [EditContent], [Status]) VALUES (1, 2, N'LadyByNight', CAST(0x0000A53600000000 AS DateTime), CAST(0x0000A53700000000 AS DateTime), N'Lady by night được tổ chức hàng năm vào ngày 20/10 - DH FPT', CAST(0x0000A53600000000 AS DateTime), 372, 5, 0, 3, 2, CAST(0x0000A53600000000 AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[Event] OFF
SET IDENTITY_INSERT [dbo].[EventFollow] ON 

INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (7, 1, 3)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (8, 1, 5)
INSERT [dbo].[EventFollow] ([EventFollowID], [EventID], [FollowerID]) VALUES (59, 1, 4)
SET IDENTITY_INSERT [dbo].[EventFollow] OFF
SET IDENTITY_INSERT [dbo].[EventPlace] ON 

INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (1, 1, 7)
INSERT [dbo].[EventPlace] ([EventPlaceID], [EventID], [LocationID]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[EventPlace] OFF
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ImageID], [EventID], [UserID], [ImageLink], [UploadDate]) VALUES (3, 1, 2, N'http://i.imgur.com/vCBNmUy.gif', CAST(0x0000A53700000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[Image] OFF
SET IDENTITY_INSERT [dbo].[LikeDislike] ON 

INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (1, 1, 2, 1)
INSERT [dbo].[LikeDislike] ([LikeDislikeID], [EventID], [UserID], [Type]) VALUES (2, 1, 3, -1)
SET IDENTITY_INSERT [dbo].[LikeDislike] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (2, 105.837017, 21.030379, N'Bảo tàng Mỹ thuật Việt Nam, 66 Nguyễn Thái Học, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (3, 105.84899, 21.022947, N'Trung tâm Giao lưu Văn hóa Nhật Bản tại Việt Nam 27 Quang Trung, Hoàn Kiếm, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (4, 105.856258, 21.024564, N'Swing 21 Tràng Tiền, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (5, 105.876266, 21.047961, N'Tầng 2, 292 Tây Sơn, Tòa nhà Kinh Đô, Quận Đống Đa, Hà Nội')
INSERT [dbo].[Location] ([LocationID], [Longitude], [Latitude], [LocationName]) VALUES (7, 105.526555, 21.013629, N'Đại học FPT thạch thất hà nội')
SET IDENTITY_INSERT [dbo].[Location] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (1, N'cuongnv764119', N'Scylla7601', N'Cuong1', N'Nguyen Van', N'cuongnv764119@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (2, N'cuongnvse02837', N'Scylla7601', N'cuong2', NULL, N'cuongnvse02837@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (3, N'cuong1111', N'Scylla7601', N'cuong3', NULL, N'cuongnv1412@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (4, N'cuong111111', N'Scylla7601', N'cuong4', NULL, N'cuong.nv764119@gmail.com', CAST(0xC3150B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (5, N'hinatahyuga1412', N'Scylla7601', N'ニコニコ', N'動画', N'hinatahyuga1412@gmail.com', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (6, N'cuong1234', N'Scylla7601', N'cuong', NULL, N'cuon.gnv764119@gmail.com', CAST(0xE2150B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (7, N'cuong6666', N'Scylla7601', N'cuong', NULL, N'cuongnv.764119@gmail.com', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (8, N'cuongnv76', N'Scylla7601', N'cuong', NULL, N'cuong.nv76.4119@gmail.com', CAST(0x2A1A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (9, N'cuongnvse02837555', N'Scylla7601', N'cuong', N'fiiuouo', N'cuong.nv.7.64119@gmail.com', CAST(0x321A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (10, N'felixphan1394', N'JOX0D028', N'Phan Thanh', N'Vũ', N'vupt94@gmail.com', CAST(0xD6150B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0x9C3A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (11, N'felixphan', N'heaven13', N'Vu', N'Phan', N'VuPTSE61276@fpt.edu.vn', CAST(0xFF370B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0xA03A0B00 AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [UserFirstName], [UserLastName], [UserEmail], [UserDOB], [IDCard], [UserRoles], [Phone], [Place], [AccountStatus], [Gender], [AvatarLink], [DataJoin]) VALUES (12, N'cuongnvse028377', N'Scylla7601', N'cuong', N'nguyen van', N'cuongnvse0283.7@fpt.edu.vn', CAST(0x9F1A0B00 AS Date), NULL, 0, NULL, NULL, 1, NULL, N'/img/default-avatar.jpg', CAST(0xA13A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Video] ON 

INSERT [dbo].[Video] ([VideoID], [EventPlaceID], [VideoLink], [StartTime], [EndTime], [Privacy]) VALUES (1, 1, N'https://www.youtube.com/watch?v=xM-6fHqXvig', CAST(0x0000A53600000000 AS DateTime), CAST(0x0000A53800000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Video] OFF
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
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User]
GO
ALTER TABLE [dbo].[TrackingAction]  WITH CHECK ADD  CONSTRAINT [FK_TrackingAction_User1] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[TrackingAction] CHECK CONSTRAINT [FK_TrackingAction_User1]
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

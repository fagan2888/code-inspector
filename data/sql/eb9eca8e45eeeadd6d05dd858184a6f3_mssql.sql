-- NOTE: DUMMY is replaced by the name of the site

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[Badges]') AND type in (N'U'))
DROP TABLE DUMMY.[Badges]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[Comments]') AND type in (N'U'))
DROP TABLE DUMMY.[Comments]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[Posts]') AND type in (N'U'))
DROP TABLE DUMMY.[Posts]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[PostTags]') AND type in (N'U'))
DROP TABLE DUMMY.[PostTags]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[PostTypes]') AND type in (N'U'))
DROP TABLE DUMMY.[PostTypes]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[Users]') AND type in (N'U'))
DROP TABLE DUMMY.[Users]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[Votes]') AND type in (N'U'))
DROP TABLE DUMMY.[Votes]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DUMMY.[VoteTypes]') AND type in (N'U'))
DROP TABLE DUMMY.[VoteTypes]

SET ansi_nulls  ON
SET quoted_identifier  ON
SET ansi_padding  ON

CREATE TABLE DUMMY.[VoteTypes] (
  [Id]   [INT]    NOT NULL,
  [Name] [VARCHAR](40)    NOT NULL
  , CONSTRAINT [PK__VoteType__3214EC073864608B] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  )ON [PRIMARY]

SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[PostTypes] (
  [Id]   [INT]    NOT NULL,
  [Type] [NVARCHAR](10)    NOT NULL
  , CONSTRAINT [PK_PostTypes] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  ) ON [PRIMARY]

IF 0 = 1--SPLIT
  BEGIN
	SET ansi_nulls  ON
	SET quoted_identifier  ON

	CREATE TABLE DUMMY.[PostTags] (
	  [PostId] [INT]    NOT NULL,
	  [Tag]    [NVARCHAR](50)    NOT NULL
	  , CONSTRAINT [PK_PostTags_1] PRIMARY KEY CLUSTERED ( [PostId] ASC,[Tag] ASC ) ON [PRIMARY]
	  ) ON [PRIMARY]
  
  END
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(1, N'AcceptedByOriginator')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(2, N'UpMod')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(3, N'DownMod')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(4, N'Offensive')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(5, N'Favorite')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(6, N'Close')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(7, N'Reopen')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(8, N'BountyStart')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(9, N'BountyClose')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(10,N'Deletion')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(11,N'Undeletion')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(12,N'Spam')
INSERT DUMMY.[VoteTypes] ([Id], [Name]) VALUES(13,N'InformModerator')
INSERT DUMMY.[PostTypes] ([Id], [Type]) VALUES(1, N'Question') 
INSERT DUMMY.[PostTypes] ([Id], [Type]) VALUES(2, N'Answer') 

IF 0 = 1--FULLTEXT
  BEGIN
	IF  EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'DUMMY.[Posts]'))
	ALTER FULLTEXT INDEX ON DUMMY.[Posts] DISABLE
	IF  EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'DUMMY.[Posts]'))
	DROP FULLTEXT INDEX ON DUMMY.[Posts]
	IF  EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'PostFullText')
	DROP FULLTEXT CATALOG [PostFullText]
	CREATE FULLTEXT CATALOG [PostFullText]WITH ACCENT_SENSITIVITY = ON
	AUTHORIZATION dbo
  END



SET ansi_padding  OFF
SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[Votes] (
  [Id]           [INT]    NOT NULL,
  [PostId]       [INT]    NOT NULL,
  [UserId]       [INT]    NULL,
  [BountyAmount] [INT]    NULL,
  [VoteTypeId]   [INT]    NOT NULL,
  [CreationDate] [DATETIME]    NOT NULL
  , CONSTRAINT [PK_Votes] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  ) ON [PRIMARY]

IF 0 = 1-- INDICES
  BEGIN
    CREATE NONCLUSTERED INDEX [IX_Votes_Id_PostId] ON DUMMY.[Votes] (
          [Id] ASC,
          [PostId] ASC)
    ON [PRIMARY]

    CREATE NONCLUSTERED INDEX [IX_Votes_VoteTypeId] ON DUMMY.[Votes] (
          [VoteTypeId] ASC)
    ON [PRIMARY]
  END

SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[Users] (
  [Id]             [INT]    NOT NULL,
  [AboutMe]        [NVARCHAR](2100)    NULL,
  [Age]            [INT]    NULL,
  [CreationDate]   [DATETIME]    NOT NULL,
  [DisplayName]    [NVARCHAR](40)    NOT NULL,
  [DownVotes]      [INT]    NOT NULL,
  [EmailHash]      [NVARCHAR](40)    NULL,
  [LastAccessDate] [DATETIME]    NOT NULL,
  [Location]       [NVARCHAR](100)    NULL,
  [Reputation]     [INT]    NOT NULL,
  [UpVotes]        [INT]    NOT NULL,
  [Views]          [INT]    NOT NULL,
  [WebsiteUrl]     [NVARCHAR](200)    NULL
  , CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  ) ON [PRIMARY]

IF 0 = 1-- INDICES
  BEGIN
    CREATE NONCLUSTERED INDEX [IX_Users_DisplayName] ON DUMMY.[Users] (
          [DisplayName] ASC)
    ON [PRIMARY]
  END


SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[Posts] (
  [Id]                    [INT]    NOT NULL,
  [AcceptedAnswerId]      [INT]    NULL,
  [AnswerCount]           [INT]    NULL,
  [Body]                  [NTEXT]    NOT NULL,
  [ClosedDate]            [DATETIME]    NULL,
  [CommentCount]          [INT]    NULL,
  [CommunityOwnedDate]    [DATETIME]    NULL,
  [CreationDate]          [DATETIME]    NOT NULL,
  [FavoriteCount]         [INT]    NULL,
  [LastActivityDate]      [DATETIME]    NOT NULL,
  [LastEditDate]          [DATETIME]    NULL,
  [LastEditorDisplayName] [NVARCHAR](40)    NULL,
  [LastEditorUserId]      [INT]    NULL,
  [OwnerUserId]           [INT]    NULL,
  [ParentId]              [INT]    NULL,
  [PostTypeId]            [INT]    NOT NULL,
  [Score]                 [INT]    NOT NULL,
  [Tags]                  [NVARCHAR](150)    NULL,
  [Title]                 [NVARCHAR](250)    NULL,
  [ViewCount]             [INT]    NOT NULL
  , CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  -- INDICES ,CONSTRAINT [IX_Posts_Id_AcceptedAnswerId] UNIQUE NONCLUSTERED ([Id] ASC,[AcceptedAnswerId] ASC ) ON [PRIMARY],
  -- INDICES CONSTRAINT [IX_Posts_Id_OwnerUserId] UNIQUE NONCLUSTERED ([Id] ASC,[OwnerUserId] ASC ) ON [PRIMARY],
  -- INDICES CONSTRAINT [IX_Posts_Id_ParentId] UNIQUE NONCLUSTERED ([Id] ASC,[ParentId] ASC ) ON [PRIMARY]
  )ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

IF 0 = 1-- INDICES
  BEGIN
    CREATE NONCLUSTERED INDEX [IX_Posts_Id_PostTypeId] ON DUMMY.[Posts] (
          [Id] ASC,
          [PostTypeId] ASC)
    ON [PRIMARY]

    CREATE NONCLUSTERED INDEX [IX_Posts_PostType] ON DUMMY.[Posts] (
          [PostTypeId] ASC)
    ON [PRIMARY]
  END

IF 0 = 1--FULLTEXT
  BEGIN
	EXEC dbo.Sp_fulltext_table
	  @tabname = N'DUMMY.[Posts]' ,
	  @action = N'create' ,
	  @keyname = N'PK_Posts' ,
	  @ftcat = N'PostFullText'

	DECLARE  @lcid INT

	SELECT @lcid = lcid
	FROM   MASTER.dbo.syslanguages
	WHERE  alias = N'English'

	EXEC dbo.Sp_fulltext_column
	  @tabname = N'DUMMY.[Posts]' ,
	  @colname = N'Body' ,
	  @action = N'add' ,
	  @language = @lcid

	SELECT @lcid = lcid
	FROM   MASTER.dbo.syslanguages
	WHERE  alias = N'English'

	EXEC dbo.Sp_fulltext_column
	  @tabname = N'DUMMY.[Posts]' ,
	  @colname = N'Title' ,
	  @action = N'add' ,
	  @language = @lcid

	EXEC dbo.Sp_fulltext_table
	  @tabname = N'DUMMY.[Posts]' ,
	  @action = N'start_change_tracking'

	EXEC dbo.Sp_fulltext_table
	  @tabname = N'DUMMY.[Posts]' ,
	  @action = N'start_background_updateindex'

  END

SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[Comments] (
  [Id]           [INT]    NOT NULL,
  [CreationDate] [DATETIME]    NOT NULL,
  [PostId]       [INT]    NOT NULL,
  [Score]        [INT]    NULL,
  [Text]         [NVARCHAR](700)    NOT NULL,
  [UserId]       [INT]    NULL
  , CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  ) ON [PRIMARY]

IF 0 = 1-- INDICES
  BEGIN
    CREATE NONCLUSTERED INDEX [IX_Comments_Id_PostId] ON DUMMY.[Comments] (
          [Id] ASC,
          [PostId] ASC)
    ON [PRIMARY]

    CREATE NONCLUSTERED INDEX [IX_Comments_Id_UserId] ON DUMMY.[Comments] (
          [Id] ASC,
          [UserId] ASC)
    ON [PRIMARY]
  END

SET ansi_nulls  ON
SET quoted_identifier  ON

CREATE TABLE DUMMY.[Badges] (
  [Id]     [INT]    NOT NULL,
  [Name]   [NVARCHAR](40)    NOT NULL,
  [UserId] [INT]    NOT NULL,
  [Date]   [DATETIME]    NOT NULL
  , CONSTRAINT [PK_Badges] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [PRIMARY]
  ) ON [PRIMARY]

IF 0 = 1-- INDICES
  BEGIN
    CREATE NONCLUSTERED INDEX [IX_Badges_Id_UserId] ON DUMMY.[Badges] (
          [Id] ASC,
          [UserId] ASC)
    ON [PRIMARY]
  END
 
USE [master]
GO
/****** Object:  Database [Cowculator]    Script Date: 10/29/2024 10:36:31 AM ******/
CREATE DATABASE [Cowculator]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cowculator', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cowculator.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Cowculator_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cowculator_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Cowculator] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cowculator].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cowculator] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cowculator] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cowculator] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cowculator] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cowculator] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cowculator] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cowculator] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cowculator] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cowculator] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cowculator] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cowculator] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cowculator] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cowculator] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cowculator] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cowculator] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Cowculator] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cowculator] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cowculator] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cowculator] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cowculator] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cowculator] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cowculator] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cowculator] SET RECOVERY FULL 
GO
ALTER DATABASE [Cowculator] SET  MULTI_USER 
GO
ALTER DATABASE [Cowculator] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cowculator] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cowculator] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cowculator] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Cowculator] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Cowculator] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Cowculator', N'ON'
GO
ALTER DATABASE [Cowculator] SET QUERY_STORE = ON
GO
ALTER DATABASE [Cowculator] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Cowculator]
GO
/****** Object:  Table [dbo].[Alerts]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alerts](
	[AlertID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[AlertMessage] [varchar](200) NULL,
	[AlertDate] [datetime] NULL,
	[Resolved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comparisons]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comparisons](
	[ComparisonID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[MetricName] [varchar](50) NULL,
	[RecordedValue] [decimal](5, 2) NULL,
	[IdealValue] [decimal](5, 2) NULL,
	[ComparisonResult] [varchar](50) NULL,
	[ComparisonDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComparisonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CowDiagnosis]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CowDiagnosis](
	[DiagnosisID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[Diagnosis] [varchar](200) NULL,
	[DiagnosisDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cows]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cows](
	[CowID] [int] IDENTITY(1,1) NOT NULL,
	[CowName] [varchar](50) NULL,
	[Age] [int] NULL,
	[Breed] [varchar](50) NULL,
	[Weight] [decimal](5, 2) NULL,
	[FarmID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiseaseHistory]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiseaseHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[Disease] [varchar](100) NULL,
	[DiagnosisDate] [datetime] NULL,
	[TreatmentDate] [datetime] NULL,
	[RecoveryDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Farm]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Farm](
	[FarmID] [int] IDENTITY(1,1) NOT NULL,
	[FarmName] [varchar](100) NULL,
	[Location] [varchar](200) NULL,
	[OwnerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FarmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feeding]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feeding](
	[FeedingID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[FeedType] [varchar](100) NULL,
	[FeedQuantity] [decimal](5, 2) NULL,
	[FeedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthMetricLimits]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthMetricLimits](
	[LimitID] [int] IDENTITY(1,1) NOT NULL,
	[MetricName] [varchar](50) NULL,
	[MinValue] [decimal](5, 2) NULL,
	[MaxValue] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[LimitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthMetrics]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthMetrics](
	[MetricID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[Weight] [decimal](5, 2) NULL,
	[Temperature] [decimal](4, 2) NULL,
	[HeartRate] [int] NULL,
	[DateRecorded] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MetricID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoricalData]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoricalData](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[CowID] [int] NULL,
	[MetricID] [int] NULL,
	[DiagnosisID] [int] NULL,
	[TreatmentID] [int] NULL,
	[EventDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyCattle]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyCattle](
	[CattleID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[CowID] [int] NULL,
	[OwnershipDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CattleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewUsers]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewUsers](
	[UserID] [int] NULL,
	[Email] [nvarchar](255) NULL,
	[Username] [nvarchar](255) NULL,
	[DateAdded] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatments]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatments](
	[TreatmentID] [int] IDENTITY(1,1) NOT NULL,
	[DiagnosisID] [int] NULL,
	[TreatmentDescription] [varchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TreatmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Email] [varchar](100) NULL,
	[PasswordHash] [varchar](100) NULL,
	[Role] [varchar](20) NULL,
	[RegistrationDate] [datetime] NULL,
	[EmailSent] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vets]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vets](
	[VetID] [int] IDENTITY(1,1) NOT NULL,
	[VetName] [varchar](100) NULL,
	[FarmID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[VetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [idx_NewUsers_DateAdded]    Script Date: 10/29/2024 10:36:31 AM ******/
CREATE NONCLUSTERED INDEX [idx_NewUsers_DateAdded] ON [dbo].[NewUsers]
(
	[DateAdded] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_NewUsers_UserID]    Script Date: 10/29/2024 10:36:31 AM ******/
CREATE NONCLUSTERED INDEX [idx_NewUsers_UserID] ON [dbo].[NewUsers]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alerts] ADD  DEFAULT (getdate()) FOR [AlertDate]
GO
ALTER TABLE [dbo].[Alerts] ADD  DEFAULT ((0)) FOR [Resolved]
GO
ALTER TABLE [dbo].[Comparisons] ADD  DEFAULT (getdate()) FOR [ComparisonDate]
GO
ALTER TABLE [dbo].[CowDiagnosis] ADD  DEFAULT (getdate()) FOR [DiagnosisDate]
GO
ALTER TABLE [dbo].[Feeding] ADD  DEFAULT (getdate()) FOR [FeedDate]
GO
ALTER TABLE [dbo].[HealthMetrics] ADD  DEFAULT (getdate()) FOR [DateRecorded]
GO
ALTER TABLE [dbo].[HistoricalData] ADD  DEFAULT (getdate()) FOR [EventDate]
GO
ALTER TABLE [dbo].[MyCattle] ADD  DEFAULT (getdate()) FOR [OwnershipDate]
GO
ALTER TABLE [dbo].[NewUsers] ADD  DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [EmailSent]
GO
ALTER TABLE [dbo].[Alerts]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[Comparisons]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[CowDiagnosis]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[Cows]  WITH CHECK ADD FOREIGN KEY([FarmID])
REFERENCES [dbo].[Farm] ([FarmID])
GO
ALTER TABLE [dbo].[DiseaseHistory]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[Farm]  WITH CHECK ADD FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Feeding]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[HealthMetrics]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[HistoricalData]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[HistoricalData]  WITH CHECK ADD FOREIGN KEY([DiagnosisID])
REFERENCES [dbo].[CowDiagnosis] ([DiagnosisID])
GO
ALTER TABLE [dbo].[HistoricalData]  WITH CHECK ADD FOREIGN KEY([MetricID])
REFERENCES [dbo].[HealthMetrics] ([MetricID])
GO
ALTER TABLE [dbo].[HistoricalData]  WITH CHECK ADD FOREIGN KEY([TreatmentID])
REFERENCES [dbo].[Treatments] ([TreatmentID])
GO
ALTER TABLE [dbo].[MyCattle]  WITH CHECK ADD FOREIGN KEY([CowID])
REFERENCES [dbo].[Cows] ([CowID])
GO
ALTER TABLE [dbo].[MyCattle]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Treatments]  WITH CHECK ADD FOREIGN KEY([DiagnosisID])
REFERENCES [dbo].[CowDiagnosis] ([DiagnosisID])
GO
ALTER TABLE [dbo].[Vets]  WITH CHECK ADD FOREIGN KEY([FarmID])
REFERENCES [dbo].[Farm] ([FarmID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='User' OR [Role]='Vet' OR [Role]='Admin'))
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_User]
    @Username NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(50), 
    @Role NVARCHAR(20)
AS
BEGIN
    
    DECLARE @PasswordHash NVARCHAR(255);

    
    DECLARE @UserExists INT;
    EXEC @UserExists = CheckUserExists @Username, @Email;

    IF @UserExists = 1
    BEGIN
        
        RETURN;  
    END

    
    SET @PasswordHash = CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', @Password), 2);  -- Hash de la contraseña

    
    INSERT INTO Users (Username, Email, PasswordHash, Role, RegistrationDate)
    VALUES (@Username, @Email, @PasswordHash, @Role, GETDATE());
END;

GO
/****** Object:  StoredProcedure [dbo].[CheckCowHealth]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckCowHealth]
    @CowID INT
AS
BEGIN
    DECLARE @Weight DECIMAL(5,2), @HeartRate INT, @Temperature DECIMAL(4,2);
    DECLARE @MinWeight DECIMAL(5,2), @MaxWeight DECIMAL(5,2);
    DECLARE @MinHeartRate INT, @MaxHeartRate INT;
    DECLARE @MinTemperature DECIMAL(4,2), @MaxTemperature DECIMAL(4,2);
    
    -- Get the current cow's metrics from HealthMetrics table
    SELECT @Weight = h.Weight, @HeartRate = h.HeartRate, @Temperature = h.Temperature
    FROM HealthMetrics h
    WHERE h.CowID = @CowID;

    -- Get the healthy weight limits from HealthMetricLimits table
    SELECT @MinWeight = l.MinValue, @MaxWeight = l.MaxValue
    FROM HealthMetricLimits l
    WHERE l.MetricName = 'Weight';

    -- Get the healthy heart rate limits from HealthMetricLimits table
    SELECT @MinHeartRate = l.MinValue, @MaxHeartRate = l.MaxValue
    FROM HealthMetricLimits l
    WHERE l.MetricName = 'HeartRate';

    -- Get the healthy temperature limits from HealthMetricLimits table
    SELECT @MinTemperature = l.MinValue, @MaxTemperature = l.MaxValue
    FROM HealthMetricLimits l
    WHERE l.MetricName = 'Temperature';

    -- Check if the cow's metrics are within the healthy limits
    IF (@Weight > @MaxWeight OR @Weight < @MinWeight)
    BEGIN
        PRINT 'The cow has an abnormal weight. Suggest adjusting the diet or monitoring more closely.';
    END
    ELSE IF (@HeartRate < @MinHeartRate OR @HeartRate > @MaxHeartRate)
    BEGIN
        PRINT 'The cow has an abnormal heart rate. Consult a vet for further analysis.';
    END
    ELSE IF (@Temperature < @MinTemperature OR @Temperature > @MaxTemperature)
    BEGIN
        PRINT 'The cow has an abnormal temperature. Check for symptoms of illness and consult a vet.';
    END
    ELSE
    BEGIN
        PRINT 'The cow is healthy. No action is required.';
    END
END;

GO
/****** Object:  StoredProcedure [dbo].[CheckUserExists]    Script Date: 10/29/2024 10:36:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckUserExists]
    @Username NVARCHAR(50),
    @Email NVARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Username = @Username OR Email = @Email)
    BEGIN
        RETURN 1;  
    END
    ELSE
    BEGIN
        RETURN 0;  
    END
END;
GO
USE [master]
GO
ALTER DATABASE [Cowculator] SET  READ_WRITE 
GO

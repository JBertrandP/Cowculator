USE [master]
GO
/****** Object:  Database [Integrador]    Script Date: 10/8/2024 1:00:59 PM ******/
CREATE DATABASE [Integrador]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Integrador', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Integrador.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Integrador_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Integrador_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Integrador] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Integrador].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Integrador] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Integrador] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Integrador] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Integrador] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Integrador] SET ARITHABORT OFF 
GO
ALTER DATABASE [Integrador] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Integrador] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Integrador] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Integrador] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Integrador] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Integrador] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Integrador] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Integrador] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Integrador] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Integrador] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Integrador] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Integrador] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Integrador] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Integrador] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Integrador] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Integrador] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Integrador] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Integrador] SET RECOVERY FULL 
GO
ALTER DATABASE [Integrador] SET  MULTI_USER 
GO
ALTER DATABASE [Integrador] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Integrador] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Integrador] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Integrador] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Integrador] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Integrador] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Integrador', N'ON'
GO
ALTER DATABASE [Integrador] SET QUERY_STORE = ON
GO
ALTER DATABASE [Integrador] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Integrador]
GO
/****** Object:  Table [dbo].[Alerts]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alerts](
	[alert_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[alert_type] [varchar](50) NULL,
	[alert_message] [text] NULL,
	[alert_status] [varchar](50) NULL,
	[alert_date] [datetime] NULL,
	[alert_criteria_met] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[alert_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comparisons]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comparisons](
	[comparison_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[healthy_cow_id] [int] NULL,
	[comparison_result] [varchar](255) NULL,
	[comparison_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[comparison_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CowDiagnosis]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CowDiagnosis](
	[cow_id] [int] NOT NULL,
	[diagnosis_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cow_id] ASC,
	[diagnosis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cows]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cows](
	[cow_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[breed] [varchar](100) NULL,
	[age] [int] NULL,
	[farm_id] [int] NULL,
	[healthy_status] [bit] NULL,
	[created_at] [datetime] NULL,
	[last_health_check] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[cow_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnoses]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnoses](
	[diagnosis_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[vet_id] [int] NULL,
	[diagnosis_description] [text] NULL,
	[diagnosis_date] [date] NULL,
	[treatment_plan] [text] NULL,
	[severity_level] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[diagnosis_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiseaseHistory]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiseaseHistory](
	[disease_history_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[disease_name] [varchar](100) NULL,
	[diagnosis_date] [date] NULL,
	[treatment_plan] [text] NULL,
	[recovery_date] [date] NULL,
	[disease_status] [varchar](50) NULL,
	[severity_level] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[disease_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Farm]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Farm](
	[farm_id] [int] IDENTITY(1,1) NOT NULL,
	[farm_name] [varchar](150) NULL,
	[location] [varchar](255) NULL,
	[owner_name] [varchar](100) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[farm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feeding]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feeding](
	[feeding_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[feed_type] [varchar](100) NULL,
	[amount] [decimal](5, 2) NULL,
	[feeding_date] [date] NULL,
	[feed_impact_on_health] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[feeding_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthMetricLimits]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthMetricLimits](
	[breed] [varchar](100) NOT NULL,
	[min_weight] [decimal](5, 2) NULL,
	[max_weight] [decimal](5, 2) NULL,
	[min_temperature] [decimal](4, 2) NULL,
	[max_temperature] [decimal](4, 2) NULL,
	[min_heart_rate] [int] NULL,
	[max_heart_rate] [int] NULL,
	[min_activity_level] [decimal](5, 2) NULL,
	[max_activity_level] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[breed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthMetrics]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthMetrics](
	[metric_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[weight] [decimal](5, 2) NULL,
	[temperature] [decimal](4, 2) NULL,
	[heart_rate] [int] NULL,
	[activity_level] [decimal](5, 2) NULL,
	[bloating] [bit] NULL,
	[other_symptoms] [text] NULL,
	[metric_date] [date] NULL,
	[metric_status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[metric_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthyCows]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthyCows](
	[cow_id] [int] IDENTITY(1,1) NOT NULL,
	[breed] [varchar](100) NULL,
	[avg_weight] [decimal](5, 2) NULL,
	[avg_temperature] [decimal](4, 2) NULL,
	[avg_heart_rate] [int] NULL,
	[avg_activity_level] [decimal](5, 2) NULL,
	[last_updated] [date] NULL,
	[follow_up_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[cow_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoricalData]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoricalData](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[weight] [decimal](5, 2) NULL,
	[temperature] [decimal](4, 2) NULL,
	[heart_rate] [int] NULL,
	[bloating] [bit] NULL,
	[metric_date] [date] NULL,
	[reason_for_history] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatments]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatments](
	[treatment_id] [int] IDENTITY(1,1) NOT NULL,
	[cow_id] [int] NULL,
	[treatment_description] [text] NULL,
	[treatment_start_date] [date] NULL,
	[treatment_end_date] [date] NULL,
	[success_rate] [decimal](5, 2) NULL,
	[treatment_effectiveness] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[treatment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vets]    Script Date: 10/8/2024 1:00:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vets](
	[vet_id] [int] IDENTITY(1,1) NOT NULL,
	[vet_name] [varchar](100) NULL,
	[license_number] [varchar](50) NULL,
	[contact_info] [varchar](255) NULL,
	[specialty] [varchar](100) NULL,
	[farm_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[vet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alerts] ADD  DEFAULT ('Pending') FOR [alert_status]
GO
ALTER TABLE [dbo].[Alerts] ADD  DEFAULT (getdate()) FOR [alert_date]
GO
ALTER TABLE [dbo].[Comparisons] ADD  DEFAULT (getdate()) FOR [comparison_date]
GO
ALTER TABLE [dbo].[Cows] ADD  DEFAULT ((1)) FOR [healthy_status]
GO
ALTER TABLE [dbo].[Cows] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Farm] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Alerts]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Comparisons]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Comparisons]  WITH CHECK ADD FOREIGN KEY([healthy_cow_id])
REFERENCES [dbo].[HealthyCows] ([cow_id])
GO
ALTER TABLE [dbo].[CowDiagnosis]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[CowDiagnosis]  WITH CHECK ADD FOREIGN KEY([diagnosis_id])
REFERENCES [dbo].[Diagnoses] ([diagnosis_id])
GO
ALTER TABLE [dbo].[Diagnoses]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Diagnoses]  WITH CHECK ADD FOREIGN KEY([vet_id])
REFERENCES [dbo].[Vets] ([vet_id])
GO
ALTER TABLE [dbo].[DiseaseHistory]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Feeding]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[HealthMetrics]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[HistoricalData]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Treatments]  WITH CHECK ADD FOREIGN KEY([cow_id])
REFERENCES [dbo].[Cows] ([cow_id])
GO
ALTER TABLE [dbo].[Vets]  WITH CHECK ADD FOREIGN KEY([farm_id])
REFERENCES [dbo].[Farm] ([farm_id])
GO
USE [master]
GO
ALTER DATABASE [Integrador] SET  READ_WRITE 
GO

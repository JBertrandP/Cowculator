# Project description 

# Cowculator 🐄
This project is an integrated solution focused on cattle health management, specifically for cows. Cowculator allows farmers and veterinarians to keep track of their cattle’s health metrics, assess the health status, and receive alerts for any abnormalities, all in a user-friendly web interface. 

## 📋 Project Overview

**Cowculator** aims to assist cattle farmers in monitoring and managing the health of their cows by comparing recorded metrics against predefined healthy benchmarks. The application can alert users if a cow shows signs of potential health issues, helping to improve herd health and reduce risks associated with undetected problems.

### Main Features
- **Record Cattle Health Data**: Add data related to weight, heart rate, temperature, and other health metrics.
- **Health Assessment**: Automatically assess the health status of each cow based on predefined healthy limits.
- **Alert System**: Receive alerts when health metrics fall outside of safe ranges.
- **Veterinarian and Farm Management**: Manage veterinarians across farms, keep track of treatments, and access a history of diagnoses.
- **User-Friendly Dashboard**: Easily navigate, input, and view data about your cattle.

## 🚀 Technologies Used

This project integrates both backend and frontend technologies to provide a seamless experience:
- **Frontend**: HTML, CSS, JavaScript
- **Backend**: Python
- **Database**: SQL Server
- **Artificial Intelligence**: PyTorch for basic AI-based health recommendations
- **Automation**: Python-based bot for automated email notifications

## 🗂 Database Structure

The Cowculator project includes a structured SQL database designed to manage cattle health metrics, user information, and alerts. Each table has a specific purpose, ensuring data integrity and facilitating streamlined operations. Here’s an overview of the main tables:

- **Users**: Stores information on registered users, including their credentials and registration details. Key columns include `UserID`, `Username`, `Email`, `PasswordHash`, `Role`, `RegistrationDate`, and `EmailSent` to track whether a welcome email has been sent.

- **Cows**: Records individual cow information, such as `CowID`, `FarmID`, `Breed`, `Age`, `Weight`, and other identifying details. This table allows easy association of each cow with farms and other records.

- **HealthMetrics**: This table tracks health data metrics for each cow, storing records with columns like `MetricID`, `CowID`, `Weight`, `Temperature`, `HeartRate`, and `DateRecorded`. Each entry enables monitoring of individual health metrics over time.

- **HealthMetricLimits**: Defines the acceptable health metric ranges to assess cow health status. Key columns include `LimitID`, `MetricName`, `MinValue`, and `MaxValue`, which represent the healthy bounds for each metric (e.g., weight, heart rate, temperature).

- **Alerts**: Stores alerts that are triggered when a cow’s health metrics fall outside of the defined limits. Key columns include `AlertID`, `CowID`, `MetricID`, `AlertMessage`, and `DateIssued`, providing a log of health warnings for user reference.

- **MyCattle**: Contains data on the cows managed by individual users, enabling personalized tracking. Key columns include `MyCattleID`, `UserID`, `CowID`, `AssignedDate`, and any additional details specific to a user's cattle.

- **Vets**: Holds information about veterinarians, including `VetID`, `Name`, `Specialty`, and `FarmID`, allowing vets to be linked to multiple farms for flexible management.

- **Farm**: Stores information about the farms where the cows are located. Key columns include `FarmID`, `FarmName`, `Location`, and `OwnerID`, organizing each farm and linking them to cows and veterinarians.

- **CowDiagnosis**: Records diagnoses given to cows, tracking issues and conditions over time. Key columns include `DiagnosisID`, `CowID`, `Diagnosis`, `DiagnosisDate`, and `VetID`, maintaining a history of diagnoses and treatments.

- **Treatments**: Details treatments given to cows based on diagnoses, with columns such as `TreatmentID`, `DiagnosisID`, `TreatmentDescription`, `StartDate`, and `EndDate`, supporting continuity of care records.

- **Comparisons**: Facilitates metric comparisons to standard values, allowing assessments of health data against established healthy metrics.

- **Feeding**: Tracks feeding schedules and quantities for each cow. Key columns include `FeedingID`, `CowID`, `FeedType`, `Quantity`, and `FeedingTime`, aiding in monitoring nutritional intake.

- **DiseaseHistory**: Records previous diseases that have affected each cow, creating a health history. Key columns include `HistoryID`, `CowID`, `DiseaseName`, `DiagnosisDate`, and `RecoveryDate`.

- **HistoricalData**: Maintains historical records of health metrics, diagnoses, and treatments for data analysis over time.

Each table is interconnected to ensure consistent, reliable data, enabling Cowculator to provide real-time health assessments and alert notifications.

## 📊 Project Objectives

1. **Main Objective**: To develop a web-based tool that helps in monitoring cattle health by comparing metrics with healthy benchmarks, and provides alerts to users when necessary.
2. **Specific Objectives**:
   - To enable real-time health assessment.
   - To automate alert notifications for out-of-range health metrics.
   - To provide recommendations based on AI analysis of health data.
   - To facilitate farm and veterinarian management.

🤖 AI-Powered Health Assessment
Cowculator includes a basic AI model to provide recommendations based on inputted health data. This model offers advice on potential treatments or care adjustments if a cow’s metrics fall outside healthy ranges.
The model is implemented with PyTorch, designed to learn from historic data and offer insights to support the alert system.

📧 Automated Email Notifications
An automated bot will send a welcome email to each new user upon registration. This bot is built with Python’s smtplib and is set to run periodically, ensuring prompt engagement with new users.

⏳ Project Timeline
The project is developed within a 3-month period, starting in September and ending in November.

📈 Future Enhancements
Some planned features include:
Expanded AI capabilities for more complex recommendations.
Enhanced dashboard visualizations.
Integration with mobile apps for remote access.

🐄 Acknowledgments
This project was created as part of an integrative project in Software Development, with a focus on improving livestock management for farmers and veterinarians.

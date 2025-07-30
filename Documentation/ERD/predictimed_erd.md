# PredictiMed Decision Support System - Entity Relationship Diagram

```mermaid
erDiagram
    %% Account Management
    Account {
        string id PK
        string email UK "Unique Email"
        string password "Hashed Password"
        string role "Admin, User, Health_Worker"
        boolean isActive
        datetime createdAt
        datetime updatedAt
        string profilePictureUrl
        boolean emailVerified
        datetime lastLogin
    }

    UserProfile {
        string id PK
        string accountId FK "References Account"
        string fullName
        date dateOfBirth
        int age
        string gender "Male, Female"
        string address
        string contactNumber
        string religion
        string civilStatus "Single, Married, Widowed, Separated, Live-in"
        string occupation
        string educationLevel
        string philhealthNumber
        string nhtsStatus "NHTS, Non-NHTS"
        boolean personWithDisability
        boolean indigenousPeople
        datetime createdAt
        datetime updatedAt
    }

    %% Family Records
    FamilyRecord {
        string id PK
        string familyId UK "Unique Family Identifier"
        string headOfFamilyId FK "References UserProfile"
        string address
        string contactNumber
        boolean smsConsent
        datetime createdAt
        datetime updatedAt
    }

    FamilyMember {
        string id PK
        string familyRecordId FK
        string userProfileId FK "References UserProfile (if has account)"
        string memberName
        string relationship "Head, Spouse, Child, Parent, Sibling, Other"
        string gender
        int age
        string occupation
        string civilStatus
        datetime createdAt
    }

    FamilyHealthHistory {
        string id PK
        string familyRecordId FK
        string[] geneticConditions
        string[] chronicDiseases
        datetime recordedDate
        string recordedBy FK "References Account"
    }

    %% Medical Records Categories
    MaternalHealth {
        string id PK
        string userProfileId FK
        string mothersName
        int mothersAge
        date mothersBirthday
        string mothersMaidenName
        string mothersReligion
        string mothersEducation
        string mothersOccupation
        int numberOfChildren
        string gravidaPara "G/P format"
        int menarcheAge
        date lastMenstrualPeriod
        date expectedDeliveryDate
        string tetanusToxoidStatus "TT1-TT5"
        datetime createdAt
        datetime updatedAt
    }

    PrenatalVisit {
        string id PK
        string maternalHealthId FK
        date visitDate
        int gestationalAgeWeeks
        float weightKg
        float heightCm
        string bloodPressure "systolic/diastolic"
        float fundalHeightCm
        string fetalHeartTone
        date nextVisitDate
        string recordedBy FK "References Account"
        datetime createdAt
    }

    LaboratoryTest {
        string id PK
        string prenatalVisitId FK "References PrenatalVisit (nullable)"
        string userProfileId FK "References UserProfile (nullable)"
        date testDate
        string testType "CBC, Urinalysis, HBsAg, VDRL, Ultrasound"
        boolean testCompleted
        string recordedBy FK "References Account"
        datetime createdAt
    }

    Intervention {
        string id PK
        string prenatalVisitId FK
        string tetanusToxoidDose
        string tetanusToxoidLocation
        date tetanusToxoidDate
        boolean ironSupplementation
        string ironMedication
        boolean vitaminSupplementation
        string vitaminMedication
        boolean calciumSupplementation
        string calciumMedication
        string[] healthEducationTopics
        datetime createdAt
    }

    %% Birth Information
    BirthInformation {
        string id PK
        string userProfileId FK "Child's profile"
        string maternalHealthId FK
        string placeOfDelivery
        time timeOfDelivery
        string deliveryType "NSD, CS, Normal Spontaneous Delivery, Cesarean Section"
        float birthWeightKg
        float birthHeightCm
        date newbornScreeningDate
        boolean newbornScreeningCompleted
        string feedingType "Breastfeeding, Mixed, Bottle-fed"
        datetime createdAt
        string recordedBy FK "References Account"
    }

    %% Immunization Records
    ImmunizationEvent {
        string id PK
        string userProfileId FK
        date visitDate
        float temperatureCelsius
        float weightKg
        float heightCm
        string adverseReactions
        string healthWorkerName
        string healthWorkerSignature
        date nextFollowupDate
        datetime createdAt
        string recordedBy FK "References Account"
    }

    VaccineGiven {
        string id PK
        string immunizationEventId FK
        string vaccineName "BCG, Hepatitis_B, Penta, OPV, IPV, PCV10, MCV1_MMR, MCV2, Vitamin_A"
        string doseNumber "1st, 2nd, 3rd"
        date dateGiven
        string lotNumber
        datetime createdAt
    }

    %% Health Monitoring
    VitalSigns {
        string id PK
        string userProfileId FK
        date recordDate
        string bloodPressure "systolic/diastolic"
        int heartRate
        int respiratoryRate
        float temperatureCelsius
        int pulseRate
        string recordedBy FK "References Account"
        datetime createdAt
    }

    AnthropometricMeasurement {
        string id PK
        string userProfileId FK
        date measurementDate
        float weightKg
        float heightCm
        float headCircumferenceCm "For infants and children"
        float waistCircumferenceCm "For NCD risk assessment"
        float bmi
        string recordedBy FK "References Account"
        datetime createdAt
    }

    GrowthTracking {
        string id PK
        string userProfileId FK
        date trackingDate
        string weightForAge
        string heightForAge
        string weightForHeight
        string recordedBy FK "References Account"
        datetime createdAt
    }

    %% Visit Records
    VisitRecord {
        string id PK
        string userProfileId FK
        date visitDate
        string visitType "Routine Check-up, Follow-up, Emergency, Preventive Care"
        string visitFrequency
        boolean referred
        string facilityName
        string referralReason
        string recordedBy FK "References Account"
        datetime createdAt
    }

    %% NCD Risk Assessment
    NCDRiskAssessment {
        string id PK
        string userProfileId FK
        date assessmentDate
        string smokingStatus "Current, Former, Never"
        string alcoholIntake "Regular, Occasional, Never"
        string physicalActivity "Active, Inactive, Moderate"
        string fruitVegetableIntake "Adequate, Inadequate"
        boolean familyHistoryDiabetes
        boolean familyHistoryHypertension
        boolean familyHistoryHeartDisease
        boolean familyHistoryStroke
        boolean screeningCompleted
        boolean followUpNeeded
        string[] lifestyleModifications
        string[] healthEducationReceived
        string recordedBy FK "References Account"
        datetime createdAt
    }

    %% Healthcare Services
    HealthWorker {
        string id PK
        string accountId FK "References Account"
        string name
        string role "Doctor, Nurse, Midwife, Health Worker, Other"
        string contactNumber
        string signature
        boolean isActive
        datetime createdAt
    }

    HealthEducation {
        string id PK
        string userProfileId FK
        string[] topicsCovered
        date dateProvided
        string providedBy FK "References HealthWorker"
        datetime createdAt
    }

    NutritionalCounseling {
        string id PK
        string userProfileId FK
        string recommendations
        date dateProvided
        string providedBy FK "References HealthWorker"
        datetime createdAt
    }

    Referral {
        string id PK
        string userProfileId FK
        string facilityName
        string reason
        date dateReferred
        string status "Pending, Completed, Cancelled"
        string referredBy FK "References HealthWorker"
        datetime createdAt
    }

    %% Follow-up System
    Appointment {
        string id PK
        string userProfileId FK
        date nextVisitDate
        string visitType "Prenatal, Immunization, Growth Monitoring, NCD Follow-up, Sick Visit"
        string appointmentStatus "Scheduled, Completed, Missed, Cancelled"
        string scheduledBy FK "References Account"
        datetime createdAt
        datetime updatedAt
    }

    ImmunizationReminder {
        string id PK
        string userProfileId FK
        string vaccineName
        date dueDate
        boolean reminderSent
        datetime sentAt
        datetime createdAt
    }

    TestReminder {
        string id PK
        string userProfileId FK
        string testName
        date dueDate
        boolean reminderSent
        datetime sentAt
        datetime createdAt
    }

    %% Events & Seminars
    Event {
        string id PK
        string title
        string description
        string eventType "Event, Seminar, Workshop"
        date eventDate
        time startTime
        time endTime
        string venue
        string targetAudience
        int maxParticipants
        string status "Draft, Published, Cancelled, Completed"
        string bannerImageUrl
        string createdBy FK "References Account"
        datetime createdAt
        datetime updatedAt
    }

    EventRegistration {
        string id PK
        string eventId FK
        string userProfileId FK
        date registrationDate
        string status "Registered, Attended, No-Show, Cancelled"
        string notes
        datetime createdAt
    }

    %% Medical Programs
    MedicalProgram {
        string id PK
        string programName
        string description
        string programType "Mass Vaccination, Mass Checkup, Mass Circumcision, Health Screening"
        date startDate
        date endDate
        string venue
        string targetDemographic "Children, Adults, Pregnant Women, Senior Citizens, All"
        int targetParticipants
        string status "Planning, Active, Completed, Cancelled"
        string bannerImageUrl
        string createdBy FK "References Account"
        datetime createdAt
        datetime updatedAt
    }

    ProgramParticipation {
        string id PK
        string medicalProgramId FK
        string userProfileId FK
        date participationDate
        string status "Registered, Participated, No-Show"
        string servicesReceived
        string notes
        string recordedBy FK "References Account"
        datetime createdAt
    }

    %% Virtual Checkup
    VirtualCheckup {
        string id PK
        string userProfileId FK
        string healthWorkerId FK
        date scheduledDate
        time scheduledTime
        string meetingUrl
        string status "Scheduled, In-Progress, Completed, Cancelled, No-Show"
        string consultationType "General Consultation, Follow-up, Emergency"
        string chiefComplaint
        string notes
        int durationMinutes
        datetime createdAt
        datetime updatedAt
    }

    VirtualCheckupNote {
        string id PK
        string virtualCheckupId FK
        string note
        string createdBy FK "References Account"
        datetime createdAt
    }

    %% Inquiries
    Inquiry {
        string id PK
        string userProfileId FK
        string subject
        string message
        string priority "Low, Normal, High, Urgent"
        string status "Open, In-Progress, Resolved, Closed"
        string category "General, Medical, Technical, Appointment"
        datetime createdAt
        datetime updatedAt
    }

    InquiryResponse {
        string id PK
        string inquiryId FK
        string message
        string respondedBy FK "References Account"
        datetime createdAt
    }

    %% Survey System
    Survey {
        string id PK
        string title
        string description
        string surveyType "Household Data, Health Assessment, Feedback, Research"
        boolean isActive
        date startDate
        date endDate
        string qrCode
        string createdBy FK "References Account"
        datetime createdAt
        datetime updatedAt
    }

    SurveyQuestion {
        string id PK
        string surveyId FK
        string questionText
        string questionType "Text, Number, Multiple Choice, Checkbox, Date, Boolean"
        string[] options "For multiple choice and checkbox"
        boolean isRequired
        int orderIndex
        datetime createdAt
    }

    SurveyResponse {
        string id PK
        string surveyId FK
        string userProfileId FK "References UserProfile (nullable for anonymous)"
        string ipAddress
        datetime submittedAt
        datetime createdAt
    }

    SurveyAnswer {
        string id PK
        string surveyResponseId FK
        string surveyQuestionId FK
        string answer
        datetime createdAt
    }

    %% Analytics & Reports
    AnalyticsReport {
        string id PK
        string reportName
        string reportType "Population Health, Immunization Coverage, Growth Trends, Disease Surveillance"
        string[] dataFilters
        json reportData
        date reportPeriodStart
        date reportPeriodEnd
        string generatedBy FK "References Account"
        datetime createdAt
    }

    PredictionModel {
        string id PK
        string modelName
        string modelType "Immunization Compliance, Growth Trajectory, Disease Outbreak, Resource Demand"
        json modelParameters
        json predictionResults
        float accuracy
        date lastTrained
        boolean isActive
        string createdBy FK "References Account"
        datetime createdAt
        datetime updatedAt
    }

    %% System Logs
    SystemLog {
        string id PK
        string userId FK "References Account"
        string action
        string entityType
        string entityId
        json oldData
        json newData
        string ipAddress
        string userAgent
        datetime createdAt
    }

    %% Relationships
    Account ||--|| UserProfile : "has"
    Account ||--o{ HealthWorker : "can be"

    UserProfile ||--o{ FamilyMember : "can be member of"
    FamilyRecord ||--o{ FamilyMember : "contains"
    FamilyRecord ||--|| FamilyHealthHistory : "has"
    UserProfile ||--|| FamilyRecord : "heads family"

    UserProfile ||--o{ MaternalHealth : "has"
    MaternalHealth ||--o{ PrenatalVisit : "has visits"
    PrenatalVisit ||--o{ LaboratoryTest : "may have tests"
    PrenatalVisit ||--o{ Intervention : "has interventions"

    UserProfile ||--o{ BirthInformation : "has birth record"
    MaternalHealth ||--o{ BirthInformation : "related to"

    UserProfile ||--o{ ImmunizationEvent : "has immunizations"
    ImmunizationEvent ||--o{ VaccineGiven : "contains vaccines"

    UserProfile ||--o{ VitalSigns : "has vital signs"
    UserProfile ||--o{ AnthropometricMeasurement : "has measurements"
    UserProfile ||--o{ GrowthTracking : "has growth data"
    UserProfile ||--o{ VisitRecord : "has visit records"
    UserProfile ||--o{ NCDRiskAssessment : "has risk assessments"

    UserProfile ||--o{ HealthEducation : "receives education"
    UserProfile ||--o{ NutritionalCounseling : "receives counseling"
    UserProfile ||--o{ Referral : "has referrals"

    UserProfile ||--o{ Appointment : "has appointments"
    UserProfile ||--o{ ImmunizationReminder : "has reminders"
    UserProfile ||--o{ TestReminder : "has test reminders"

    Account ||--o{ Event : "creates events"
    Event ||--o{ EventRegistration : "has registrations"
    UserProfile ||--o{ EventRegistration : "registers for events"

    Account ||--o{ MedicalProgram : "creates programs"
    MedicalProgram ||--o{ ProgramParticipation : "has participants"
    UserProfile ||--o{ ProgramParticipation : "participates in programs"

    UserProfile ||--o{ VirtualCheckup : "schedules checkups"
    HealthWorker ||--o{ VirtualCheckup : "conducts checkups"
    VirtualCheckup ||--o{ VirtualCheckupNote : "has notes"

    UserProfile ||--o{ Inquiry : "creates inquiries"
    Inquiry ||--o{ InquiryResponse : "has responses"

    Account ||--o{ Survey : "creates surveys"
    Survey ||--o{ SurveyQuestion : "has questions"
    Survey ||--o{ SurveyResponse : "has responses"
    SurveyResponse ||--o{ SurveyAnswer : "has answers"
    UserProfile ||--o{ SurveyResponse : "submits responses"

    Account ||--o{ AnalyticsReport : "generates reports"
    Account ||--o{ PredictionModel : "creates models"

    Account ||--o{ SystemLog : "has activity logs"
```

## Database Schema Overview

This ERD represents the comprehensive database structure for the PredictiMed Decision Support System, designed to support:

### Core Features:

-   **Account Management**: Multi-role user authentication and profiles
-   **Medical Records**: Comprehensive health data tracking for trend analysis
-   **Family Health Records**: Family-based health information management
-   **Maternal & Child Health**: Prenatal care, birth records, and immunization tracking
-   **Health Monitoring**: Vital signs, growth tracking, and NCD risk assessment
-   **Events & Seminars**: Healthcare event management system
-   **Medical Programs**: Mass health program coordination
-   **Virtual Checkup**: Telemedicine consultation platform
-   **Inquiries**: User-admin communication system
-   **Survey System**: QR code-enabled data collection
-   **Analytics & Reports**: Decision support and predictive modeling
-   **System Monitoring**: Comprehensive audit trail and logging

### Key Relationships:

-   Each **Account** has one **UserProfile** with detailed demographic information
-   **UserProfiles** can belong to **FamilyRecords** for household health tracking
-   **MaternalHealth** records link to **PrenatalVisits** and **BirthInformation**
-   **ImmunizationEvents** track multiple **VaccinesGiven** per visit
-   **Surveys** support multiple **SurveyQuestions** with flexible **SurveyResponses**
-   **Analytics** and **PredictionModels** enable trend analysis and forecasting

### Design Principles:

-   **Trend-Focused**: All models designed for time-series analysis rather than diagnostic decisions
-   **Audit-Ready**: Complete change tracking for all medical records
-   **Scalable**: Optimized for large datasets and complex queries
-   **Flexible**: Supports various health programs and data collection methods

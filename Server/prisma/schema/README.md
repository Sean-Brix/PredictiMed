# PredictiMed Prisma Schema Organization

This directory contains the Prisma schema files organized into logical modules following the 8-page ERD structure.

## �️ **Database: MySQL**

The schema is optimized for MySQL with JSON fields for array data and complex structures.

## �📁 File Structure

```
prisma/
├── schema/
│   ├── schema.prisma                          # Main config (generator & datasource)
│   ├── 01_account_management.prisma           # Core user authentication & profiles
│   ├── 02_family_records.prisma               # Family & household management
│   ├── 03_maternal_child_health.prisma        # Pregnancy & child health records
│   ├── 04_immunization_health_monitoring.prisma # Vaccines & health monitoring
│   ├── 05_healthcare_services.prisma          # Services & appointments
│   ├── 06_events_programs.prisma              # Community events & programs
│   ├── 07_communication_surveys.prisma        # Communication & data collection
│   └── 08_analytics_system_management.prisma  # Analytics & system logs
```

## 🏗️ Module Organization

### **01. Core Account & User Management**

-   `Account` - Authentication and authorization
-   `UserProfile` - Detailed demographic information
-   `HealthWorker` - Healthcare provider profiles

### **02. Family & Household Management**

-   `FamilyRecord` - Household information
-   `FamilyMember` - Individual family member data
-   `FamilyHealthHistory` - Genetic and chronic disease history

### **03. Maternal & Child Health**

-   `MaternalHealth` - Pregnancy records
-   `PrenatalVisit` - Prenatal checkup data
-   `LaboratoryTest` - Medical tests and results
-   `Intervention` - Health interventions
-   `BirthInformation` - Delivery and newborn details

### **04. Immunization & Health Monitoring**

-   `ImmunizationEvent` - Vaccination visits
-   `VaccineGiven` - Specific vaccines administered
-   `VitalSigns` - Basic health measurements
-   `AnthropometricMeasurement` - Physical measurements
-   `GrowthTracking` - Child development monitoring
-   `NCDRiskAssessment` - Disease risk evaluation

### **05. Healthcare Services & Appointments**

-   `VisitRecord` - General healthcare visits
-   `HealthEducation` - Educational interventions
-   `NutritionalCounseling` - Dietary guidance
-   `Referral` - Healthcare referrals
-   `Appointment` - Scheduled visits
-   `ImmunizationReminder` & `TestReminder` - Follow-up systems
-   `VirtualCheckup` & `VirtualCheckupNote` - Telemedicine

### **06. Events, Programs & Community Engagement**

-   `Event` - Community health events
-   `EventRegistration` - Event participation
-   `MedicalProgram` - Mass health programs
-   `ProgramParticipation` - Program attendance

### **07. Communication & Surveys**

-   `Inquiry` & `InquiryResponse` - User-admin communication
-   `Survey` - Data collection instruments
-   `SurveyQuestion` - Survey structure
-   `SurveyResponse` & `SurveyAnswer` - Survey data

### **08. Analytics & System Management**

-   `AnalyticsReport` - Health trend reports
-   `PredictionModel` - AI/ML predictive models
-   `SystemLog` - Audit trail and activity tracking

## 🔧 Usage Instructions

### **MySQL-Specific Considerations**

-   **Array Data**: Stored as JSON arrays (e.g., `["item1", "item2"]`)
-   **Complex Data**: Analytics and prediction data stored as JSON objects
-   **Indexing**: MySQL automatically indexes JSON fields for efficient queries

### **Working with JSON Arrays in Code**

```javascript
// Creating records with JSON arrays
const healthEducation = await prisma.healthEducation.create({
    data: {
        userProfileId: 'user123',
        topicsCovered: ['nutrition', 'exercise', 'hygiene'],
        dateProvided: new Date(),
        providedBy: 'healthworker123',
    },
});

// Querying JSON arrays
const educationRecords = await prisma.healthEducation.findMany({
    where: {
        topicsCovered: {
            path: '$',
            array_contains: 'nutrition',
        },
    },
});
```

### **Development Workflow**

1. **Individual Module Development**: Work on specific domain files independently
2. **Cross-module Changes**: Update relationships across multiple files as needed
3. **Schema Generation**: Prisma automatically combines all files

### **Migration Commands**

```bash
# Generate Prisma client
npx prisma generate

# Create and apply migration
npx prisma migrate dev --name "descriptive_migration_name"

# Reset database (development only)
npx prisma migrate reset
```

### **Database Commands**

```bash
# View database in Prisma Studio
npx prisma studio

# Check migration status
npx prisma migrate status

# Deploy to production
npx prisma migrate deploy
```

## 🔗 Key Relationships

### **Central Entities**

-   **Account**: Referenced across analytics, events, surveys, system logs
-   **UserProfile**: Central to all patient-related modules
-   **HealthWorker**: Links accounts to healthcare services

### **Cross-Module Dependencies**

-   Family Records → Account Management (UserProfile)
-   Maternal Health → Account Management (UserProfile)
-   All Health Records → Account Management (UserProfile)
-   Events/Programs → Account Management (Account)
-   Surveys → Account Management (Account, UserProfile)
-   Analytics → Account Management (Account)

## 🎯 Design Principles

### **Modularity**

-   Each file contains related models for easier maintenance
-   Clear separation of concerns by healthcare domain
-   Independent development and testing capabilities

### **Consistency**

-   Standardized naming conventions across all modules
-   Consistent relationship patterns (FK references, cascade deletes)
-   Uniform audit fields (createdAt, updatedAt, recordedBy)

### **Scalability**

-   Optimized for large healthcare datasets
-   Support for time-series trend analysis
-   Efficient indexing through proper relationships

### **Flexibility**

-   JSON fields for dynamic analytics data
-   Array fields for multi-value selections
-   Optional fields for varying data completeness

## 📊 Benefits of This Organization

1. **Maintainability**: Easier to locate and modify domain-specific models
2. **Team Collaboration**: Multiple developers can work on different modules
3. **Documentation**: Clear mapping to ERD pages and business domains
4. **Testing**: Isolated testing of specific healthcare domains
5. **Deployment**: Selective module updates and rollbacks

## ⚠️ Important Notes

-   All `.prisma` files in the schema directory are automatically combined by Prisma
-   The main `schema.prisma` file contains only generator and datasource configuration
-   Cross-file model relationships work seamlessly
-   Migration history applies to the entire combined schema

This modular approach ensures maintainability while preserving the comprehensive nature of the PredictiMed Decision Support System.

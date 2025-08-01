# PredictiMed System - Use Case Diagrams (Role-Based)

This directory contains Use Case diagrams organized by user roles (User, Admin, Super Admin) that illustrate the interactions between different actors and the PredictiMed healthcare management system.

## Role-Based Organization

### User Role Use Cases

#### 1. User Profile & Account Management (`01_user_role_use_cases.mmd`)

Basic user account and profile management functions.

**Key Use Case Groups:**

-   **Profile Management**: View/edit profile, change password, upload picture
-   **Health Records**: Medical history, immunizations, lab results, reports
-   **Appointments & Consultations**: Book, view, reschedule, join virtual consultations

#### 2. User Health Services (`02_user_health_services_use_cases.mmd`)

Healthcare services accessible to regular users.

**Key Use Case Groups:**

-   **Events & Programs**: Browse, register, enroll, track progress
-   **Communication & Support**: Inquiries, FAQ, chat support, ratings
-   **Location Services**: Find facilities, interactive map, directions
-   **QR Code Services**: Scan codes, access information, view history

#### 3. User Maternal & Child Health (`06_user_maternal_child_health_use_cases.mmd`)

Specialized services for mothers and parents.

**Key Use Case Groups:**

-   **Prenatal Care**: Schedule, appointments, pregnancy tracking, education
-   **Immunization Services**: Child vaccination schedules, appointments, certificates
-   **Family Planning**: Information, consultations, method tracking, education
-   **Child Health Monitoring**: Growth charts, development tracking, checkups

### Admin Role Use Cases

#### 4. Admin General Management (`01_admin_role_use_cases.mmd`)

Administrative functions for system management.

**Key Use Case Groups:**

-   **User Management**: Create accounts, edit profiles, reset passwords, assign roles
-   **Health Worker Management**: Register, schedule, performance monitoring, area assignment
-   **Event & Program Management**: Create/manage events and health programs
-   **Content & Location Management**: Website content, facility information, interactive maps

#### 5. Admin Health Worker Management (`03_admin_health_worker_management_use_cases.mmd`)

Specialized admin functions for managing health workers.

**Key Use Case Groups:**

-   **Health Worker Registration**: Register, verify credentials, assign permissions
-   **Schedule Management**: Create schedules, assign consultations, handle conflicts
-   **Performance Monitoring**: Track performance, generate reports, assess service delivery
-   **Training & Development**: Assign training, track progress, manage certifications

#### 6. Admin Analytics & Reporting (`05_admin_analytics_reporting_use_cases.mmd`)

Analytics and reporting functions for administrators.

**Key Use Case Groups:**

-   **Health Analytics**: Trends, demographics, program effectiveness, disease patterns
-   **Operational Analytics**: Consultation stats, appointment rates, facility utilization
-   **Event & Program Analytics**: Attendance, enrollment, success metrics, participation
-   **Custom Reporting**: Create custom reports, schedule automation, export data

### Super Admin Role Use Cases

#### 7. Super Admin System Management (`01_super_admin_role_use_cases.mmd`)

System-level administration and configuration.

**Key Use Case Groups:**

-   **System Administration**: Configure settings, security policies, system parameters
-   **User & Role Management**: Create admin accounts, configure permissions, audit logs
-   **Data Management**: Backup/restore, export data, migration, cleanup
-   **System Monitoring**: Performance metrics, health dashboard, error analysis

#### 8. Super Admin Analytics (`04_super_admin_analytics_use_cases.mmd`)

Advanced system analytics and business intelligence.

**Key Use Case Groups:**

-   **System Analytics**: System trends, usage tracking, performance metrics
-   **Data Management Analytics**: Database performance, storage utilization, data quality
-   **Security Analytics**: Audit reports, access control analysis, incident monitoring
-   **Business Intelligence**: Healthcare analytics, resource utilization, ROI analysis

## Role Hierarchy & Permissions

### User Role (Patients/Community Members)

-   **Access Level**: Basic healthcare services
-   **Key Functions**: Personal health management, consultations, events, support
-   **Restrictions**: Cannot access administrative functions or other users' data

### Admin Role (Healthcare Administrators)

-   **Access Level**: Administrative functions and user management
-   **Key Functions**: Manage users, health workers, events, programs, basic analytics
-   **Restrictions**: Cannot access system configuration or super admin functions

### Super Admin Role (System Administrators)

-   **Access Level**: Full system control and configuration
-   **Key Functions**: System configuration, advanced analytics, security management
-   **Restrictions**: Primarily focused on system-level operations, not day-to-day healthcare

## Use Case Relationships

### Include Relationships (-.->|includes|)

-   Indicates that one use case always includes the functionality of another
-   The included use case is essential for the including use case to complete

### Extend Relationships (-.->|extends|)

-   Indicates optional functionality that may extend the base use case
-   The extending use case adds additional behavior under specific conditions

## Visual Design

All diagrams use:

-   **Transparent backgrounds** with black borders and text
-   **Consistent styling** across all role-based diagrams
-   **Clear actor-use case relationships** with solid lines
-   **Include/extend relationships** with dotted lines

## Integration with System Architecture

These use cases integrate with:

-   **Database Layer**: All use cases involve data persistence (see ERD documentation)
-   **Authentication System**: Role-based access control implementation
-   **Business Logic**: Use cases define the functional requirements
-   **UI/UX Design**: Use cases inform interface design and user workflows

## Related Documentation

-   **ERD**: `../ERD/` - Database structure supporting these use cases
-   **Flowcharts**: `../Flowchart/` - Process flows implementing these use cases
-   **Fishbone**: `../FishBone/` - Problem analysis that these use cases solve

---

_Role-Based Use Cases for PredictiMed Healthcare Management System_
_Last Updated: August 2025_

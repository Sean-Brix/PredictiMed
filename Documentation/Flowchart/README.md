# PredictiMed System - Flowchart Documentation (Modular Structure)

This directory contains modular flowcharts that detail the processes and workflows within the PredictiMed healthcare management system. The flowcharts have been split into smaller, focused diagrams for better visibility and understanding.

## Modular Flowchart Structure

### Core System Flow

#### 1. Authentication & Role Access (`00_authentication_role_access.mmd`)

The foundational authentication and role-based access control flow.

**Key Processes:**

-   User login and credential validation
-   Session management and creation
-   Role-based access determination (User, Admin, Super Admin)
-   Logout and session cleanup procedures

#### 2. Master System Overview (`00_master_system_overview_new.mmd`)

High-level overview connecting all system modules and their relationships.

**Key Components:**

-   System entry points and authentication flow
-   Role-based dashboard access
-   Module integration points
-   System exit and cleanup processes

### Role-Specific Module Flows

#### 3. Super Admin Modules (`01_super_admin_modules.mmd`)

Detailed workflows for Super Admin functions.

**Key Module Groups:**

-   **System Management**: Configuration, database, server, security management
-   **User & Role Management**: Admin account creation, role permissions, system audits
-   **Global Settings**: Site, email, SMS, API configuration
-   **System Analytics**: Performance metrics, user activity, system health monitoring
-   **Data Management**: Backup/restore, export, cleanup, migration operations

#### 4. Admin Modules (`02_admin_modules.mmd`)

Administrative workflows for general admin functions.

**Key Module Groups:**

-   **User Management**: User account creation, profile editing, role management
-   **Health Worker Management**: Registration, scheduling, performance monitoring
-   **Event & Program Management**: Health event and program creation/management
-   **Location Management**: Facility management, interactive mapping, analytics
-   **Content Management**: Website content, media library, SEO management
-   **Analytics & Reports**: Dashboard views, report generation, system usage statistics

#### 5. User Modules (`03_user_modules.mmd`)

User-facing workflows and service access.

**Key Module Groups:**

-   **Profile Management**: Personal profile, health records, medical information updates
-   **Consultations**: Virtual consultation booking, scheduling, meeting participation
-   **Health Records**: Medical history, immunizations, lab results, report downloads
-   **Events & Programs**: Health event browsing, registration, program enrollment
-   **Support & Communication**: Inquiry creation, FAQ access, chat support, feedback
-   **Location Services**: Health facility finder, interactive maps, directions

## Flowchart Design Principles

### Visual Consistency

-   **Transparent backgrounds** with black borders and text for professional presentation
-   **Consistent node shapes** for different process types (rectangles, diamonds, circles)
-   **Clear directional flow** with arrows indicating process progression
-   **Modular organization** for easier maintenance and understanding

### Process Flow Types

-   **Decision Points**: Diamond shapes for yes/no or multiple choice decisions
-   **Process Steps**: Rectangular shapes for actions and operations
-   **Start/End Points**: Circular shapes for system entry and exit points
-   **Module References**: Rectangular shapes linking to other detailed flowcharts

## Integration Architecture

### System Integration Points

All flowcharts connect through common integration layers:

1. **Database Layer**: All modules interact with the central database
2. **Security Layer**: Authentication and authorization across all modules
3. **Notification System**: Cross-module communication and alerts
4. **Analytics Engine**: Data collection and analysis across all processes

### Cross-Module Dependencies

-   **Authentication Flow** → Required for all other module access
-   **Super Admin Modules** → Control system-wide configurations
-   **Admin Modules** → Manage operational aspects and user coordination
-   **User Modules** → Consume services provided by admin-managed resources

## Process Flow Relationships

### Sequential Flows

1. Authentication must precede all module access
2. Role determination directs users to appropriate module sets
3. Session management maintains state across module interactions
4. Logout procedures ensure secure session termination

### Parallel Flows

-   Multiple users can access their respective modules simultaneously
-   Admin and Super Admin functions can operate concurrently
-   User services can be accessed independently of administrative functions

## Solving Current Manual Process Problems

These digital workflows replace manual processes:

### From Manual to Digital

-   **Paper Forms** → Digital registration and profile management
-   **Phone Scheduling** → Online appointment booking system
-   **Physical Files** → Digital health records and document management
-   **Manual Reports** → Automated analytics and real-time reporting
-   **In-Person Only** → Virtual consultations and remote access

### Process Improvements

-   **Real-time Updates**: Immediate data synchronization across all modules
-   **Automated Workflows**: Reduced manual intervention and human error
-   **Multi-user Access**: Simultaneous system usage with proper access controls
-   **Mobile Accessibility**: Remote access to all appropriate functions
-   **Audit Trails**: Complete tracking of all system activities and changes

## Related Documentation

-   **ERD**: `../ERD/` - Database structure supporting these workflows
-   **Use Cases**: `../Usecase/` - User interaction scenarios implemented by these flows
-   **Fishbone**: `../FishBone/` - Manual process problems these workflows solve

## How to Navigate the Flowcharts

1. **Start with Authentication Flow** (`00_authentication_role_access.mmd`)
2. **Review Master Overview** (`00_master_system_overview_new.mmd`)
3. **Deep-dive into Role-specific Modules** based on user type:
    - Super Admin: `01_super_admin_modules.mmd`
    - Admin: `02_admin_modules.mmd`
    - User: `03_user_modules.mmd`

---

_Modular Flowcharts for PredictiMed Healthcare Management System_
_Last Updated: August 2025_

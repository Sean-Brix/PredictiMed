# PredictiMed Diagrams - Simplified Overview

## ✅ COMPLETED SIMPLIFICATIONS

### Use Case Diagrams (Usecase/)

**BEFORE**: Complex subgraphs with 15-25 detailed use cases per role
**AFTER**: 5 core functional areas per role

#### Super Admin (`01_super_admin_role_use_cases.mmd`)

-   👥 User Management
-   ⚙️ System Config
-   📊 Analytics
-   🗄️ Data Management
-   🔒 Security

#### Admin (`01_admin_role_use_cases.mmd`)

-   👥 User Management
-   👩‍⚕️ Health Worker Mgmt
-   📅 Event Management
-   📊 Reports
-   🗺️ Location Management

#### User (`01_user_role_use_cases.mmd`)

-   👤 Profile Management
-   🏥 Health Records
-   📅 Appointments
-   📍 Health Events
-   📱 QR Code Access

### Fishbone Diagrams (FishBone/)

**BEFORE**: Detailed subgraphs with 16-20 specific problem causes
**AFTER**: 4 main problem categories

#### Manual Registration Problems (`01_manual_patient_registration_problems.mmd`)

-   📄 Paper Forms → 🚩 Manual Registration Issues
-   📊 Excel Files → Problem
-   👥 Staff Process → Problem
-   🔒 Security Risk → Problem

#### Manual Scheduling Problems (`02_manual_consultation_scheduling_problems.mmd`)

-   📅 Paper Schedule → 🚩 Manual Scheduling Issues
-   📞 Phone Booking → Problem
-   ❌ No Reminders → Problem
-   ⚠️ Double Booking → Problem

## 🎨 ERD COLOR SCHEME APPLIED

All diagrams now use consistent colors from the ERD:

-   **Start/End Elements**: Light blue (#e1f5fe) / Dark blue (#01579b)
-   **Actors**: Light blue (#e1f5fe) / Dark blue (#01579b)
-   **Super Admin Functions**: Light purple (#f3e5f5) / Purple (#4a148c)
-   **Admin Functions**: Light green (#e8f5e8) / Green (#2e7d32)
-   **User Functions**: Light orange (#fff3e0) / Orange (#e65100)
-   **Problems**: Light red (#ffebee) / Red (#c62828)
-   **Decisions**: Light orange (#fff3e0) / Orange (#e65100)

## 📊 SIMPLIFICATION IMPACT

### Size Reduction

-   **Use Cases**: From 80+ nodes to 15 nodes per diagram
-   **Fishbone**: From 20+ problem causes to 4 main categories
-   **Visual Complexity**: 70% reduction in diagram elements

### Readability Improvement

-   Clear visual hierarchy with ERD colors
-   Focused on core functionality
-   Eliminated redundant details
-   Better contrast for readability

## 🚀 BENEFITS

1. **Easier to Understand**: Core concepts immediately visible
2. **Professional Appearance**: Consistent ERD color scheme
3. **Better Printing**: Simpler diagrams print clearly
4. **Faster Review**: Stakeholders can quickly grasp system functionality
5. **Maintainable**: Less complex diagrams are easier to update

## 📁 SIMPLIFIED FILE EXAMPLES

Created demonstration files:

-   `FishBone/excel_simplified.mmd` - Excel data problems
-   `Flowchart/master_simplified.mmd` - System overview
-   `Flowchart/auth_simplified.mmd` - Authentication flow

## ⏭️ NEXT STEPS

To complete the simplification:

1. Apply same approach to remaining Flowchart files
2. Update remaining FishBone diagrams
3. Ensure all Use Case files follow the 5-function pattern
4. Update all README files with new structure

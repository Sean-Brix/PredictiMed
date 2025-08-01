# Analytics & Reporting Module - Flowchart Documentation

## Overview

The Analytics & Reporting module has been split into 5 focused flowcharts for better organization and readability.

## Files

### 01_analytics_dashboard.mmd

**Main Entry Point** - Authentication and dashboard navigation

-   **Size**: ~40 lines (was part of 349 line monolith)
-   **Purpose**: User authentication, permission checking, and main dashboard navigation
-   **Key Features**:
    -   Authentication flow
    -   Permission validation
    -   Navigation to specific analytics modules

### 02_category_analytics.mmd

**Category-based Analytics** - Detailed analysis by system categories

-   **Size**: ~50 lines
-   **Purpose**: Analytics for different system modules (Users, Health Programs, Consultations, etc.)
-   **Key Features**:
    -   User management analytics
    -   Health program performance metrics
    -   Consultation analytics
    -   Chart and graph generation

### 03_trends_analysis.mmd

**Trends Analysis** - Time-based analysis and predictions

-   **Size**: ~40 lines
-   **Purpose**: Time-series analysis and trend prediction
-   **Key Features**:
    -   Daily, weekly, monthly, yearly trends
    -   Custom period analysis
    -   Seasonal trends
    -   Predictive analytics with ML models
    -   Multiple visualization types

### 04_report_generation.mmd

**Report Generation** - Standard and custom report creation

-   **Size**: ~60 lines
-   **Purpose**: Comprehensive report generation and export
-   **Key Features**:
    -   Standard reports (daily, weekly, monthly, quarterly, annual)
    -   Custom report builder
    -   Scheduled and automated reports
    -   Multiple export formats (PDF, Excel, CSV)
    -   Email and sharing capabilities

### 05_realtime_analytics.mmd

**Real-time Analytics** - Live system monitoring

-   **Size**: ~45 lines
-   **Purpose**: Live system monitoring and real-time data visualization
-   **Key Features**:
    -   Active user monitoring
    -   System performance metrics
    -   Live events tracking
    -   Real-time alerts and notifications
    -   Auto-refreshing dashboard

## Benefits of Splitting

### Before

-   **Single file**: 349 lines
-   **Complex navigation**: Hard to find specific functionality
-   **Maintenance**: Difficult to update individual features

### After

-   **5 focused files**: Average 45 lines each
-   **Clear separation**: Each file has specific purpose
-   **Better organization**: Grouped in dedicated folder
-   **Easier maintenance**: Update individual features independently

## Color Scheme

-   **Start/End**: Light blue (#e1f5fe) / Dark blue (#01579b)
-   **Process**: Light purple (#f3e5f5) / Purple (#4a148c)
-   **Decision**: Light orange (#fff3e0) / Orange (#e65100)
-   **Success**: Light green (#e0f2f1) / Green (#00695c)
-   **Error**: Light red (#ffebee) / Red (#c62828)
-   **Specialized**: Different colors for each analytics type

## Navigation Flow

1. Start at `01_analytics_dashboard.mmd` for authentication
2. Navigate to specific analytics modules based on user choice
3. Each module can export results and return to main dashboard
4. Clear separation allows for independent development and maintenance

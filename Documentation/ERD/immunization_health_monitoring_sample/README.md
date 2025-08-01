# PredictiMed - Immunization & Health Monitoring Linear Regression Sample

This sample demonstrates how to implement linear regression analysis for health monitoring data visualization using HTML, Tailwind CSS, and Chart.js.

## 📊 Overview

The sample includes four key health monitoring areas with linear regression analysis:

1. **Immunization Coverage Trends** - BCG vaccination coverage over time
2. **Child Growth Monitoring** - Average weight progression with age
3. **NCD Risk Assessment** - Non-communicable disease risk distribution trends
4. **Vital Signs Monitoring** - Blood pressure and heart rate trend analysis

## 🗂️ Files Structure

```
immunization_health_monitoring_sample/
├── index.html          # Main dashboard with interactive charts
├── sample_data.json     # Sample healthcare data (50+ data points)
└── README.md           # This documentation
```

## 📈 Data Structure

### Sample Data Categories

#### 1. Immunization Coverage

```json
{
    "month": "2024-01",
    "coverage_percentage": 85.2,
    "population": 1250,
    "immunized": 1065,
    "vaccine_type": "BCG"
}
```

#### 2. Child Growth Trends

```json
{
    "month": "2024-01",
    "age_months": 6,
    "average_weight": 7.2,
    "average_height": 65.5,
    "children_measured": 120
}
```

#### 3. NCD Risk Trends

```json
{
    "month": "2024-01",
    "high_risk_percentage": 12.5,
    "moderate_risk_percentage": 35.2,
    "low_risk_percentage": 52.3,
    "total_assessed": 850
}
```

#### 4. Vital Signs Trends

```json
{
    "month": "2024-01",
    "avg_systolic_bp": 118.5,
    "avg_diastolic_bp": 78.2,
    "avg_heart_rate": 72.8,
    "avg_temperature": 36.6,
    "total_measurements": 450
}
```

## 🔧 Implementation Process

### Step 1: Linear Regression Calculation

The dashboard implements a custom linear regression function:

```javascript
function calculateLinearRegression(data, xKey, yKey) {
    const n = data.length;
    let sumX = 0,
        sumY = 0,
        sumXY = 0,
        sumXX = 0;

    data.forEach((point, index) => {
        const x = index + 1; // Use index as x-value
        const y = xKey ? point[xKey] : point[yKey];
        sumX += x;
        sumY += y;
        sumXY += x * y;
        sumXX += x * x;
    });

    const slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    const intercept = (sumY - slope * sumX) / n;

    return { slope, intercept };
}
```

### Step 2: Trend Line Generation

```javascript
function generateRegressionLine(data, regression, xKey, yKey) {
    return data.map((_, index) => {
        const x = index + 1;
        return regression.slope * x + regression.intercept;
    });
}
```

### Step 3: Chart.js Integration

Each chart combines actual data points with calculated regression lines:

```javascript
datasets: [
    {
        label: 'Actual Data',
        data: actualDataPoints,
        borderColor: 'rgb(34, 197, 94)',
        backgroundColor: 'rgba(34, 197, 94, 0.1)',
        fill: true,
        tension: 0.4,
    },
    {
        label: 'Trend Line',
        data: regressionLine,
        borderColor: 'rgb(239, 68, 68)',
        borderDash: [5, 5],
        fill: false,
        pointRadius: 0,
    },
];
```

## 🚀 How to Run

### Option 1: Local File Server

```bash
# Navigate to the sample directory
cd immunization_health_monitoring_sample

# Start a simple HTTP server (Python 3)
python -m http.server 8000

# Or using Node.js
npx serve .

# Open browser to http://localhost:8000
```

### Option 2: Direct File Opening

-   Open `index.html` directly in a modern web browser
-   Note: JSON loading may be restricted in some browsers due to CORS policies

## 📊 Key Features

### Interactive Dashboard Elements

-   **Real-time Statistics Cards** - Key performance indicators
-   **Responsive Charts with Regression Lines** - Trend analysis visualization
-   **Predictive Insights Panel** - Future projections based on linear models
-   **Mobile-Responsive Design** - Optimized for all screen sizes

### Linear Regression Analysis

-   **Immunization Coverage**: Shows +1.2% monthly improvement trend
-   **Child Growth**: Demonstrates +0.37kg monthly average weight gain
-   **NCD Risk**: Reveals -0.37% monthly reduction in high-risk population
-   **Vital Signs**: Indicates -0.28 mmHg monthly blood pressure improvement

## 🎨 Design Patterns

### Tailwind CSS Classes Used

-   **Layout**: `grid`, `flex`, `max-w-7xl`, `mx-auto`
-   **Spacing**: `p-6`, `m-8`, `space-x-4`, `gap-6`
-   **Colors**: `bg-green-50`, `text-blue-600`, `border-gray-200`
-   **Typography**: `text-lg`, `font-semibold`, `text-sm`
-   **Effects**: `shadow-sm`, `rounded-lg`, `hover:bg-gray-50`

### Chart.js Configuration

-   **Responsive Design**: `maintainAspectRatio: false`
-   **Custom Styling**: Point radius, hover effects, gradients
-   **Multiple Y-Axes**: For displaying different measurement units
-   **Legend Positioning**: Bottom placement with custom styling

## 🔍 Data Analysis Insights

### Trends Identified

1. **Improving Immunization**: Coverage increased from 85.2% to 98.7%
2. **Healthy Growth**: Consistent child weight gain following WHO standards
3. **Reduced Health Risks**: NCD high-risk population declining
4. **Better Vital Signs**: Overall improvement in blood pressure readings

### Predictive Modeling

The linear regression models suggest:

-   **99.2%** immunization coverage achievable by March 2025
-   **1.1kg** average weight increase expected in next quarter
-   **3.3 mmHg** blood pressure improvement projected
-   **0.37%** monthly reduction in high-risk NCD population

## 🔧 Customization Options

### Data Integration

Replace `sample_data.json` with real data from your PredictiMed database:

```javascript
// Replace fetch with actual API call
fetch('/api/health-monitoring/trends')
    .then((response) => response.json())
    .then((data) => {
        healthData = data;
        initializeCharts();
    });
```

### Chart Customization

Modify chart configurations in the `initializeCharts()` function:

-   Change colors, styles, and animations
-   Add new datasets or chart types
-   Implement different regression algorithms
-   Add interactive filters and date range selectors

### Styling Updates

Update Tailwind classes for different themes:

-   Change color schemes in class names
-   Modify spacing and layout properties
-   Add dark mode support with `dark:` prefixes
-   Implement custom brand colors

## 🔗 Integration with PredictiMed

### Database Schema Mapping

This sample aligns with the PredictiMed ERD Module 4:

-   **ImmunizationEvent** → `immunization_coverage`
-   **AnthropometricMeasurement** → `child_growth_trends`
-   **NCDRiskAssessment** → `ncd_risk_trends`
-   **VitalSigns** → `vital_signs_trends`

### API Endpoints Needed

```
GET /api/immunization/coverage-trends
GET /api/children/growth-trends
GET /api/ncd/risk-assessment-trends
GET /api/vital-signs/monthly-averages
```

## 📚 Dependencies

### External Libraries

-   **Chart.js v4.x** - Chart rendering and animations
-   **Tailwind CSS v3.x** - Utility-first CSS framework
-   **Standard Web APIs** - Fetch API for data loading

### Browser Compatibility

-   Chrome 60+, Firefox 55+, Safari 12+, Edge 79+
-   Mobile browsers with ES6 support
-   JavaScript enabled required

## 🎯 Use Cases

### Healthcare Administrators

-   Monitor vaccination program effectiveness
-   Track child development patterns
-   Assess community health risks
-   Plan resource allocation

### Health Workers

-   Identify trends in patient populations
-   Predict future health needs
-   Generate reports for stakeholders
-   Make data-driven decisions

### Data Analysts

-   Perform regression analysis on health data
-   Create predictive models
-   Generate insights for policy makers
-   Build comprehensive health dashboards

---

**Note**: This is a demonstration sample with synthetic data. In production, integrate with your actual PredictiMed database and implement proper error handling, authentication, and data validation.

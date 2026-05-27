# Food Inspection Risk Analytics

**Every day, thousands of restaurants are inspected for food safety violations. But when inspection data lives in silos across cities different formats, different schemas, different risk definitions health officials and analysts can't see the full picture.**

This project fixes that.

---

## The Problem

Chicago and Dallas each collect food inspection data independently:
- Chicago captures **17 columns**
- Dallas captures **114 columns**
- Neither dataset is compatible with the other

The result? No unified way to answer critical questions like:
- Which restaurants are repeat offenders across cities?
- What violations are most common and where?
- Which facility types carry the highest risk?
- Are inspection failures clustered in specific zip codes?

Without a unified pipeline, these questions go unanswered.

---

## The Solution

I built an end-to-end data pipeline that ingests, cleans, models, and analyzes **200,000+ food inspection records** from both cities into a single queryable system.

---

## How It Works

```
Chicago (17 cols)  ──┐
                      ├──► Alteryx ETL ──► PySpark Profiling ──► Snowflake Star Schema ──► Risk Analytics
Dallas (114 cols)  ──┘
```

**Step 1 — Ingest & Clean**
Alteryx workflows pull raw inspection data from both cities, reconcile 17–114 source columns, and standardize them into a common schema.

**Step 2 — Profile**
PySpark on Databricks profiles each dataset detecting nulls, duplicates, cardinality issues, and data anomalies across 100K+ records before loading.

**Step 3 — Model**
Data is loaded into a Snowflake star schema 1 fact table, 6 dimension tables enabling fast, flexible analytical queries.

**Step 4 — Analyze**
7 business queries surface actionable risk intelligence: violation trends, repeat offenders, facility risk scores, and geographic hotspots.

---

## Why It Matters

| Without This Pipeline | With This Pipeline |
|---|---|
| 2 incompatible datasets | 1 unified analytical system |
| 100K+ null values | 85% data incompleteness eliminated |
| No cross-city visibility | Violation patterns across 200K+ records |
| Manual reporting | Automated star schema queries |
| Unknown repeat offenders | Flagged businesses with 2+ failures |

---

## Tech Stack

| Layer | Tools |
|---|---|
| ETL & Cleaning | Alteryx, PySpark |
| Data Profiling | Databricks, PySpark, ydata-profiling |
| Data Modeling | ER Studio (Star Schema) |
| Storage & Analytics | Snowflake, SQL |
| Schema Mapping | Excel |
| Visualization | Power BI |

---

## Key Findings (BR1–BR7)

| Analysis | Question Answered |
|---|---|
| BR1 | Which inspection types produce the most failures? |
| BR2 | When are inspections most likely to fail? (monthly/weekly trends) |
| BR3 | Which risk levels have the worst average scores? |
| BR4 | What are the top 10 most frequent violations? |
| BR5 | Which businesses have failed inspections more than once? |
| BR6 | Which facility types (restaurant, school, daycare) fail most? |
| BR7 | Which zip codes and cities have the highest inspection failure rates? |

---

## Results

- Unified **200K+** inspection records from 2 incompatible city datasets
- Reconciled schema gaps from **17 to 114 source columns**
- Eliminated **85% of data incompleteness** across 100K+ null values
- Delivered risk intelligence across **6 analytical dimensions**
- Identified repeat offender businesses and geographic violation hotspots

---

## Files

| File | Description |
|---|---|
| `Chicago_Alteryx.yxmd` | Alteryx ETL workflow — Chicago data ingestion and cleaning |
| `Dallas_Cleaning.yxmd` | Alteryx ETL workflow — Dallas data cleaning |
| `Chicago_Databricks_Profiling.ipynb` | PySpark profiling — nulls, cardinality, duplicates, schema |
| `Dallas_Databricks_Profiling.ipynb` | PySpark profiling — nulls, cardinality, duplicates, schema |
| `ER_Model.DM1` | ER Studio dimensional model (star schema) |
| `Mapping_FoodInspection_Chicago_Dallas.xlsx` | Cross-city column mapping and reconciliation |
| `setup.sql` | Snowflake DDL — warehouse, schema, staging, dimension, fact tables |
| `business_queries.sql` | 7 business requirement queries (BR1–BR7) |

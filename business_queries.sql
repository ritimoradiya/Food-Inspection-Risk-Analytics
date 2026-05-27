-- ============================================================
-- Food Inspection Risk Analytics
-- Business Requirement Queries
-- ============================================================

-- BR1: Inspection Results by Type
SELECT
    Inspection_Type,
    Results,
    COUNT(*) AS Total_Inspections
FROM FCT_Inspection
GROUP BY Inspection_Type, Results
ORDER BY Total_Inspections DESC;


-- BR2: Monthly / Weekly Inspection Trends
SELECT
    d.Year,
    d.Month,
    d.Weekday,
    COUNT(*) AS Total_Inspections
FROM FCT_Inspection f
JOIN DIM_Date d ON f.Date_Key = d.Date_Key
GROUP BY d.Year, d.Month, d.Weekday
ORDER BY d.Year, d.Month;


-- BR3: Risk Level and Average Inspection Scores
SELECT
    r.Risk_Level,
    COUNT(*) AS Total_Inspections,
    AVG(r.Inspection_Score) AS Avg_Score
FROM FCT_Inspection f
JOIN DIM_Risk r ON f.Risk_Key = r.Risk_Key
GROUP BY r.Risk_Level
ORDER BY Avg_Score ASC;


-- BR4: Top 10 Violations
SELECT
    v.Violation_Description,
    COUNT(*) AS Violation_Count
FROM FCT_Inspection f
JOIN DIM_Violation v ON f.Violation_Key = v.Violation_Key
GROUP BY v.Violation_Description
ORDER BY Violation_Count DESC
LIMIT 10;


-- BR5: Repeat Offender Businesses
SELECT
    b.DBA_Name,
    b.AKA_Name,
    b.License,
    COUNT(*) AS Failed_Inspections
FROM FCT_Inspection f
JOIN DIM_Business b ON f.Business_Key = b.Business_Key
WHERE f.Results IN ('Fail', 'Out of Business')
GROUP BY b.DBA_Name, b.AKA_Name, b.License
HAVING COUNT(*) > 1
ORDER BY Failed_Inspections DESC;


-- BR6: Facility Type Failure Comparison
SELECT
    fac.Facility_Type,
    COUNT(*) AS Total_Inspections,
    SUM(CASE WHEN f.Results = 'Fail' THEN 1 ELSE 0 END) AS Failures
FROM FCT_Inspection f
JOIN DIM_Facility fac ON f.Facility_Key = fac.Facility_Key
GROUP BY fac.Facility_Type
ORDER BY Failures DESC;


-- BR7: Location-Based Risk Insights
SELECT
    loc.City,
    loc.State,
    loc.Zip_Code,
    COUNT(*) AS Total_Inspections
FROM FCT_Inspection f
JOIN DIM_Location loc ON f.Location_Key = loc.Location_Key
GROUP BY loc.City, loc.State, loc.Zip_Code
ORDER BY Total_Inspections DESC;

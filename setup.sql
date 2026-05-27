-- ============================================================
-- Food Inspection Risk Analytics
-- Snowflake Setup & Schema Definition
-- ============================================================

-- Infrastructure Setup
CREATE OR REPLACE WAREHOUSE FinalProject_WH WAREHOUSE_SIZE = 'small';
CREATE OR REPLACE DATABASE FinalProject_DB;
CREATE OR REPLACE SCHEMA FinalProject_DB.FinalProject_SCHEMA;
CREATE OR REPLACE ROLE FinalProject_ROLE;

GRANT OWNERSHIP ON DATABASE FinalProject_DB TO ROLE ACCOUNTADMIN;
GRANT USAGE ON WAREHOUSE FinalProject_WH TO ROLE FinalProject_ROLE;
GRANT USAGE ON DATABASE FinalProject_DB TO ROLE FinalProject_ROLE;
GRANT OWNERSHIP ON SCHEMA FinalProject_DB.FinalProject_SCHEMA TO ROLE FinalProject_ROLE;
GRANT USAGE ON SCHEMA FinalProject_DB.FinalProject_SCHEMA TO ROLE FinalProject_ROLE;

CREATE OR REPLACE USER FinalProject_USER
    DEFAULT_ROLE = FinalProject_ROLE
    DEFAULT_WAREHOUSE = FinalProject_WH;

-- ============================================================
-- Staging Tables
-- ============================================================

USE DATABASE FinalProject_DB;
USE SCHEMA FinalProject_SCHEMA;

CREATE OR REPLACE TABLE STG_Chicago_Inspections (
    InspectionID            INT,
    DBA_Name                STRING,
    AKA_Name                STRING,
    License                 FLOAT,
    Facility_Type           STRING,
    Risk                    STRING,
    Address                 STRING,
    City                    STRING,
    State                   STRING,
    Zip                     FLOAT,
    Inspection_Date         DATE,
    Inspection_Type         STRING,
    Results                 STRING,
    Violations              STRING,
    Latitude                FLOAT,
    Longitude               FLOAT,
    Location                STRING,
    Violation_Code          STRING,
    Violation_Description   STRING
);

CREATE OR REPLACE TABLE STG_Dallas_Inspection (
    RecordID            INT,
    restaurant_name     STRING,
    Inspection_Type     STRING,
    Inspection_Date     DATE,
    inspection_score    INT,
    Street_Address      STRING,
    Zip_Code            STRING,
    LatLong             STRING,
    Violation_desc      STRING,
    Description         STRING,
    Latitude            FLOAT,
    Longitude           FLOAT,
    Facility_Type       STRING,
    City                STRING,
    State               STRING,
    Results             STRING,
    Risk                STRING
);

-- ============================================================
-- Dimension Tables
-- ============================================================

CREATE OR REPLACE TABLE DIM_Business (
    Business_Key    NUMBER(10,0) NOT NULL,
    AKA_Name        VARCHAR(255),
    DBA_Name        VARCHAR(255),
    License         NUMBER(10,0)
);

CREATE OR REPLACE TABLE DIM_Date (
    Date_Key        INTEGER,
    Inspection_Date DATE,
    Year            VARCHAR(100),
    Month           VARCHAR(100),
    Weekday         VARCHAR(100)
);

CREATE OR REPLACE TABLE DIM_Facility (
    Facility_Key    NUMBER(10,0) NOT NULL,
    Facility_Type   VARCHAR(100)
);

CREATE OR REPLACE TABLE DIM_Location (
    Location_Key    NUMBER(10,0) NOT NULL,
    Longitude       FLOAT,
    Latitude        FLOAT,
    Location        VARCHAR(100),
    Zip_Code        VARCHAR(10),
    State           CHAR(10),
    City            VARCHAR(100),
    Address         VARCHAR(255)
);

CREATE OR REPLACE TABLE DIM_Risk (
    Risk_Key            INTEGER,
    Risk_Level          VARCHAR(100),
    Inspection_Score    INTEGER
);

CREATE OR REPLACE TABLE DIM_Violation (
    Violation_Key           INTEGER,
    Violation_Description   VARCHAR(10000)
);

-- ============================================================
-- Fact Table
-- ============================================================

CREATE OR REPLACE TABLE FCT_Inspection (
    Inspection_Event_Key    INTEGER,
    Facility_Key            INTEGER,
    Business_Key            INTEGER,
    Location_Key            INTEGER,
    Violation_Key           INTEGER,
    Date_Key                INTEGER,
    Risk_Key                INTEGER,
    Inspection_Type         VARCHAR(100),
    Results                 VARCHAR(50),
    Inspection_ID           INTEGER,
    Source_Name             VARCHAR(50),
    DI_Created_DT           DATE
);

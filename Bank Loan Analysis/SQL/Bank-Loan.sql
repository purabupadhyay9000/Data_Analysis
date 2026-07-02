

-- Total Loan Applications
SELECT COUNT("id") AS Total_Applications
FROM bank;

-- MTD Loan Applications
SELECT COUNT("id") AS Total_Applications
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12;

-- PMTD Loan Applications
SELECT COUNT("id") AS Total_Applications
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 11;

-- Total Funded Amount
SELECT SUM("loan_amount") AS Total_Funded_Amount
FROM bank;

-- MTD Total Funded Amount
SELECT SUM("loan_amount") AS Total_Funded_Amount
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12;

-- PMTD Total Funded Amount
SELECT SUM("loan_amount") AS Total_Funded_Amount
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 11;

-- Total Amount Received
SELECT SUM("total_payment") AS Total_Amount_Collected
FROM bank;

-- MTD Total Amount Received
SELECT SUM("total_payment") AS Total_Amount_Collected
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12;

-- PMTD Total Amount Received
SELECT SUM("total_payment") AS Total_Amount_Collected
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 11;

-- Average Interest Rate
SELECT AVG("int_rate") * 100 AS Avg_Int_Rate
FROM bank;

-- MTD Average Interest Rate
SELECT AVG("int_rate") * 100 AS MTD_Avg_Int_Rate
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12;
-------------------------------------------------------
-- PMTD Average Interest Rate
SELECT AVG("int_rate") * 100 AS PMTD_Avg_Int_Rate
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 11;

-- Average DTI
SELECT AVG("dti") * 100 AS Avg_DTI
FROM bank;

-- MTD Average DTI
SELECT AVG("dti") * 100 AS MTD_Avg_DTI
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12;

-- PMTD Average DTI
SELECT AVG("dti") * 100 AS PMTD_Avg_DTI
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 11;

-- ==========================
-- GOOD LOANS
-- ==========================

-- Good Loan Percentage
SELECT
(
COUNT(
CASE
WHEN "loan_status" IN ('Fully Paid','Current')
THEN "id"
END
) * 100.0
) / COUNT("id") AS Good_Loan_Percentage
FROM bank;

-- Good Loan Applications
SELECT COUNT("id") AS Good_Loan_Applications
FROM bank
WHERE "loan_status" IN ('Fully Paid','Current');

-- Good Loan Funded Amount
SELECT SUM("loan_amount") AS Good_Loan_Funded_Amount
FROM bank
WHERE "loan_status" IN ('Fully Paid','Current');

-- Good Loan Amount Received
SELECT SUM("total_payment") AS Good_Loan_Amount_Received
FROM bank
WHERE "loan_status" IN ('Fully Paid','Current');

-- ==========================
-- BAD LOANS
-- ==========================

-- Bad Loan Percentage
SELECT
(
COUNT(
CASE
WHEN "loan_status"='Charged Off'
THEN "id"
END
) * 100.0
) / COUNT("id") AS Bad_Loan_Percentage
FROM bank;

-- Bad Loan Applications
SELECT COUNT("id") AS Bad_Loan_Applications
FROM bank
WHERE "loan_status"='Charged Off';

-- Bad Loan Funded Amount
SELECT SUM("loan_amount") AS Bad_Loan_Funded_Amount
FROM bank
WHERE "loan_status"='Charged Off';

-- Bad Loan Amount Received
SELECT SUM("total_payment") AS Bad_Loan_Amount_Received
FROM bank
WHERE "loan_status"='Charged Off';

-- ==========================
-- LOAN STATUS
-- ==========================

SELECT
    "loan_status",
    COUNT("id") AS LoanCount,
    SUM("total_payment") AS Total_Amount_Received,
    SUM("loan_amount") AS Total_Funded_Amount,
    AVG("int_rate") * 100 AS Interest_Rate,
    AVG("dti") * 100 AS DTI
FROM bank
GROUP BY "loan_status";

SELECT
    "loan_status",
    SUM("total_payment") AS MTD_Total_Amount_Received,
    SUM("loan_amount") AS MTD_Total_Funded_Amount
FROM bank
WHERE EXTRACT(MONTH FROM "issue_date") = 12
GROUP BY "loan_status";

-- ==========================
-- MONTH OVERVIEW
-- ==========================

SELECT
    EXTRACT(MONTH FROM "issue_date") AS Month_Number,
    TO_CHAR("issue_date",'Month') AS Month_Name,
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY
EXTRACT(MONTH FROM "issue_date"),
TO_CHAR("issue_date",'Month')
ORDER BY Month_Number;

-- ==========================
-- STATE
-- ==========================

SELECT
    "address_state" AS State,
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY "address_state"
ORDER BY "address_state";

-- ==========================
-- TERM
-- ==========================

SELECT
    "term",
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY "term"
ORDER BY "term";

-- ==========================
-- EMPLOYEE LENGTH
-- ==========================

SELECT
    "emp_length" AS Employee_Length,
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY "emp_length"
ORDER BY "emp_length";

-- ==========================
-- PURPOSE
-- ==========================

SELECT
    "purpose",
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY "purpose"
ORDER BY "purpose";

-- ==========================
-- HOME OWNERSHIP
-- ==========================

SELECT
    "home_ownership",
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
GROUP BY "home_ownership"
ORDER BY "home_ownership";

-- ==========================
-- FILTER EXAMPLE (GRADE A)
-- ==========================

SELECT
    "purpose",
    COUNT("id") AS Total_Loan_Applications,
    SUM("loan_amount") AS Total_Funded_Amount,
    SUM("total_payment") AS Total_Amount_Received
FROM bank
WHERE "grade" = 'A'
GROUP BY "purpose"
ORDER BY "purpose";
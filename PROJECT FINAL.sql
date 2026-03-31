create database finance;
use finance;
RENAME TABLE train_ctrua4k TO loan_data;
-- 1.	Loan approval rate by Credit History 

SELECT 
    Credit_History,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate_Percentage
FROM loan_data
GROUP BY Credit_History;

-- 2.	Loan-to-Income Ratio comparison
SELECT 
    Loan_Status,
    ROUND(AVG(LoanAmount / (ApplicantIncome + CoapplicantIncome)), 4) 
        AS Avg_Loan_to_Income_Ratio
FROM loan_data
WHERE (ApplicantIncome + CoapplicantIncome) > 0
GROUP BY Loan_Status;
-- 3.	Approval rate by Education
SELECT 
    Education,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY Education;
-- 4.	Approval rate by number of dependents
SELECT 
    Dependents,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY Dependents
ORDER BY Dependents;
-- 5.	Approval rate with vs without co-applicant income
SELECT 
    CASE 
        WHEN CoapplicantIncome > 0 THEN 'With Coapplicant'
        ELSE 'Without Coapplicant'
    END AS Coapplicant_Status,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY 
    CASE 
        WHEN CoapplicantIncome > 0 THEN 'With Coapplicant'
        ELSE 'Without Coapplicant'
    END;
-- 6.	Approval rate by Property Area
SELECT 
    Property_Area,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY Property_Area;
-- 7.	Approval rate by Loan Amount Term
SELECT 
    Loan_Amount_Term,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY Loan_Amount_Term
ORDER BY Loan_Amount_Term;
-- 8.	Approval rate by Gender
SELECT 
    Gender,
    COUNT(*) AS Total_Applications,
    SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
    ROUND(
        SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Approval_Rate
FROM loan_data
GROUP BY Gender;
-- 9.	Rejected applicants who could be approved with policy relaxation
SELECT *
FROM loan_data
WHERE Loan_Status = 'N'
  AND Credit_History = 1
  AND (LoanAmount / (ApplicantIncome + CoapplicantIncome)) <= 0.4
  AND (ApplicantIncome + CoapplicantIncome) > 4000;



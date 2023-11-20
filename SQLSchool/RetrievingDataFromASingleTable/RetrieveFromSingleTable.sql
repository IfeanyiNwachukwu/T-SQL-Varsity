--A SELECT statement that retrieves all the data from the Invoices table
SELECT *
FROM Invoices;

--A SELECT statement that retrieves three columns
--from each row, sorted in ascending sequence by invoice total

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal;

--A SELECT statement that retrieves two columns and a calculated value
--for a specific invoice

SELECT InvoiceID, InvoiceTotal, CreditTotal + PaymentTotal As TotalCredits
FROM Invoices
WHERE InvoiceID = 17

--A SELECT statement that retrieves all invoices between given dates

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceDate BETWEEN '2020-01-01' AND '2020-03-31'

--A SELECT statement that returns an empty result set

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > 50000;


--FUNCTIONS

--A SELECT statement that uses the LEFT function

SELECT VendorContactFName, VendorContactLName, 
    LEFT(VendorContactFName,1) +
	LEFT(VendorContactLName,1)
FROM Vendors;

--A SELECT statement that uses the CONVERT function

SELECT 'Invoice: #' + InvoiceNumber + ', dated ' +
		CONVERT(char(8), PaymentDate, 1) + ' for $' +
		CONVERT(varchar(9), PaymentTotal, 1)
FROM Invoices;

--A SELECT statement that returns all rows

SELECT VendorCity, VendorState
FROM Vendors
ORDER BY VendorCity

--A SELECT statement that eliminates duplicate rows

SELECT DISTINCT VendorCity, VendorState
FROM Vendors;

--A SELECT statement with a TOP clause

SELECT TOP 5 VendorID, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal Desc

--A SELECT statement with a TOP clause and the PERCENT keyword

SELECT TOP 10 PERCENT VendorID, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal DESC

--A SELECT statement with a TOP clause and the WITH TIES keyword

SELECT TOP 5 WITH TIES VendorID, InvoiceDate
FROM Invoices
ORDER BY InvoiceDate ASC;

--Examples of WHERE clauses
--Vendors located in Iowa
--WHERE VendorState = 'IA'
--Invoices with a balance due (two variations)
--WHERE Invoi ceTotal - PaymentTotal - CreditTotal > 0
--WHERE Inv oiceTotal > PaymentTota l + CreditTota l
--Vendors with names from A to L
--WHERE VendorName < ' M'
--Invoices on or before a specified date
--WHERE InvoiceDa te <= '2020 - 01-31'
--Invoices on or after a specified date
--WHERE InvoiceDate >= '1/1/20'
--Invoices with credits that don't equal zero
--WHERE CreditTotal <> 0

--A search condition that uses the AND operator
--WHERE VendorState = 'NJ' AND YTDPurchases > 200
--A search condition that uses the OR operator
--WHERE VendorState = 'NJ' OR YTDPurchases > 200
--A search condition that uses the NOT operator
--WHERE NOT (InvoiceTotal >= 5000 OR NOT InvoiceDate <= '2020-02-01')
--The same condition rephrased to eliminate the NOT operator
--WHERE InvoiceTotal < 5000 AND InvoiceDate <= '2020-02-01'

--WHERE InvoiceDate > '01/01/2020'
--OR InvoiceTotal > 500
--AND InvoiceTotal - PaymentTotal - CreditTotal > 0

--WHERE (InvoiceDate > '01/01/2020'
--OR InvoiceTotal > 500)
--AND InvoiceTotal - PaymentTotal - CreditTotal > 0

SELECT * 
FROM Terms
WHERE TermsID IN (1, 3, 4);

SELECT *
FROM Vendors
WHERE VendorID IN
   (SELECT VendorID
    FROM Invoices
	WHERE InvoiceDate = '2019-12-01'
    );

--Examples of the BETWEEN phrase
--A BETWEEN phrase with literal values
SELECT *
FROM Invoices
WHERE InvoiceDate BETWEEN '2020-01-01' AND '2020-01-31';

--A BETWEEN phrase preceded by NOT
SELECT *
FROM Vendors
WHERE VendorZipCode NOT BETWEEN 93600 AND 93799;

--A BETWEEN phrase with a test expression coded as a calculated value
SELECT *
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal BETWEEN 200 AND 500;

--A BETWEEN phrase with the upper and lower limits coded
--as calculated values
SELECT *
FROM Invoices
WHERE InvoiceDueDate BETWEEN GetDate() AND GetDate() + 30

--WHERE clauses that use the LIKE operator

SELECT DISTINCT VendorCity
FROM Vendors
WHERE VendorCity LIKE 'SAN%';

SELECT VendorName 
FROM VENDORS
WHERE VendorName LIKE 'COMPU_ER%'

SELECT VendorContactLName
FROM VENDORS
WHERE VendorContactLName LIKE 'DAMI[EO]N'

SELECT VendorState
FROM VENDORS
WHERE VendorState LIKE 'N[A-J]'

SELECT VendorState
FROM VENDORS
WHERE VendorState LIKE 'N[^K-Y]'

SELECT VendorZipCode
FROM Vendors
WHERE VendorZipCode NOT LIKE '[1-9]%'

--An ORDER BY clause that uses an alias

SELECT VendorName,
    VendorCity + ',  ' + VendorState + ' ' + VendorZipCode As Address
FROM Vendors
ORDER BY Address, VendorName;


--An ORDER BY clause that uses an expression
SELECT VendorName,
VendorCity + ' , ' + VendorState + ' ' + VendorZipCode AS Address
FROM Vendors
ORDER BY VendorContactLName + VendorContactFName;

--An ORDER BY clause that uses column positions

SELECT VendorName,
VendorCity + ' , ' + VendorState + '  ' + VendorZipCode AS Address
FROM Vendors
ORDER BY 2, 1;

--An ORDER BY clause that retrieves the first five rows

SELECT VendorID, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal DESC
      OFFSET 0 ROWS
	  FETCH FIRST 5 ROWS ONLY;

--An ORDER BY clause that retrieves rows 11 through 20

SELECT VendorName, VendorCity, VendorState, VendorZipCode
FROM Vendors
WHERE VendorState = 'CA'
ORDER BY VendorCity
      OFFSET 10 ROWS
	  FETCH NEXT 10 ROWS ONLY;






		

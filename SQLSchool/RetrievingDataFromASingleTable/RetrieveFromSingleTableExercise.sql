--Write a SELECT statement that returns three columns from the Vendors table:
--VendorContactFName, VendorContactLName, and VendorName. Sort the
--result set by last name, then by first name.

SELECT VendorContactFName, VendorContactLName, VendorName
FROM Vendors
Order BY VendorContactLName, VendorContactFName


--Write a SELECT statement that returns four columns from the Invoices table,
--named Number, Total, Credits, and Balance:
--Number
--Total
--Credits
--Balance
--Column alias for the InvoiceNumber column
--Column alias for the InvoiceTotal column
--Sum of the PaymentTotal and CreditTotal columns
--InvoiceTotal minus the sum of PaymentTotal and CreditTotal
--Use the AS keyword to assign column aliases.

SELECT InvoiceNumber As Number, InvoiceTotal As Total,
     PaymentTotal + CreditTotal As Credits,
	 InvoiceTotal - ( PaymentTotal + CreditTotal) As Balance
FROM Invoices

--Write a SELECT statement that returns one column from the Vendors table
--named Full Name. Create this column from the VendorContactFName and
--VendorContactLName columns. Format it as follows: last name, comma, first
--name (for example, "Doe, John"). Sort the result set by last name, then by first
--name.

SELECT VendorContactFName + ',' + ' ' + VendorContactLName As FullName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName

--Write a SELECT statement that returns three columns:
--InvoiceTotal
--10%
--From the Invoices table
--10% of the value of InvoiceTotal
--Plus 10% The value of InvoiceTotal plus 10%
--(For example, if InvoiceTotal is 100.0000, 10% is 10.0000, and Plus 10% is
--110.0000.) Only return those rows with a balance due greater than 1000. Sort
--the result set by InvoiceTotal, with the largest invoice first.
--(1)
SELECT InvoiceTotal, (InvoiceTotal * 10)/100 AS "10%", 
     InvoiceTotal + (InvoiceTotal * 10)/100 AS "Plus 10%"
FROM Invoices
WHERE InvoiceTotal - (PaymentTotal + CreditTotal) > 1000
ORDER BY InvoiceTotal DESC

--(2)
SELECT InvoiceTotal, InvoiceTotal / 10 AS [10%],
       InvoiceTotal * 1.1 AS [Plus 10%]
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
ORDER BY InvoiceTotal DESC;


--Modify the solution to exercise 2 to filter for invoices with an InvoiceTotal
--that's greater than or equal to $500 but less than or equal to $10,000.
--(1)
SELECT InvoiceNumber As Number, InvoiceTotal As Total,
     PaymentTotal + CreditTotal As Credits,
	 InvoiceTotal - ( PaymentTotal + CreditTotal) As Balance
FROM Invoices
WHERE InvoiceTotal >= 500 AND InvoiceTotal <= 10000

--(2)
SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
WHERE InvoiceTotal BETWEEN 500 AND 10000;

--Modify the solution to exercise 3 to filter for contacts whose last name begins
--with the letter A, B, C, or E.
--(1)
SELECT VendorContactFName + ',' + ' ' + VendorContactLName As FullName
FROM Vendors
WHERE LEFT(VendorContactLName,1) IN ('A', 'B', 'C', 'E')
ORDER BY VendorContactLName, VendorContactFName

--(2)
SELECT VendorContactFName + ',' + ' ' + VendorContactLName As FullName
FROM Vendors
WHERE VendorContactLName LIKE '[A-C]%' OR VendorContactLName LIKE '[E]%'
ORDER BY VendorContactLName, VendorContactFName

--(3)
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A-C,E]%'
--Also acceptable:
--WHERE VendorContactLName LIKE '[A-E]%' AND
--      VendorContactLName NOT LIKE 'D%'
ORDER BY VendorContactLName, VendorContactFName;


--Write a SELECT statement that determines whether the PaymentDate column
--of the Invoices table has any invalid values. To be valid, PaymentDate must be
--a null value if there's a balance due and a non-null value if there's no balance
--due. Code a compound condition in the WHERE clause that tests for these
--conditions.

--(1)
SELECT PaymentDate As InvalidPamentDate
FROM Invoices
WHERE (PaymentDate IS NOT NULL AND InvoiceTotal - (PaymentTotal + CreditTotal) > 0)
      OR
	  (PaymentDate IS NULL AND InvoiceTotal - (PaymentTotal + CreditTotal) = 0)

--(2)
SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND
      PaymentDate IS NULL) OR
      ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND
      PaymentDate IS NOT NULL);




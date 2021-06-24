/* Inserting data into the professor's table from a text file */
BULK INSERT Lab3.dbo.Professors
FROM 'C:\Users\hanke\Documents\SQL Server Management Studio\Lab 3\Data\faculty.txt'
WITH 
	(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)


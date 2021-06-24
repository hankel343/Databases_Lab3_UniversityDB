/* Inserting data into the professor's table from a text file */
BULK INSERT Lab3.dbo.Professors
FROM 'C:\Users\hanke\Documents\SQL Server Management Studio\Lab 3\Data\faculty.txt'
WITH 
	(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	);

/* Inserting data into the GradStudents table */
BULK INSERT Lab3.dbo.GradStudents
FROM 'C:\Users\hanke\Documents\SQL Server Management Studio\Lab 3\Data\student.txt'
WITH 
	(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	);

/* Inserting data into Projects table from text file */
BULK INSERT Lab3.dbo.Projects
FROM 'C:\Users\hanke\Documents\SQL Server Management Studio\Lab 3\Data\projects.txt'
WITH
	(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	);

/* Inserting data into the Departments table */
INSERT INTO Departments VALUES(100,'College of Liberal Arts','231 Ross');
INSERT INTO Departments VALUES(101,'College of Engineering','2215 Coover Hall');
INSERT INTO Departments VALUES(102,'College of Business','1200 Gerdin Business Building');

/* Inserting data into Manages table */
INSERT INTO Manages VALUES(11564812, 2214);
INSERT INTO Manages VALUES(11564812, 2462); -- Demonstration that a single professor can be manager of more than one project
INSERT INTO Manages VALUES(90873519, 2214); --ERROR: Project have one manager
INSERT INTO Manages VALUES(141582651, 7312);
INSERT INTO Manages VALUES(254099823, 8421);
INSERT INTO Manages VALUES(287321212, 8431);

/* Inserting data into CoInvestigators table */
INSERT INTO CoInvestigators VALUES(11564812, 2462);
INSERT INTO CoInvestigators VALUES();
INSERT INTO CoInvestigators VALUES();
INSERT INTO CoInvestigators VALUES();
INSERT INTO CoInvestigators VALUES();
INSERT INTO CoInvestigators VALUES();
INSERT INTO CoInvestigators VALUES();

SELECT *
FROM Professors;

SELECT *
FROM Projects;
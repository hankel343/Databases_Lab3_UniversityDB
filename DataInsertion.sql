/* Inserting data into the professor's table from a text file */
BULK INSERT Lab3.dbo.Professors
FROM 'C:\Users\hanke\Documents\SQL Server Management Studio\Lab 3\Data\faculty.txt'
WITH 
	(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)

/* Inserting data into the Departments table */
INSERT INTO Departments VALUES(100,'College of Liberal Arts','231 Ross',142519864);
INSERT INTO Departments VALUES(101,'College of Engineering','2215 Coover Hall',254099823);
INSERT INTO Departments VALUES(102,'College of Business','1200 Gerdin Business Building',248965255);

/* Inserting data into the Insructors table */
INSERT INTO Instructors VALUES(142519864,100,.75);
INSERT INTO Instructors VALUES(142519864,101,.25);
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
INSERT INTO Instructors VALUES();
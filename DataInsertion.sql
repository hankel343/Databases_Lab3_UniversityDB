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
INSERT INTO CoInvestigators VALUES(90873519, 2214);
INSERT INTO CoInvestigators VALUES(287321212, 8431);
INSERT INTO CoInvestigators VALUES(489221823, 8421);
INSERT INTO CoInvestigators VALUES(141582651, 7312);
INSERT INTO CoInvestigators VALUES(11564812, 8431);
INSERT INTO CoInvestigators VALUES(619023588,7312);

/* Inserting data into ResearchAssistants table */
INSERT INTO ResearchAssistant VALUES(51135593,11564812,2214);
INSERT INTO ResearchAssistant VALUES(51135593,142519864,2214); --Demonstrates that an RA can have multiple different supervisors on the same project
INSERT INTO ResearchAssistant VALUES(60839453,242518965,2214);
INSERT INTO ResearchAssistant VALUES(99354543,248965255,2462);
INSERT INTO ResearchAssistant VALUES(132977562,356187925, 2462);
INSERT INTO ResearchAssistant VALUES(269734834,619023588, 2462);
INSERT INTO ResearchAssistant VALUES(567354612,248965255,7312);
INSERT INTO ResearchAssistant VALUES(574489456,489456522,7312);
INSERT INTO ResearchAssistant VALUES(322654189,356187925,7312);
INSERT INTO ResearchAssistant VALUES(455798411,548977562,8421);
INSERT INTO ResearchAssistant VALUES(322654189,141582651,8421);
INSERT INTO ResearchAssistant VALUES(60839453,254099823,8421);
INSERT INTO ResearchAssistant VALUES(269734834,486512566,8431);
INSERT INTO ResearchAssistant VALUES(318548912,242518965,8431);
INSERT INTO ResearchAssistant VALUES(51135593,356187925,8431);

/* Inserting data into Chairs table */
INSERT INTO Chairs VALUES(254099823, 100);
INSERT INTO Chairs VALUES(489221823, 100); --ERROR: Departments must have only one chair
INSERT INTO Chairs VALUES(254099823, 101); --Demonstration that a single professor can chair two different departments
INSERT INTO Chairs VALUES(159542516, 102);

/* Inserting data into StudentIn table */
INSERT INTO StudentIn VALUES(51135593, 100);
INSERT INTO StudentIn VALUES(60839453, 100);
INSERT INTO StudentIn VALUES(99354543, 100);
INSERT INTO StudentIn VALUES(132977562, 100);
INSERT INTO StudentIn VALUES(269734834, 100);
INSERT INTO StudentIn VALUES(280158572, 100);
INSERT INTO StudentIn VALUES(301221823, 100);
INSERT INTO StudentIn VALUES(550156548, 100);
INSERT INTO StudentIn VALUES(573284895, 100);
INSERT INTO StudentIn VALUES(574489456, 100);
INSERT INTO StudentIn VALUES(578875478, 100);
INSERT INTO StudentIn VALUES(112348546, 101);
INSERT INTO StudentIn VALUES(320874981, 101);
INSERT INTO StudentIn VALUES(322654189, 101);
INSERT INTO StudentIn VALUES(348121549, 101);
INSERT INTO StudentIn VALUES(455798411, 101);
INSERT INTO StudentIn VALUES(462156489, 101);
INSERT INTO StudentIn VALUES(552455318, 101);
INSERT INTO StudentIn VALUES(556784565, 101);
INSERT INTO StudentIn VALUES(567354612, 101);
INSERT INTO StudentIn VALUES(318548912, 102);
INSERT INTO StudentIn VALUES(351565322, 102);
INSERT INTO StudentIn VALUES(451519864, 102);

/* Inserting data in to FacultyIn Table */
INSERT INTO FacultyIn VALUES(11564812, 101, .75);
INSERT INTO FacultyIn VALUES(11564812, 101, .25);
INSERT INTO FacultyIn VALUES();
INSERT INTO FacultyIn VALUES();

SELECT *
FROM Professors;

SELECT *
FROM Departments;
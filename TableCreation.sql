/* Entities */
CREATE TABLE Professors (
	PK_fid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	rank VARCHAR(20),
	dob VARCHAR(20),
	specialty VARCHAR(20),
);

CREATE TABLE Chairmen (
	PK_chairid INTEGER PRIMARY KEY,
	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid),
);

CREATE TABLE PrimaryInvestigators (
	PK_investid INTEGER PRIMARY KEY,
	FK_investfid INTEGER UNIQUE REFERENCES Professors(PK_fid), --One-to-One relationship between Primary Investigators and Professor ids
);

CREATE TABLE CoInvestigators (
	PK_fid INTEGER PRIMARY KEY,
	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid), --One-to-One relationship between Professor record and CoInvest. record b/c they are the same thing
	FK_pid INTEGER REFERENCES Projects(PK_pid), --Represents the "Works On" relationship between CoInvest. and Projects. Note many CoInvest. can work on one proj.
);

CREATE TABLE Instructors (
	PK_instructorid INTEGER PRIMARY KEY,
	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid),
	time_percentage REAL,
);

CREATE TABLE GradStudents (
	PK_sid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	dob VARCHAR(20),
	degree_program VARCHAR(20),
	FK_majordept INTEGER REFERENCES Departments(PK_did), --Represents the "StudentIn" relationship between GradStudent and Departments
);

--ResearchAssistants exist in an ISA relationship with GradStudents
CREATE TABLE ResearchAssistant (
	PK_raid INTEGER PRIMARY KEY, --Uniquely identifies research assistants
	FK_supervisorid INTEGER REFERENCES Professors(PK_fid), --One RA can have many different advisors.
	FK_sid INTEGER UNIQUE REFERENCES GradStudents(PK_sid), --UNIQUE keyword ensures there is a one-to-one relationship between RAs and GradStudents b/c they are the same
														--thing just in a different context (e.g. RAs are grad students working on projects)
	FK_pid INTEGER REFERENCES Projects(PK_pid), --Represents "Works On" relationship from RAs to projects in ERD.
);

--StudentAdvisors exist in an ISA relationship with GradStudents
CREATE TABLE StudentAdvisor (
	PK_advisorid INTEGER PRIMARY KEY,
	FK_advisorsid INTEGER UNIQUE REFERENCES GradStudents, --There is a 1:1 relationship between advisorid and sid from GradStudents b/c advisors are grad students.
	FK_adviseesid INTEGER REFERENCES GradStudents, --Represents the "Advises" relationship in the ERD.
);

CREATE TABLE Projects (
	PK_pid INTEGER PRIMARY KEY,
	project_name VARCHAR(20),
	start_date VARCHAR(20),
	end_date VARCHAR(20),
	budget DECIMAL (8, 2),
	FK_managerid INTEGER REFERENCES PrimaryInvestigators(PK_investid),
);

CREATE TABLE Departments (
	PK_did INTEGER PRIMARY KEY,
	name VARCHAR(20),
	main_office VARCHAR(20),

	FK_chairmanid INTEGER UNIQUE REFERENCES Chairmen(PK_chairid),
	FK_instructorid INTEGER REFERENCES Instructors(PK_instructorid), --Represents the "WorksIn" relationship between Professors and Departments
);
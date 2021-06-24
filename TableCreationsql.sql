/* Entities */
CREATE TABLE Professors (
	PK_fid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	rank VARCHAR(20)NOT NULL,
	dob VARCHAR(20) NOT NULL, --Constraint: Every entry must have a DOB listed.
	specialty VARCHAR(20) NOT NULL,

	CONSTRAINT valid_rank
		CHECK (rank = 'Associate' or rank = 'Adjunct' or rank = 'Full' or rank = 'Emeritus'),
);

CREATE TABLE Chairmen (
	PK_chairid INTEGER PRIMARY KEY,
	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid)
		ON DELETE CASCADE --A Chairmen record is in an ISA relationship with a Professor record, so any changes in one should be reflected in the other.
		ON UPDATE CASCADE
);

CREATE TABLE PrimaryInvestigators (
	PK_investid INTEGER PRIMARY KEY,
	FK_investfid INTEGER UNIQUE REFERENCES Professors(PK_fid) --One-to-One relationship between Primary Investigators and Professor ids
		ON DELETE CASCADE --A PrimaryInvestigator is a Professor, so changes must cascade between records.
		ON UPDATE CASCADE
);

CREATE TABLE CoInvestigators (
	PK_fid INTEGER PRIMARY KEY,

	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid) --One-to-One relationship between Professor record and CoInvest. record b/c they are the same thing
		ON DELETE CASCADE --A CoInvestigator is a Professor, so changes must cascade between records.
		ON UPDATE CASCADE,

	FK_pid INTEGER REFERENCES Projects(PK_pid) --Represents the "Works On" relationship between CoInvest. and Projects. Note many CoInvest. can work on one proj.
		ON DELETE NO ACTION --A CoInvestigator record needs a Project record to exist, so if the project is deleted CoInvestigators must be deleted as well.
		ON UPDATE NO ACTION,
);

CREATE TABLE Instructors (
	PK_instructorid INTEGER PRIMARY KEY,
	
	FK_fid INTEGER UNIQUE REFERENCES Professors(PK_fid)
		ON DELETE CASCADE --Instructors are in an ISA relationship with Professors, so any changes to one must be reflected in the other.
		ON UPDATE CASCADE,

	time_percentage REAL,

	CONSTRAINT non_negative
		CHECK (time_percentage >= 0),
);

CREATE TABLE GradStudents (
	PK_sid INTEGER PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	dob VARCHAR(20)NOT NULL,
	degree_program VARCHAR(20) DEFAULT 'Undecided' NOT NULL,
	
	FK_majordept INTEGER REFERENCES Departments(PK_did) --Represents the "StudentIn" relationship between GradStudent and Departments
		ON DELETE NO ACTION  --Deleting/Updating a Department record should have no effect on GradStudent records.
		ON UPDATE NO ACTION,
);

--ResearchAssistants exist in an ISA relationship with GradStudents
CREATE TABLE ResearchAssistant (
	PK_raid INTEGER PRIMARY KEY, --Uniquely identifies research assistants

	FK_supervisorid INTEGER REFERENCES Professors(PK_fid) --One RA can have many different advisors.
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,

	FK_sid INTEGER UNIQUE REFERENCES GradStudents(PK_sid) --UNIQUE keyword establishes a one-to-one relationship between RAs and GradStudents.
		ON DELETE CASCADE
		ON UPDATE CASCADE,								

	FK_pid INTEGER REFERENCES Projects(PK_pid) --Represents "Works On" relationship from RAs to projects in ERD.
		ON DELETE CASCADE --RAs require the existance of a project, so if the project is deleted the RA record must be deleted as well.
		ON UPDATE NO ACTION,
);

--StudentAdvisors exist in an ISA relationship with GradStudents
CREATE TABLE StudentAdvisor (
	PK_advisorid INTEGER PRIMARY KEY,
	
	FK_advisorsid INTEGER UNIQUE REFERENCES GradStudents --There is a 1:1 relationship between advisorid and sid from GradStudents b/c advisors are grad students.
		ON DELETE CASCADE --Advisor ISA GradStudent, changes must be reflected in both records
		ON UPDATE CASCADE,

	FK_adviseesid INTEGER REFERENCES GradStudents --Represents the "Advises" relationship in the ERD.
		ON DELETE NO ACTION --Deletion/Updating a GradStudent Record should not affect the advisor record.
		ON UPDATE NO ACTION,
);

CREATE TABLE Projects (
	PK_pid INTEGER PRIMARY KEY,
	project_name VARCHAR(20),
	start_date VARCHAR(20),
	end_date VARCHAR(20),
	budget DECIMAL (8, 2),

	/* Foreign Key */
	FK_managerid INTEGER REFERENCES PrimaryInvestigators(PK_investid)
		ON DELETE CASCADE --Project records require a manager, so if the PrimaryInvestigator record is deleted the project is deleted as well.
		ON UPDATE NO ACTION,
);

CREATE TABLE Departments (
	PK_did INTEGER PRIMARY KEY,
	name VARCHAR(20),
	main_office VARCHAR(20),

	/* Foreign Key */
	FK_chairmanid INTEGER UNIQUE REFERENCES Chairmen(PK_chairid)
		ON DELETE CASCADE --Departments require the existance of chairmen
		ON UPDATE NO ACTION,

	FK_instructorid INTEGER REFERENCES Instructors(PK_instructorid) --Represents the "WorksIn" relationship between Professors and Departments
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
);

DROP TABLE chairmen;
DROP TABLE coinvestigators;
DROP TABLE departments;
DROP TABLE gradstudents;
DROP TABLE instructors;
DROP TABLE primaryinvestigators;
DROP TABLE professors;
DROP TABLE projects;
DROP TABLE researchassistant;
DROP TABLE studentadvisor;
--============
/* Entities */
--============

CREATE TABLE Professors (
	PK_fid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	rank VARCHAR(20)NOT NULL CONSTRAINT valid_rank
								CHECK (rank = 'Associate' or rank = 'Adjunct' or rank = 'Full' or rank = 'Emeritus'),
	dob VARCHAR(20) NOT NULL, --Constraint: Every entry must have a DOB listed.
	specialty VARCHAR(50) NOT NULL,
);

CREATE TABLE Departments (
	PK_did INTEGER PRIMARY KEY,
	name VARCHAR(50),
	main_office VARCHAR(50),
);

CREATE TABLE GradStudents (
	PK_sid INTEGER PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	dob VARCHAR(20)NOT NULL,
	degree_program VARCHAR(50) NOT NULL,
);

CREATE TABLE Projects (
	PK_pid INTEGER PRIMARY KEY,
	sponsor_name VARCHAR(100),
	start_date VARCHAR(20),
	end_date VARCHAR(20),
	budget INTEGER,
);

--=======================
/* Relationship Tables */
--=======================

--Represents the "Manages" relationship between Professors and Projects in the ERD.
CREATE TABLE Manages ( 
	/* Fields */
	FK_primaryinvestigatorid INTEGER,
	FK_pid INTEGER UNIQUE, --The use of UNIQUE ensures that a pid appears once in the table when associated with a primaryInvestigator, but a primaryinvestigatorid
						   --can appear multiple times in the table with different pids.

	PRIMARY KEY(FK_primaryinvestigatorid, FK_pid),

	/* Foreign Key to Professors */
	CONSTRAINT Manages_Professors
		FOREIGN KEY (FK_primaryinvestigatorid) REFERENCES Professors
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	/* Foreign Key to Projects */
	CONSTRAINT Manages_Projects
		FOREIGN KEY (FK_pid) REFERENCES Projects
			ON DELETE CASCADE
			ON UPDATE CASCADE,
);

--Represents the relationship "WorksOn" between CoInvestigators and Projects
CREATE TABLE CoInvestigators (
	/* Fields */
	FK_coinvestigatorid INTEGER,
	FK_pid INTEGER,

	PRIMARY KEY (FK_coinvestigatorid, FK_pid),

	/* Foreign Key between CoInvestigators and Professors */
	CONSTRAINT FK_CoInvestigatorISAProfessor --ISA FK constraint tying CoInvestigator's ID with matching ID in Professors table.
		FOREIGN KEY (FK_coinvestigatorid) REFERENCES Professors(PK_fid)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	
	/* Foreign Key between CoInvestigators and Projects */
	CONSTRAINT CoInvestigator_WorksOn --Represents the "WorksOn" relationship between CoInvestigators and Projects in the ERD.
		FOREIGN KEY (FK_pid) REFERENCES Projects(PK_pid)
			ON DELETE CASCADE --A CoInvestigator requires a project to exist
			ON UPDATE CASCADE,
);

--Represents the "WorksIn" relationship between Professors and Departments
CREATE TABLE WorksIn ( 
	/* Fields */
	FK_professorid INTEGER,
	FK_departmentid INTEGER,
	time_percentage REAL CONSTRAINT valid_percentage_range
							CHECK (time_percentage BETWEEN 0.0 and 1.0),
	
	PRIMARY KEY (FK_professorid, FK_departmentid), --A record is uniquely identified by the combination of professor id and a department id.

	/* Foreign Key */
	CONSTRAINT FK_InstructorISAProfessor --ISA relationship between instructors (e.g. professors in a department) and professor records
		FOREIGN KEY(FK_professorid) REFERENCES Professors(PK_fid)
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	/* Foreign Key */
	CONSTRAINT WorksIn --Represents the relationship "WorksIn" between Professors and Departments in the ERD.
		FOREIGN KEY (FK_departmentid) REFERENCES Departments(PK_did)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
);

--Represents the "StudentIn" relationship between GradStudents and Departments
CREATE TABLE StudentIn ( 
	/* Fields */
	FK_sid INTEGER UNIQUE, --Spec: "Graduate students have ONE major department..."
	FK_did INTEGER,

	PRIMARY KEY (FK_sid, FK_did),

	/* Foreign Key to GradStudents record */
	CONSTRAINT GradStudent_StudentIn
		FOREIGN KEY (FK_sid) REFERENCES GradStudents(PK_sid)
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	/* Foreign Key to Departments record */
	CONSTRAINT Department_StudentIn
		FOREIGN KEY (FK_sid) REFERENCES Departments(PK_did) 
			ON DELETE CASCADE
			ON UPDATE CASCADE,
);

--Represents ternary relationship between RAs, Professors, and Projects (eg Supervises and WorksOn relationships respectively)
CREATE TABLE ResearchAssistant (
	FK_raid INTEGER,
	FK_supervisorid INTEGER,
	FK_pid INTEGER,

	PRIMARY KEY (FK_raid, FK_supervisorid, FK_pid),

	/* Foreign Key to GradStudents */
	CONSTRAINT ResearchAssistant_GradStudents --Represents the ISA relationship between ResearchAssistants and GradStudents in the ERD.
		FOREIGN KEY (FK_raid) REFERENCES GradStudents(PK_sid)
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	CONSTRAINT ResearchAssistant_Professors --Represents the relationship "Supervises" in the ERD.
		FOREIGN KEY (FK_supervisorid) REFERENCES Professors(PK_fid)
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	CONSTRAINT ResearchAssistant_Projects --Represents the relationship "WorksOn" from ResearchAssistants to Projects in the ERD.
		FOREIGN KEY (FK_pid) REFERENCES Projects(PK_pid)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
);

--StudentAdvisors exist in an ISA relationship with GradStudents
CREATE TABLE Advises (
	FK_advisorid INTEGER, --Advisor can advise multiple students
	FK_adviseeid INTEGER UNIQUE, --GradStudent will have one advisor

	PRIMARY KEY (FK_advisorid, FK_adviseeid),

	/* Foreign Key to GradStudent for Advisor */
	CONSTRAINT AdvisesAsAdvisor_GradStudent
		FOREIGN KEY(FK_advisorid) REFERENCES GradStudents(PK_sid)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,

	/* Foreign Key to GradStudnet for Advisee */
	CONSTRAINT AdvisesAsAdvisee_GradStudent
		FOREIGN KEY (FK_adviseeid) REFERENCES GradStudents(PK_sid)
			ON DELETE NO ACTION 
			ON UPDATE NO ACTION,
);

--Represents the "Chairs" relationship between Professors and Departments
CREATE TABLE Chairs (
	FK_chairid INTEGER, --Database allows for one professor to chair multiple departments
	FK_departmentid INTEGER UNIQUE, --UNIQUE ensures there is only one record with a department id and therefore one chairperson

	PRIMARY KEY(FK_chairid, FK_departmentid),

	/* Foreign Key to Professors */
	CONSTRAINT Chairs_Professors
		FOREIGN KEY (FK_chairid) REFERENCES Professors
			ON DELETE CASCADE
			ON UPDATE CASCADE,

	/* Foreign Key to Departments */
	CONSTRAINT Chairs_Departments
		FOREIGN KEY (FK_departmentid) REFERENCES Departments(PK_did)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
);


DROP TABLE Professors;
DROP TABLE Projects;
DROP TABLE Departments;
DROP TABLE GradStudents;

DROP TABLE Advises;
DROP TABLE WorksIn;
DROP TABLE Chairs;
DROP TABLE CoInvestigators;
DROP TABLE Manages;
DROP TABLE ResearchAssistant;
DROP TABLE StudentIn;
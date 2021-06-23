/* Table Creation (Entities and relationships) */
CREATE TABLE Professors ( --!
	fid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	rank VARCHAR(20),
	dob DATE,
	specialty VARCHAR(20),
);

CREATE TABLE GradStudents (
	sid INTEGER PRIMARY KEY,
	name VARCHAR(20),
	dob DATE,
	degree_program VARCHAR(20),
);

CREATE TABLE StudentIn ( --Represents the StudentIn relationship in the ERD.
	sid INTEGER UNIQUE,
	major VARCHAR(20),
);

CREATE TABLE Departments (
	did INTEGER PRIMARY KEY,
	name VARCHAR(20),
	main_office VARCHAR(20),
);

CREATE TABLE WorksIn (
	fid INTEGER PRIMARY KEY,
	time_percentage real,
);

CREATE TABLE Projects ( --!
	pid INTEGER PRIMARY KEY,
	project_name VARCHAR(50),
	start_date DATE,
	end_date DATE,
	Budget DECIMAL (8, 2),
);

/*	Research Assistants exist as a subentity in an ISA relationship with GradStudents.
 *	This allows for the supervise relationship between Professors and Research Assistants
 *	to apply to only graduate students who work on projects (e.g. Research Assistants)
*/
CREATE TABLE ResearchAssistants (
	sid INTEGER PRIMARY KEY
);

CREATE TABLE StudentAdvisors (
	said INTEGER PRIMARY KEY,
);

CREATE TABLE Advises (
	said INTEGER UNIQUE REFERENCES StudentAdvisors, --Student Advisor id
	sid INTEGER UNIQUE REFERENCES GradStudents,

	PRIMARY KEY(said, sid)
);
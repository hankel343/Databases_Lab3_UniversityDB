/* Foreign keys for Professors table */
ALTER TABLE Professors
ADD CONSTRAINT FK_Professors_WorksIn --Relation between 
		FOREIGN KEY (fid) REFERENCES WorksIn
			ON DELETE NO ACTION
			ON UPDATE CASCADE;

/* Foreign Keys for GradStudent table */
ALTER TABLE GradStudents
ADD CONSTRAINT FK_GradStudents_StudentIn
		FOREIGN KEY (sid) REFERENCES StudentIn (sid)
			ON DELETE NO ACTION
			ON UPDATE CASCADE;

/* Foreign Keys for StudentIn table */
ALTER TABLE StudentIn
ADD CONSTRAINT FK_StudentIn_Departments
		FOREIGN KEY (sid) REFERENCES Departments(did)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION;

/* Foreign Keys for Departments Table */
ALTER TABLE Departments
ADD CONSTRAINT FK_Deparments_Chairman --Represents the "Chairs" relation between Professors and Departments in the ERD.
		FOREIGN KEY (did) REFERENCES Professors(fid)
			ON DELETE NO ACTION --Deleting the chairman record should not have an impact on a Departments record
			ON UPDATE NO ACTION --Updating the chariman's record should not have an impact on a Departments record

/* Foreign Keys for WorksIn table */
ALTER TABLE WorksIn
ADD CONSTRAINT FK_WorksIn_Departments --Represents relationship between WorksIn and Departments
		FOREIGN KEY (fid) REFERENCES Departments
			ON DELETE CASCADE --If a Departments record is deleted, a WorksIn record should also be deleted.
			ON UPDATE NO ACTION --Updating a Departments record should not change a WorksIn record.

/* Foreign Keys for Projects table */
ALTER TABLE Projects 
--Because FK is defined here, many project records can be managed by one professor record (e.g. one-to-many)
ADD CONSTRAINT FK_Projects_Professors_PrimaryInvestigator --This foreign key represents the Manages relationship in the ERD
		FOREIGN KEY (pid) REFERENCES Professors (fid)
			ON DELETE NO ACTION --If PrimaryInvestigator is deleted, do not delete the associated project record.
			ON UPDATE CASCADE; --If PrimaryInvestigator's record updates, reflect this in relevant Project record.

ALTER TABLE Projects
ADD CONSTRAINT FK_Projects_Professors_WorkOn --This represents the relationship "Work On" between Co-Investigators and Projects in the ERD.
		FOREIGN KEY (pid) REFERENCES Professors(fid)
			ON DELETE NO ACTION --If a Professor record is deleted it should not influence a project record.
			ON UPDATE NO ACTION; --Updating a Professor record should not influence a project record.

ALTER TABLE Projects
ADD CONSTRAINT FK_Projects_ResearchAssistants_WorkOn --Represents relationship "Work On" between Research Assistants and Projects in the ERD.
		FOREIGN KEY (pid) REFERENCES ResearchAssistants(sid)
			ON DELETE NO ACTION	--Deletion of a research assistant should have no bearing on a project record.
			ON UPDATE NO ACTION; --Updating a research assistant record should have no bearing on a project record.

/* Foreign keys for Research Assistants */
ALTER TABLE ResearchAssistants
ADD CONSTRAINT FK_ResearchAssistants_GradStudents_ISA
		FOREIGN KEY (sid) REFERENCES GradStudents(sid)
			ON DELETE CASCADE --RAs exist in an ISA relationship with grad students, so any deletions/updates in grad students should be reflected in RAs.
			ON UPDATE CASCADE;

ALTER TABLE ResearchAssistants
ADD CONSTRAINT FK_ResearchAssistants_Professors_Supervisor --Represents the relation Supervises between Professors and RAs in ERD
		FOREIGN KEY (sid) REFERENCES  Professors(fid)
			ON DELETE CASCADE --If a supervising professor record is deleted, the corresponding research assistant record should also be deleted.
			ON UPDATE NO ACTION;

/*Foreign keys for Student Advisors*/
ALTER TABLE StudentAdvisors
ADD CONSTRAINT FK_StudentAdvisors_GradStudents_ISA
		FOREIGN KEY (said) REFERENCES GradStudents
			ON DELETE CASCADE
			ON UPDATE NO ACTION;
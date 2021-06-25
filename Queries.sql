/* Queries */
--(1) What is the total budget for all projects?
SELECT SUM(P.budget)
FROM Projects AS P;

--(2) Who are the professors that manage projects?
SELECT Professors.name --Inner join b/w Professors and Manages for primary keys that are shared between both tables.
FROM Professors
JOIN Manages ON Professors.PK_fid = FK_primaryinvestigatorid;

--(3) Who are the professors who don't manage projects?
SELECT Professors.name --Get all names of professors, and then perform set-difference operation with professors that manage projects.
FROM Professors
EXCEPT
SELECT Professors.name
FROM Professors
JOIN Manages ON Professors.PK_fid = FK_primaryinvestigatorid;

--(4) Which graduate students work on more than three projects?
SELECT G.name
FROM GradStudents AS G
WHERE G.PK_sid in ((SELECT R.FK_raid --Return set of all RAids in RA records that have a count greater than three
			FROM ResearchAssistant AS R
			GROUP BY R.FK_raid
			HAVING (COUNT(R.FK_raid) >= 3)));

--(5) What are the professors that work in each department?
SELECT P.name
FROM Professors AS P
WHERE P.PK_fid IN ((SELECT F.FK_professorid
			FROM FacultyIn AS F
			GROUP BY F.FK_professorid
			HAVING COUNT(F.FK_professorid) = 3));


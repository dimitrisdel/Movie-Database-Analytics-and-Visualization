--VIEW ACTOR
Create View Actor AS 
    Select distinct person_id, gender, name
    From movie_cast

--VIEW CrewMember
Create View CrewMember AS 
    Select distinct person_id, gender, name
    From movie_crew

--VIEW Person
Create View Person AS 
    SELECT * FROM Actor
    UNION
    SELECT * FROM CrewMember;
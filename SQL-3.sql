--Part 1:
ALTER TABLE PARENT ADD CONSTRAINT pk_child_id PRIMARY KEY (Child_ID);
--Table altered.

CREATE INDEX hh_zip_i ON HOUSEHOLD(Zip);
--Index created.

--PART 2:

CREATE SEQUENCE pet_id_seq 
MINVALUE 1
MAXVALUE 999999999
START WITH 6
INCREMENT BY 1;
--Sequence created.

ALTER TABLE PET MODIFY (Pet_ID DEFAULT pet_id_seq.nextval);
--Table altered.

INSERT INTO PET (PName, Type, Fur_Type, Year_Born, House_In)
VALUES ('Findlay', 'Dog', 'Short Hair', '2021', 1);
--1 row created.

--PART 3:

CREATE VIEW VHOUSEHOLD
AS
SELECT House_ID, Address_Num, City, State, Zip
FROM HOUSEHOLD;
--View created.

SELECT * 
FROM VHOUSEHOLD
WHERE City = 'Cincinnati';

HOUSE_ID ADDRESS_NU CITY                                               ST
---------- ---------- -------------------------------------------------- --
       ZIP
----------
         4 999        Cincinnati                                         OH
     45220

         5 265        Cincinnati                                         OH
     45220

--PART 4:
--#1
SELECT DISTINCT H.City
FROM HOUSEHOLD H, MEMBER M
WHERE M.Lives_In = H.House_ID;

CITY
--------------------------------------------------
Cleveland
Cincinnati
Akron
Chicago
Columbus

--#2
SELECT M.Member_ID, M.Name, M.Birthday, M.Phone_Num
FROM MEMBER M, PET P
WHERE M.Lives_In = P.House_In
AND P.PName = 'Whiskers';

MEMBER_ID NAME                                               BIRTHDAY
---------- -------------------------------------------------- ---------
PHONE_NUM
------------
         3 William Mack                                       12-AUG-23
330-949-2522

         4 Mary Burbank                                       15-FEB-22
330-512-9725

--#3
SELECT *  
FROM (SELECT Address_Num, Street, City, State 
FROM HOUSEHOLD 
ORDER BY city)
WHERE rownum <= 3;

ADDRESS_NU STREET
---------- --------------------------------------------------
CITY                                               ST
-------------------------------------------------- --
123        2nd Ave.
Akron                                              OH

102        Michigan Ave.
Chicago                                            IL

999        Freeland St.
Cincinnati                                         OH

--#4
SELECT M.NAME
FROM MEMBER M, HOUSEHOLD H
WHERE M.Lives_In = H.House_ID
AND H.Address_Num='321'
AND H.Street = 'High St.'
UNION ALL
SELECT P.PName
FROM PET P, HOUSEHOLD H
WHERE P.House_In = H.House_ID
AND H.Address_Num='321'
AND H.Street = 'High St.';

NAME
--------------------------------------------------
Nelson Freeman
Mary Mader
Jessica Freeman
Jack
Crookshanks
Findlay

6 rows selected.

--#5
SELECT M.* 
FROM MEMBER M, PET P
WHERE M.Lives_In = P.House_In(+)
AND P.House_In IS NULL;

MEMBER_ID NAME                                               PHONE_NUM
---------- -------------------------------------------------- ------------
BIRTHDAY  G   LIVES_IN
--------- - ----------
        14 Joseph Freeman                                     312-893-2254
27-DEC-72 M          6

        15 Abigale Whitman                                    773-254-8919
03-FEB-68 F          6

         5 Samuel Freeman
15-MAR-98 M          6


 MEMBER_ID NAME                                               PHONE_NUM
---------- -------------------------------------------------- ------------
BIRTHDAY  G   LIVES_IN
--------- - ----------
         2 Samuel Hunter                                      513-395-7045
26-AUG-22 M          4

        10 Lucerna Harlow                                     513-786-2650
03-SEP-18 F          4



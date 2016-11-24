.read sp16data.sql
.read fa16data.sql

CREATE TABLE obedience AS
  select seven, denero from students;

CREATE TABLE smallest_int AS
  select time, smallest from students where smallest > 8 order by smallest limit 20;

CREATE TABLE greatstudents AS
  select fa.date, fa.number, fa.pet, fa.color, sp.color from students as fa, sp16students as sp 
  where fa.date = sp.date and fa.number = sp.number and fa.pet = sp.pet;

CREATE TABLE sevens AS
  select s.seven from students as s, checkboxes as b 
  where s.time = b.time and s.number = 7 and b.'7' = 'True';

CREATE TABLE matchmaker AS
  select a.pet, a.song, a.color, b.color from students as a, students as b 
  where a.time < b.time and a.pet = b.pet and a.song = b.song;

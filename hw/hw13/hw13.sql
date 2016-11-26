create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
create table size_of_dogs as
  select name, size from dogs, sizes where min < height and height <= max;

-- All dogs with parents ordered by decreasing height of their parent
create table by_height as
  select child from dogs, parents where parent = name order by height desc;

-- Sentences about siblings that are the same size
create table sentences as
  with siblings(s1, s2) as (
      SELECT a.child, b.child FROM parents AS a, parents AS b
      WHERE a.parent = b.parent AND a.child < b.child
  )
  select s1 || " and " || s2 || " are " || a.size || " siblings"
  from siblings, size_of_dogs as a, size_of_dogs as b
  where a.name = s1 and b.name = s2 and a.size = b.size;
;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
create table stacks as
  with stacks(stack, total_height, num_dogs, last_height) as(
      select name, height, 1, height from dogs union
      select stack || ", " || name, total_height + height, num_dogs + 1, height from stacks, dogs
      where last_height < height and num_dogs < 4
  )
  select stack, total_height from stacks
  where num_dogs = 4 and total_height >= 170 order by total_height;

-- non_parents is an optional, but recommended question
-- All non-parent relations ordered by height difference
create table non_parents as
  with pair(d1, d2, diff) as(
    with ancestors(ancestor, descendant) as(
        select a.parent, b.child from parents as a, parents as b where a.child = b.parent union
        select ancestor, child from ancestors, parents where parent = descendant
    )
    select ancestor, descendant, a.height - b.height as diff from ancestors, dogs as a, dogs as b
    where a.name = ancestor and b.name = descendant
    union
    select descendant, ancestor, b.height - a.height as diff from ancestors, dogs as a, dogs as b
    where a.name = ancestor and b.name = descendant
  )
  select d1, d2 from pair order by diff;

create table ints as
    with i(n) as (
        select 1 union
        select n+1 from i limit 100
    )
    select n from i;

create table divisors as
    with divisors(n, total, last) as(
        select n, 1, 1 from ints union
        select d.n, total + 1, i.n from divisors as d, ints as i
        where d.n % i.n = 0 and last < i.n and i.n <= d.n
    )
    select n, max(total) as divisor from divisors group by n order by n;

create table primes as
    select n from divisors where divisor = 2;

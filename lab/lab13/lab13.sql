.read data.sql

-- Q1
create table flight_costs as
  with costs(day, price, next) as(
    select 1 as day, 20 as price, 0 as next union
	select 2,        30         , 0         union
	select 3,        40         , 55        union
	select day + 1, next, (price + next) / 2 + 5 * ((day + 2) % 7)
	from costs
	where 3 <= day and day < 25
  )
  select day, price from costs;

-- Q2
create table schedule as
  select "SFO, PDX", price from flights where departure = "SFO" and arrival = "PDX" union
  select "SFO, " || a.arrival || ", PDX", a.price + b.price from flights as a, flights as b
  where a.departure = "SFO" and a.arrival = b.departure and b.arrival = "PDX"
  order by price;

-- Q3
create table shopping_cart as
  with list(items, budget, previous) as(
    select item, 60 - price, price from supermarket where price <= 60 union
	select items || ", " || item, budget - price, price
	from list as l, supermarket as s
	where previous <= price and price <= budget
  )
  select items, budget from list order by budget, items;

-- Q4
create table number_of_options as
  select count(distinct meat) from main_course;

-- Q5
create table calories as
  select count(*) from main_course as m, pies as p
  where m.calories + p.calories < 2500;

-- Q6
create table healthiest_meats as
  select meat, min(m.calories + p.calories)
  from main_course as m, pies as p
  group by meat
  having max(m.calories + p.calories) <= 3000;

-- Q7
create table average_prices as
  select category, avg(MSRP) from products group by category;

-- Q8
create table lowest_prices as
  select item, store, min(price) from inventory group by item;

-- Q9
create table shopping_list as
  with best_deal(item, m_div_r) as(
    select name, min(MSRP / rating) from products group by category
  )
  select l.item as item, l.store as store 
  from lowest_prices as l, best_deal as b where l.item = b.item;

-- Q10
create table total_bandwidth as
  select sum(Mbs) from stores as s, shopping_list as l where s.store = l.store;

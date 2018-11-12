use sakila;
show tables;

-- 1a
select first_name, last_name from actor;

-- 1b
select upper(concat(first_name," ", last_name)) from actor;

-- 2a
select actor_id, first_name, last_name from actor where first_name = 'Joe';

-- 2b
select * from actor where last_name like "%GEN%";

-- 2c
select * from actor where last_name like "%LI%" order by last_name, first_name;

-- 2d
select * from country where country In ('Afghanistan', 'Bangladesh', 'China');

-- 3a TODO
-- 3b TODO

-- 4a
select last_name, count(1) as count from actor group by last_name;

-- 4b 
select last_name, count(*)  as count from actor group by last_name having count >=2;

-- 4c
UPDATE actor
SET first_name = 'HARPO'
WHERE last_name = "williams" and first_name = "GROUCHO";

select * from actor where last_name = "williams";

-- 4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE last_name = "williams" and first_name = "HARPO";

select * from actor where last_name = "williams";

-- 5a
CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;

-- 6a

select s.first_name, s.last_name, a.address from staff s join address  a on (s.address_id = a.address_id) ;

-- 6b
select first_name, last_name, sum(amount) from (select s.staff_id, s.first_name, s.last_name,  p.amount  from staff s join payment p on (s.staff_id = p.staff_id) where MONTH(payment_date) = "08" and YEAR(payment_date) = "2005") iq group by iq.staff_id, iq.first_name, iq.last_name ;

-- 6c
select title, num_of_actors from film f JOIN (select film_id, count(actor_id) as num_of_actors from film_actor group by film_id) ds on (f.film_id = ds.film_id );

-- 6d
select count(*) as copies_film from inventory group by film_id having film_id in (select film_id from film where title = "Hunchback Impossible");


-- 6e
select first_name, last_name, sum(amount) as Total_Amount_paid from (select s.customer_id, s.first_name, s.last_name,  p.amount  from customer s join payment p on (s.customer_id = p.customer_id)) iq group by iq.customer_id, iq.first_name, iq.last_name  order by last_name asc;

-- 7a
select * from film where title like 'K%' or title like 'Q%' and  language_id in (select language_id  from language where name = 'english');

-- 7b
select first_name, last_name from actor where actor_id in (select actor_id from film_actor where film_id in (select film_id from film where title = "Alone Trip"));

-- 7c
select first_name, last_name, email from customer where address_id in (select address_id from address where city_id in (select city_id from city where country_id in (  select country_id from country where country = "Canada"  )));

-- 7d

select * from film where film_id in (select film_id from film_category where category_id in (select category_id from category where name = "Family"));

-- 7e
select * from film order by rental_rate desc;

-- 7f

select * from sales_by_store;

-- 7g
select s.store_id, cy.city, coun.country from store s join address ad on (s.address_id = ad.address_id)
								join city cy on (cy.city_id = ad.city_id)
                                join country coun on (coun.country_id = cy.country_id);
-- 7h
-- category, film_category, inventory, payment, and rental.



select nt.`name`, sum(nt.amount) as total_amt  from (select ct.category_id as cid, ct.`name` as `name`  ,pt.amount as amount from category ct join film_category fc on (ct.category_id = fc.category_id)
						  join inventory inv on (inv.film_id = fc.film_id ) 
                          join rental rt on (inv.inventory_id = rt.inventory_id)
                          join payment pt on (rt.rental_id = pt.rental_id)) nt group by nt.`name` order by total_amt desc limit 5;





-- 8a
CREATE VIEW top_five_genres
AS
select nt.`name`, sum(nt.amount) as total_amt  from (select ct.category_id as cid, ct.`name` as `name`  ,pt.amount as amount from category ct join film_category fc on (ct.category_id = fc.category_id)
						  join inventory inv on (inv.film_id = fc.film_id ) 
                          join rental rt on (inv.inventory_id = rt.inventory_id)
                          join payment pt on (rt.rental_id = pt.rental_id)) nt group by nt.`name` order by total_amt desc limit 5;
-- 8b
                         


  






    









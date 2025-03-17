 /* Q1.  1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints. 
 */
 
 create database company;
 use company;
 
 create table employees (
              emp_id int not null,
              emp_name varchar (50),
              age int check (age >=18),
              email varchar(40) unique,
              salary decimal(10) default (30000),
              primary key(emp_id)
              );

select * from employees;

/* Q2.  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints ? /*

/* Ans SQL constraints are used to specify rules for the data in a table.

Constraints are used to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the table. If there is any violation between the constraint and the data action, the action is aborted.

NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX - Used to create and retrieve data from the database very quickly  */

create table std (
   roll_no int ,
   std_name varchar(20) not null,
   std_class varchar(10) ,
   sub varchar(10) unique,
   total_num  int  check(total_num>40),
   primary key (roll_no) 
   );
   
   
/*  Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer. */

/* Ans.  You apply a NOT NULL constraint to a column to ensure that every record in that column always contains a valid value, preventing empty or missing data. A primary key, by definition, cannot contain NULL values because it must uniquely identify each row in a table */


/* Q4. . Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint */

/* ans. In SQL, constraints are used to enforce rules on data in a table. Common constraints include PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, and DEFAULT. Constraints can be added or removed from an existing table using the ALTER TABLE command. */

/* To add a constraint to an existing table, use the ALTER TABLE statement with the ADD CONSTRAINT clause. */
alter table employees  add constraint emp_age check (age>=18);

select * from employees;

/* Removing a Constraint
To remove a constraint from a table, use the ALTER TABLE statement with the DROP CONSTRAINT clause. */

alter table employees drop constraint emp_age;
select * from employees;


/* 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint. */ 

/* ans 
. PRIMARY KEY Violation
Scenario
A PRIMARY KEY ensures that each row in a table has a unique, non-null identifier. Trying to insert a duplicate value in a primary key column will cause an error. */

create table customer(customer_id int primary key,
                      customer_name varchar(20) ); 


insert into customer values (1005,"kirti");
insert into customer  values (1005,"ram"); # Error Code: 1062. Duplicate entry '1005' for key 'customer.PRIMARY'


/* 6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00 */

create table products (
      product_id int primary key,
      product_name varchar(50),
      price decimal(10,2) default(50.00));
      
      
      
/* you have two table student and class 
 Write a query to fetch the student_name and class_name for each student using an INNER JOIN. */


create table student( student_id int not null , student_name varchar(20), class_id int  );


# insert the data
 insert into student values 
       (1,"Alica",101),
       (2,"Bob",102),
       (3,"Charlie",101);
       
select * from student;
    
    
    
# class 
create table class(class_id int,class_name varchar(10));

insert into class values
  (101,"Math"),
  (102,"Science"),
  (103,"History");
  
  select student_name,class_name 
  from student inner join class
  on
  student.class_id = class.class_id;
  
  
  /*  Consider the following three tables:
  order,customer, product 
  
  Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN)5 */

create table orders (order_id int, order_date date, customer_id int);

insert into orders values
    (1,"2024-01-01",101),
    (2,"2024-01-03",102);
    
select * from orders;

create table customers(customer_id int , customer_name varchar(20));
insert into customers values
         (101,"Alice"),
         (102,"Bob");
         
select * from customers;

create table products(product_id int, product_name varchar(10), order_id int);

insert into products values
    (1,"Laptop",1),
    (2,"Phone",Null);
    
select * from products;

with cust as
(select customer_name ,customer_id
from customers ),
product as
(select order_id ,product_name from products )
select customer_name,product_name
from  orders inner join cust
on
orders.customer_id = cust.customer_id
left join product 
on
orders.order_id = product.order_id ;



/* Q9.  Given the following tables: 
  sales and products
  Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function. */
  
  create table sales (sales_id int, product_id  int, amount int);

insert into sales values
       (1,101,500),
       (2,102,300),
       (3,101,700);
       
select * from sales;
      
create table products(product_id int, product_name varchar(30));
insert into products values
  (101,"Laptop"),
  (102,"Phone");
select * from products;
drop table products;

select sum(amount) as total_amount
from sales inner join products
on
sales.product_id = products.product_id;

select sum(amount) as total_amount from sales;

/*  . You are given three tables: 
orders,customers,order_details 
 Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables. */

create table orders (order_id int, order_date date, customer_id int);

insert into orders values
    (1,"2024-01-01",101),
    (2,"2024-01-03",102);
    
select * from orders;

create table customers(customer_id int , customer_name varchar(20));
insert into customers values
         (101,"Alice"),
         (102,"Bob");
         
select * from customers;

create table order_details(order_id int ,product_id int, quantity int );

insert into  order_details values 
   (1,101,2),
   (1,102,1),
   (2,101,3);
   
select * from order_details;

with cus as
(select customer_id,customer_name 
from customers ),
dlt as
(select order_id ,quantity from order_details)
select customer_name,quantity
from orders inner join cus 
on orders.customer_id = cus.customer_id
inner join dlt
on
orders.order_id = dlt.order_id;


# SQL Commands  
/* Q1. Identify the primary keys and foreign keys in maven movies db. Discuss the differences */
/* 1-The primary key doesn't allow null values. The foreign key accepts multiple null values. */

use Mavenmovies;

/* 2- List all details of actors */
select * from actor;

/* # - List all customer information from DB. */
select * from customer;

/* 4- List different countries */
select country from country;

/* 5- Display all active customers. */

select active from customer;

/* 6- List of all rental IDs for customer with ID 1 */
use mavenmovies;
select rental_id from rental
where customer_id = 1;

/* 7-  Display all the films whose rental duration is greater than 5  */  
select film_id,title,description from film
where rental_duration > 5;

/* 8- - List the total number of films whose replacement cost is greater than $15 and less than $20  */

select sum(film_id) as total_num_of_film from film
where replacement_cost<20 and replacement_cost>15;

/* 9- Display the count of unique first names of actors */
select count(distinct first_name) as unique_first_name from actor;



/* 10 - Display the first 10 records from the customer table .*/
select * from customer
limit 10;



/*11- - Display the first 3 records from the customer table whose first name starts with ‘b’ */
select * from customer
where first_name like "b%"
limit 3;


/* 12-  -Display the names of the first 5 movies which are rated as ‘G’*/
select * from film
where rating like "G"
limit 5;

/* 13- -Find all customers whose first name starts with "a" */
select * from customer
where first_name like "a%";


/* 14- Find all customers whose first name ends with "a". */

select * from customer
where first_name like "%a";

/* 15-    Display the list of first 4 cities which start and end with ‘a’ . */

select city from city
where city like "%a%"
limit 4;


/* 16- Find all customers whose first name have "NI" in any position */

select * from customer
where first_name like "NI";

/* 17-   - Find all customers whose first name have "r" in the second position  */
select * from customer
where first_name like"_r%";

/* 18-  Find all customers whose first name starts with "a" and are at least 5 characters in length */
select * from customer 
where first_name like "a____%";


/* 19-  Find all customers whose first name starts with "a" and ends with "o" */

select * from customer
where first_name like "a%%o";

/* 20 -  Get the films with pg and pg-13 rating using IN operator */
select film_id,title,rating from film
where rating in ("PG","PG-13");

/* 21- Get the films with length between 50 to 100 using between operator*/
select  film_id,title,length from film
where  length between 50 and 100;

/* 22-  Get the top 50 actors using limit operator */
select * from actor
limit 50;

/* 23- Get the distinct film ids from inventory table */

select count(distinct film_id) from inventory;



/* Functions
 Basic Aggregate Functions:
 Question 1:
 Retrieve the total number of rentals made in the Sakila database.
 Hint: Use the COUNT() function */
 
 use sakila;
 select count(rental_id) as total_rentals from rental;
 
 
 /*Question 2:
 Find the average rental duration (in days) of movies rented from the Sakila database.
 Hint: Utilize the AVG() function */
 
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental;
 
 
 
 
 /* String Functions:
 Question 3:
 Display the first name and last name of customers in uppercase.
 Hint: Use the UPPER () function */
 
 select upper(first_name) as upper_first_name, upper(last_name) as upper_last_name from   customer;
 
 
 /* Question 4:
 Extract the month from the rental date and display it alongside the rental ID.
 Hint: Employ the MONTH() function. */
 
 select month(rental_date) as Month_number, monthname(rental_date) as rental_month_name , rental_id  from rental;
 
 
 /*  GROUP BY:
 Question 5:
 Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 Hint: Use COUNT () in conjunction with GROUP BY */
 
 select customer_id,count(rental_id) as rental  
 from rental
 group by customer_id;
 
 /*  Question 6:
 Find the total revenue generated by each store.
 Hint: Combine SUM() and GROUP BY. */
 

 SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

 
 

 
 
 /*  Question 7:
 Determine the total number of rentals for each category of movies.
 Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY. */
 

select * from category;
select * from film_category;



select  name as category_name , count(rental_id) as total_rental 
from 
category join film_category 
on 
category.category_id = film_category.category_id 
join inventory
on inventory.film_id = film_category.film_id
join rental
on
rental.inventory_id = inventory.inventory_id
group by name
order by total_rental; 

 

 
 /*  Question 8:
 Find the average rental rate of movies in each language.
 Hint: JOIN film and language tables, then use AVG () and GROUP BY. */
 
 select * from language;
 select *  from rental;
 
 select name as language_name , avg(rental_rate) as avg_rental
 from 
 language join film 
 on 
 language.language_id = film.language_id 
group by name;


/* Joins
 Questions 9 -
 Display the title of the movie, customer s first name, and last name who rented it.
 Hint: Use JOIN between the film, inventory, rental, and customer tables. */
 
 select first_name,last_name,title  as movie_title
 from customer 
 join inventory 
 on 
 customer.store_id = inventory.store_id
 join film
 on
 film.film_id = inventory.film_id
 join rental
 on
 rental.inventory_id = inventory.inventory_id;
 
 
 /* Question 10:
 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 Hint: Use JOIN between the film actor, film, and actor tables */
 
 select first_name ,last_name
 from actor join film_actor
 on
 actor.actor_id = film_actor.actor_id
 join film
 on
 film.film_id = film_actor.film_id
where title = 'Gone with the Wind';


/*   Question 11:
 Retrieve the customer names along with the total amount they've spent on rentals.
 Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY */
 
 select first_name, last_name,sum(amount) as rentals from
 customer join payment on customer.customer_id = payment.customer_id 
 join rental on rental.rental_id = payment.rental_id
 group by customer.first_name,last_name;
 
 
 /*  Question 12:
 List the titles of movies rented by each customer in a particular city (e.g., 'London').
 Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY. */
 
 
 select city as city_name ,first_name,last_name,title as movie_title from
 address join city on address.city_id = city.city_id
 join customer on customer.address_id = address.address_id
 join inventory on inventory.store_id = customer.store_id
 join film on film.film_id = inventory.film_id 
 join rental on rental.inventory_id = inventory.inventory_id
 where city = "London"
 ORDER BY
    last_name,
    first_name,
    title;
 
 /*  Advanced Joins and GROUP BY:
 Question 13:
 Display the top 5 rented movies along with the number of times they've been rented.
 Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results */
 
 select rental_duration,title,count(rental_id) as rental  from
 film join inventory on film.film_id = inventory.film_id 
 join rental on rental.inventory_id = inventory.inventory_id 
 group by title,length,rental_duration
  limit 5;
  
  
  /*  Question 14:
 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
 Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY */
 
 SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE
    i.store_id IN (1, 2)
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING
    COUNT(DISTINCT i.store_id) = 2;


/* Windows Function:
 1. Rank the customers based on the total amount they've spent on rentals */  
 use sakila;
 select first_name,last_name ,sum(amount) as total_spent ,rank() over(order by sum(amount) desc ) as rank_
 from customer join payment
 on customer.customer_id = payment.customer_id 
 join rental on rental.rental_id = payment.rental_id
 group by first_name,last_name;
 
 
 /* 2. Calculate the cumulative revenue generated by each film over time */
 
 select film.film_id,title,payment_date, sum(amount) over(partition  by film_id order by rental_date) as cumulative_revenue
 from film join inventory on inventory.film_id = film.film_id
 join rental on rental.inventory_id = inventory.inventory_id
 join  payment on payment.rental_id = rental.rental_id;
 
 
 
 /*  3. Determine the average rental duration for each film, considering films with similar lengths. */
 use sakila;
 select film.film_id ,length , avg(datediff(return_date,rental_date)) as avg_rental_duration
 from film join inventory on inventory.film_id = inventory.film_id
 join rental on inventory.inventory_id = rental.inventory_id
 group by film.film_id,length;
 
 /*  4. Identify the top 3 films in each category based on their rental counts. */



WITH FilmRentalCounts AS (
select name ,title ,count(rental.rental_id) as rental_count ,
rank() over(partition by name order by count(rental.rental_id) desc) as rank_amount from category join film_category on film_category.category_id = category.category_id
join film on film.film_id = film_category.film_id
join inventory on film.film_id = inventory.film_id
join rental on rental.inventory_id = inventory.inventory_id
group by name,title )
select title,name,rental_count
from FilmRentalCounts
WHERE rank_amount <= 3
order by name,rank_amount;
 



 
 /* 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
 across all customers. */
 
 WITH CustomerRentalCounts AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
AverageRentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM CustomerRentalCounts
)
SELECT 
    crc.customer_id,
    crc.customer_name,
    crc.total_rentals,
    ar.avg_rentals,
    (crc.total_rentals - ar.avg_rentals) AS rental_difference
FROM CustomerRentalCounts crc
CROSS JOIN AverageRentals ar
ORDER BY rental_difference DESC;

 
 /* 6. Find the monthly revenue trend for the entire rental store over time */
 use sakila;
 select monthname(payment_date)as monthname, sum(amount) as total_revenue from  payment
 group by payment_date;
 
 /* 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers*/
WITH customer_spending AS (
    SELECT 
        customer_id, 
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
), ranked_customers AS (
    SELECT 
        customer_id, 
        total_spent,
        NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_rank
    FROM customer_spending
)
SELECT customer_id, total_spent
FROM ranked_customers
WHERE spending_rank = 1
ORDER BY total_spent DESC;


/*  8. Calculate the running total of rentals per category, ordered by rental count*/
with some as (
select c.name as category  ,count(r.rental_id) as rental_count
from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id 
group by c.name),
running as
(select 
category,rental_count,sum(rental_count) over(order by rental_count desc) as running_count from some )
select * from running;

/* 9. Find the films that have been rented less than the average rental count for their respective categories */

WITH category_avg AS (
    SELECT 
        c.category_id,
        c.name AS category_name,
        AVG(film_rentals.rental_count) AS avg_rental_count
    FROM (
        SELECT 
            f.film_id, 
            fc.category_id, 
            COUNT(r.rental_id) AS rental_count
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        JOIN film_category fc ON f.film_id = fc.film_id
        GROUP BY f.film_id, fc.category_id
    ) AS film_rentals
    JOIN category c ON film_rentals.category_id = c.category_id
    GROUP BY c.category_id, c.name
)
SELECT 
    f.film_id,
    f.title,
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count,
    ca.avg_rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN category_avg ca ON c.category_id = ca.category_id
GROUP BY f.film_id, f.title, c.name, ca.avg_rental_count
HAVING COUNT(r.rental_id) < ca.avg_rental_count
ORDER BY c.name, rental_count ASC;


/* 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month */
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;
 
 
 /* Normalisation & CTE
 1. First Normal Form (1NF):
               a. Identify a table in the Sakila database that violates 1NF. Explain how you
               would normalize it to achieve 1NF */ 
 /*               What is 1NF?
A table is in First Normal Form (1NF) if:

All columns contain atomic (indivisible) values.
Each column contains values of a single type.
Each row has a unique identifier (Primary Key).
There are no repeating groups or arrays.
               Table in Sakila that Violates 1NF: film Table
The film table in the Sakila database has a special_features column, which stores multiple values in a single field (comma-separated values such as 'Trailers,Commentaries,Deleted Scenes').
*/
 create database Sakilaa;
 use Sakilaa;
 
 CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR,
    language_id TINYINT NOT NULL,
    original_language_id TINYINT DEFAULT NULL,
    rental_duration TINYINT NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT 'G',
    special_features SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes'),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  
);

 
 CREATE TABLE film_special_feature (
    film_id INT,
    special_feature VARCHAR(50),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO film_special_feature (film_id, special_feature)
SELECT film_id, TRIM(value)
FROM film, 
     JSON_TABLE(
         CONCAT('["', REPLACE(special_features, ', ', '","'), '"]'), 
         '$[*]' COLUMNS (value VARCHAR(50) PATH '$')
     ) AS special_feature_split;

ALTER TABLE film DROP COLUMN special_features;










/*  2. Second Normal Form (2NF):
               a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
            If it violates 2NF, explain the steps to normalize it. */
            
            
/* econd Normal Form (2NF) builds upon the principles of First Normal Form (1NF) by ensuring that there are no partial dependencies of any column on the primary key.
 This means that non-key attributes must be fully functionally dependent on the entire primary key, not just a part of it.
 
 Evaluating the film_actor Table

The film_actor table records the association between films and actors. Its structure is as follows:

Primary Key: Composite key consisting of actor_id and film_id.

Non-Key Attributes: last_update.

To assess 2NF compliance:

Functional Dependency: The last_update attribute depends on both actor_id and film_id.
Since there are no partial dependencies (i.e., last_update does not depend solely on actor_id or film_id), the film_actor table complies with 2NF. */



CREATE TABLE actor (
    actor_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    actor_name VARCHAR(255) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE film_actor (
    actor_id SMALLINT NOT NULL,
    film_id int ,
    actor_name VARCHAR(255),  -- Problematic column
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

            
/* 3. Third Normal Form (3NF):
a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
present and outline the steps to normalize the table to 3NF */

/* . Identifying a Violation of 3NF in the film Table
The 3rd Normal Form (3NF) requires that:

The table must be in 2NF.
It should not have transitive dependencies—i.e., no non-key attribute should depend on another non-key attribute.
In the film table, we have the following columns:

film_id (Primary Key)
title
description
release_year
language_id (Foreign Key referencing language table)
original_language_id
rental_duration
rental_rate
length
replacement_cost
rating
special_features
Transitive Dependency Example:
The column rating (e.g., PG, R, G) and special_features (e.g., Deleted Scenes, Behind the Scenes) are dependent on the type of movie, not directly on film_id. This creates a transitive dependency
 because rating and special_features are characteristics of a film category or genre, not the film itself.*/

CREATE TABLE country (
    country_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE city (
    city_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country_id SMALLINT NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address (
    address_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) DEFAULT NULL,
    district VARCHAR(20) NOT NULL,
    city_id SMALLINT NOT NULL,
    postal_code VARCHAR(10) DEFAULT NULL,
    phone VARCHAR(20) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE customer (
    customer_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    store_id TINYINT NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50) DEFAULT NULL,
    address_id SMALLINT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    create_date DATETIME NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

describe customer;
describe city;
describe address;



/*  4. Normalization Process:
               a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
            unnormalized form up to at least 2NF */
            
            
            CREATE TABLE language (
    language_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
 
 
 CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR,
    language_id TINYINT NOT NULL,
    original_language_id TINYINT DEFAULT NULL,
    rental_duration TINYINT NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT 'G',
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    FOREIGN KEY (original_language_id) REFERENCES language(language_id)
);

CREATE TABLE film_special_feature (
    film_id INT NOT NULL,
    special_feature VARCHAR(50) NOT NULL,
    PRIMARY KEY (film_id, special_feature),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE TABLE actor (
    actor_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE film_actor (
    actor_id SMALLINT NOT NULL,
    film_id int,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);



/* 
5. CTE Basics:
                a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
                have acted in from the actor and film_actor tables */
            

WITH ActorFilmCount AS (
    SELECT 
        fa.actor_id, 
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name, 
        COUNT(fa.film_id) AS film_count
    FROM film_actor fa
    JOIN actor a ON fa.actor_id = a.actor_id
    GROUP BY fa.actor_id, actor_name
)
SELECT * FROM ActorFilmCount
ORDER BY film_count DESC;


/* 6. CTE with Joins:
                a. Create a CTE that combines information from the film and language tables to display the film title, 
                 language name, and rental rate */ 
                 
with languagefilminfo as (
select 
   f.title as film_title,
   l.name as language_name,
   f.rental_rate
   from language l join film f on
   l.language_id = f.language_id 
   )
select * from languagefilminfo 
order by rental_rate desc;

/*   7. CTE for Aggregation:
               a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
                from the customer and payment tables. */
                
use sakila;

WITH CustomerRevenue AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM CustomerRevenue
ORDER BY total_revenue DESC;

                
                
 /* 8.CTE with Window Functions:
               a. Utilize a CTE with a window function to rank films based on their rental duration from the film table. */ 
			with filmrank as 
            (
	         select title,film_id,rank() over(order by rental_duration) as rank_ from film)
             select * from filmrank
             order by rank_,title;
               
               
  /*  9. CTE and Filtering:
               a. Create a CTE to list customers who have made more tthan two rentals, and then join this CTE with the 
            customer table to retrieve additional customer details. */ 
            
	with customer_rental as
    ( select  customer_id,count(rental_id) as rental_count from rental
    group by customer_id
    having count(rental_id) >2 )
    select 
    store_id,first_name,last_name,email,address_id,active,create_date,last_update,customer.customer_id, cr.rental_count
    from customer join customer_rental  cr on cr.customer_id = customer.customer_id
    order by cr.rental_count desc;
  
            
/* 10.CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the 
rental_date from the rental table */

with rentalmonth as 
(select count(rental_id) , monthname(rental_date) as month_name from rental 
group by month_name
order by month_name)
select * from rentalmonth;


/* 11. CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
together, using the film_actor table */  

WITH ActorFilms AS (
    SELECT 
        film_id, 
        actor_id 
    FROM film_actor
)
SELECT 
    af1.film_id,
    af1.actor_id AS actor_1,
    af2.actor_id AS actor_2
FROM ActorFilms af1
JOIN ActorFilms af2 
    ON af1.film_id = af2.film_id 
    AND af1.actor_id < af2.actor_id
ORDER BY af1.film_id, af1.actor_id, af2.actor_id;





 /* 12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
considering the reports_to column*/
   select * from staff;
   
   
   WITH RECURSIVE StaffHierarchy AS (
    -- Base case: Find the direct reports of the given manager
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        active
    FROM staff
    WHERE active = 1  -- Replace with the manager's staff_id

    UNION ALL

    -- Recursive case: Find employees reporting to those found in the base case
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.active
    FROM staff s
    INNER JOIN StaffHierarchy sh ON s.active = sh.staff_id
)
SELECT * FROM StaffHierarchy;

   

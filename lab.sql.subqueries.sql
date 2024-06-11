-- How many copies of the film Hunchback Impossible exist in the inventory system?

select count(*) as number_of_copies
from inventory i
where film_id in (
     select film_id
     from film 
     where title = 'Hunchback Impossible'
);

-- List all films whose length is longer than the average of all the films.

select title, length
from film
where length > (select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

select actor_id, first_name, last_name
from actor
where actor_id in (
     select actor_id
	 from film_actor
     where film_id = (
        select film_id
        from film
        where title = 'Alone Trip'
    )
);
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select title
from film 
where film_id in (
	select film_id
    from film_category
    where category_id = (
    select category_id
    from category
    where `name` = 'Family')
);


-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select first_name, last_name, email
from customer
where address_id in(
    select address_id
	from address
    where city_id in(
    select city_id
    from city
    where country_id = (
    select country_id
    from country
    where country = 'Canada')
));

SELECT first_name, last_name, email 
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select f.title, a.last_name
from film f
join(
select a.last_name
from actor a
where a.last_name=(
max(count(f.film_id))
));


-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select a.actor_id, a.first_name, a.last_name, count(f.film_id) as film_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
group by a.actor_id, a.last_name
order by film_count desc
limit 1;



-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having sum(amount)>( select avg (amount) from payment)
order by total_amount_spent desc
limit 10;

 


-- Lab | SQL Join (Part II)
USE sakila;
-- In this lab, you will be using the Sakila database of movie rentals.
-- Instructions


-- 1. Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id AS 'Store ID',
    c.city AS 'City',
    cy.country AS 'Country'
FROM
    store AS s
        JOIN
    address AS a ON a.address_id = s.address_id
        JOIN
    city AS c ON c.city_id = a.city_id
        JOIN
    country AS cy ON cy.country_id = c.country_id
ORDER BY s.store_id;



-- 2. Write a query to display how much business, in dollars, each store brought in.
	SELECT 
    CONCAT(c.city, ', ', cy.country) AS `Store`,
    s.store_id AS 'Store ID',
    SUM(p.amount) AS `Sales in total`
FROM
    payment AS p
        JOIN
    rental AS r ON r.rental_id = p.rental_id
        JOIN
    inventory AS i ON i.inventory_id = r.inventory_id
        JOIN
    store AS s ON s.store_id = i.store_id
        JOIN
    address AS a ON a.address_id = s.address_id
        JOIN
    city AS c ON c.city_id = a.city_id
        JOIN
    country AS cy ON cy.country_id = c.country_id
GROUP BY s.store_id;


-- 3. Which film categories are longest?
SELECT 
    category.name, AVG(length)
FROM
    film
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
GROUP BY category.name
HAVING AVG(length) > (SELECT 
        AVG(length)
    FROM
        film)
ORDER BY AVG(length) DESC;


-- 4. Display the most frequently rented movies in descending order.
SELECT 
    f.title AS 'Movie', COUNT(r.rental_date) AS 'Times Rented'
FROM
    film AS f
        JOIN
    inventory AS i ON i.film_id = f.film_id
        JOIN
    rental AS r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_date) DESC;


-- 5. List the top five genres in gross revenue in descending order.
	SELECT 
    c.name AS 'Film', SUM(p.amount) AS 'Gross Revenue'
FROM
    category AS c
        JOIN
    film_category AS fc ON fc.category_id = c.category_id
        JOIN
    inventory AS i ON i.film_id = fc.film_id
        JOIN
    rental AS r ON r.inventory_id = i.inventory_id
        JOIN
    payment AS p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    film.film_id,
    film.title,
    store.store_id,
    inventory.inventory_id
FROM
    inventory
        JOIN
    store USING (store_id)
        JOIN
    film USING (film_id)
WHERE
    film.title = 'Academy Dinosaur'
        AND store.store_id = 1;


-- 7. Get all pairs of actors that worked together.
SELECT 
    f.film_id,
    f2.actor_id,
    f3.actor_id,
    CONCAT(a1.first_name, ' ', a1.last_name),
    CONCAT(a2.first_name, ' ', a2.last_name)
FROM
    film f
        INNER JOIN
    film_actor f2 ON f.film_id = f2.film_id
        INNER JOIN
    actor a1 ON f2.actor_id = a1.actor_id
        INNER JOIN
    film_actor f3 ON f.film_id = f3.film_id
        INNER JOIN
    actor a2 ON f3.actor_id = a2.actor_id
Where CONCAT(a1.first_name, ' ', a1.last_name)<>CONCAT(a2.first_name, ' ', a2.last_name);

-- 8. Get all pairs of customers that have rented the same film more than 3 times.


-- 9. For each film, list actor that has acted in more films.
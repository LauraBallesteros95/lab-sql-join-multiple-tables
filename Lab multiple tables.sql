-- Lab | SQL Joins on multiple tables
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, a.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- What is the average running time of films by category?
SELECT cat.name AS category, AVG(film.length) AS average_running_time
FROM film_category fc
JOIN film film ON fc.film_id = film.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name;

-- Which film categories are longest?
SELECT cat.name AS category, AVG(film.length) AS average_running_time
FROM film_category fc
JOIN film film ON fc.film_id = film.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY average_running_time DESC;

-- Display the most frequently rented movies in descending order.
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;

-- List the top five genres in gross revenue in descending order.
SELECT cat.name AS genre, SUM(p.amount) AS gross_revenue
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY cat.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title AS movie_title, s.store_id AS store, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;

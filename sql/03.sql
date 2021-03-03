/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */
SELECT DISTINCT(c.customer_id)
FROM customer c
INNER JOIN rental USING (customer_id)
INNER JOIN inventory USING (inventory_id)
WHERE film_id in(
	SELECT film_id
	FROM film
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
	INNER JOIN payment USING (rental_id)
	GROUP BY film_id
	ORDER BY SUM(amount) DESC
	LIMIT 5)
ORDER BY c.customer_id;

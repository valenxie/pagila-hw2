/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * HINT:
 * This can be solved either with a LEFT JOIN or with the NOT IN operator.
 * You may choose whichever solution makes the most sense to you.
 */
SELECT DISTINCT(title)
FROM film
LEFT JOIN  inventory USING (film_id)
WHERE film_id NOT IN (
        SELECT DISTINCT film_id
        FROM film
        INNER JOIN inventory USING (film_id)
        INNER JOIN rental USING (inventory_id)
        INNER JOIN customer USING (customer_id)
        INNER JOIN address USING (address_id)
        INNER JOIN city USING (city_id)
        INNER JOIN country USING (country_id)
        WHERE country = 'United States' ) 
        AND inventory.film_id IS NOT NULL
ORDER BY title;

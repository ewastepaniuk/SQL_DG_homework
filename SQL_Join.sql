use sakila16_77;

/* zad.1 Wpłaty i wypożyczenia */
select * from rental; -- rental_id, rental_date
select * from payment; -- payment_id, rental_id, amount, payment_date
select * from inventory;
-- select  * from film;

select rental_id, rental_date, payment_date, amount, payment_date
    from rental as ren
join payment as pay
using (rental_id);

/* zad.2 Wypożyczenia i stany magazynowe */
select inv.inventory_id, rental_id, film_id
    from rental as ren
join inventory as inv
using(inventory_id);

/* zad.3 Wypożyczenia filmu */
select inventory_id, f.film_id, title, description, release_year
    from film f
join inventory as inv
using(film_id);

/* zad.4 Raport wypożyczeń */
select
    rent.rental_id as "id wypożyczenia"
    ,f.film_id as "id filmu"
    ,title as "tytuł filmu"
    ,description as "opis filmu"
    ,rating as "rating filmu"
    ,rental_rate as "ocena wypożyczenia"
    ,rental_date as "data wypożyczenia"
    ,payment_date as "data płatności"
    ,amount as "kwota płatności"
    from
        rental as rent
join payment as pay
    using(rental_id)
join inventory as inv
    using(inventory_id)
join film as f
        using(film_id)
;

/* zad.5 Wypożyczenia nieopłacone */
select  * from tasks16_77.payment;
select * from rental;

select * from tasks16_77.payment as tsk_pay
right join
    rental as rent
using(rental_id)
where tsk_pay.payment_id IS NULL;

/* UPDATE */
select * from tasks16_77.city_country; -- country id
select * from country; -- country id

update
tasks16_77.city_country as cc
join country using (country_id)
set cc.country = country.country
where cc.country is null;

-- sprawdzenie:
select * from tasks16_77.city_country
where country is null; -- brak rekordów oznacza poprawne wykonanie.

/* DELETE */
select * from tasks16_77.films_to_be_cleaned;
select * from film_category;

DELETE ftbc  -- moje rozwiązanie
from tasks16_77.films_to_be_cleaned as ftbc
join film_category as fc using(film_id)
where
    ftbc.length < 60
  and
    fc.category_id IN (1, 5, 7, 9)
  and
    ftbc.rating NOT IN ('NC-17', 'PG');

DELETE f -- sposób z zajęć - nie mam pojęcia jak wyświetlić jeszcze kolumnę category.
FROM
        tasks16_77.films_to_be_cleaned AS f
    INNER JOIN
        film_category AS c USING (film_id)
WHERE c.category_id IN (1, 5, 7, 9)
    AND  f.length < 60
    AND rating NOT IN ('NC-17','PG')
;

-- sprawdzenie:
SELECT *
FROM tasks16_77.films_to_be_cleaned
JOIN film_category ON tasks16_77.films_to_be_cleaned.film_id = film_category.film_id
WHERE film_category.category_id IN (1, 5, 7, 9)
AND tasks16_77.films_to_be_cleaned.length < 60
AND tasks16_77.films_to_be_cleaned.rating NOT IN ('NC-17', 'PG');  -- poprawne


/*  INSERT  INTO */  -- DO PRZEĆWICZENIA ONCE AGAIN!!!
select * from tasks16_77.california_payments as tcp
join payment as p using(payment_id);

select * from payment as p
join staff as s using(staff_id);

select * from staff as s
join address as adr using (address_id)

    ;
select  * from payment; -- stąd payment id
select * from staff;  -- stąd address id | nie może być stąd bo to jest 1:n, a potrzebujemy n:n, żeby zaciągnąć dane
select * from address; -- stąd district 'California'
select * from tasks16_77.california_payments;

use sakila16_77;

INSERT INTO tasks16_77.california_payments
select p.* from payment as p
inner join
    customer as c using(customer_id)
inner join
    address as adr using(address_id)
where district like 'California';

select * from tasks16_77.california_payments;

-- sprawdzenie, w wyniku którego dostaniemy districts, których nie ma standardowo w tabeli tasks_cp
select distinct a.district from tasks16_77.california_payments
inner join customer c using(customer_id)
inner join address a using(address_id);

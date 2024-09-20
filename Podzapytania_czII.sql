use sakila16_77;

/*  Napisz kwerendę, która wyświetli filmy z kategorii Horror, Documentary, Family o ratingu R lub NC-17.
Używając wyników poprzedniego zadania oraz sakila.film_text, wyświetl opisy tych filmów.
Dodatkowo:
3. Posortuj sakila.film_list według klucza Category - rosnąco, Price - malejąco.
4. Posortuj sakila.film_list według klucza Rating - rosnąco, Length - malejąco. */

/* ad. 2 */ with abc as ( -- abc zastępuje tutaj nową tabelę tymczas, z tylko jednym rekordem, będącym wynikiem warunku.
select
    * -- ad. 1, 3, 4
   -- FID -- ad. 2
from film_list
where category in ('Horror', 'Documentary', 'Family')
and rating in ('R', 'NC-17')
-- order by category, price desc -- ad.3
-- order by rating, length desc -- ad. 4
    )
select * from film_text
where film_id in (select FID from abc)
    ;

-- statystyki filmów
select * from rating_analytics
-- ad 1. null
-- ad.2 Znajdź te ratingi, które są wyższe od średniej wyznaczonej dla wszystkich filmów, bez podziału na rating:
where rating_analytics.avg_rental_rate > (select avg_rental_rate from rating_analytics where rating IS NULL);

/* sposób z kluzulą with */
with abc as(
    select avg_rental_rate
        from rating_analytics
        where rating IS NULL
)
select * from rating_analytics
where avg_rental_rate > (select * from abc);

-- ad.3 Znajdź te ratingi, których średni czas wypożyczenia jest krótszy od średniej globalnej.
with abc as(
    select avg_rental_duration
        from rating_analytics
        where rating IS NULL
)
select *
    from rating_analytics
where rating_analytics.avg_rental_duration < (select * from abc)
;

-- Używając podzapytania wyświetl statystyki dla id_rating = 3.
select * from rating_analytics where rating = (select rating from rating where id_rating = 3);
select * from rating_analytics where rating IN (select rating from rating where id_rating in (3,2,5));

-- Napisz kwerendę, która powie, który rating cieszy się największą popularnością,
select rating from rating_analytics
where rentals = (select MAX(rentals) from rating_analytics where rating IS NOT NULL);

-- Napisz kwerendę, która odpowie, z którego ratingu filmy są średnio najkrótsze.
select rating, avg_film_length from rating_analytics
-- order by avg_film_length
-- lub
where avg_film_length = (select min(avg_film_length)from rating_analytics);

-- statystyki aktorów
select * from actor;
select * from actor_analytics;

with abc as (
    select actor_id
        from actor
        where first_name like 'zero' and last_name like 'cage'
)
select * from actor_analytics
where actor_id = (select * from abc); -- zad.1

-- zad.2&3 / Wyświetl aktorów, którzy grali w co najmniej 30 filmach.
select
    first_name
    ,last_name
    ,films_amount
    ,actor_id
    from actor_analytics
where films_amount >= 30 order by films_amount, last_name;

/*
zad.4 / znajdź tych aktrów dla których najdłuższy film w którym zagrali (kolumna longest_movie_duration)
trwał 184 lub 174 lub 176 lub 164. */

-- with actor_abd as ( -- 5a
                select first_name
                    , last_name
                    , longest_movie_duration
                    , actor_id
               from actor_analytics
               where longest_movie_duration in (184, 174, 176, 164)
               order by longest_movie_duration desc, last_name
--          )
;

-- 5. Następnie użyj tabeli sakila.film_actor, aby uzyskać pełną listę filmów, w których ci aktorzy grali (B).
with LoMoDu as (select first_name, last_name, longest_movie_duration
            from actor_analytics
            where longest_movie_duration in (184, 174, 176, 164)
            )
, actor_film as
    (
    select *
    from film_actor
    where actor_id in (select actor_id from LoMoDu)
    )
select film_id, title, description, length from film
where length in (184, 175, 176, 164)
and film_id in (select film_id from actor_film)
;



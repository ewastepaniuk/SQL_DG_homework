use sakila16_77;
-- Napisz zapytania, które wyświetlą informacje (sakila.rental) na podstawie poniższych kryteriów:

-- o wypożyczeniach z roku 2005,
select customer_id, rental_date, return_date
from rental
where rental_date like '2005-%';

-- o wypożyczeniach z dnia 2005-05-24,
select
    customer_id, rental_date, return_date
from
    rental
where
    rental_date like '2005-05-24%';

-- o wypożyczeniach po 2005-06-30,
select customer_id, rental_date, return_date
    from rental
where rental_date > '2005-06-30%';

-- o wypożyczeniach w trakcie wakacji, tj. pomiędzy 2005-06-30 a 2005-08-31 od pracownika Jon'a.

select staff_id, first_name
    from staff; -- sprawdzanie id Jon'a >> 2

select
    staff_id
    ,rental_id
    ,rental_date
    ,return_date
  from rental
  where
    staff_id = 2
    and
    rental_date between '2005-06-30%' and '2005-08-31%';

/* Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
- wszystkich aktywnych klientów,
- wszystkich aktywnych klientów albo tych, którzy zaczynają się od 'ANDRE'.
*/

select
    -- *
    customer_id
     ,first_name
     ,last_name
     ,email
     ,active
from customer
where
  active = 1 xor -- równoległa odpowiedź na dwa pytania, wystarczy usunąć znacznik komentarza przez <active>
  first_name like 'ANDRE%'
;

/*
1. wszystkich nieaktywnych klientów ze store_id= 1
2. klientów, którzy mają adres email w innej domenie niż sakilacustomer.org. Czy istnieją tacy?
3. klientów o unikalnych wartościach w kolumnie create_date.
 */

 select
     *
 -- ,
 from customer
 where
  active = 0 and store_id = 1 -- ex.1
  -- email not like '%sakilacustomer.org' -- ex.2
 ;

select distinct -- ex.3 v1 (zwraca 3 kolumny unikalnych wartości)
    create_date, last_name, customer_id
  from customer;

select * -- zwraca wszystko | filtrowanie zaawansowane
from customer
where create_date in
(select distinct create_date);

select * from actor_analytics;
select *
    from actor_analytics
where
    -- films_amount >= 25 -- wyświetlą aktorów, którzy grali w ponad 25 filmach
    films_amount > 20 and avg_film_rate > 3.3 -- wyświetla aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3,
    or actor_payload > 2000 -- grali w ponad 20 filmach i ich średni rating przekracza 3.3 lub wpływy z wypożyczeń (actor_payload) przekroczyły 2000.
    ;


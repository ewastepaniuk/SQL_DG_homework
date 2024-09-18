use sakila16_77;

select -- aliasowanie
    rental_id, inventory_id, customer_id
    ,rental_date date_of_rental
    ,return_date date_of_rental_return
    from rental;

select -- aliasowanie
    rental_id "id wypożyczenia"
    ,inventory_id "id przedmiotu"
    ,rental_date "data wypożyczenia"
    ,return_date "data zwrotu"
    from rental;

select -- formatowanie dat
    payment_date
    ,DATE_FORMAT(payment_date, '%Y-%m-%d') ad1
    ,DATE_FORMAT(payment_date, '%Y-%M-%a') ad2
    ,DATE_FORMAT(payment_date, '%Y-%u') ad3
    ,DATE_FORMAT(payment_date, '%Y-%m-%d %a') ad4
    ,DATE_FORMAT(payment_date, '%Y-%m-%d %w') ad5
    from payment;

select -- Predefiniowane formaty dat GET_FORMAT()
    payment_date
    ,DATE_FORMAT(payment_date, GET_FORMAT(DATETIME,'USA')) payment_date_usa_formatted -- Predefiniowane formaty dat GET_FORMAT()
    from payment;

select -- Least()
    title
    ,price
    ,length
    ,rating
   -- ,least(price,length)
    ,least(price, length, rating)
from film_list;

select -- typ danych 'char' jest cieższy niż decimal czy smallint, stąd zwraca znaki jako dane o najwyższej wartości
    title
    ,price
    ,length
    ,rating
    ,greatest(price, length, rating)
    -- ,greatest(price,length)
    from film_list;
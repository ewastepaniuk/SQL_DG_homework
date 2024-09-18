use sakila16_77;

/* bez dodatkowej kolumny, ale z haczykiem opisanym niżej */

select first_name from customer
union
select first_name from actor
union
select first_name from staff;

/* z dodaniem kolumny, w której można zobaczyć z której tabeli pochodzi dane imię
(haczyk - customer zajmuje pierwszych 500 pozycji) */

SELECT * from customer;

desc customer; -- pokazuje szczegółowe info o tabeli consumer

SELECT first_name, 'customer' as category from customer
UNION
SELECT first_name, 'actor' as category from actor
UNION
SELECT first_name, 'staff' as category from staff;

/* Korzystając z własności, że UNION zwraca domyślnie zbiór, zmodyfikuj poniższą kwerendę tak,
   aby zwracała kategorię filmów (category) bez powtórzeń (nie używaj tutaj klauzuli DISTINCT):

    SELECT * FROM sakila.nicer_but_slower_film_list
   */

SELECT category FROM nicer_but_slower_film_list -- Ilość kolumn musi się zgadzać
UNION
SELECT category FROM nicer_but_slower_film_list;

select 'hello';
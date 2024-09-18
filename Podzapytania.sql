use sakila16_77;

desc sakila16_77.sales_by_store;
desc sakila16_77.sales_total;

/* Używając danych zawartych w sakila.sales_by_store oraz sakila.sales_total znajdź te sklepy,
   których całkowita sprzedaż przekracza połowę sprzedaży całkowitej wypożyczalni. */

select * from sales_by_store;
select * from sales_total;

select store -- mój sposób
    from sales_by_store
where
    total_sales > ((select  * from sales_total)/2);

select * -- sposób grupy
    from sales_by_store
where exists(
    select 1 or 0 -- obojętne co wstawisz, grunt żeby dodać tab. sales_total, bo inaczej nie ma z czego zaciągnąć
        from sales_total -- jak tego nie wstawisz to nie wie skąd ma wziąć dzielnik, czyli b  [a/b=c]
        where
        sales_by_store.total_sales / sales_total.total_sales > 0.5
);

select * from rating_analytics;
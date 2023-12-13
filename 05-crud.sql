set search_path = db_project, public;

-- table "client"

select first_name, last_name from client;

insert into client(first_name, last_name, login, password)
    values ('Алексей', 'Алексеев', 'alexxx1991', 'coolALEX_666');

update client
    set login = 'Alexxey', password = 'leshKKA777'
where first_name = 'Алексей' AND last_name = 'Алексеев';

delete from client
where first_name = 'Алексей' AND last_name = 'Алексеев';

-- table "product"

select name, price from product
where price >= 80000
order by price desc;

insert into product(name, description, price, quantity_available)
    values ('Материнская плата Gigabyte', null, 33000, 0);

update product
    set description = 'Очень крутая и быстрая'
where name = 'Материнская плата Gigabyte';

delete from product
where name = 'Материнская плата Gigabyte';

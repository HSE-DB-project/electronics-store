set search_path = db_project, public;
set datestyle = 'iso, dmy';

insert into client(first_name, last_name, login, password)
    values ('Иван', 'Петров', 'ivan123', 'qwerty123');
insert into client(first_name, last_name, login, password)
    values ('Елена', 'Иванова', 'elena456', 'p@ssw0rd');
insert into client(first_name, last_name, login, password)
    values ('Дмитрий', 'Смирнов', 'dima789', 'securepwd');
insert into client(first_name, last_name, login, password)
    values ('Анна', 'Козлова', 'anna_k', 'mypassword');
insert into client(first_name, last_name, login, password)
    values ('Сергей', 'Морозов', 'sergey_m', 'winter2023');
insert into client(first_name, last_name, login, password)
    values ('Мария', 'Кошкина', 'mary_lol', 'catlover123');
insert into client(first_name, last_name, login, password)
    values ('Алексей', 'Попов', 'alex_pop', 'poppppp1234');
insert into client(first_name, last_name, login, password)
    values ('Екатерина', 'Сидорова', 'katya99', 'sidor_pass');
insert into client(first_name, last_name, login, password)
    values ('Павел', 'Федоров', 'pavel_f', 'letmein123');
insert into client(first_name, last_name, login, password)
    values ('Наталья', 'Кузнецова', 'nata_87', 'sunflower74');

insert into department(name)
    values ('HEAD');
insert into department(name)
    values ('SALES');
insert into department(name)
    values ('HR');

insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (1, 'Гога', 'Меладзе', 50000, 2, '15-02-2020'::date, '01-01-5999'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (2, 'Елена', 'Зеленская', 60000, 2, '13-11-2017'::date, '14-12-2021'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (2, 'Елена', 'Зеленская', 60000, 3, '15-12-2021'::date, '01-01-5999'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (3, 'Дмитрий', 'Чуркен', 55000, 2, '08-04-2019'::date, '01-01-5999'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (4, 'Анна', 'Гольдберг', 58000, 3, '09-06-2016'::date, '07-10-2018'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (4, 'Анна', 'Гольдберг', 58000, 2, '08-10-2018'::date, '01-01-5999'::date);
insert into employee(employee_id, first_name, last_name, salary, department_id, valid_from, valid_until)
    values (5, 'Владимир', 'Базовый', 110000, 1, '18-03-2015'::date, '01-01-5999'::date);

insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (3, 4, '08-10-2018'::date, '09-11-2021'::date, 'DELIVERED', 80000);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (8, 4, '08-10-2018'::date, '15-12-2021'::date, 'DELIVERED', 149900);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (6, 1, '15-02-2020'::date, '13-01-2022'::date, 'DELIVERED', 234000);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (1, 3, '08-04-2019'::date, '16-10-2023'::date, 'CANCELLED', 89900);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (1, 3, '08-04-2019'::date, '17-10-2023'::date, 'DELIVERED', 45000);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (3, 3, '08-04-2019'::date, '23-11-2023'::date, 'IN_PROGRESS', 78000);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (5, 1, '15-02-2020'::date, '04-12-2023'::date, 'PAID', 78000);
insert into "order"(client_id, employee_id, employee_valid_from, date, status, price_total)
    values (5, 1, '15-02-2020'::date, '13-01-2022'::date, 'DELIVERED', 449500);

insert into product(name, description, price, quantity_available)
    values ('Игровой ноутбук Lenovo', null, 60000, 0);
insert into product(name, description, price, quantity_available)
    values ('Смартфон Samsung', 'Мощнейший и крутейший', 80000, 5);
insert into product(name, description, price, quantity_available)
    values ('Видеокарта Nvidia RTX 3070', null, 45000, 2);
insert into product(name, description, price, quantity_available)
    values ('Телевизор Sony', 'Диагональ 80`, качество 4K', 89900, 12);
insert into product(name, description, price, quantity_available)
    values ('PlayStation 5', null, 78000, 0);

insert into order_x_product(order_id, product_id, quantity)
    values (1, 2, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (2, 1, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (2, 4, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (3, 5, 3);
insert into order_x_product(order_id, product_id, quantity)
    values (4, 4, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (5, 3, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (6, 5, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (7, 5, 1);
insert into order_x_product(order_id, product_id, quantity)
    values (8, 4, 5);

insert into supplier(name, phone_no, city)
    values ('Москва Ритейл', '+74956723473', 'Москва');
insert into supplier(name, phone_no, city)
    values ('Ching-chong', '8-952-655-11-33', 'Хабаровск');
insert into supplier(name, phone_no, city)
    values ('Electronica', '89327778899', 'Мелитополь');
insert into supplier(name, phone_no, city)
    values ('Good-name Ltd.', '89110347656', 'Самара');
insert into supplier(name, phone_no, city)
    values ('ООО "Обнал"', '89055552123', 'Москва');

insert into supply(supplier_id, date)
    values (1, '15-10-2021'::date);
insert into supply(supplier_id, date)
    values (2, '11-11-2022'::date);
insert into supply(supplier_id, date)
    values (2, '01-05-2022'::date);
insert into supply(supplier_id, date)
    values (4, '07-07-2021'::date);
insert into supply(supplier_id, date)
    values (5, '18-03-2022'::date);
insert into supply(supplier_id, date)
    values (5, '20-03-2022'::date);

insert into supply_x_product(supply_id, product_id, quantity)
    values (1, 1, 1);
insert into supply_x_product(supply_id, product_id, quantity)
    values (1, 2, 3);
insert into supply_x_product(supply_id, product_id, quantity)
    values (2, 3, 3);
insert into supply_x_product(supply_id, product_id, quantity)
    values (3, 2, 3);
insert into supply_x_product(supply_id, product_id, quantity)
    values (4, 4, 7);
insert into supply_x_product(supply_id, product_id, quantity)
    values (5, 4, 3);
insert into supply_x_product(supply_id, product_id, quantity)
    values (6, 4, 2);

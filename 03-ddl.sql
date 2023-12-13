drop schema if exists db_project cascade;

create schema db_project;

set search_path = db_project, public;

create table client (
    client_id  serial primary key,
    first_name text not null,
    last_name  text not null,
    login      text not null,
    password   text not null check(length(password) >= 8)
);

create table department (
    department_id serial primary key,
    name          text not null
);

create table employee (
    employee_id   int not null,
    first_name    text not null,
    last_name     text not null,
    salary        numeric(19, 2) check (salary > 0),
    department_id int references db_project.department(department_id),
    valid_from    date not null,
    valid_until   date,
    primary key (employee_id, valid_from)
);

create table "order" (
    order_id            serial primary key,
    client_id           int references db_project.client(client_id),
    employee_id         int,
    employee_valid_from date,
    date                date not null,
    status              text not null check (status in ('PAID', 'IN_PROGRESS', 'DELIVERED', 'CANCELLED')),
    price_total         numeric(19, 2),
    foreign key (employee_id, employee_valid_from) references db_project.employee(employee_id, valid_from)
);

create table product (
    product_id         serial primary key,
    name               text not null,
    description        text,
    price              numeric(19, 2) check (price > 0),
    quantity_available int check (quantity_available >= 0)
);

create table supplier (
    supplier_id serial primary key,
    name        text not null,
    phone_no    text check (regexp_match(phone_no, '^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$') notnull),
    city        text
);

create table supply (
    supply_id   serial primary key,
    supplier_id int references db_project.supplier(supplier_id),
    date        date not null
);

create table supply_x_product (
    supply_id  int references db_project.supply(supply_id),
    product_id int references db_project.product(product_id),
    quantity   int check (quantity > 0),
    primary key (supply_id, product_id)
);

create table order_x_product (
    order_id  int references db_project."order"(order_id),
    product_id int references db_project.product(product_id),
    quantity   int check (quantity > 0),
    primary key (order_id, product_id)
);

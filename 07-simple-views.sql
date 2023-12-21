drop schema if exists db_project_views;

create schema db_project_views;

set search_path = db_project, db_project_views, public;

-- client
create or replace view db_project_views.clients as
    select
        c.login,
        left(c.first_name, 1) || '****' as first_name,
        left(c.last_name, 1) || '****' as last_name
    from client c;

-- order
create or replace view db_project_views.orders as
    select
        c.login as client,
        e.last_name || ' ' || e.first_name as employee,
        p.name as product,
        oxp.quantity,
        o.date,
        o.status,
        o.price_total
    from "order" o
        join db_project.client c on c.client_id = o.client_id
        join db_project.employee e on o.employee_id = e.employee_id and o.employee_valid_from = e.valid_from
        join db_project.order_x_product oxp on o.order_id = oxp.order_id
        join db_project.product p on oxp.product_id = p.product_id;

-- employee
create or replace view db_project_views.actual_employees as
    select
        e.last_name || ' ' || e.first_name as name,
        e.salary,
        d.name as department
    from
        employee e join db_project.department d on d.department_id = e.department_id
    where
        e.valid_until = '01-01-5999'::date;

-- department
create or replace view db_project_views.departments as
    select
        d.name as department
    from department d;

-- product
create or replace view db_project_views.products as
    select
        p.name,
        p.description,
        p.price,
        (p.quantity_available > 0)::bool as is_available
    from product p;

-- supply
create or replace view db_project_views.supplies as
    select
        sr.name as supplier,
        p.name,
        sxp.quantity,
        s.date
    from supply s
        join db_project.supplier sr on sr.supplier_id = s.supplier_id
        join db_project.supply_x_product sxp on s.supply_id = sxp.supply_id
        join db_project.product p on p.product_id = sxp.product_id;

-- supplier
create or replace view db_project_views.suppliers as
    select
        s.name,
        left(s.phone_no, 1) || '*********' || right(s.phone_no, 1) as phone_number,
        s.city
    from supplier s;

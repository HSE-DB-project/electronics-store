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

-- employee


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
-- supplier
create or replace view db_project_views.suppliers as
    select
        s.name,
        left(s.phone_no, 1) || '*********' || right(s.phone_no, 1) as phone_number,
        s.city
    from supplier s;

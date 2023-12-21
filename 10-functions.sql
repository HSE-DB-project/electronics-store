set search_path = db_project, public;
set datestyle = 'iso, dmy';

-- drop function apply_supply;

create function apply_supply(in new_supply_id int) 
returns void as $$
declare supply_element record;
begin
    for supply_element in (select *
                 from supply_x_product 
                 where supply_id = new_supply_id)
        loop
            update product set quantity_available = quantity_available + supply_element.quantity 
              where product_id = supply_element.product_id;
        end loop;
end;
$$ language plpgsql;

drop table if exists price_mismatches;
create table price_mismatches (
  order_id       int references db_project."order"(order_id),
  expected_price numeric(19, 2),
  actual_price   numeric(19, 2)
);


-- drop function find_price_mismatches(in start_date date);

create function find_price_mismatches(in start_date date default '01-01-2000') 
returns void as $$
declare supply_element record;
begin
    truncate db_project.price_mismatches;
    insert into db_project.price_mismatches (
      select o.order_id as order_id, sum(oxp.quantity * p.price), o.price_total
        from 
          "order" o inner join order_x_product oxp 
             on o.order_id = oxp.order_id
           inner join product p 
             on oxp.product_id = p.product_id
        where o.date > start_date
        group by o.order_id
        having sum(oxp.quantity * p.price) != o.price_total);
end;
$$ language plpgsql;

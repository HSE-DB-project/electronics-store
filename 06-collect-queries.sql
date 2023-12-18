set search_path = db_project, public;

-- для каждого работника вывести последний отдел, в котором он работал / работает
select employee_id as id,
       first_name,
       last_name,
       d.name      as department
from employee e
         join department d on d.department_id = e.department_id
where e.valid_until = (select MAX(e1.valid_until)
                       from employee e1
                       where e1.employee_id = e.employee_id
                       group by e.employee_id);

-- определим зоны ответственности - для каждого работника сформировать список из товаров и сколько раз он с каждым их них работал,
-- отсортировать по убыванию частот; будем считать работника компетентным, если он процессил товар хотя бы 3 раза
with processed_products as (select e.employee_id     as e_id,
                                   p.product_id      as p_id,
                                   e.first_name      as e_first_name,
                                   e.last_name       as e_last_name,
                                   p.name            as p_name,
                                   sum(oxp.quantity) as p_amount
                            from employee e
                                     join "order" o on
                                e.employee_id = o.employee_id
                                    and e.valid_until = '01-01-5999'::date
                                    and o.status = 'DELIVERED'
                                     join db_project.order_x_product oxp on o.order_id = oxp.order_id
                                     join db_project.product p on oxp.product_id = p.product_id
                            group by e.employee_id, p.product_id, e.first_name, e.last_name, p.name
                            having sum(oxp.quantity) >= 3)
select e_id                                               as id,
       e_first_name                                       as first_name,
       e_last_name                                        as last_name,
       string_agg(concat_ws(': ', p_name, p_amount), ',') as processed_products
from processed_products
group by e_id, e_first_name, e_last_name;


-- в какие месяцы вырастает нагрузка на поставщиков -
-- сколько товаров было поставлено в каждый месяц и на сколько процентов произошло изменение по сравнению с предыдущим месяцем
with products_supplied_per_month as (select date_part('month', s.date) as month,
                                            date_part('year', s.date)  as year,
                                            sum(sxp.quantity)          as products_amount
                                     from supply s
                                              join db_project.supply_x_product sxp on s.supply_id = sxp.supply_id
                                     group by date_part('month', s.date), date_part('year', s.date))
select month,
       year,
       products_amount,
       round((products_amount * 1.0 / lag(products_amount) over (order by year * 100 + month) - 1) * 100,
             2) as per_cent_diff
from products_supplied_per_month;

-- самые прибыльные товары в магазине по убыванию общей выручки
select p.product_id                as id,
       p.name                      as name,
       p.price                     as price,
       sum(oxp.quantity)           as number_of_sold,
       sum(oxp.quantity * p.price) as total_value
from product p
         join order_x_product oxp on p.product_id = oxp.product_id
         join "order" o on oxp.order_id = o.order_id and o.status in ('DELIVERED', 'PAID')
group by p.product_id
order by sum(p.price * oxp.quantity) desc;

-- сколько у каждого работника заказов в обработке
select e.employee_id as id,
       count(status) as orders_in_progress_number
from employee e
         left join "order" o
                   on e.employee_id = o.employee_id
                       and e.valid_from = o.employee_valid_from
                       and e.valid_until = '01-01-5999'::date
                       and o.status = 'IN_PROGRESS'
group by e.employee_id;

-- самые щедрые клиенты по убыванию внесенного капитала
select
    c.client_id as client_id,
    c.login as login,
    sum(o.price_total) as total_amount
from
    client c
        join "order" o on c.client_id = o.client_id
            and o.status in ('PAID', 'DELIVERED')
group by c.client_id
order by sum(o.price_total) desc;
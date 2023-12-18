set search_path = db_project, public;

-- Статистика по товарам в магазине, отсортированная в порядке убывания кол-ва продаж.
create or replace view products_statistics as
	select 
	p."name", -- Название товара
	p.price, -- Цена товара
	sum(oxp.quantity) as purchases_amount, -- Кол-во проданных экземпляров
	count(1) as orders_amount, -- Кол-во заказов с этим товаром
	sum(oxp.quantity) / count(1) as average_per_order -- Среднее кол-во товаров в заказе
	from product p 
		left join order_x_product oxp on p.product_id  = oxp.order_id 
		left join "order" o on oxp.order_id = o.order_id
	where o.status = 'DELIVERED'
	group by p.product_id
	order by sum(oxp.quantity) desc, p.product_id asc;


-- Статиситка по департаментам, отсортированная по убыванию средней зарплаты
create or replace view department_statistics as
	select
	d."name", -- Название департамента
	avg(e.salary) as average_salary, -- Средняя зарплата в департаменте
	min(e.salary) as min_salary, -- Минимальная зарплата в департаменте
	count(1) as workers_amount -- Кол-во работников в департаменте
	from department d
		left join employee e on d.department_id = e.department_id
	where e.valid_from <= now() and e.valid_until >= now()
	group by d.department_id 
	order by avg(e.salary) desc;
	
-- Сводка по поставкам в порядке убывания даты
create or replace view supplier_statistics as
	select
	sy."date", -- Дата
	ser."name" as supplier_name, -- Имя поставщика
	ser.city as supplier_city, -- Город поставщика
	p."name" as product_name, -- Название товара
	sxp.quantity as product_quantity -- Кол-во товара в поставке
	from supply sy 
		left join supplier ser on ser.supplier_id = sy.supplier_id
		left join supply_x_product sxp on sy.supply_id = sxp.supply_id
		left join product p on sxp.product_id = p.product_id 
	group by ser.supplier_id, sy.supply_id, p.product_id, sxp.supply_id, sxp.product_id 
	order by sy."date" desc;
	

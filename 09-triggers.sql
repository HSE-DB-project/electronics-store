set search_path = db_project, public;

-- Триггер на обновление valid_until при добавлении нового сотрудника

create or replace function employee_update()
    returns trigger as
$$
begin
	update employee 
	set valid_until = new.valid_from
	where employee_id = new.employee_id AND valid_until >= now();
	return new;
end;
$$ language plpgsql;

create trigger employee_insert_trigger
    before insert
    on employee
    for each row
execute function employee_update();



-- Триггер на логгирование изменение паролей клиентов

create table clients_pass_log
(
    log_id          serial primary key,
    operation_at    timestamp(0) not null,
    client_id 	    int not null,
    first_name	    text not null,
    last_name       text not null,
    login	    text not null,
    old_password    text,
    new_password    text not null
);

create or replace function clients_log()
    returns trigger as	
$$
begin
	if tg_op = 'INSERT'
    then
        insert into clients_pass_log(operation_at, client_id, first_name, last_name, login, old_password, new_password)
        values (current_timestamp, new.client_id, new.first_name, new.last_name, new.login, null, new.password);
    elseif tg_op = 'UPDATE'
    then
        insert into clients_pass_log(operation_at, client_id, first_name, last_name, login, old_password, new_password)
        values (current_timestamp, new.client_id, new.first_name, new.last_name, new.login, old.password, new.password);
    end if;
    return null;
end;
$$ language plpgsql;

create trigger client_log_trigger
    after insert or update
    on client
    for each row
execute function clients_log();

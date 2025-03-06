-- N1.ex1
create index idx_credit_card on credit_card(id);

CREATE TABLE IF NOT EXISTS credit_card (
        id VARCHAR(15) PRIMARY KEY,
        iban VARCHAR(50),
        pan VARCHAR(30),
        pin VARCHAR(4),
        cvv VARCHAR(100),
        expiring_date VARCHAR(20)
    );

alter table transaction
add constraint fk_credit_card_id foreign key (credit_card_id) REFERENCES credit_card(id);

-- N1.ex2
select * from credit_card
where id="CcU-2938";

update credit_card
set iban = "R323456312213576817699999"
where id="CcU-2938";

select * from credit_card
where id="CcU-2938";

-- N1.ex3
select * from company
where id="b-9999";

select * from credit_card 
where id="ccu-9999";

insert into company (id) values ("b-9999");
insert into credit_card (id) values ("CcU-9999");
insert into transaction (id, credit_card_id, company_id, user_id,
lat, longitude, timestamp, amount, declined)
values ("108B1D1D-5B23-A76C-55EF-C568E49A99DD", "CcU-9999", "b-9999", 9999,
"829.999", "-117.999", datetime, "111.11", 0);

update transaction
set timestamp = now()
where id="108B1D1D-5B23-A76C-55EF-C568E49A99DD";

select * from company
where id="b-9999";
select * from credit_card
where id="CcU-9999";
select * from transaction
where id="108B1D1D-5B23-A76C-55EF-C568E49A99DD";

-- N1.ex4
alter table credit_card
drop column pan;

-- N2.ex1
delete from transaction
where id="02C6201E-D90A-1859-B4EE-88D2986D3B02";

select * from transaction
where id="02C6201E-D90A-1859-B4EE-88D2986D3B02";

-- N2.ex2 company_name, phone, country, avg(amount)
select c.company_name, c.phone, c.country, round(avg(amount), 2) as mitjana_amount from company c
left join transaction t on c.id=t.company_id
group by c.company_name, c.phone, c.country
order by avg(amount) desc;

-- N2.ex3
select c.company_name, c.phone, c.country, round(avg(amount), 2) as mitjana_amount from company c
left join transaction t on c.id=t.company_id
where c.country="Germany"
group by c.company_name, c.phone, c.country
order by avg(amount) desc;

-- N3.ex1
alter table company
drop column website;

alter table credit_card
add fecha_actual date;

alter table credit_card
modify column cvv INT;

alter table transaction
add constraint fk_user_id foreign key (user_id) REFERENCES user(id);
 
show create table data_user;

alter table user
drop foreign key user_ibfk_1;

set foreign_key_checks=0;

alter table transaction
add constraint fk_user_id foreign key (user_id) REFERENCES user(id);

set foreign_key_checks=1;

alter table user rename data_user;

alter table data_user rename column email to personal_email;

-- N3.ex2
select t.id transacció, u.name, u.surname, cc.iban, c.company_name empresa from transaction t
left join company c on t.company_id=c.id
left join credit_card cc on t.credit_card_id=cc.id
left join data_user u on t.user_id=u.id
order by t.id desc;
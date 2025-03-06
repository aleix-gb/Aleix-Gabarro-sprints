drop database prova_s4;

alter table users_ca rename users;

alter table transactions
modify column id varchar(255);

ALTER TABLE transactions
ADD CONSTRAINT PK_id PRIMARY KEY (id);

alter table companies
modify column company_id varchar(15);

ALTER TABLE companies
ADD CONSTRAINT PK_company_id PRIMARY KEY (company_id);

alter table credit_cards
modify column id varchar(15);

ALTER TABLE credit_cards
ADD CONSTRAINT PK_id PRIMARY KEY (id);

alter table users
modify column id INT(11);

ALTER TABLE users
ADD CONSTRAINT PK_id PRIMARY KEY (id);

alter table transactions
modify column business_id varchar(15);

alter table transactions
modify column card_id varchar(15);

alter table transactions
add constraint fk_user_id foreign key (user_id) REFERENCES users(id);

alter table transactions
add constraint fk_card_id foreign key (card_id) REFERENCES credit_cards(id);

alter table transactions
add constraint fk_business_id foreign key (business_id) REFERENCES companies(company_id);

select * from transactions;
select * from credit_cards;
select * from companies;
select * from users;

-- N1.ex1
select u.id, u.name, u.surname, count(user_id) from transactions t
left join users u on t.user_id=u.id
group by u.id, u.name, u.surname
having count(user_id) >30;

-- N1.ex2
select c.company_id, c.company_name, cc.iban, avg(amount) from transactions t
left join companies c on t.business_id=c.company_id
left join credit_cards cc on t.card_id=cc.id
where c.company_name = "Donec Ltd";

select * from credit_cards;
select * from transactions;

-- N2.ex1

drop table acti
create table active_cards as select card_id, timestamp, declined from transactions;

select * from active_cards;
select distinct card_id from active_cards
case
	when 
    end;

-- N3.ex1
select * from products;
create table sold_products as select id, product_ids from transactions;


select distinct p.id, count(product_ids) as comptador from sold_products sp
join products p on sp.product_ids=p.id
group by p.id
order by comptador desc;

drop database transactions_s4;

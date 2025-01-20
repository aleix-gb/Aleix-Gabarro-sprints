select * from transaction;
select * from company;

-- N1.ex2.a
select distinct c.country from company as c
left join transaction as t on c.id=t.company_id
order by c.country;

-- N1.ex2.b
select count(distinct c.country) from company as c
left join transaction as t on c.id=t.company_id;

-- N1.ex2.c
select c.company_name, round(avg(t.amount), 2) as mitjana from transaction as t
left join  company as c on t.company_id=c.id
group by c.company_name
order by mitjana desc
limit 1;

-- N1.ex3.a
select * from transaction
where company_id in (select id from company 
	where country = "Germany");

-- N1.ex3.b
select distinct company_name from company
where id in (select company_id from transaction
	where amount > (select avg(amount) from transaction))
order by company_name;

-- N1.ex3.c
SELECT company_name FROM company
WHERE NOT EXISTS( SELECT * FROM transaction
        WHERE transaction.company_id = company.id)
ORDER BY company_name;

-- N2.ex1
select date(timestamp) data, sum(amount) total from transaction
group by data
order by total desc
limit 5;

-- N2.ex2
 select c.country, round(avg(amount), 2) as mitjana from company as c
 left join transaction as t on c.id=t.company_id
 left join (select company_id, avg(amount) from transaction group by company_id) avgamountcountry
 on c.id=avgamountcountry.company_id
 group by c.country
 order by avg(amount) desc;

-- N2.ex3.a
select c.company_name, t.* from transaction as t
left join company as c on t.company_id=c.id
where country = (select country from company
	where company_name = "Non Institute");
    
-- N2.ex3.b
select * from transaction
where company_id in (select id from company 
	where country = (select country from company where company_name = "Non Institute"));

-- N3.ex1 nom, telèfon, país, data i amount
select c.company_name, c.phone, c.country, date(timestamp) data, t.amount from company c
left join transaction as t on c.id=t.company_id
where (t.amount between 100 and 200) and (date(timestamp) in ("2021-04-29", "2021-07-20", "2022-03-13"))
order by t.amount desc;

-- N3.ex2
select c.company_name, count(company_id) num_transaccions,
case 
	when count(company_id) >= 4 then "4 o més"
    else "Menys de 4"
end as QuantityText 
from company c
left join transaction t on c.id=t.company_id
group by c.company_name
order by count(company_id) desc;
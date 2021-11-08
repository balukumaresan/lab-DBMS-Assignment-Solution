create database ecommerce;
use ecommerce;

create table if not exists SUPPLIER
(
SUPP_ID int primary key auto_increment not null,
SUPP_NAME varchar(50),
SUPP_CITY varchar(50),
SUPP_PHONE varchar(10)
);

create table if not exists CUSTOMER
(
CUST_ID int primary key auto_increment not null,
CUST_NAME varchar(20) null default null,
CUST_PHONE varchar(10),
CUST_CITY varchar(30),
CUST_GENDER varchar(1)
);

create table if not exists CATEGORY
(
CAT_ID int primary key auto_increment not null,
CAT_NAME varchar(20) default null
);

create table if not exists PRODUCT
(
PROD_ID int primary key auto_increment not null,
PROD_NAME varchar(20) null default null,
PROD_DESC varchar(60) null default null,
CAT_ID int not null,
foreign key (CAT_ID) references CATEGORY(CAT_ID)
);

create table if not exists PRODUCT_DETAILS
(
PROD_DETAILS_ID int primary key auto_increment not null,
PRO_ID int not null,
SUPP_ID int not null,
PROD_PRICE int not null,
foreign key (PRO_ID) references PRODUCT (PROD_ID),
foreign key (SUPP_ID) references SUPPLIER (SUPP_ID)
);

create table if not exists ORDERS
(
ORDER_ID int primary key not null,
ORDER_AMOUNT int not null,
ORDER_DATE date,
CUST_ID int not null,
PROD_ID int not null,
foreign key (CUST_ID) references CUSTOMER (CUST_ID),
foreign key (PROD_ID) references PRODUCT (PROD_ID)
);


create table if not exists RATING
(
RAT_ID int not null,
CUST_ID int not null,
SUPP_ID int not null,
RAT_RATSTARS INT not null,
primary key (RAT_ID),
foreign key (SUPP_ID) references SUPPLIER (SUPP_ID),
foreign key (CUST_ID) references CUSTOMER (CUST_ID)
);

insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Rajesh Retails', 'Delhi', '1234567890');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Appario Ltd.', 'Mumbai', '2589631470');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Knome products', 'Banglore', '9785462315');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Bansal Retails', 'Kochi', '8975463285');
insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values ('Mittal Ltd.', 'Lucknow', '7898456532');

select * from supplier;

insert into customer (CUST_NAME, CUST_PHONE, CUST_CITY, CUST_GENDER) values ('AAKASH', '9999999999', 'DELHI',  'M');
insert into customer (CUST_NAME, CUST_PHONE, CUST_CITY, CUST_GENDER) values ('AMAN',   '9785463215', 'NOIDA',  'M');
insert into customer (CUST_NAME, CUST_PHONE, CUST_CITY, CUST_GENDER) values ('NEHA',   '9999999999', 'MUMBAI', 'F');
insert into customer (CUST_NAME, CUST_PHONE, CUST_CITY, CUST_GENDER) values ('MEGHA',  '9994562399', 'KOLKATA', 'F');
insert into customer (CUST_NAME, CUST_PHONE, CUST_CITY, CUST_GENDER) values ('PULKIT', '7895999999', 'LUCKNOW', 'M');

select * from customer;

insert into category (CAT_NAME) values ('BOOKS');
insert into category (CAT_NAME) values ('GAMES');
insert into category (CAT_NAME) values ('GROCERIES');
insert into category (CAT_NAME) values ('ELECTRONICS');
insert into category (CAT_NAME) values ('CLOTHES');

select * from category;

insert into product (PROD_NAME, PROD_DESC, CAT_ID) values ('GTA V','DFJDJFDJFDJFDJFJF','2');
insert into product (PROD_NAME, PROD_DESC, CAT_ID) values ('TSHIRT','DFDFJDFJDKFD','5');
insert into product (PROD_NAME, PROD_DESC, CAT_ID) values ('ROG LAPTOP','DFNTTNTNTERND','4');
insert into product (PROD_NAME, PROD_DESC, CAT_ID) values ('OATS','REURENTBTOTH','3');
insert into product (PROD_NAME, PROD_DESC, CAT_ID) values ('HARRY POTTER', 'NBEMCTHTJTH','1');

select * from product;

insert into product_details (PRO_ID, SUPP_ID, PROD_PRICE) values (1, 2, 1500);
insert into product_details (PRO_ID, SUPP_ID, PROD_PRICE) values (3, 5,30000);
insert into product_details (PRO_ID, SUPP_ID, PROD_PRICE) values (5, 1, 1000);
insert into product_details (PRO_ID, SUPP_ID, PROD_PRICE) values (2, 3,2500);
insert into product_details (PRO_ID, SUPP_ID, PROD_PRICE) values (4, 1,1000);

select * from product_details;

insert into ORDERS (ORDER_ID, ORDER_AMOUNT, ORDER_DATE, CUST_ID, PROD_ID) values (20, 1500, '2021-10-12', 3, 5);
insert into ORDERS (ORDER_ID, ORDER_AMOUNT, ORDER_DATE, CUST_ID, PROD_ID) values (25, 30500, '2021-09-16', 5, 2);
insert into ORDERS (ORDER_ID, ORDER_AMOUNT, ORDER_DATE, CUST_ID, PROD_ID) values (26, 2000, '2021-10-05', 1, 1);
insert into ORDERS (ORDER_ID, ORDER_AMOUNT, ORDER_DATE, CUST_ID, PROD_ID) values (30, 3500, '2021-08-16', 4, 3);
insert into ORDERS (ORDER_ID, ORDER_AMOUNT, ORDER_DATE, CUST_ID, PROD_ID) values (50, 2000, '2021-10-06', 2, 1);

select * from ORDERS;

insert into RATING (CUST_ID, SUPP_ID, RAT_RATSTARS) values (2, 2, 4);
insert into RATING (CUST_ID, SUPP_ID, RAT_RATSTARS) values (3, 4, 3);
insert into RATING (CUST_ID, SUPP_ID, RAT_RATSTARS) values (5, 1, 5);
insert into RATING (CUST_ID, SUPP_ID, RAT_RATSTARS) values (1, 3, 2);
insert into RATING (CUST_ID, SUPP_ID, RAT_RATSTARS) values (4, 5, 4);

select * from RATING;

# 3) Display the number of the customer group by their genders who have placed any order
# of amount greater than or equal to Rs.3000.

select customer.cust_gender, count(customer.cust_id) CUSTOMERS_COUNT 
	from customer customer, orders orders 
	where customer.cust_id = orders.cust_id
	and orders.ORDER_AMOUNT >= 3000  
	group by customer.cust_gender;
	
# 4) Display all the orders along with the product name ordered by a customer having
#  Customer_Id=2.
	
SELECT ord.ORDER_ID, ord.ORDER_AMOUNT, ord.ORDER_DATE, ord.CUST_ID, ord.PROD_ID, prod.PROD_NAME 
	FROM orders ord , product prod
	where ord.cust_id = 2
	and ord.prod_id = prod.prod_id;

#5) Display the Supplier details who can supply more than one product.

select sup.* 
	from supplier sup, product_details pd
	where sup.SUPP_ID = pd.SUPP_ID
	group by pd.SUPP_ID 
	having count(pd.SUPP_ID) > 1;
	
# 6) Find the category of the product whose order amount is minimum.
	
select ord.*, prod.PROD_NAME, prod.PROD_DESC, cat.CAT_ID, cat.CAT_NAME 
	from orders ord, product prod, category cat
	where ord.PROD_ID = prod.PROD_ID
	and prod.CAT_ID = cat.CAT_ID
	having min(ord.ORDER_AMOUNT);
	
# 7) Display the Id and Name of the Product ordered after “2021-10-05”.

select ord.*, prod.PROD_NAME  
	from orders ord, product prod
	where ord.PROD_ID = prod.PROD_ID
	and ord.ORDER_DATE > '2021-10-05';
	
# 8) Print the top 3 supplier name and id and their rating on the basis of their rating along
#  with the customer name who has given the rating

select sup.SUPP_ID, sup.SUPP_NAME, rat.RAT_RATSTARS, cust.CUST_NAME  
	from supplier sup, rating rat, customer cust
	where sup.SUPP_ID = rat.SUPP_ID
	and rat.CUST_ID = cust.CUST_ID
	order by rat.RAT_RATSTARS desc
	limit 3;
	
# 9) Display customer name and gender whose names start or end with character 'A'

select CUST_NAME, CUST_GENDER 
	from customer
	where CUST_NAME like 'A%'
	or CUST_NAME like '%A';

# 10) Display the total order amount of the male customers

select sum(ord.ORDER_AMOUNT) as SUM_AMOUNT 
	from orders ord , customer cust
	where ord.CUST_ID =  cust.CUST_ID
	AND  cust.CUST_GENDER = 'M';
	
# 11) Display all the Customers left outer join with the orders.
	
    select * from customer cust
    left outer join orders ord
    on cust.cust_id = ord.cust_id
    order by cust.CUST_ID;

# 12) Create a stored procedure to display the Rating for a Supplier if any along with the
# Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
# Supplier” else “Supplier should not be considered”.
	
DELIMITER $$
USE `ecommerce`$$
CREATE PROCEDURE `supplierVerdict`(IN suppID INT)
BEGIN
  select sup.*, rat.rat_ratstars, 
  CASE 
  when rat.rat_ratstars > 4 then 'Genuine Supplier'
  when rat.rat_ratstars > 2 then 'Average Supplier'
  else 'Supplier should not be considered'
  end as VERDICT
  from supplier sup, rating rat 
where sup.SUPP_ID = rat.SUPP_ID
and sup.SUPP_ID = suppID;
  
END$$

DELIMITER ;
;

CALL ecommerce.supplierVerdict(3);
create database TRAVEl_ON_GO;
use TRAVEl_ON_GO;

create table if not exists PASSANGER 
(
PASSANGER_NAME varchar(50),
CATEGORY varchar(25),
GENDER varchar(1),
BOARDING_CITY varchar(50),
DESTINATION_CITY varchar(50),
DISTANCE int,
BUS_TYPE varchar(25)
);

INSERT INTO PASSANGER VALUES('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT INTO PASSANGER VALUES('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT INTO PASSANGER VALUES('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT INTO PASSANGER VALUES('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT INTO PASSANGER VALUES('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
INSERT INTO PASSANGER VALUES('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
INSERT INTO PASSANGER VALUES('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper');
INSERT INTO PASSANGER VALUES('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
INSERT INTO PASSANGER VALUES('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

select * from PASSANGER;

create table    if not exists PRICE
(
BUS_TYPE varchar(10) ,
DISTANCE int not null,
PRICE int not null
);


INSERT INTO PRICE VALUES ('Sleeper', 350,  770);
INSERT INTO PRICE VALUES ('Sleeper', 500,  1100);
INSERT INTO PRICE VALUES ('Sleeper', 600,  1320);
INSERT INTO PRICE VALUES ('Sleeper', 700,  1540);
INSERT INTO PRICE VALUES ('Sleeper', 1000, 2200);
INSERT INTO PRICE VALUES ('Sleeper', 1200, 2640);
INSERT INTO PRICE VALUES ('Sleeper', 350,  434);
INSERT INTO PRICE VALUES ('Sitting',  500,  620);
INSERT INTO PRICE VALUES ('Sitting',  500,  620);
INSERT INTO PRICE VALUES ('Sitting',  600,  744);
INSERT INTO PRICE VALUES ('Sitting',  700,  868);
INSERT INTO PRICE VALUES ('Sitting',  1000, 1240);
INSERT INTO PRICE VALUES ('Sitting',  1200,  1488);

select * from price;

#3) How many females and how many male passengers travelled for a minimum distance of
#600 KM s?
select GENDER, count(GENDER) PASSANGER_COUNT 
	from PASSANGER 
	where DISTANCE >= 600
	group by GENDER 
	order by GENDER;


#4) Find the minimum ticket price for Sleeper Bus. 

select min(PRICE) 
	from PRICE 
	where BUS_TYPE = 'Sleeper';


#5) Select passenger names whose names start with character 'S' 

select * 
	from PASSANGER
	where PASSANGER_NAME like 's%';

#6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
#Destination City, Bus_Type, Price in the output

SELECT P.PASSANGER_NAME, P.BOARDING_CITY, P.DESTINATION_CITY, P.BUS_TYPE, P.DISTANCE, 
		CASE 
			when PR.PRICE is null then 'Price not available'
			else PR.PRICE
		end as PRICE_CHARGED 
	from PASSANGER P 
	LEFT OUTER JOIN PRICE PR
	on P.BUS_TYPE = PR.BUS_TYPE
	and P.DISTANCE  = PR.DISTANCE
	group by P.PASSANGER_NAME;

#7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
#distance of 1000 KM s 
SELECT P.PASSANGER_NAME, P.BOARDING_CITY, P.DESTINATION_CITY, P.BUS_TYPE, P.DISTANCE, PR.PRICE
	from PASSANGER P 
	LEFT OUTER JOIN PRICE PR
	on P.BUS_TYPE = PR.BUS_TYPE
	and P.DISTANCE  = PR.DISTANCE
	where P.DISTANCE = 1000
	and P.BUS_TYPE = 'Sitting'
	group by P.PASSANGER_NAME;	
	
#8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
#Panaji?
SELECT * 
	from PASSANGER P 
	left outer join  PRICE PR 
	on  P.BUS_TYPE = PR.BUS_TYPE  
	and P.DISTANCE = PR.DISTANCE
	where P.PASSANGER_NAME ='Pallavi'
	and P.BOARDING_CITY = 'Bangalore'
	and  P.DESTINATION_CITY = 'Panaji' 
	group by PASSANGER_NAME
;

#9) List the distances from the "Passenger" table which are unique (non-repeated
#distances) in descending order

select DISTANCE 
	from PASSANGER 
	group by DISTANCE 
	order by DISTANCE desc;

#10) Display the passenger name and percentage of distance travelled by that passenger
#from the total distance travelled by all passengers without using user variables 

select PASSANGER_NAME, DISTANCE, 100 * DISTANCE/ (Select sum(DISTANCE) as TOTAL from PRICE) as PERCENTAGE_OF_DISTANCE 
	from PASSANGER 
	group by PASSANGER_NAME;

#11) Display the distance, price in three categories in table Price
#a) Expensive if the cost is more than 1000
#b) Average Cost if the cost is less than 1000 and greater than 500
#c) Cheap otherwise

select DISTANCE, PRICE, 
	CASE 
		when PRICE > 1000 then 'Expensive'
		when PRICE > 500 and PRICE < 1000 then 'Average'
		else 'Cheap'
	END as CATEGORY 
	from PRICE 
	order by PRICE;
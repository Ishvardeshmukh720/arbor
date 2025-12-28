-- Question - 1] The accounts team wants to check payments made via UPI to measure digital
-- adoption.
select * from payments where PaymentMethod = 'upi';

-- Question - 2] List all unique first names of customers for a duplicate check.
select distinct firstname from customers ;
-- Question - 3] Delete all rooms with Capacity = 1.

delete from customers where capacity = 1;
-- Question - 4] Display each customer’s name and phone number together using CONCAT.
select concat(firstname,'     ',lastname,'      ',phone) from customers ;
-- Question - 5] The booking office wants to see bookings where RoomID = 10 to check utilization
-- of a specific room.
select * from rooms where roomid = 10;
-- Question - 6] Identify rooms whose Capacity is greater than the average Capacity of all rooms.
-- (Rooms subquery)
select *  from rooms
where capacity > (select avg(capacity) from rooms);
-- Question - 7] Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and
-- Phone.
create view staff_contact as 
select firstname,lastname,role,phone from  staff;
select * from staff_contact;
-- Question - 8] The receptionist wants to offer Suite rooms under ₹7000 to business travelers.alter
select * from rooms where roomtype = 'suite' and pricepernight < 7000;

-- Question - 9] The admin wants to see email addresses sorted by LastName from the Customers
select email, lastname from customers order by lastname asc ;

-- Question - 10] Show staff full names combined into one column.
select concat(firstname,' ',lastname) from staff ;
-- Question - 11] Display all payment details in one line using CONCAT_WS.
select concat_ws('   ----    ',paymentid,bookingid,paymentdate,paymentmethod,amount) from payments;
-- Question - 12] The hotel wants to display the 2 most expensive rooms for VIP guests.
select * from rooms order by pricepernight desc limit 2;
-- Question - 13] Show each BookingID with its CheckIn and CheckOut dates combined.
-- Hotel Management System
select bookingid , concat_ws(' | ' ,checkindate,checkoutdate) as dates from bookings;


-- Question - 14] Finance wants to calculate the average Amount per PaymentMethod.
select paymentmethod,avg(amount) from payments group by paymentmethod;
-- Question - 15] The analytics team wants to find the city where average CustomerID is greater
-- than 50.
select avg(customerid) , city from customers group by city  having avg(customerid) >50;
select * from customers;

-- Question - 16] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings
-- subquery)
select * from bookings
 where totalamount >(select avg(totalamount) from bookings);
 
 
-- Question - 17] Display the last 2 added rooms from the Rooms table.
select * from rooms order by roomid desc limit 2 ;
-- Question - 18] The cashier wants a report of payments where Amount < ₹1500 for small
-- transactions.
select * from payments where amount <1500;
-- Question - 19] Management wants to list all customers who have made more than 5 bookings.
SELECT 
    c.firstname,
    c.lastname,
    b.customerid,
    COUNT(*) AS TotalBookings
FROM customers c
JOIN bookings b ON c.customerid = b.customerid
GROUP BY c.firstname, c.lastname, b.customerid
HAVING COUNT(*) > 5;

-- Question - 20] Identify customers who live in the same city. (Customers self join)
select a1.firstname,a2.firstname,a1.city
 from customers a1
 join customers a2
 on a1.city = a2.city
and a1.customerid < a2.customerid
order by a1.city asc  ;
-- Question - 21] Show the total revenue handled by each StaffID.
select staffid , sum(totalamount) from bookings group by staffid;
select * from bookings;
-- Question - 22] The manager wants to see all customers from Mumbai to check city-wise
-- marketing campaigns.
select * from customers where city = 'mumbai';
-- Question - 23] Display the 3 lowest booking amounts.
select * from bookings order by totalamount asc limit 3;
-- Question - 24] Insert 5 new room records with type, price, and capacity into the Rooms table.
select * from rooms;
insert into rooms(roomtype,pricepernight,capacity)
 value      ( 'suite',1600,1),
            (  'double',1500,4),
            (  'single',1400,2),
            (  'family',1700,6),
            (  'suite',1600,3);
            

-- Question - 25] Show all unique CustomerIDs from bookings.
select distinct customerid from customers order by customerid asc ;
-- Question - 26] Create a trigger to automatically delete a payment when its corresponding
-- booking is deleted.
delimiter //
create trigger ato_delete_booking
after delete on payments
for each row
begin 
    delete from payments
    where bookingid = old.bookingid;
end;
delimiter //;
delete from payments where bookingid = 10;
-- Question - 27] The marketing team wants to update the FirstName of CustomerID = 30 to
-- 'Rahul'.
 
UPDATE customers
SET firstname = 'Rahul'
WHERE customerid = 30;


-- Question - 28] List all bookings ordered by CheckInDate.
select * from bookings order by checkindate ;
-- Question - 29] Show all rooms where capacity is greater than 2.
select * from rooms where capacity >2;
-- Question - 30] List staff emails ordered by their roles.
-- Hotel Management System
select email,role from staff order by role asc ;

-- Question - 31] Display each customer’s full name and city using CONCAT_WS.
SELECT CONCAT_WS(' | ', firstname, lastname, city) AS Customer_Details
FROM customers;

-- Question - 32] Show the first 4 customers’ full names only.
select concat_ws("|",firstname,lastname) from customers  limit 4;

-- Question - 33] Show each staff’s role with their full name.
select role, concat_ws("|",firstname,lastname) as fullname from staff ;

-- Question - 34] Management wants to find the average StaffID per role.
select * from staff;
select role,avg(staffid) from staff group by role;
-- Question - 35] List all bookings handled by StaffID = 2
select * from bookings where staffid = 2;

-- Question - 36] Display the first 3 staff alphabetically by their first names.
select * from staff order by firstname ;
-- Question - 37] The front desk manager wants to see customers where FirstName = 'Amit' AND
-- City = 'Nagpur' for personal attention.
select * from customers where firstname = 'amit' and city = 'nagpur';
-- Question - 38] Show all unique payment methods in descending order.
select distinct paymentmethod from payments order by PaymentMethod desc;
-- Question - 39] Insert 5 staff members into the Staff table with their role, phone, and email.
INSERT INTO staff (role, phone, email)
VALUES
('Manager', '9876543210', 'manager1@gmail.com'),
('Receptionist', '9123456780', 'reception@gmail.com'),
('Accountant', '9988776655', 'accounts@gmail.com'),
('Clerk', '9012345678', 'clerk@gmail.com'),
('Supervisor', '8899776655', 'supervisor@gmail.com');


-- Question - 40] The hotel manager wants to review bookings where CheckInDate is after '2024-
-- 01-01' to analyze recent occupancy.
select * from bookings where checkindate > '2024-01-01';
-- Question - 41] List all customers whose FirstName is 'Rahul' for a loyalty program.
select * from customers where firstname = 'rahul';
-- Question - 42] Show all unique room types offered by the hotel.
select distinct roomtype from rooms;
-- Question - 43] Identify customers who spent more than 50,000 in total.
select firstname,lastname,sum(TotalAmount) from customers join bookings on customers.customerid = bookings.customerid
group by firstname,lastname having sum(totalamount)>50000;
-- Question - 44] Delete all customers from the city 'TestCity'.

-- Question - 45] Find rooms that have the same PricePerNight. (Rooms self join)
select a.roomid,b.roomid,a.pricepernight from rooms a join rooms b on a.pricepernight = b.PricePerNight
where a.roomid < b.roomid ;
-- Question - 46] The manager wants to see staff whose Email ends with '@tcs.in' for corporate tieups.
select * from staff  where email like '%@tcs.in';

-- Question - 47] The analytics team wants to list all cities where maximum CustomerID is more
-- than 100.
select city,max(customerid) from customers group by city having max(customerid)>100;
-- Question - 48] Show all unique capacities in descending order.
select distinct capacity from rooms order by capacity desc;
-- Question - 49] List staff working as Managers.
-- Hotel Management System
select * from staff where role = 'manager';

-- Question - 50] Display each payment’s ID, Method, Amount in one line.
select concat_ws("|", paymentid,paymentmethod,amount) from payments;
-- Question - 51] Show the first 4 payments only.
select * from payments limit 4;

-- Question - 52] The hotel manager wants to review rooms where PricePerNight is between ₹2000
-- and ₹4000 to offer discounts.
select * from rooms where pricepernight between 2000 and 4000 ;
-- Question - 53] List all bookings ordered by CheckInDate.
select * from bookings order by checkindate ;
-- Question - 54] Display all unique CustomerIDs from bookings.
select distinct customerid from bookings;
-- Question - 55] The hotel manager wants to add new customer details. Insert 5 records with full
-- details into the Customers table.
INSERT INTO customers (firstname, lastname, email, phone, city)
VALUES
('Rahul', 'Deshpande', 'rahul.d@tcs.in', '9876543210', 'Jaipur'),
('Amit', 'Kulkarni', 'amit.k@infosys.com', '9123456789', 'Pune'),
('Om', 'Deshmukh', 'om.d@wipro.com', '9988776655', 'Nagpur'),
('Sneha', 'Patil', 'sneha.p@tcs.com', '9090909090', 'Nashik'),
('Priya', 'Sharma', 'priya.s@hcl.com', '9555443322', 'Bhopal');



        
-- Question - 56] Show the last 2 staff hired.
select * from staff order by staffid desc limit 2;
-- Question - 57] Identify rooms with PricePerNight higher than the maximum PricePerNight of
-- rooms with Capacity = 2. (Rooms subquery)
select roomid,roomtype from rooms
where pricepernight>(select max(pricepernight) from rooms where capacity = 2);
-- Question - 58] The HR team wants to see staff whose Role is not 'Chef' for role reallocation.
select * from staff where role != 'chef';
-- Question - 59] Show all unique cities in descending order from the Customers table.
select*from customers order by city desc;
-- Question - 60] Display the phone number of the Waiter only.
select phone from staff where role = 'waiter';
-- Question - 61] Display the last 2 bookings in the table.
select * from bookings order by bookingid desc ;
-- Question - 62] The marketing team wants to see customers living in Delhi or Chennai for
-- targeted promotions.
select * from customers where city = 'chennai' and   city = 'delhi';
-- Question - 63] Show all rooms where RoomType != 'Family' to plan renovations.
select * from rooms where roomid != 'family';
-- Question - 64] List staff emails ordered by their roles.
select email from staff order by role ;
-- Question - 65] Display all unique payment methods.
select distinct paymentmethod from payments;
-- Question - 66] The receptionist wants a list of customers whose Phone starts with '98' for mobile
-- offers.
select * from customers where phone like "98%";
-- Question - 67] Show the 3 cheapest rooms available for budget travelers.
-- Hotel Management System
select  * from rooms order by pricepernight asc limit 3;


-- Question - 68] Display the last 2 payments.
select * from payments order by paymentid desc limit 2;
-- Question - 69] Management wants to know which unique cities customers come from.
select distinct city from customers;
-- Question - 70] List all bookings where TotalAmount > 5000.
select * from customers where totalamount > 5000;
-- Question - 71] Display each staff’s Role with their Email in one column.
select concat_ws("/",firstname,lastname,role,email) from staff ;
-- Question - 72] Show the first 4 staff full names.
select concat(firstname,lastname) from staff limit 4;
-- Question - 73] Find bookings where TotalAmount is greater than all bookings made by
-- CustomerID = 10. (Bookings subquery)
select  * from bookings 
where totalamount >all (select totalamount 
                    from bookings 
                    where customerid = 10);
-- Question - 74] List rooms with capacity >= 3 for family bookings.
select * from rooms where capacity >3;
-- Question - 75] Display the RoomType and Price of only Suite rooms.
select pricepernight,roomtype from rooms where roomtype = 'suite';
-- Question - 76] The cashier wants to see payments with Amount between ₹2000 and ₹7000 for
-- mid-range billing checks.
select * from payments where amount between 2000 and 7000;
-- Question - 77] Insert 5 booking records into the Bookings table with all details.
INSERT INTO bookings
(   checkindate, checkoutdate, totalamount)
VALUES
(  '2025-01-10', '2025-01-12', 4500),

(  '2025-01-15', '2025-01-18', 9000),

(   '2025-02-01', '2025-02-03', 5000),

(   '2025-02-10', '2025-02-15', 15000),

(   '2025-03-05', '2025-03-07', 6000);


-- Question - 78] Display the 3 lowest payments made by customers.
select * from payments order by amount   limit 3 ;
-- Question - 79] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(bookingid,totalamount) as bookings_details  from bookings ;
-- Question - 80] Show all unique RoomIDs in descending order.
select distinct roomid from rooms order by roomid desc ;
-- Question - 81] Display each room’s RoomType and Price using CONCAT_WS.
select concat_ws("/",roomtype,pricepernight) from rooms ;
-- Question - 82] The admin wants to delete all bookings handled by StaffID = 3.
delete from bookings where staffid = 3;
-- Question - 83] Show customers whose FirstName length > 5 characters for a name-pattern
-- study.
select * from customers where length(firstname)>5;
-- Question - 84] Show all unique roles available in the hotel.
select distinct role  from staff ;
-- Question - 85] List all rooms where capacity is greater than 2.
select * from rooms where capacity >2;
-- Question - 86] Display each payment’s ID with Amount using CONCAT.
select concat(paymentid       ,   amount) from payments;
-- Question - 87] List all Card payments from the Payments table.
-- Hotel Management System
select * from payments where paymentmethod = 'card';

-- Question - 88] Delete all customers whose Email ends with '@test.com' as invalid.
delete from customers where email like "%@test.com";
-- Question - 89] The hotel manager wants to review bookings where CheckOutDate before '2023-
-- 12-31' to measure old occupancy.
select * from bookings ;
-- Question - 90] The front office manager needs to list rooms with capacity = 2 for couples.
select * from rooms where capacity = 2;
-- Question - 91] Show all unique capacities in descending order.
select distinct capacity from rooms order by capacity desc ;
-- Question - 92] The operations team wants to find the minimum TotalAmount in bookings.
select * from bookings order by totalamount asc limit 1;
-- Question - 93] Display all rooms by capacity in ascending order.
select * from rooms order by capacity ;
-- Question - 94] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(bookingid,totalamount) from bookings ;
-- Question - 95] The operations head wants to see rooms with Capacity = 4 AND PricePerNight >
-- ₹6000 for premium family packages.
select * from rooms where capacity = 4 and pricepernight > 6000;
-- Question - 96] Show staff full names combined into one column.
select concat(firstname,lastname)  as fullname from staff ;
-- Question - 97] The accounts team wants to see bookings where the TotalAmount is greater than
-- ₹10,000 to track high-value customers.
select * from bookings where totalamount > 10000;
-- Question - 98] Show all unique payment methods in descending order.
select distinct paymentmethod from payments order by paymentmethod desc;
-- Question - 99] List staff members who share the same Role. (Staff self join)
select a.firstname, a.lastname,b.firstname,b.lastname ,a.role   from staff a join staff b on a.role = b.role 
where a.firstname != b.firstname and a.lastname != b.lastname ;
-- Question - 100] Show customer first name, last name, and TotalAmount of their bookings using
-- JOIN between Customers and Bookings.
select firstname,lastname,totalamount from bookings join customers on bookings.customerid = customers.customerid;
-- Question - 101] Display the first 4 bookings only.
select * from bookings limit 4;
-- Question - 102] Show all unique staff first names.
select distinct firstname from staff;
-- Question - 103] Insert 5 new room records with type, price, and capacity into the Rooms table.
insert into rooms(roomtype,pricepernight,capacity)
values('doulble',4554,4),('suite',4000,2),('couple',3000,2),('single',1000,1),('suite',5000,2);
-- Question - 104] Display each customer’s full name and city using CONCAT_WS.
select concat_ws("|",firstname,lastname,city) from customers;
-- Question - 105] Show all unique cities in descending order from the Customers table.
select distinct city from customers order by city desc;
-- Question - 106] The analytics team wants to list all cities where maximum CustomerID is more
-- than 100.
select city,max(customerid) from customers group by city having max(customerid)>100;

-- Question - 107] The HR team wants to see staff whose FirstName is 'Priya' for employee
-- recognition.
select * from staff where firstname = "priya";
-- Question - 108] Display the last 2 staff members from the Staff table.
select * from staff order by staffid desc limit 2;
-- Question - 109] Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID,
-- and TotalAmount.
create view bookingsummary  as 
select bookingid,customerid,roomid,totalamount from bookings;
select * from bookingsummary;
-- Question - 110] Show all unique RoomIDs in descending order.
select distinct roomid from rooms order by roomid desc;
-- Question - 111] Display each staff’s role with their full name.
select concat(firstname,lastname) ,role from staff ;
-- Question - 112] The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
select * from rooms where pricepernight <7000;
-- Question - 113] Display the first 3 staff alphabetically by their first names.
select * from staff order by firstname asc limit 3;
-- Question - 114] List all bookings ordered by CheckInDate.
select * from bookings order by checkindate ;
-- Question - 115] Show all unique StaffIDs from the bookings.
select distinct staffid from bookings;
-- Question - 116] Display the first 4 customers’ full names only.
select concat(firstname,lastname) from customers limit 4;
-- Question - 117] Show all unique room types offered by the hotel.
select distinct roomtype from rooms ;
-- Question - 118] Display the phone number of the Waiter only.
select phone from staff where role = 'waiter';
-- Question - 119] Show all bookings where TotalAmount > 5000.
select * from bookings where totalamount> 5000;
-- Question - 120] The HR team wants to update Role = 'Senior Manager' where StaffID = 12.

update staff 
set role = 'senior manager' where  staffid = 12;
-- Question - 121] List all staff working as Managers.
select * from staff where role = 'manager';
-- Question - 122] Show the last 2 registered customers for follow-up.
select * from customers order by customerid desc limit 2;
-- Question - 123] Display each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(bookingid, ' - ', totalamount) AS Booking_Details
FROM bookings;

-- Question - 124] Insert 5 staff members into the Staff table with their role, phone, and email.
INSERT INTO staff ( role, phone, email)
VALUES
( 'Manager', '9876543210', 'manager1@hotel.com'),
( 'Senior Manager', '9123456789', 'senior.manager@hotel.com'),
( 'Receptionist', '9988776655', 'reception@hotel.com'),
( 'Housekeeping', '9090909090', 'housekeeping@hotel.com'),
( 'Accountant', '9555443322', 'accounts@hotel.com');

-- Question - 125] Display the RoomType and Price of only Suite rooms.
select roomtype,pricepernight from rooms where roomtype = 'suite';
-- Question - 126] The admin wants to delete all payments linked to BookingID = 15.
-- 8
delete from payments where bookingid = 15;
-- Question - 127] Display all unique capacities in descending order.
select distinct capacity from rooms order by capacity desc ;
-- Question - 128] Show the first 4 rooms sorted alphabetically by RoomType.
select * from rooms order by roomtype limit 4;
-- Question - 129] The cashier wants a report of payments where Amount < ₹1500 for small
-- transactions.
select * from payments where amount <15000;
-- Question - 130] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(bookingid, '-' ,totalamount) from bookings;
-- Question - 131] Display the last 2 added rooms from the Rooms table.
select * from rooms order by roomid desc limit 2;
-- Question - 132] List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal
-- attention.
select * from customers where firstname = 'amit' and  city = 'nagpur';
-- Question - 133] Insert 5 new customer details into the Customers table.
INSERT INTO customers (firstname, lastname, email, phone, city)
VALUES
('Rahul', 'Deshpande', 'rhul.d@tcs.in', '9876543210', 'Jaipur'),
('Amit', 'Kulkarni', 'amt.k@infosys.com', '9123456789', 'Pune'),
('Om', 'Deshmukh', 'om.d@wpro.com', '9988776655', 'Nagpur'),
('Sneha', 'Patil', 'seha.p@tcs.com', '9090909090', 'Nashik'),
('Priya', 'Sharma', 'prya.s@hcl.com', '9555443322', 'Bhopal');

-- Question - 134] Show staff full names combined into one column.
select concat(firstname,lastname) from staff;
-- Question - 135] Show all room details separated by commas using CONCAT_WS.
select concat_ws("   |    ",roomid,roomtype,pricepernight,capacity) from rooms ;
-- Question - 136] Display each customer’s name and phone number together using CONCAT.
select concat(firstname,"-",phone) from customers;
-- Question - 137] Display all payment details in one line using CONCAT_WS.
select concat_ws("|",paymentid,bookingid,paymentdate,paymentmethod,amount) from payments;
-- Question - 138] Show the last 2 bookings in the table.
select* from bookings order by bookingid desc limit 2 ;

-- Question - 139] List all payments ordered by PaymentDate.
select * from payments order by paymentdate ;
-- Question - 140] Show the 2 highest payments received.
select * from payments order by amount desc limit 2;
-- Question - 141] The marketing team wants to check customers whose FirstName is 'Rahul' for a
-- loyalty program.
select * from customers where firstname = 'rahul';
-- Question - 142] Display each PaymentID with its method using CONCAT.
select concat (paymentid ," - ",paymentmethod) from payments;
-- Question - 143] The operations team wants to list all PaymentMethods used more than 5 times.
select paymentmethod,count(*) from payments group by paymentmethod having count(*)>5;
-- Question - 144] Show the 2 most expensive rooms for VIP guests.
select * from rooms order by PricePerNight desc  limit 2 ;
-- Question - 145] Show each room’s RoomType and Price using CONCAT_WS.
select concat_ws("|",roomtype,pricepernight) from rooms ;
-- Question - 146] Display the first 3 staff alphabetically by their first names.
select * from staff order by firstname  asc limit 3;

-- Question - 147] List all bookings handled by StaffID = 2.
select * from bookings where staffid = 2;
-- Question - 148] The analytics team wants to find the city where average CustomerID is greater
-- than 50.
select city , avg(customerid) from customers 
group by city having avg(customerid)> 50;
-- Question - 149] The hotel wants to display the 2 most expensive rooms for VIP guests.
select * from rooms order by Roomid desc limit 2;
-- Question - 150] Show all unique first names of customers for a duplicate check.
select distinct firstname from customers ;
-- Question - 151] Show all unique roles in descending order.
select distinct role from staff order by role desc ;
-- Question - 152] Identify rooms whose Capacity is greater than the average Capacity of all
-- rooms. (Rooms subquery)
SELECT roomid, capacity
FROM rooms
WHERE capacity >
(
    SELECT AVG(capacity)
    FROM rooms
);

-- Question - 153] Display all rooms by capacity in ascending order.
select * from rooms order by capacity ;
-- Question - 154] Display the first 4 payments only.
select * from payments limit 4 ;
-- Question - 155] Show each payment’s ID, Method, Amount in one line.
select concat(paymentid," - ",paymentmethod,"-",amount) from payments ;
-- Question - 156] List all bookings where TotalAmount > 5000.
select * from bookings where totalamount > 5000;
-- Question - 157] Find all customers whose CustomerID is greater than the average CustomerID.
-- (Customers subquery)
select firstname,lastname,customerid from customers 
where customerid > (select avg(customerid) from customers );
-- Question - 158] The HR manager wants to see staff whose Role is not 'Chef' for role
-- reallocation.
select * from staff where role ='chaf';
-- Question - 159] The accounts team wants to check bookings where TotalAmount is greater than
-- ₹10,000.
select * from bookings where totalamount > 10000;
-- Question - 160] Display each staff’s role with their full name.
select role ,concat(firstname,lastname) from staff;
-- Question - 161] List staff members who share the same Role. (Staff self join)
select a.staffid,a.firstname,a.lastname,a.role,b.staffid,b.firstname,b.lastname
from staff a join staff b on a.role = b.role 
where a.staffid < b.staffid ;
        
-- Question - 162] Show Customer Name and Payment Amount by joining Customers, Bookings,
-- and Payments.
SELECT c.firstname, c.lastname, p.amount
FROM customers c
JOIN bookings b
    ON c.customerid = b.customerid
JOIN payments p
    ON b.bookingid = p.bookingid;

-- Question - 163] Display all bookings where TotalAmount > 5000.
-- Hotel Management System
select * from bookings where totalamount >5000;

-- Question - 164] The front desk wants to see customers whose Phone starts with '98'.
select * from customers where phone like "98%";
-- Question - 165] Identify customers who live in the same city. (Customers self join)
select a.firstname,a.lastname,b.firstname,b.lastname,a.city from customers a join customers b 
on a.city = b.city
where a.customerid != b.customerid ;
-- Question - 166] The operations manager wants to check bookings with CheckOutDate before
-- '2023-12-31'.
select * from bookings where checkoutdate < 2023-12-31;

-- Question - 167] Display all unique StaffIDs from the bookings.
select distinct staffid from bookings;
-- Question - 168] Create a VIEW OnlinePayments showing all payments made by
-- PaymentMethod = 'Online'.
create view onlinepayments as
select * from payments 
where paymentmethod = 'online';
select * from onlinepayments;

-- Question - 169] Display all unique payment methods in descending order.
select distinct paymentmethod from payments order by paymentmethod desc ;
-- Question - 170] Display each payment’s ID with Amount using CONCAT.
select concat(paymentid,"-",amount) from payments;
-- Question - 171] Show all unique RoomIDs in descending order.
select distinct roomid from rooms order by roomid desc ;
-- Question - 172] The analytics team wants to list all cities where maximum CustomerID is more
-- than 100.
select city, max(customerid) from customers group by city having max(customerid) > 100;
-- Question - 173] List staff emails ordered by their roles.
select email from staff order by role ;
-- Question - 174] Find bookings where TotalAmount exceeds the average TotalAmount.
-- (Bookings subquery)
select * from bookings 
where totalamount >(select avg(totalamount) from bookings );
-- Question - 175] Show all rooms where PricePerNight > ₹5000 for premium customer
-- recommendations.
select * from rooms where pricepernight >500;
-- Question - 176] Show all unique capacities in descending order.
select distinct capacity from rooms order by capacity desc;
-- Question - 177] Display the first 4 rooms sorted alphabetically by RoomType.
select * from rooms order by roomid limit 4;
-- Question - 178] Show all unique staff first names.
select distinct firstname from staff;
-- Question - 179] Identify rooms with PricePerNight higher than the maximum PricePerNight of
-- rooms with Capacity = 2. (Rooms subquery)
select roomid,pricepernight from rooms
where pricepernight>(select max(pricepernight) from rooms where capacity = 2);
-- Question - 180] Show all unique cities in descending order from the Customers table.
-- Hotel Management Systems
select distinct city from customers order by city desc ;

-- Question - 181] List all bookings where TotalAmount > 5000.
select * from bookings where totalamount >5000;
-- Question - 182] Show PaymentID, Customer Name, and BookingID for payments made using
-- 'Credit Card'.
SELECT 
    p.paymentid,
    c.firstname,
    c.lastname,
    b.bookingid
FROM customers c
JOIN bookings b
    ON c.customerid = b.customerid
JOIN payments p
    ON b.bookingid = p.bookingid
WHERE p.paymentmethod = 'Credit Card';

-- Question - 183] Display each booking’s BookingID with TotalAmount using CONCAT.
select concat(bookingid,'-',totalamount) from bookings;
-- Question - 184] Show all bookings handled by StaffID = 2.
select * from bookings where staffid = '2';
-- Question - 185] Display the last 2 added rooms from the Rooms table.
select * from rooms order by roomid desc limit 2;
-- Question - 186] List all rooms where capacity is greater than 2.
select * from rooms where capacity >2;
-- Question - 187] Display the last 2 staff members from the Staff table.
select * from staff order by staffid desc limit 2;
-- Question - 188] Show all unique roles available in the hotel.
select distinct role from staff  ;

-- Question - 189] Display the last 2 payments.
select * from payments order by paymentid desc limit 2;
-- Question - 190] The manager wants to see bookings where CustomerID IN (2,4,6,8) to track
-- repeat guests.
SELECT c.customerid, b.bookingid
FROM customers c
LEFT JOIN bookings b
    ON c.customerid = b.customerid
WHERE c.customerid IN (2, 4, 6, 8);
        
-- Question - 191] Show all unique first names of customers for a duplicate check.
select distinct firstname from customers ;
-- Question - 192] Display all bookings where TotalAmount > 5000.
select * from bookings where totalamount >5000;
-- Question - 193] The admin wants to delete all payments where Amount < 1000.
delete from payments where amount < 1000;
-- Question - 194] Display all unique RoomIDs in descending order.
select distinct roomid from rooms order by roomid desc ;
-- Question - 195] List customers who made more than 5 bookings.
SELECT customerid, COUNT(*) AS total_bookings
FROM bookings
GROUP BY customerid
HAVING COUNT(*) > 5;

-- Question - 196] Display all rooms by capacity in ascending order.
select * from rooms order by capacity asc ;
-- Question - 197] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(bookingid,totalamount) from bookings ;
-- Question - 198] List all staff working as Managers.
select * from staff where role = 'manager';
-- Question - 199] Show customers whose FirstName length > 5 characters for a name-pattern
-- study.
select * from customers where length(firstname) > 5;
-- Question - 200] Display all unique capacities in descending order.
    select distinct capacity  from rooms order by capacity desc ;
-- Question - 201] List staff members who share the same Role. (Staff self join)
select a.staffid,a.firstname,a.lastname,b.staffid,b.firstname,b.lastname,a.role from staff a join staff b
on a.role = b.role 
where a.staffid < b.staffid ;
-- Question - 202] Show PaymentID, Customer Name, and BookingID for payments made using
-- 'Credit Card'.
select p.paymentid,c.firstname,c.lastname,b.bookingid from customers c join bookings b 
on c.customerid = b.customerid 
join payments p on b.bookingid = p.bookingid ;
-- Question - 203] Display the first 4 payments only.
select * from payments limit 4;
-- Question - 204] Show each payment’s ID, Method, Amount in one line.
select concat_ws("|",paymentid,paymentmethod,amount) from payments ;
-- Question - 205] Create a VIEW HighValueBookings showing all bookings with TotalAmount >
-- 20,000.
create view highvaluebookings as
select * from bookings 
where totalamount > 20000;
select * from highvaluebookings;
-- Question - 206] Create a trigger to automatically delete a payment when its corresponding
-- booking is deleted.
delimiter //
create trigger ato__booking_delete 
after delete  on payments
for each row
begin
    delete from payments where bookingid =old.bookingid
end
delimiter //
-- Question - 207] Create a trigger to prevent insertion of a booking where CheckOutDate <
-- CheckInDate.
create trigger insertion_booking 
before insert on bookings 
for each row 
 if new.checkindate < new.checkoutdate then
 SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'CheckOutDate cannot be earlier than CheckInDate';
    END IF;
END

DELIMITER //
-- Question - 208] Create a trigger to automatically update TotalAmount in Bookings when a
-- payment is inserted in Payments
DELIMITER $$

CREATE TRIGGER update_totalamount_after_payment
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE bookings
    SET totalamount = totalamount + NEW.amount
    WHERE bookingid = NEW.bookingid;
END$$

DELIMITER ;

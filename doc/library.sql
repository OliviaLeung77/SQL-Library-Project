DROP DATABASE Library; 
 
CREATE DATABASE Library;
USE Library;


CREATE TABLE users
(userid INT(5) PRIMARY KEY, 
uname CHAR(20) NOT NULL, 
phone CHAR(10),
address VARCHAR(30),
university VARCHAR(25) NOT NULL);

CREATE TABLE books
(bid INT(4) PRIMARY KEY,
bname VARCHAR(40), 
pauthor VARCHAR(25) NOT NULL, 
sauthor VARCHAR(25), 
pubdate DATE,
pages INT(4),
publisher VARCHAR(30), 
translator VARCHAR(10),
topics TINYTEXT);#Not sure here

CREATE TABLE rentings
(userid INT(5) REFERENCES users(userid),
bid INT(4) REFERENCES books(bid),
rent_time DATETIME, 
comments TINYTEXT);

INSERT INTO users 
	VALUES (10001, 'Sharon', '9736487612','6573 A Street','Columbia University');
INSERT INTO users 
	VALUES (10002, 'Olivia', '3322487340','4312 Hunter St','New York University');
INSERT INTO users 
	VALUES (10003, 'Polly', '6462382844','2215 5 Avenue','New York University');
INSERT INTO users 
	VALUES (10004, 'Katherine', '2123630883','4310 Jackson Vernon','New York University');
INSERT INTO users 
	VALUES (10005, 'Joanna', '8573612347','1101 49 St','Boston University');
INSERT INTO users 
	VALUES (10006, 'Carina', '2024121993','2320 Garden St','Johns Hopkins University');
INSERT INTO users 
	VALUES (10007, 'Aurora', '3015265203','4715 1 Avenue','Sydney University');
    
INSERT INTO books (bid,bname,pauthor,pubdate,pages,publisher,topics)
	VALUES (6111, 'Marketing Analytics', 'Wayne L. Winston','2014-01-01',720,'Wiley','Business textbook, marketing');
INSERT INTO books (bid,bname,pauthor,pubdate,pages,publisher,translator,topics)
	VALUES (2331, 'The Hunger Games: Cathcing Fire', 'Suzanne Collins','2009-09-01',391,'Scholastic','Jia Xiuyan','Fiction');
INSERT INTO books (bid,bname,pauthor,sauthor,pubdate,pages,publisher,topics)
	VALUES (2332, 'Harry Potter and the Cursed Child', 'J.K. Rowling','John Tiffany','2016-07-30',224,'Pottermore Publishing','Fiction');
INSERT INTO books (bid,bname,pauthor,pubdate,pages,publisher,topics)
	VALUES (6112, 'Media Planning & Buying', 'Ronald Geskey','2017-01-01',631,'Marketing Communications LLC','Business textbook, media');
INSERT INTO books (bid,bname,pauthor,pubdate,pages,publisher,topics)
	VALUES (6113, 'SQL Practial Guide for Developers', 'Michael J. Donahoo','2005-01-01',631,'Diane Cerra','statistics');
 
INSERT INTO rentings
	VALUES (10002, 6111, '2021-04-23 11:30:35','This is a good book but hard to understand');
INSERT INTO rentings
	VALUES (10004, 6111, '2021-05-20 9:30:40','It was very useful in my market analysis class, I learnt a lot from this book with many basic concepts.');
INSERT INTO rentings 
	VALUES (10002, 6111, '2022-02-01 15:30:00','I rented it again because I forgot some of the marketing concepts, I think I found answeres in this book this time.');
INSERT INTO rentings
	VALUES (10001, 2331, '2021-03-08 12:30:35','It is so exciting and the story is really great.');
INSERT INTO rentings
	VALUES (10002, 2331, '2022-01-04 16:50:00','I am looking forward to enjoy the third episode.');
INSERT INTO rentings
	VALUES (10007, 2331, '2022-03-02 9:21:54','After reading this book, I would like to enjoy the film too. I think this novel reflect some social questions which are worth discussing.');
INSERT INTO rentings
	VALUES (10003, 2332, '2019-07-23 2:20:44','I think I am not really interested in Harry Potter, I think maybe I should wathch the movies first.');
INSERT INTO rentings
	VALUES (10006, 2332, '2020-09-1 18:56:25','This is my n times to watch Harry potter, everytime when I read them, I will also find some new things that I didnt notice before. The time watching Harry potter is chill, imagnary and released.');
INSERT INTO rentings
	VALUES (10005, 2332, '2022-01-1 7:15:00','Just finished, ready to read the next episode');
INSERT INTO rentings
	VALUES (10004, 6112, '2019-02-23 8:31:20','This textbook is so hard to find on the internet. I finally found that but my class has begin 1 month ago lol, but thank god I finally got it.');
INSERT INTO rentings
	VALUES (10001, 6112, '2020-09-30 17:01:07','Learn so much on it, I read it combing with the notes that I took in classes, I think it deepen my understandings of media planning and management.');
INSERT INTO rentings
	VALUES (10006, 6112, '2022-01-31 4:30:00','Just read the first 3 chapters, I dont think there is an advanced book of media planning and management. it is more like an entry level book.');

#SELECT * FROM books;
#SELECT * FROM users;
#SELECT * FROM rentings;

-- Which books have been checked out since 2019 to 2020?
SELECT b.bname, r.rent_time
FROM books as b, rentings as r
WHERE b.bid = r.bid AND r.rent_time >'2019-01-01 00:00:00' AND r.rent_time <'2020-12-31 11:59:59';

-- Which users have checked out Harry Potter and the Cursed Child and Media Planning & Buying book.
SELECT u.uname
FROM users AS u,rentings AS r
WHERE u.userid=r.userid AND r.bid IN('6112','2332')
GROUP BY u.uname
HAVING COUNT(*)>1;

-- How many books does the library have on fiction and statistics topic.
SELECT COUNT(bname) AS COUNT
FROM books
WHERE topics = 'fiction' OR topics = 'statistics';

-- Which users from New York University have checked out books on Marketing Analytics between 2021.04.01 and 22021.05.31.
SELECT u.uname, r.rent_time
FROM users AS u JOIN rentings AS r
ON u.userid = r.userid
WHERE r.bid = '6111' AND r.rent_time >'2021-04-01 00:00:00' AND r.rent_time <'2021-05-31 11:59:59' AND u.university =  'New York University';

-- What comments have been made by any User about Harry Potter and the Cursed Child and The Hunger Games: Cathcing Fire between 2021-01-01 and such 2022-12-31, ordered from the most recent to the least recent.
SELECT b.bname,r.comments,r.rent_time
FROM rentings AS r JOIN books AS b
ON r.bid = b.bid
WHERE r.bid IN('2331','2332') AND r.rent_time >'2021-01-01 00:00:00' AND r.rent_time <'2022-12-31 11:59:59'
ORDER BY r.rent_time;

-- Show for User Olivia, what comments she have made about The Hunger Games: Cathcing Fire and Marketing Analytics.
SELECT u.uname, r.comments
FROM users AS u JOIN rentings AS r
ON u.userid = r.userid
WHERE u.uname = 'OLIVIA' AND r.bid IN('6111','2331');

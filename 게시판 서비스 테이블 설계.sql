#날짜 : 2022/10/18
#이름 : 길은섭
#내용 : 게시판 서비스 테이블 설계

#데이터베이스 생성
CREATE DATABASE `java1_board`;
CREATE USER 'java1_board'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON `java1_board`.* TO 'java1_board'@'%';
FLUSH PRIVILEGES;

#회원 테이블 생성
CREATE TABLE `board_user` (
	`uid`		VARCHAR(20) PRIMARY KEY, 
	`pass`	VARCHAR(255),
	`name`	VARCHAR(20),
	`nick`	VARCHAR(20) UNIQUE,
	`email`	VARCHAR(100) UNIQUE,
	`hp`		CHAR(13) UNIQUE,
	`grade`	TINYINT DEFAULT 2,
	`zip`		CHAR(5),
	`addr1`	VARCHAR(255),
	`addr2`	VARCHAR(255),
	`regip`	VARCHAR(100),
	`rdate`	DATETIME
);

#약관 테이블 생성
CREATE TABLE `board_terms` (
	`terms`	 TEXT,		
	`privacy` TEXT
);

#게시물 테이블 생성
CREATE TABLE `board_article` (
	`no`			INT AUTO_INCREMENT PRIMARY KEY,
	`parent`		INT DEFAULT 0,
	`comment`	INT DEFAULT 0,
	`cate`		VARCHAR(20) DEFAULT 'free',
	`title`		VARCHAR(255),
	`content`	TEXT NOT NULL,
	`file`		TINYINT DEFAULT 0,
	`hit`			INT DEFAULT 0,
	`uid`			VARCHAR(20) NOT NULL,
	`regip`		VARCHAR(100) NOT NULL,
	`rdate`		DATETIME NOT NULL
);

#파일 테이블 생성
CREATE TABLE `board_file` (
	`fno`			INT AUTO_INCREMENT PRIMARY KEY,
	`parent`		INT,
	`newName`	VARCHAR(255),
	`oriName`	VARCHAR(255),
	`download`	INT DEFAULT 0,
	`rdate`		DATETIME
);

#비밀번호 은닉화(해시)
SELECT COUNT(`uid`) FROM `board_user` WHERE `uid`='abcd'

SELECT SHA('1234');
SELECT SHA2('1234', 256);

SELECT a.*, b.`name`, c.`prodName` FROM `order` AS a
JOIN `customer` AS b ON a.orderId = b.custId
JOIN `product` AS c ON a.orderProduct = c.prodNo;

SELECT a.*, b.`fno`, b`oriName`, b`download` 
FROM `board_article` AS a
LEFT JOIN `board_file` AS b
ON a.`no` = b.`parent`
WHERE `no`=2;

UPDATE `board_article` SET `hit` = `hit` + 1 WHERE `no`=1;
UPDATE `board_file` SET `download` = `download` + 1 WHERE `fno`=1;



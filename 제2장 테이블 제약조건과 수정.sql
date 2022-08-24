#날짜 : 2022/08/23
#이름 : 길은섭
#내용 : 제2장 테이블 제약조건과 수정

#실습 2-1 기본키로 지정된 칼럼은 반드시 데이터 입력(NULL x), 값 중복 x
create table `User2` (
	`uid`	varchar(20) primary key, #아이디 컬럼을 기본키로
    `name`	varchar(10),
    `hp`	char(13), 				 #전화번호도 중복이 안되서 PK를 지정해야함
    `age`	tinyint
);

#실습 2-2 
insert into `User2` values ('a103', '김유신', '010-1234-1001', 25); 
insert into `User2` values ('a102', '김춘추', '010-1234-1002', 23); 

#실습 2-3 유니크는 NULL 값 허용
create table `User3` (
	`uid`	varchar(20) primary key,
    `name`	varchar(10),
    `hp`	char(13) unique, 
    `age`	tinyint
);

#실습 2-4
insert into `User3` values ('a101', '김유신', '010-1234-1003', 25); 
insert into `User3` values ('a102', '김춘추', '010-1234-1002', 23);

#실습 2-5 외래키 두 테이블(부모-자식)을 연결하는 키, 부모자식의 값이 동일해야함(NULL포함) 
create table `Parent` (		#자식은 아무렇게 만들지 않음
	`pid`	varchar(10) primary key,
    `name`	varchar(10),
    `hp`	char(13) unique
);

create table `Child` (
	`cid`	varchar(10) primary key,
    `name`	varchar(10),
    `hp`	char(13) unique,
    `pid` 	varchar(10),
    foreign key (`pid`) references `Parent` (`pid`) #모델링을 통해 외래키 참조
);

insert into `Parent` values('p101', '이성계', '010-1234-1111');
insert into `Child` values('c101', '이방원', '010-1234-1001', 'p101');

#실습 2-6 자동번호 칼럼 기본키를 지정할 후보 키가 없는 테이블 사용
create table `User4` (
	`seq`		int primary key auto_increment,   #컬럼은 아무 이름이나
	`name`		varchar(10),
    `gender`	tinyint,
    `age`		tinyint,
    `addr`		varchar(255)	#varchar의 최대값
);

insert into `User4` (`name`, `gender`, `age`, `addr`) values('김유신', 1, 25, '김해시'); #시퀀스는 넣는거 아님
insert into `User4` (`name`, `gender`, `age`, `addr`) values('김춘추', 1, 23, '경주시'); #시퀀스는 넣는거 아님
insert into `User4` (`name`, `gender`, `age`, `addr`) values('신사임당', 2, 27, '연제구'); #시퀀스는 넣는거 아님
delete from `User4`	where `name`='신사임당';

#실습 2-7 디폴트는 값 입력 x 자동으로 입력되는 기본값, 반드시 데이터 입력 받아야 하는 컬럼은 NOT NULL 사용
create table `User5` (
	`name`		varchar(10) not null, #이름은 중요하니까 낫 널
    `gender`	tinyint,
    `age`		tinyint default 1, #age 컬럼에 널값 보단 디폴트1 넣어주는게 좋음
    `addr`		varchar(255)
);

insert into `User5` set `name`='김유신';
insert into `User5` set 
						`name`='김춘추',
                        `addr`='부산시'; #이름값을 안 넣었기 때문에 실행 오류

#실습 2-8 나중에 순서 수정
#실습 2-9
#실습 2-10
#실습 2-11 컬럼 추가
alter table `User5` add `hp` varchar(20);
alter table `User5` add `birth` char(10) default '0000-00-00' after `name`;
alter table `User5` add `uid` varchar(10) first;

#실습 2-12
alter table `User5` modify `hp` char(13);
alter table `User5` modify `age` tinyint;

#실습 2-13
alter table `User5` change column `addr` `address` varchar(100);

#실습 2-14
alter table `` drop ``;
#실습 2-15 데이터는 복사 되지 않음
create table `User6` like `User5`;
#실습 2-16 인서트 셀렉트 복합식(유저 5의 데이터를 6에 복사)
insert into `User6` select * from `User5`;
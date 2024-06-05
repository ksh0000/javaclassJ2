show tables;

create table worldGuest (
 	idx int not null auto_increment primary key, /* 방명록 고유번호*/
 	masterId varchar(20) not null,								/*게시글 올린이 아이디*/
	guestId varchar(20) not null,								/*게시글 올린이 아이디*/
	nickName varchar(20) not null,   /* 방명록 작성자 별명 */
	content text not null,       /* 방명록 글 내용 */
	email varchar(60)not null,           /* 메일주소 */
	visitDate datetime default now(),    /* 방문일자 */
	foreign key(masterId) references world(mid),
	foreign key(guestId) references world(mid)
);

desc worldGuest;

drop table worldGuest;

insert into worldGuest values (default, 'admin', '관리맨', '방명록 서비스를 시작합니다.', 'admin123@naver.com', default);
insert into worldGuest values (default, 'hkd1234', '실험맨',  '방명록 서비스를 시작합니다.', 'admin123@naver.com', default);
insert into worldGuest values (default, 'admin22', '확인맨',  '방명록 서비스를 시작합니다.', 'admin123@naver.com', default);
insert into worldGuest values (default, 'atom1234', '실수맨',  '방명록 서비스를 시작합니다.', 'admin123@naver.com', default);


select * from worldGuest;

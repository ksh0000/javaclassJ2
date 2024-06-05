show tables;

create table free (
	idx int not null auto_increment,  			/*게시글의 고유번호*/
	masterId varchar(20) not null,								/*게시글 올린이 아이디*/
	guestId varchar(20) not null,								/*게시글 보는이 아이디*/
	nickName varchar(20) not null,					/*게시글 올린이 닉네임*/
	title varchar(100) not null,						/*게시글 제목*/
	content text not null, 									/*글 내용*/
	readNum int default 0,									/*글 조회수*/
	wDate datetime default now(),						/*글쓴 날짜*/
	good int default 0,											/*'좋아요' 클릭 횟수 누적*/
	complaint char(2) default 'NO',					/*신고 글 유무(신고당한글:OK , 정상글:NO)*/
	primary key(idx),												/*기본키 : 고유번호*/
	foreign key(masterId) references world(mid),
	foreign key(guestId) references world(mid)
);

desc free;

drop table free;

insert into free values (default, 'admin','hkd1234', '관리맨', '게시판 서비스를 시작합니다.', '즐거운 게시판 생활 되세요', default, default, default, default);
insert into free values (default, 'admin','asd123', '관리맨2', '게시판 서비스를 시작합니다.2', '즐거운 게시판 생활 되세요2', default, default, default, default);
insert into free values (default, 'hkd1234','admin', '홍장군_', '게시판 서비스를 시작합니다.3', '즐거운 게시판 생활 되세요3', default, default, default, default);

select idx, title from free where idx < 4 and masterId='hkd1234' order by idx desc limit 1;
select idx, title from free where idx > 4 and masterId='hkd1234' order by idx limit 1

select * from free order by idx desc;
select * from free where masterId='admin' order by idx desc;
select * from free where masterId='hkd1234' order by idx desc;

/* 댓글달기 */
create table freeReply (
	idx int not null auto_increment,  /* 댓글 고유번호 */
	freeIdx int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
	mid varchar(20) not null,					/* 댓글 올린이의 아이디 */
	nickName varchar(20) not null,		/* 댓글 올린이의 닉네임 */
	wDate datetime default now(),			/* 댓글 올린 날짜/시간 */
	content text not null,						/* 댓글 내용*/
	primary key(idx),
	foreign key(freeIdx) references free(idx)
	on update cascade
	on delete restrict
);

desc freeReply;

drop table freeReply;

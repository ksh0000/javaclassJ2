show tables;

create table diary (
	idx int not null auto_increment,  /*스케줄관리 고유번호*/
	mid varchar(20) not null,					 /*회원 아이디 (일정검색시 필요) */
	sDate datetime not null,					 /*일정 등록 날짜*/
	part varchar(10) not null,				 /*일정분류(1.모임, 2.업무, 3.약속, 4.여행, 5.기타*/	
	content text not null,						 /*일정 상세내역*/
	primary key(idx),
	foreign key(mid) references world(mid)
);
drop table diary;
desc diary;
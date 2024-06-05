show tables;

/* 신고테이블(complaint) */
create table complaint(
	idx int not null auto_increment,  /* 신고테이블 고유번호 */
	part varchar(15) not null,				/* 신고 경로(게시판:board, 자료실:pds, 방명록:guest) */
	partIdx int not null,							/* 신고 경로 항목 글의 고유번호 */
	cpMid varchar(20) not null,				/* 신고자 아이디 */
	cpContent text not null,					/* 신고 사유 */
	cpDate datetime default now(),		/* 신고한 날짜 */
	primary key(idx)
);

desc complaint;


/* 댓글 테이블 */
create table comment(
	idx int not null auto_increment,  /*댓글 고유번호*/
	part varchar(20) not null,				/*분야(게시판:board, 자료실:pds....)*/
	partIdx int not null,							/*해당분야의 고유번호*/
	mid varchar(20) not null,					/*댓글 올린이*/
	nickName varchar(20) not null,		/*댓글 올린이 닉네임*/
	content text,											/*댓글 내용 */
	rDate	datetime default now(),			/*댓글 등록일자*/
	primary key(idx),
	foreign key(mid) references world(mid)
);

desc comment;
drop table comment;
/* 리뷰에 댓글 달기 */
create table cmreply(
  replyIdx    		int not null auto_increment,/* 댓글의 고유번호 */
  reviewIdx	int not null,								/* 원본글(부모글:리뷰)의 고유번호(외래키로 설정) */
  replyMid			varchar(20) not null,		/* 댓글 올린이의 아이디 */
  replyNickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  replyRDate		datetime default now(),	/* 댓글 올린 날짜 */
  replyContent	text not null,					/* 댓글 내용 */
  primary key(replyIdx),
  foreign key(reviewIdx) references review(idx),
  foreign key(replyMid) references world(mid)
);

desc cmreply;
drop table cmreply;

select count(content) as cnt from worldGuest where idx = cnt + 1;

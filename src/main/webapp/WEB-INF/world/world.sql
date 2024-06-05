show tables;

create table world (
	idx 				int not null auto_increment, 				/*회원 고유번호*/
	mid		 			varchar(30) not null,								/* 회원 아이디(중복불허) */
	pwd					varchar(200) not null,								/* 회원 비밀번호 */
	nickName 		varchar(20) not null,								/* 회원 별명(중복불허/수정가능) */
	name				varchar(20) not null,								/* 회원 성명 */
	gender			char(2)	not null default '남자',			/* 회원 성별 */
	birthday		datetime default now(),							/* 회원 생일 */
	tel					varchar(15)not null,								/* 전화번호 (비밀번호 분실시에 사용)*/
	email				varchar(60) not null,		  					/* 이메일(아이디 분실시에 사용)-형식체크필수 */
	photo				varchar(100) default 'a.jpg', /* 회원 사진 */
	todayCnt		int default 0,											/* 오늘 방문한 횟수 */
	visitCnt		int default 0,											/* 총 방문횟수 */
	startDate		datetime default now(),							/* 최초 가입일 */
	lastDate		datetime default now(),							/* 마지막 접속일 */
	hostIp			varchar(30) not null,								/* 방문자의 접속IP*/
	userDel	 		char(2)  default 'NO',							/* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
	level     int default 2,							/* 회원등급( 1:비로그인, 2:로그인, (3:운영자))  */
	primary key(idx),
	unique(mid)
	);
	
	desc world;
	drop table world;
	
insert into world values (default, 'admin', '1234', '관리맨', '관리자', default, default, '010-1234-5678', 'abc@atom.com', default, default, default, default, default, '192.168.50.52', default);

select * from world;




show tables;

create table board (
  idx  int  not null auto_increment,	/* 게시글의 고유번호 */
  nickName  varchar(20)  not null,		/* 게시글을 올린사람의 닉네임 */
  title			varchar(100) not null,		/* 게시글의 글 제목 */
  email			varchar(100),							/* 글쓴이의 메일주소 */
  homePage	varchar(100),							/* 글쓴이의 홈페이지(블로그)주소 */
  content		text not null,						/* 글 내용 */
  wDate			datetime default now(),		/* 글 올린 날짜 */
  readNum		int default 0,						/* 글 조회수 */
  hostIp		varchar(50) not null,			/* 접속 IP 주소 */
  good			int default 0,						/* '좋아요' 횟수 누적처리 */
  mid				varchar(20) not null,			/* 회원 아이디(게시글 조회시 사용) */
  primary key(idx)										/* 게시판의 기본키 : 고유번호 */
);

desc board;

insert into board values (default,'관리맨','게시판 서비스를 시작합니다.','cjsk1126@naver.com','http://blog.daum.net/cjsk1126','이곳은 게시판입니다.',default,default,'192.168.50.20',default,'admin');
select * from board;

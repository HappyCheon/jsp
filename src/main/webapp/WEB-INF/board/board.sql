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

select * from board where idx = 5-1;	/* 현재글이 5번글인경우 */
select * from board where idx = 1-1;	/* 현재글이 1번글인경우 */
select * from board where idx = 27-1;
select * from board where idx = 27+1;

select * from board where idx > 5 limit 1;  /* 다음글 */
select * from board where idx < 5 order by idx desc limit 1;  /* 이전글 */

/* 
  외래키(foreign key) : 서로다른 테이블간의 연관관계를 맺어주기위한 키
       : 외래키를 설정하려면, 설정하려는 외래키는 다른테이블의 주키(기본키 : Primary key)이어야 한다.
         즉, 외래키로 지정하는 필드는, 해당테이블의 속성과 똑 같아야 한다.
*/
/* 댓글 테이블(boardReply) */
create table boardReply (
  idx		int not null auto_increment,	/* 댓글의 고유번호 */
  boardIdx int not null,							/* 원본글의 고유번호(외래키로 지정함) */
  mid      varchar(20) not null,			/* 댓글 올린이의 아이디 */
  nickName varchar(20) not null,			/* 댓글 올린이의 닉네임 */
  wDate    datetime default now(),		/* 댓글쓴 날짜 */
  hostIp   varchar(50) not null,			/* 댓글쓴 PC의 IP */
  content  text				 not null,			/* 댓글 내용 */
  primary key(idx),										/* 주키(기본키)는 idx */
  foreign key(boardIdx) references board(idx)	/* board테이블의 idx를 boardReply테이블의 외래키(boardIdx)로 설정했다. */
  on update cascade				/* 원본테이블에서의 주키의 변경에 영향을 받는다. */
  on delete restrict			/* 원본테이블에서의 주키삭제 시키지 못하게 한다.(삭제시는 에러발생하고 원본키를 삭제하지 못함.) */
);

 
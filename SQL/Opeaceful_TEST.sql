/*부서 데이터*/
INSERT INTO department (DEPT_NAME) VALUES
   ('영업본부'),
   ('경영지원본부'),
   ('개발본부');

INSERT INTO department (DEPT_NAME,TOP_DEPT_CODE) VALUES
   ('영업팀',1),
   ('마케팅팀',1),
   ('재경팀',2),
   ('총무팀',2),
   ('인사팀',2),
   ('서비스개발팀',3),
   ('플랫폼운영팀',3),
   ('디자인팀',3);

/*직급 데이터*/
INSERT INTO position (P_NAME) VALUES
   ('사장'),
   ('부사장'),
   ('이사'),
   ('부장'),
   ('차장'),
   ('과장'),
   ('대리'),
   ('주임'),
   ('사원');



INSERT INTO MEMBER(ENO, STATUS_TYPE, USER_PWD, USER_NAME, HIRE_DATE, EMAIL)
   VALUES ( 230502 , 0,'$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', 'test', SYSDATE(), 'test@gmail.com');

/* 계정 등록(팀게시판 조회 조건) = user_no = 3 , 4 두명 필요하고 and 둘 다 영업팀 이어야함 직급은 상관없음!!*/

/*공지사항 고정게시글 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,FIXED)
VALUES ('2023년 하절기 사옥 냉난방기 운용 관련 공지','TEST1','1','N',default,'2022-05-12','Y'),
('2023년 06월 전사 플레이샵 조 편성 및 차량배정 관련 공지 글(필독)','TEST2','1','N',default,'2022-04-24','Y'),
('2023년 07월 ~ 08월 하계 휴가기간 제주도 리조트 예약 신청 공지 건','TEST3','1','N',default,'2022-04-15','Y'),
('5/1(월) 근로자의 날 휴무 관련 공지','TEST3','1','N',default,'2022-04-03','Y'),
('2023년 인사발령','TEST5','1','N',default,'2022-03-12','Y');
/*공지 고정아닌글*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,FIXED)
VALUES ('공지사항1','TEST1','1','N',default,'2023-05-12','N'),
('공지사항2','TEST2','1','N',default,'2023-04-24','N'),
('공지사항3','TEST3','1','N',default,'2023-04-21','N'),
('공지사항4','TEST3','1','N',default,'2023-04-20','N'),
('공지사항5','TEST5','1','N',default,'2023-04-19','N'),
('공지사항6','TEST3','1','N',default,'2023-04-08','N'),
('공지사항7','TEST3','1','N',default,'2023-04-07','N'),
('공지사항8','TEST3','1','N',default,'2023-04-06','N'),
('공지사항9','TEST3','1','N',default,'2023-04-05','N'),
('공지사항10','TEST3','1','N',default,'2023-04-04','N'),
('공지사항11','TEST3','1','N',default,'2023-04-03','N');
/*자유게시판 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES ('영업팀 최고','TEST1','1','F',default,'2023-05-12'),
('인사팀 최고','TEST2','1','F',default,'2023-04-24'),
('회계팀 최고','TEST3','1','F',default,'2023-04-15'),
('마케팅팀 최고','TEST4','2','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','2','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','2','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','3','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','3','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','3','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','4','F',default,'2023-04-03'),
('마케팅팀 최고','TEST4','4','F',default,'2023-04-03'),
('개발팀 최고','TEST5','4','F',default,'2023-03-12');
/*팀게시판 데이터*/
INSERT INTO BOARD(DEPT_CODE,BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES (4,'여기는','TEST1','3','T',default,'2023-05-12'),
(4,'영업팀','TEST2','3','T',default,'2023-04-24'),
(4,'게시판','TEST3','3','T',default,'2023-04-15'),
(4,'리스트','TEST4','3','T',default,'2023-04-03'),
(4,'입니당','TEST5','3','T',default,'2023-03-12'),
(4,'영엄팀은','TEST1','4','T',default,'2023-05-12'),
(4,'코드번호','TEST2','4','T',default,'2023-04-24'),
(4,'4번','TEST3','4','T',default,'2023-04-15'),
(4,'~~~','TEST4','4','T',default,'2023-04-03'),
(4,'입니당','TEST5','4','T',default,'2023-03-12');










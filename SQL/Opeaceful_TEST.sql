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

/*공지사항 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES ('2023년 하절기 사옥 냉난방기 운용 관련 공지','TEST1','admin','N',default,'2023-05-12'),
('2023년 06월 전사 플레이샵 조 편성 및 차량배정 관련 공지 글(필독)','TEST2','admin','N',default,'2023-04-24'),
('2023년 07월 ~ 08월 하계 휴가기간 제주도 리조트 예약 신청 공지 건)','TEST3','admin','N',default,'2023-04-15'),
('5/1(월) 근로자의 날 휴무 관련 공지','TEST4','admin','N',default,'2023-04-03'),
('2023년 인사발령','TEST5','admin','N',default,'2023-03-12'),
('2023년 07월 ~ 08월 하계 휴가기간 제주도 리조트 예약 신청 공지 건','TEST6','admin','N',default,'2023-03-11');


/*공지사항 고정게시글 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,FIXED)
VALUES ('고','TEST1','admin','N',default,'2022-05-12','Y'),
('정','TEST2','admin','N',default,'2022-04-24','Y'),
('게','TEST3','admin','N',default,'2022-04-15','Y'),
('시','TEST3','admin','N',default,'2022-04-03','Y'),
('글','TEST5','admin','N',default,'2022-03-12','Y');
/*자유게시판 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES ('영업팀 최고','TEST1','admin','F',default,'2023-05-12'),
('인사팀 최고','TEST2','admin','F',default,'2023-04-24'),
('회계팀 최고','TEST3','admin','F',default,'2023-04-15'),
('마케팅팀 최고','TEST4','admin','F',default,'2023-04-03'),
('개발팀 최고','TEST5','admin','F',default,'2023-03-12');
/*팀게시판 데이터*/
INSERT INTO BOARD(DEPT_CODE,BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES (6,'6번코드','TEST1','3','T',default,'2023-05-12'),
(6,'팀','TEST2','3','T',default,'2023-04-24'),
(6,'게시판','TEST3','3','T',default,'2023-04-15'),
(6,'상세보기','TEST4','3','T',default,'2023-04-03'),
(6,'입니당','TEST5','3','T',default,'2023-03-12'),
(5,'5번코드','TEST1','4','T',default,'2023-05-12'),
(5,'팀','TEST2','4','T',default,'2023-04-24'),
(5,'게시판','TEST3','4','T',default,'2023-04-15'),
(5,'상세보기','TEST4','4','T',default,'2023-04-03'),
(5,'입니당','TEST5','4','T',default,'2023-03-12');










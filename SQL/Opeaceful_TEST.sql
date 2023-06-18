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

/* 계정 등록(팀게시판 조회 조건) = user_no = 3 , 4 두명 필요하고 and 둘 다 영업팀 이어야함 직급은 상관없음!! user_no = 5 는  마케팅팀!*/

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

INSERT INTO BOARD(DEPT_CODE,BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES (5,'여기는','TEST1','5','T',default,'2023-05-12'),
(5,'마케팅팀','TEST2','5','T',default,'2023-04-24'),
(5,'게시판','TEST3','5','T',default,'2023-04-15'),
(5,'리스트','TEST4','5','T',default,'2023-04-03'),
(5,'입니당','TEST5','5','T',default,'2023-03-12'),
(5,'마케팅팀은','TEST1','5','T',default,'2023-05-12'),
(5,'코드번호','TEST2','5','T',default,'2023-04-24'),
(5,'5번','TEST3','5','T',default,'2023-04-15'),
(5,'~~~','TEST4','5','T',default,'2023-04-03'),
(5,'입니당','TEST5','5','T',default,'2023-03-12');

/*멤버 데이터*/
INSERT INTO MEMBER(ENO, STATUS_TYPE, USER_PWD, USER_NAME,HIRE_DATE, PHONE,EMAIL, ADDRESS,EXTENSION)
VALUES
  (200501, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이하나', '2020-05-01', '010-1234-5677', 'example0@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200502, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김둘셋', '2020-05-01', '010-1234-5666', 'example23@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200503, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김철수', '2020-05-01', '010-1234-5678', 'example1@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200504, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김지민', '2020-05-01', '010-9876-5432','testuser2@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200505, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이예진', '2020-05-01', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200506, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박준호', '2020-05-01', '010-1234-5678', 'example1@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200507, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최서연', '2020-05-01', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200508, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정승민', '2020-05-01','010-1234-5678', 'example1@gmail.com', '서울특별시 강남구 가로수길 1,',''),
  (200509, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '강지우', '2020-05-01', '010-2468-1357', 'random_email3@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200510, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '윤서준', '2020-05-01', '010-5798-6423', 'email7_address@gmail.com','서울특별시 강남구 가로수길 1, 101',''),
  (200511, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '장민서', '2020-05-01', '010-2468-1357', 'random_email3@gmail.com','서울특별시 강남구 가로수길 1,123',''),
  (200512, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안하린', '2020-05-11','010-1357-2468', 'myemail5@gmail.com', '부산광역시 해운대구 해운대해변로 1,',''),
  (200513, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황승현', '2020-05-12',  '010-9876-5432','testuser2@gmail.com','대구광역시 중구 동성로 1,',''),
  (200514, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '장현준', '2020-05-14', '010-2468-1357', 'random_email3@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (200515, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '한민우', '2020-05-14', '010-5798-6423', 'email7_address@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (200716, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박세은', '2020-07-06', '010-1234-5678', 'example1@gmail.com','대구광역시 동구 동대구로 1,',''),
  (200717, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박지민', '2020-07-30', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (200818, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김태희', '2020-08-01',  '010-9876-5432','testuser2@gmail.com','부산광역시 사하구 광장로 1,',''),
  (200819, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정유미', '2020-08-02', '010-6423-5798', 'randomuser6@gmail.com','대구광역시 남구 대명로 1,',''),
  (210920, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박지윤', '2021-09-11', '010-6423-5798', 'randomuser6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (210921, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '임예준', '2021-09-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (210922, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정서은', '2021-09-14', '010-1357-2468', 'myemail5@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (210923, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김영숙', '2021-09-14', '010-1234-5678', 'example1@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (211024, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정재민', '2021-10-06',  '010-9876-5432','testuser2@gmail.com','대구광역시 동구 동대구로 1,',''),
  (211025, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김현서', '2021-10-30', '010-6423-5798', 'randomuser6@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (211126, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최하율', '2021-11-01',  '010-9876-5432','testuser2@gmail.com','부산광역시 사하구 광장로 1,',''),
  (211127, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김유나', '2021-11-02','010-1234-5678', 'example1@gmail.com', '대구광역시 남구 대명로 1,',''),
  (211228, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '강하윤', '2021-12-11', '010-6423-5798', 'randomuser6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (211229, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황승현', '2021-12-12',  '010-9876-5432','testuser2@gmail.com','대구광역시 중구 동성로 1,',''),
  (211230, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '송예은', '2021-12-14', '010-1234-5678', 'example1@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (211231, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이현우', '2021-12-14', '010-2468-1357', 'user4_email@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (220132, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이철호', '2022-01-06', '010-8642-9731', 'random_email3@gmail.com','대구광역시 동구 동대구로 1,',''),
  (220133, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이준혁', '2022-01-30','010-2468-1357', 'random_email3@gmail.com', '서울특별시 강동구 천호대로 1,',''),
  (220334, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김태희', '2022-03-01', '010-1234-5678', 'example1@gmail.com','부산광역시 사하구 광장로 1,',''),
  (220335, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최민석', '2022-03-02','010-6423-5798', 'randomuser6@gmail.com', '대구광역시 남구 대명로 1,',''),
  (220336, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '송예준', '2022-03-06', '010-5798-6423', 'email7_address@gmail.com','대구광역시 동구 동대구로 1,',''),
  (220337, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황하은', '2022-03-30', '010-9731-8642', 'user8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (220438, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '서하은', '2022-04-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (220439, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정유미', '2022-04-02', '010-9864-7531', 'email_address10@gmail.com','대구광역시 남구 대명로 1,',''),
  (220540, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안하린', '2022-05-11', '010-6423-5798', 'randomuser6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (220541, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안우진', '2022-05-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (220642, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '윤예준', '2022-06-06', '010-5798-6423', 'email7_address@gmail.com','대구광역시 동구 동대구로 1,',''),
  (221143, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정은서', '2022-11-30', '010-9731-8642', 'user8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (221244, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최하윤', '2022-12-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (230145, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박예준', '2023-01-02', '010-9864-7531', 'email_address10@gmail.com','대구광역시 남구 대명로 1,',''),
  (230146, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이지우', '2023-01-11', '010-6423-5798', 'randomuser6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (230147, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김시윤', '2023-01-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (230248, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '한민서', '2023-02-06', '010-5798-6423', 'email7_address@gmail.com','대구광역시 동구 동대구로 1,',''),
  (230349, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최준서', '2023-03-30', '010-9731-8642', 'user8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (230450, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '임하늘', '2023-04-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (230451, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박현서', '2023-04-02', '010-9864-7231', 'email_address10@gmail.com','대구광역시 남구 대명로 1,',''),
  (230552, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김유진', '2023-05-11', '010-6423-5798', 'randomuser6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (230553, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이시우', '2023-05-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,','');


/*멤버 데이터 부서등록*/
INSERT INTO user_department(USER_NO, DEPT_CODE,P_CODE )
VALUES (1,4,1),
	  (2,4,3),
      (3,4,3),
      (4,4,4),
      (5,5,4),
      (6,6,4),
      (7,7,4),
      (8,8,4),
      (9,9,4),
      (10,10,4),
      (11,11,4),
      (12,4,5),
      (13,4,6),
      (14,4,7),
      (15,5,5),
      (16,5,6),
      (17,5,7),
      (18,6,5),
      (19,6,6),
      (20,6,7),
      (21,7,5),
      (22,7,6),
      (23,7,7),
      (24,8,5),
      (25,8,6),
      (26,8,7),
      (27,9,5),
      (28,9,6),
      (29,9,7),
      (30,10,5),
      (31,10,6),
      (32,10,7),
      (33,11,5),
      (34,11,6),
      (35,11,7),
      (36,4,9),
      (37,4,9),
      (38,5,9),
      (39,5,9),
      (40,6,9),
      (41,6,9),
      (42,7,9),
      (43,7,9),
      (44,8,9),
      (45,8,9),
      (46,9,9),
      (47,9,9),
      (48,10,9),
      (49,10,9),
      (50,11,9),
      (51,11,9),
      (52,4,8),
      (53,4,8);


/*권한 더미데이터, 부장~대리까지 임시로 넣어둠*/
INSERT INTO department_role(DEPT_CODE,P_CODE,ROLE_CODE )
VALUES
(8,4,'A01'),
(8,5,'A01'),
(8,6,'A01'),
(8,7,'A01'),
(8,4,'B01'),
(8,5,'B01'),
(8,6,'B01'),
(8,7,'B01'),
(8,4,'B02'),
(8,5,'B02'),
(8,6,'B02'),
(8,7,'B02'),
(8,4,'D01'),
(8,5,'D01'),
(8,6,'D01'),
(8,7,'D01'),
(8,4,'M01'),
(8,5,'M01'),
(8,6,'M01'),
(8,7,'M01'),
(8,4,'R01'),
(6,4,'S01'),
(6,5,'S01'),
(6,6,'S01'),
(6,7,'S01'),
(7,4,'T01'),
(7,5,'T01'),
(7,6,'T01'),
(7,7,'T01'),
(7,4,'T02'),
(7,5,'T02'),
(7,6,'T02'),
(7,7,'T02'),
(8,5,'Y01'),
(8,6,'Y01'),
(8,7,'Y01'),
(8,4,'Y01');

/* USER_NO : 8 에 모든권한 들어있음 */
INSERT user_role(USER_NO,ROLE_CODE) VALUE (8,'S01');
INSERT user_role(USER_NO,ROLE_CODE) VALUE (8,'T01');
INSERT user_role(USER_NO,ROLE_CODE) VALUE (8,'T02');


-- approval 더미 데이터 생성용
DELIMITER $$
CREATE PROCEDURE add_approval() -- ⓐ myFunction이라는 이름의 프로시저
BEGIN
    DECLARE i INT DEFAULT 1; -- ⓑ i변수 선언, defalt값으로 1설정
    WHILE (i <= 20) DO -- ⓒ for문 작성(i가 기준수가 될 때까지 반복)
        INSERT INTO approval(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
		VALUES
			(i, 1, "휴가", 1, '2022-11-20 15:28' ,'2022-11-27','2022-11-30'),
			(i, 3, "오후반차", 1, '2022-12-02 10:40' ,'2022-12-08','2022-12-08'),
			(i, 1, "휴가", 1, '2022-12-24 11:24' ,'2022-12-29','2023-01-02'),
			(i, 1, "휴가", 1, '2022-12-20 15:28' ,'2023-01-02','2023-01-05'),
			(i, 3, "오후반차", -1, '2023-01-22 11:40' ,'2023-02-08','2023-02-08'),
			(i, 2, "오전반차", -1, '2023-02-25 13:05' ,'2023-03-02','2023-03-02'),
			(i, 1, "휴가", 0, '2023-05-06 16:09' ,'2023-05-28','2023-05-28'),
			(i, 0, "일반", 0, '2023-05-20 10:45' ,'2023-06-01','2023-06-01');

        INSERT INTO approval_line(APPROVAL_NO, CONFIRM_STATUS, DATE, LEVEL, STATUS, TYPE, USER_NO)
		VALUES  (i*8-7 , 'Y', '2023-05-20 10:45', 1,  2 , 'A' , i ),
				(i*8-6 , 'Y', '2023-05-20 10:45', 1,  2 , 'A' , i ),
				(i*8-5 , 'Y', '2023-05-20 10:45', 1,  2 , 'A' , i ),
				(i*8-4 , 'Y', '2023-05-20 10:45', 1,  2 , 'A' , i ),
				(i*8-3 , 'Y', '2023-05-20 10:45', 1,  -1 , 'A' , i ),
				(i*8-2 , 'Y', '2023-05-20 10:45', 1,  -1 , 'A' , i ),
				(i*8-1 , 'Y', null, 1,  1 , 'A' , i ),
				(i*8 , 'N', null , 1,  1 , 'A' , i );

        SET i = i + 1; -- ⓔ i값에 더해주고 WHILE문 처음으로 이동
    END WHILE;
END$$
DELIMITER ;
CALL add_approval(); -- 프로시저 실행, 테이블에 1~1000까지 숫자 채워주기
DROP PROCEDURE IF EXISTS add_approval; -- 사용 다한 프로시저는 삭제해주기! 테스트데이터 다시돌릴 때 이미 있는프로시저라고 오류남

-- 휴가 등록 임시
-- INSERT INTO approval(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
-- VALUES
-- 		(3, 1, "휴가", 1, '2022-11-20 15:28' ,'2022-11-27','2022-11-30'),
-- 		(3, 3, "오후반차", 0, '2022-12-02 10:40' ,'2022-12-08','2022-12-08'),
--         (3, 1, "휴가", 1, '2022-12-24 11:24' ,'2022-12-29','2023-01-02'),
-- 		(3, 1, "휴가", 0, '2022-12-20 15:28' ,'2023-01-02','2023-01-05'),
-- 		(3, 3, "오후반차", 1, '2023-01-22 11:40' ,'2023-02-08','2023-02-08'),
--         (3, 2, "오전반차", -1, '2023-02-25 13:05' ,'2023-03-02','2023-03-02'),
--         (3, 1, "휴가", 2, '2023-05-06 16:09' ,'2023-05-28','2023-05-28'),
--         (3, 1, "휴가", 1, '2023-05-20 10:45' ,'2023-06-01','2023-06-01');

-- 유저 1,2,8에 연차 임시로 넣어둠
UPDATE `opeaceful`.`member` SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '8');
UPDATE `opeaceful`.`member` SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '2');
UPDATE `opeaceful`.`member` SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '1');
-- 테스트 데이터 입력용 프로시저




-- approval_form 더미 데이터 생성용
INSERT INTO `approval_form`(TYPE, TITLE, CONTENT) VALUES (0, '지출결의서', '<table style="border-collapse: collapse; width: 88.9823%; height: 556px;" border="1">
 <tbody>
 <tr style="height: 66.7344px;">
 <td style="height: 66.7344px; text-align: center; width: 99.9101%;" colspan="5"><span style="font-size: 24pt;"><strong>지 출 결 의 서&nbsp;</strong></span><strong><br /></strong></td>
 </tr>
 <tr style="height: 20px;">
 <td style="height: 60px; text-align: center; width: 11.1345%;" rowspan="3">인적사항</td>
 <td style="width: 13.7605%; height: 20px; text-align: center;">소&nbsp; &nbsp; 속</td>
 <td style="height: 20px; width: 75.0151%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 20px;">
 <td style="width: 13.7605%; height: 20px; text-align: center;">직&nbsp; &nbsp; 위</td>
 <td style="height: 20px; width: 75.0151%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 20px;">
 <td style="width: 13.7605%; height: 20px; text-align: center;">성&nbsp; &nbsp; 명</td>
 <td style="height: 20px; width: 75.0151%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 42.1719px;">
 <td style="text-align: center; height: 42.1719px; width: 11.1345%;">지출 금액</td>
 <td style="text-align: center; height: 42.1719px; width: 88.7756%;" colspan="4">000,000 원</td>
 </tr>
 <tr style="height: 34.8594px;">
 <td style="text-align: center; height: 219.094px; width: 11.1345%;" rowspan="6">내역</td>
 <td style="text-align: center; height: 34.8594px; width: 33.7336%;" colspan="2">사용처</td>
 <td style="width: 19.8529%; text-align: center; height: 34.8594px;">금액</td>
 <td style="width: 35.1891%; height: 34.8594px; text-align: center;">비고</td>
 </tr>
 <tr style="height: 36.5938px;">
 <td style="text-align: center; width: 33.7336%; height: 36.5938px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 36.5938px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 36.5938px;">&nbsp;</td>
 </tr>
 <tr style="height: 37.5938px;">
 <td style="text-align: center; width: 33.7336%; height: 37.5938px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 37.5938px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 37.5938px;">&nbsp;</td>
 </tr>
 <tr style="height: 35px;">
 <td style="text-align: center; height: 35px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 35px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 35px;">&nbsp;</td>
 </tr>
 <tr style="height: 39.6094px;">
 <td style="text-align: center; width: 33.7336%; height: 39.6094px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 39.6094px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 39.6094px;">&nbsp;</td>
 </tr>
 <tr style="height: 35.4375px;">
 <td style="text-align: center; height: 35.4375px; width: 33.7336%;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 35.4375px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 35.4375px;">&nbsp;</td>
 </tr>
 <tr style="height: 168px;">
 <td style="text-align: center; width: 99.9101%; height: 168px;" colspan="5">
 <p style="text-align: left;">&nbsp; &nbsp; 위 금액을 청구하오니 결재 바랍니다</p>
 <p style="text-align: left;">&nbsp;</p>
 <p>0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 </td>
 </tr>
 </tbody>
 </table>');
INSERT INTO `approval_form`(TYPE, TITLE, CONTENT) VALUES (1, 'OOO 휴가신청서입니다', '<table style="border-collapse: collapse; width: 88.9823%; height: 762.891px;" border="1">
 <tbody>
 <tr style="height: 93.25px;">
 <td style="height: 93.25px; text-align: center; width: 100%;" colspan="4"><span style="font-size: 24pt;"><strong>휴 가 신 청 서</strong></span></td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="height: 138.812px; text-align: center; width: 13.8655%;" rowspan="3">인적사항</td>
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">소&nbsp; &nbsp; 속</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">직&nbsp; &nbsp; 위</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 43.9375px;">
 <td style="width: 17.2269%; height: 43.9375px; text-align: center;">성&nbsp; &nbsp; 명</td>
 <td style="height: 43.9375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 53.125px;">
 <td style="text-align: center; height: 530.829px; width: 13.8655%;" rowspan="4">신청내용</td>
 <td style="text-align: center; height: 101.188px; width: 17.2269%;" rowspan="2">휴가신청</td>
 <td style="text-align: center; width: 54.937%; height: 53.125px;">0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일 부터</td>
 <td style="text-align: center; height: 101.188px; width: 13.9706%;" rowspan="2">( 0 일간 )</td>
 </tr>
 <tr style="height: 48.0625px;">
 <td style="text-align: center; width: 54.937%; height: 48.0625px;">0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일 까지</td>
 </tr>
 <tr style="height: 384.641px;">
 <td style="text-align: center; width: 17.2269%; height: 384.641px;">신청 사유</td>
 <td style="height: 384.641px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 45px;">
 <td style="text-align: center; height: 45px; width: 17.2269%;">긴급연락처</td>
 <td style="height: 45px; width: 68.9076%; text-align: left;" colspan="2">&nbsp;</td>
 </tr>
 </tbody>
 </table>');
INSERT INTO `approval_form`(TYPE, TITLE, CONTENT) VALUES (2, 'OOO 오전반차 신청서입니다', '<table style="border-collapse: collapse; width: 88.9823%; height: 720.891px;" border="1">
 <tbody>
 <tr style="height: 93.25px;">
 <td style="height: 93.25px; text-align: center; width: 100%;" colspan="4"><span style="font-size: 24pt;"><strong>휴 가 신 청 서</strong></span></td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="height: 138.812px; text-align: center; width: 13.8655%;" rowspan="3">인적사항</td>
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">소&nbsp; &nbsp; 속</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">직&nbsp; &nbsp; 위</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 43.9375px;">
 <td style="width: 17.2269%; height: 43.9375px; text-align: center;">성&nbsp; &nbsp; 명</td>
 <td style="height: 43.9375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 59.188px;">
 <td style="text-align: center; height: 488.829px; width: 13.8655%;" rowspan="3">신청내용</td>
 <td style="text-align: center; height: 59.188px; width: 17.2269%;">휴가신청</td>
 <td style="text-align: center; width: 54.937%; height: 59.188px;">0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일&nbsp; 오전</td>
 <td style="text-align: center; height: 59.188px; width: 13.9706%;">( 0.5 일간 )</td>
 </tr>
 <tr style="height: 384.641px;">
 <td style="text-align: center; width: 17.2269%; height: 384.641px;">신청 사유</td>
 <td style="height: 384.641px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 45px;">
 <td style="text-align: center; height: 45px; width: 17.2269%;">긴급연락처</td>
 <td style="height: 45px; width: 68.9076%; text-align: left;" colspan="2">&nbsp;</td>
 </tr>
 </tbody>
 </table>');
INSERT INTO `approval_form`(TYPE, TITLE, CONTENT) VALUES (3, 'OOO 오후반차 신청서입니다', '<table style="border-collapse: collapse; width: 88.9823%; height: 720.891px;" border="1">
 <tbody>
 <tr style="height: 93.25px;">
 <td style="height: 93.25px; text-align: center; width: 100%;" colspan="4"><span style="font-size: 24pt;"><strong>휴 가 신 청 서</strong></span></td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="height: 138.812px; text-align: center; width: 13.8655%;" rowspan="3">인적사항</td>
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">소&nbsp; &nbsp; 속</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 47.4375px;">
 <td style="width: 17.2269%; height: 47.4375px; text-align: center;">직&nbsp; &nbsp; 위</td>
 <td style="height: 47.4375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 43.9375px;">
 <td style="width: 17.2269%; height: 43.9375px; text-align: center;">성&nbsp; &nbsp; 명</td>
 <td style="height: 43.9375px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 59.188px;">
 <td style="text-align: center; height: 488.829px; width: 13.8655%;" rowspan="3">신청내용</td>
 <td style="text-align: center; height: 59.188px; width: 17.2269%;">휴가신청</td>
 <td style="text-align: center; width: 54.937%; height: 59.188px;">0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일&nbsp; 오후</td>
 <td style="text-align: center; height: 59.188px; width: 13.9706%;">( 0.5 일간 )</td>
 </tr>
 <tr style="height: 384.641px;">
 <td style="text-align: center; width: 17.2269%; height: 384.641px;">신청 사유</td>
 <td style="height: 384.641px; width: 68.9076%;" colspan="2">&nbsp;</td>
 </tr>
 <tr style="height: 45px;">
 <td style="text-align: center; height: 45px; width: 17.2269%;">긴급연락처</td>
 <td style="height: 45px; width: 68.9076%; text-align: left;" colspan="2">&nbsp;</td>
 </tr>
 </tbody>
 </table>');

-- salary 더미 데이터 생성용
DELIMITER $$
CREATE PROCEDURE addsalary()
BEGIN
    DECLARE i INT DEFAULT 1;
     WHILE (i <= 12) DO
 		INSERT INTO salary (USER_NO,USER_NAME,YEAR_REPORTED,MON_REPORTED,PAYMENT_DATE,TOTAL_GROSSPAY,TOTAL_DEDUCTIONS,NET_PAY,PAYMENTS,DEDUCTION,P_NAME,DEPT_NAME)
	    VALUES
        (8,'정승민',2023, i,'2023-06-05','3,750,000', '515,500', '3,234,500', '기본급,3000000,식대,100000,주휴수당,500000,기타수당,150000', '국민연금,120000,건강보험,143500,고용보험,87000,소득세,150000,지방소득세,15000', '부장', '인사팀'),
        (14,'장현준',2023, i,'2023-06-12', '3,950,000', '398,900', '3,551,100', '기본급 ,3500000,식대,100000,주휴수당,350000', '국민연금,100000,건강보험,110000,고용보험,80000,소득세,99000,지방소득세,9900', '대리', '영업팀'),
	    (16,'박세은',2023, i, '2023-06-15', '4,100,000', '634,000', '3,466,000', '기본급,4000000,식대,100000', '국민연금,180000,건강보험,190000,고용보험,99000,소득세,150000,지방소득세,15000', '과장', '마케팅팀'),
		(27,'김유나',2023, i, '2023-06-21', '3,600,000', '343,200', '3,256,800', '기본급,3500000,식대,100000', '국민연금,140000,건강보험,120000,고용보험,70000,소득세,12000,지방소득세,1200', '차장', '서비스개발팀'),
		(8,'정승민', 2022, i,'2022-06-05','3,750,000', '515,500', '3,234,500', '기본급,3000000,식대,100000,주휴수당,500000,기타수당,150000', '국민연금,120000,건강보험,143500,고용보험,87000,소득세,150000,지방소득세,15000', '부장', '인사팀'),
       (14,'장현준',2022, i,'2022-06-12', '3,950,000', '398,900', '3,551,100', '기본급 ,3500000,식대,100000,주휴수당,350000', '국민연금,100000,건강보험,110000,고용보험,80000,소득세,99000,지방소득세,9900', '대리', '영업팀'),
       (16,'박세은',2022, i, '2022-06-15', '4,100,000', '634,000', '3,466,000', '기본급,4000000,식대,100000', '국민연금,180000,건강보험,190000,고용보험,99000,소득세,150000,지방소득세,15000', '과장', '마케팅팀'),
       (27,'김유나',2022, i, '2022-06-21', '3,600,000', '343,200', '3,256,800', '기본급,3500000,식대,100000', '국민연금,140000,건강보험,120000,고용보험,70000,소득세,12000,지방소득세,1200', '차장', '서비스개발팀'),
       (8,'정승민',2021, i,'2021-06-05','3,750,000', '515,500', '3,234,500', '기본급,3000000,식대,100000,주휴수당,500000,기타수당,150000', '국민연금,120000,건강보험,143500,고용보험,87000,소득세,150000,지방소득세,15000', '대리', '인사팀'),
        (14,'장현준', 2021, i,'2021-06-12', '3,950,000', '398,900', '3,551,100', '기본급 ,3500000,식대,100000,주휴수당,350000', '국민연금,100000,건강보험,110000,고용보험,80000,소득세,99000,지방소득세,9900', '사원', '영업팀'),
        (16, '박세은',2021, i, '2021-06-15', '4,100,000', '634,000', '3,466,000', '기본급,4000000,식대,100000', '국민연금,180000,건강보험,190000,고용보험,99000,소득세,150000,지방소득세,15000', '차장', '마케팅팀'),
        (27, '김유나',2021, i, '2021-06-21', '3,600,000', '343,200', '3,256,800', '기본급,3500000,식대,100000', '국민연금,140000,건강보험,120000,고용보험,70000,소득세,12000,지방소득세,1200', '사원', '서비스개발팀');



     SET i = i + 1; -- ⓔ i값에 1더해주고 WHILE문 처음으로 이동
	END WHILE;
END$$
DELIMITER ;

CALL addsalary();
DROP PROCEDURE IF EXISTS addsalary;


-- DELIMITER $$
-- CREATE PROCEDURE addannual() -- ⓐ  프로시져
-- BEGIN
--     DECLARE i INT DEFAULT 1; -- ⓑ i변수 선언, defalt값으로 1설정
--     WHILE (i <= 9) DO -- ⓒ for문 작성(i가 1000이 될 때까지 반복)

-- 		INSERT INTO approval(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
-- 		VALUES
-- 			(8, 1, "휴가", 0, CONCAT('2023-11-0', i, ' 15:28') ,CONCAT('2023-11-0', i, ' 15:28'),CONCAT('2023-11-0', i, ' 15:28')),
-- 			(8, 0, "일반", 0, CONCAT('2023-11-1', i, ' 15:28') ,CONCAT('2023-11-1', i, ' 15:28'),CONCAT('2023-11-1', i, ' 15:28')),
-- 			(8, 1, "휴가", -1,  CONCAT('2023-10-0', i, ' 15:28') ,CONCAT('2023-10-0', i, ' 15:28'),CONCAT('2023-10-0', i, ' 15:28')),
-- 			(8, 1, "휴가", 0,  CONCAT('2022-10-1', i, ' 15:28') ,CONCAT('2022-10-1', i, ' 15:28'),CONCAT('2022-10-1', i, ' 15:28')),
-- 			(8, 3, "오후반차", 0,  CONCAT('2023-09-0', i, ' 15:28') ,CONCAT('2023-09-0', i, ' 15:28'),CONCAT('2023-09-0', i, ' 15:28')),
-- 			(8, 2, "오전반차", 2,  CONCAT('2022-09-1', i, ' 15:28') ,CONCAT('2022-09-1', i, ' 15:28'),CONCAT('2022-09-1', i, ' 15:28')),
-- 			(8, 1, "휴가", 0,  CONCAT('2022-11-0', i, ' 15:28') ,CONCAT('2022-11-0', i, ' 15:28'),CONCAT('2022-11-0', i, ' 15:28')),
-- 			(8, 1, "휴가", -1, CONCAT('2022-11-0', i, ' 15:28') ,CONCAT('2022-11-0', i, ' 15:28'),CONCAT('2022-11-0', i, ' 15:28'));

--         SET i = i + 1; -- ⓔ i값에 1더해주고 WHILE문 처음으로 이동
--     END WHILE;
-- END$$
-- DELIMITER ;

-- CALL addannual(); -- 프로시저 실행
-- DROP PROCEDURE IF EXISTS addannual; -- 사용 다한 프로시저는 삭제해주기! 테스트데이터 다시돌릴 때 이미 있는프로시저라고 오류남

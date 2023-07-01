/*부서 데이터*/
INSERT INTO DEPARTMENT (DEPT_NAME) VALUES
   ('영업본부'),
   ('경영지원본부'),
   ('개발본부');

INSERT INTO DEPARTMENT (DEPT_NAME,TOP_DEPT_CODE) VALUES
   ('영업팀',1),
   ('마케팅팀',1),
   ('재경팀',2),
   ('총무팀',2),
   ('인사팀',2),
   ('서비스개발팀',3),
   ('플랫폼운영팀',3),
   ('디자인팀',3);

/*직급 데이터*/
INSERT INTO POSITION (P_NAME) VALUES
   ('사장'),
   ('부사장'),
   ('이사'),
   ('부장'),
   ('차장'),
   ('과장'),
   ('대리'),
   ('주임'),
   ('사원');

/*멤버 데이터*/
INSERT INTO MEMBER(ENO, STATUS_TYPE, USER_PWD, USER_NAME,HIRE_DATE, PHONE,EMAIL, ADDRESS,EXTENSION)
VALUES
  (200501, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이하나', '2020-05-01', '010-1234-5677', 'example0@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200502, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김둘셋', '2020-05-01', '010-1234-5666', 'example23@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200503, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김철수', '2020-05-01', '010-1234-5678', 'example1@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200504, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김지민', '2020-05-01', '010-9876-5432','testUSER2@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200505, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이예진', '2020-05-01', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200506, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박준호', '2020-05-01', '010-1234-5678', 'example1@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200507, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최서연', '2020-05-01', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200508, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정승민', '2020-05-01','010-1234-5678', 'shwldml@gmail.com', '서울특별시 강남구 가로수길 1,',''),
  (200509, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '강지우', '2020-05-01', '010-2468-1357', 'random_email3@gmail.com','서울특별시 강남구 가로수길 1,',''),
  (200510, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '윤서준', '2020-05-01', '010-5798-6423', 'email7_ADDress@gmail.com','서울특별시 강남구 가로수길 1, 101',''),
  (200511, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '장민서', '2020-05-01', '010-2468-1357', 'random_email3@gmail.com','서울특별시 강남구 가로수길 1,123',''),
  (200512, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안하린', '2020-05-11','010-1357-2468', 'myemail5@gmail.com', '부산광역시 해운대구 해운대해변로 1,',''),
  (200513, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황승현', '2020-05-12',  '010-9876-5432','testUSER2@gmail.com','대구광역시 중구 동성로 1,',''),
  (200514, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '장현준', '2020-05-14', '010-2468-1357', 'random_email3@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (200515, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '한민우', '2020-05-14', '010-5798-6423', 'email7_ADDress@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (200716, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박세은', '2020-07-06', '010-1234-5678', 'example1@gmail.com','대구광역시 동구 동대구로 1,',''),
  (200717, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박지민', '2020-07-30', '010-1357-2468', 'myemail5@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (200818, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김태희', '2020-08-01',  '010-9876-5432','testUSER2@gmail.com','부산광역시 사하구 광장로 1,',''),
  (200819, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정유미', '2020-08-02', '010-6423-5798', 'randomUSER6@gmail.com','대구광역시 남구 대명로 1,',''),
  (210920, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박지윤', '2021-09-11', '010-6423-5798', 'randomUSER6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (210921, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '임예준', '2021-09-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (210922, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정서은', '2021-09-14', '010-1357-2468', 'myemail5@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (210923, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김영숙', '2021-09-14', '010-1234-5678', 'example1@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (211024, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정재민', '2021-10-06',  '010-9876-5432','testUSER2@gmail.com','대구광역시 동구 동대구로 1,',''),
  (211025, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김현서', '2021-10-30', '010-6423-5798', 'randomUSER6@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (211126, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최하율', '2021-11-01',  '010-9876-5432','testUSER2@gmail.com','부산광역시 사하구 광장로 1,',''),
  (211127, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김유나', '2021-11-02','010-1234-5678', 'example1@gmail.com', '대구광역시 남구 대명로 1,',''),
  (211228, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '강하윤', '2021-12-11', '010-6423-5798', 'randomUSER6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (211229, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황승현', '2021-12-12',  '010-9876-5432','testUSER2@gmail.com','대구광역시 중구 동성로 1,',''),
  (211230, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '송예은', '2021-12-14', '010-1234-5678', 'example1@gmail.com','서울특별시 종로구 청와대로 1,',''),
  (211231, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이현우', '2021-12-14', '010-2468-1357', 'USER4_email@gmail.com','부산광역시 서구 부산타워로 1,',''),
  (220132, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이철호', '2022-01-06', '010-8642-9731', 'random_email3@gmail.com','대구광역시 동구 동대구로 1,',''),
  (220133, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이준혁', '2022-01-30','010-2468-1357', 'random_email3@gmail.com', '서울특별시 강동구 천호대로 1,',''),
  (220334, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김태희', '2022-03-01', '010-1234-5678', 'example1@gmail.com','부산광역시 사하구 광장로 1,',''),
  (220335, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최민석', '2022-03-02','010-6423-5798', 'randomUSER6@gmail.com', '대구광역시 남구 대명로 1,',''),
  (220336, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '송예준', '2022-03-06', '010-5798-6423', 'email7_ADDress@gmail.com','대구광역시 동구 동대구로 1,',''),
  (220337, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '황하은', '2022-03-30', '010-9731-8642', 'USER8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (220438, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '서하은', '2022-04-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (220439, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정유미', '2022-04-02', '010-9864-7531', 'email_ADDress10@gmail.com','대구광역시 남구 대명로 1,',''),
  (220540, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안하린', '2022-05-11', '010-6423-5798', 'randomUSER6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (220541, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '안우진', '2022-05-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (220642, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '윤예준', '2022-06-06', '010-5798-6423', 'email7_ADDress@gmail.com','대구광역시 동구 동대구로 1,',''),
  (221143, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '정은서', '2022-11-30', '010-9731-8642', 'USER8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (221244, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최하윤', '2022-12-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (230145, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박예준', '2023-01-02', '010-9864-7531', 'email_ADDress10@gmail.com','대구광역시 남구 대명로 1,',''),
  (230146, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이지우', '2023-01-11', '010-6423-5798', 'randomUSER6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (230147, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김시윤', '2023-01-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,',''),
  (230248, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '한민서', '2023-02-06', '010-5798-6423', 'email7_ADDress@gmail.com','대구광역시 동구 동대구로 1,',''),
  (230349, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '최준서', '2023-03-30', '010-9731-8642', 'USER8_email@gmail.com','서울특별시 강동구 천호대로 1,',''),
  (230450, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '임하늘', '2023-04-01', '010-7531-9864','sample9_email@gmail.com','부산광역시 사하구 광장로 1,',''),
  (230451, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '박현서', '2023-04-02', '010-9864-7231', 'email_ADDress10@gmail.com','대구광역시 남구 대명로 1,',''),
  (230552, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '김유진', '2023-05-11', '010-6423-5798', 'randomUSER6@gmail.com','부산광역시 해운대구 해운대해변로 1,',''),
  (230553, 0, '$2a$10$KkpS/wSMLJ2EhWuFetS9TuJ3tpfME5XxcvXpW0WM2BD.K4qcrHjOq', '이시우', '2023-05-12', '010-1357-2468', 'myemail5@gmail.com','대구광역시 중구 동성로 1,','');


/*멤버 데이터 부서등록*/
INSERT INTO USER_DEPARTMENT(USER_NO, DEPT_CODE,P_CODE )
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
INSERT INTO DEPARTMENT_ROLE(DEPT_CODE,P_CODE,ROLE_CODE )
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
INSERT USER_ROLE(USER_NO,ROLE_CODE) VALUE (8,'S01');
INSERT USER_ROLE(USER_NO,ROLE_CODE) VALUE (8,'T01');
INSERT USER_ROLE(USER_NO,ROLE_CODE) VALUE (8,'T02');


-- APPROVAL 더미 데이터 생성용
DELIMITER $$
CREATE PROCEDURE ADD_APPROVAL() -- ⓐ myFunction이라는 이름의 프로시저
BEGIN
    DECLARE i INT DEFAULT 1; -- ⓑ i변수 선언, defalt값으로 1설정
    WHILE (i <= 10) DO -- ⓒ for문 작성(i가 기준수가 될 때까지 반복)
        INSERT INTO APPROVAL(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
		VALUES
			(i, 1, "휴가", 1, '2022-11-20 15:28' ,'2022-11-27','2022-11-30'),
			(i, 3, "오후반차", 1, '2022-12-02 10:40' ,'2022-12-08','2022-12-08'),
			(i, 1, "휴가", 1, '2022-12-24 11:24' ,'2022-12-29','2023-01-02'),
			(i, 1, "휴가", 1, '2022-12-20 15:28' ,'2023-01-02','2023-01-05'),
			(i, 3, "오후반차", -1, '2023-01-22 11:40' ,'2023-02-08','2023-02-08'),
			(i, 2, "오전반차", -1, '2023-02-25 13:05' ,'2023-03-02','2023-03-02'),
			(i, 1, "휴가", 0, '2023-05-06 16:09' ,'2023-05-28','2023-05-28'),
			(i, 0, "일반", 0, '2023-05-20 10:45' ,'2023-06-01','2023-06-01');

        INSERT INTO APPROVAL_LINE(APPROVAL_NO, CONFIRM_STATUS, DATE, LEVEL, STATUS, TYPE, USER_NO)
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
CALL ADD_APPROVAL(); -- 프로시저 실행, 테이블에 1~1000까지 숫자 채워주기
DROP PROCEDURE IF EXISTS ADD_APPROVAL; -- 사용 다한 프로시저는 삭제해주기! 테스트데이터 다시돌릴 때 이미 있는프로시저라고 오류남

-- 휴가 등록 임시
-- INSERT INTO APPROVAL(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
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
UPDATE MEMBER SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '8');
UPDATE MEMBER SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '2');
UPDATE MEMBER SET `ANNUAL_LEAVE_COUNT` = '30' WHERE (`USER_NO` = '1');
-- 테스트 데이터 입력용 프로시저


-- APPROVAL_FORM 더미 데이터 생성용
INSERT INTO `APPROVAL_FORM`(TYPE, TITLE, CONTENT) VALUES (0, '지출결의서', '<table style="border-collapse: collapse; width: 88.9823%; height: 556px;" border="1">
 <tbody>
 <tr style="height: 20px;">
 <td style="height: 60px; text-align: center; width: 11.1345%;" rowspan="3">인적사항</td>
 <td style="width: 13.7605%; height: 20px; text-align: center;">소&nbsp; &nbsp; 속</td>
 <td style="height: 20px; width: 75.0118%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 20px;">
 <td style="width: 13.7605%; height: 20px; text-align: center;">직&nbsp; &nbsp; 위</td>
 <td style="height: 20px; width: 75.0118%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 20px;">
 <td style="width: 13.7605%; height: 20px; text-align: center;">성&nbsp; &nbsp; 명</td>
 <td style="height: 20px; width: 75.0118%;" colspan="3">&nbsp;</td>
 </tr>
 <tr style="height: 42.1719px;">
 <td style="text-align: center; height: 42.1719px; width: 11.1345%;">지출 금액</td>
 <td style="text-align: center; height: 42.1719px; width: 88.7724%;" colspan="4">000,000 원</td>
 </tr>
 <tr style="height: 34.8594px;">
 <td style="text-align: center; height: 219.094px; width: 11.1345%;" rowspan="6">내역</td>
 <td style="text-align: center; height: 34.8594px; width: 33.7303%;" colspan="2">사용처</td>
 <td style="width: 19.8529%; text-align: center; height: 34.8594px;">금액</td>
 <td style="width: 35.1891%; height: 34.8594px; text-align: center;">비고</td>
 </tr>
 <tr style="height: 36.5938px;">
 <td style="text-align: center; width: 33.7303%; height: 36.5938px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 36.5938px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 36.5938px;">&nbsp;</td>
 </tr>
 <tr style="height: 37.5938px;">
 <td style="text-align: center; width: 33.7303%; height: 37.5938px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 37.5938px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 37.5938px;">&nbsp;</td>
 </tr>
 <tr style="height: 35px;">
 <td style="text-align: center; height: 35px; width: 33.7303%;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 35px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 35px;">&nbsp;</td>
 </tr>
 <tr style="height: 39.6094px;">
 <td style="text-align: center; width: 33.7303%; height: 39.6094px;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 39.6094px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 39.6094px;">&nbsp;</td>
 </tr>
 <tr style="height: 35.4375px;">
 <td style="text-align: center; height: 35.4375px; width: 33.7303%;" colspan="2">&nbsp;</td>
 <td style="width: 19.8529%; height: 35.4375px;">&nbsp;</td>
 <td style="width: 35.1891%; height: 35.4375px;">&nbsp;</td>
 </tr>
 <tr style="height: 168px;">
 <td style="text-align: center; width: 99.9068%; height: 168px;" colspan="5">
 <p style="text-align: left;">&nbsp; &nbsp; 위 금액을 청구하오니 결재 바랍니다</p>
 <p style="text-align: left;">&nbsp;</p>
 <p>0000&nbsp; 년&nbsp; &nbsp; &nbsp; 00&nbsp; 월&nbsp; &nbsp; &nbsp; 00&nbsp; 일</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 </td>
 </tr>
 </tbody>
 </table>');
INSERT INTO `APPROVAL_FORM`(TYPE, TITLE, CONTENT) VALUES (1, 'OOO 휴가신청서', '<table style="border-collapse: collapse; width: 88.9823%; height: 762.891px;" border="1">
 <tbody>
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
INSERT INTO `APPROVAL_FORM`(TYPE, TITLE, CONTENT) VALUES (2, 'OOO 오전반차 신청서', '<table style="border-collapse: collapse; width: 88.9823%; height: 720.891px;" border="1">
 <tbody>
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
INSERT INTO `APPROVAL_FORM`(TYPE, TITLE, CONTENT) VALUES (3, 'OOO 오후반차 신청서', '<table style="border-collapse: collapse; width: 88.9823%; height: 720.891px;" border="1">
 <tbody>
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

-- SALARY 더미 데이터 생성용
DELIMITER $$
CREATE PROCEDURE ADDSALARY()
BEGIN
    DECLARE i INT DEFAULT 1;
     WHILE (i <= 12) DO
 		INSERT INTO SALARY (USER_NO,USER_NAME,YEAR_REPORTED,MON_REPORTED,PAYMENT_DATE,TOTAL_GROSSPAY,TOTAL_DEDUCTIONS,NET_PAY,PAYMENTS,DEDUCTION,P_NAME,DEPT_NAME)
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

CALL ADDSALARY();
DROP PROCEDURE IF EXISTS ADDSALARY;

-- [지의] 연차 조회에서 필요한 연차 등록
INSERT INTO APPROVAL(USER_NO, TYPE, TITLE, STATUS, DRAFT_DATE, START_DATE, END_DATE)
VALUES  (12, 1, "휴가", 1, '2022-12-20 15:28' ,'2023-01-02','2023-01-05'),
		(12, 1, "휴가", 1, '2023-01-20 15:28' ,'2023-01-26','2023-01-27'),
		(12, 1, "휴가", 1, '2023-02-01 15:28' ,'2023-02-08','2023-02-08'),
		(12, 3, "오후반차", 1, '2023-01-22 11:40' ,'2023-03-31','2023-03-31'),
        (12, 2, "오전반차", 1, '2023-02-25 13:05' ,'2023-04-03','2023-04-03'),
        (12, 1, "휴가", 1, '2023-03-06 16:09' ,'2023-04-17','2023-04-17'),
        (12, 1, "휴가", 1, '2023-04-06 16:09' ,'2023-05-02','2023-05-04'),
        (12, 3, "오후반차", 1, '2023-05-06 16:09' ,'2023-05-12','2023-05-12'),
        (12, 1, "휴가", 1, '2023-05-10 16:09' ,'2023-05-26','2023-05-26'),
        (12, 1, "휴가", 1, '2023-05-06 16:09' ,'2023-06-05','2023-06-05'),
        (12, 2, "오전반차", 1, '2023-06-01 10:45' ,'2023-06-20','2023-06-20');
        
 -- [혜린]       
/* 게시판 더미데이터 */
/*공지사항 고정게시글 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,FIXED)
VALUES ('2023년 하절기 사옥 냉난방기 운용 관련 공지','<p><strong>&lt; 하절기 사옥 냉난방기 운용 관련 공지 &gt;</strong></p>
 <p>냉난방기 적정 온도 공지</p>
 <p><span style="color: #3598db;">냉방 : 24 도</span></p>
 <p><span style="color: #3598db;">난방 : 26 도</span></p>
 <p>모두를 위해 되도록 적정 온도 내에서 유지해주세요.</p>
 <p>&nbsp;</p>','경영지원본부','N',23,'2022-05-12','Y'),
('2023년 06월 전사 플레이샵 조 편성 및 차량배정 관련 공지 글(필독)','<p><strong>&lt; 전사 플레이샵 조 편성 및 차량배정 관련 공지 &gt;</strong></p>','경영지원본부','N',35,'2022-04-24','Y'),
('2023년 07월 ~ 08월 하계 휴가기간 제주도 리조트 예약 신청 공지 건','<p><strong>&lt; 사내 복지 시스템 - 리조트 예약 &gt;</strong></p>
 <p>제주도 00 리조트 선착순 예약 신청을 받습니다.</p>
 <p>예약 가능 기간은 2023 / 07 / 01 - &nbsp; 2023 / 08 / 29 입니다.</p>
 <p>예약이 필요한 직원은 <span style="text-decoration: underline; color: #3598db;">총무팀 윤지영 대리</span>에게 문의 바랍니다.</p>','경영지원본부','N',156,'2022-04-15','Y'),
('5/1(월) 근로자의 날 휴무 관련 공지','<p><span style="font-size: 14pt;"><strong>&lt; 휴무 관련 공지 &gt;</strong></span></p>
 <p><span style="font-size: 12pt; color: #e03e2d;">5월 1일 월요일 근로자의 날 휴무</span></p>
 <p><span style="font-size: 12pt;">임을 공지합니다.</span></p>','경영지원본부','N',178,'2022-04-03','Y'),
('2023년 인사발령','<h2 style="text-align: center;"><span style="font-size: 18pt;"><strong><span style="color: #e03e2d;">&lt; 2023 인사발령 공고 &gt;</span></strong></span></h2>
 <table style="border-collapse: collapse; width: 63.3377%; height: 97px; margin-left: auto; margin-right: auto;" border="1">
 <tbody>
 <tr style="height: 32.3281px;">
 <td style="width: 25.0415%; text-align: center; height: 32.3281px;"><strong>부서</strong></td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;"><strong>팀</strong></td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;"><strong>이름</strong></td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;">&nbsp;</td>
 </tr>
 <tr style="height: 32.3281px;">
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;">경영지원본부</td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;">인사팀</td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;">김혜린 사원</td>
 <td style="width: 25.0415%; height: 32.3281px; text-align: center;">휴직</td>
 </tr>
 <tr style="height: 32.3438px;">
 <td style="width: 25.0415%; height: 32.3438px; text-align: center;">영업본부</td>
 <td style="width: 25.0415%; height: 32.3438px; text-align: center;">마케팅팀</td>
 <td style="width: 25.0415%; height: 32.3438px; text-align: center;">박가영 사원</td>
 <td style="width: 25.0415%; height: 32.3438px; text-align: center;">대리 승진</td>
 </tr>
 </tbody>
 </table>
 <p>&nbsp;</p>','경영지원본부','N',312,'2023-01-03','Y');
/*공지 고정아닌글*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,FIXED)
VALUES ('보안 강화 조치 안내 및 전달','<p>보안 강화 관련 건 전달 드립니다.</p>','개발본부','N',16,'2023-05-12','N'),
('코로나 방역수칙 변경 안내','<p><strong>&lt; 코로나 방역수칙 변경 안내 &gt;</strong></p>','경영지원본부','N',38,'2023-04-24','N'),
('사내 도서관 공지','<p><strong>&lt; 사내 도서 시스템 변경 공지 &gt;</strong></p>','경영지원본부','N',64,'2023-04-21','N'),
('영업본부 필독','<p>영업본부 필독</p>','영업본부','N',21,'2023-04-20','N'),
('2022년 연말정산 공지','<p>연말정산 안내</p>','경영지원본부','N',183,'2022-11-01','N'),
('개발본부 필독','<p>개발본부 필독</p>','개발본부','N',12,'2023-04-08','N'),
('경영지원본부 필독','<p>경영지원본부 필독</p>','경영지원본부','N',11,'2023-04-07','N'),
('코로나 방역수칙 안내','<p>코로나 방역수칙 안내</p>
 <p>마스크 잘 써주세요.</p>','경영지원본부','N',43,'2023-04-06','N'),
('2023년 사내 마라톤 대회 공지','<p>사내 마라톤 대회 공지</p>','경영지원본부','N',34,'2023-04-05','N'),
('사내 도서관 공지','<p><strong>&lt; 사내 도서 시스템 변경 공지 &gt;</strong></p>','경영지원본부','N',64,'2022-04-21','N'),
('영업본부 필독','<p>영업본부 필독</p>','영업본부','N',21,'2022-04-20','N'),
('2021년 연말정산 공지','<p>연말정산 안내</p>','경영지원본부','N',183,'2021-11-01','N'),
('개발본부 필독','<p>개발본부 필독</p>','개발본부','N',12,'2022-04-08','N'),
('경영지원본부 필독','<p>경영지원본부 필독</p>','경영지원본부','N',34,'2022-04-07','N'),
('코로나 방역수칙 안내','<p>코로나 방역수칙 안내</p>
 <p>마스크 잘 써주세요.</p>','경영지원본부','N',43,'2022-04-06','N'),
('2022년 사내 마라톤 대회 공지','<p>사내 마라톤 대회 공지</p>','경영지원본부','N',51,'2022-04-05','N'),
('사내 도서관 공지','<p><strong>&lt; 사내 도서 시스템 변경 공지 &gt;</strong></p>','경영지원본부','N',64,'2021-04-21','N'),
('영업본부 필독','<p>영업본부 필독</p>','영업본부','N',21,'2021-04-20','N'),
('2020년 연말정산 공지','<p>연말정산 안내</p>','경영지원본부','N',183,'2020-11-01','N'),
('개발본부 필독','<p>개발본부 필독</p>','개발본부','N',12,'2021-04-08','N'),
('경영지원본부 필독','<p>경영지원본부 필독</p>','경영지원본부','N',9,'2021-04-07','N'),
('코로나 방역수칙 안내','<p>코로나 방역수칙 안내</p>
 <p>마스크 잘 써주세요.</p>','경영지원본부','N',43,'2021-04-06','N'),
('2021년 사내 마라톤 대회 공지','<p>사내 마라톤 대회 공지</p>','경영지원본부','N',default,'2021-04-05','N'),
('사내 인트라넷 개설 안내','<p><span style="font-size: 18pt;"><strong>&nbsp;&lt; 사내 인트라넷 개설 안내 &gt;</strong></span></p>','개발본부','N',56,'2018-04-04','N');
/*자유게시판 데이터*/
INSERT INTO BOARD(BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE,SECRET)
VALUES ('역삼역 맛집 추천','<p>좀 해주세요..ㅎ</p>','24','F',2,'2023-05-12','Y'),
('회사 사옥 어떻게 생각함?','<p>이전하면 좋겠다...ㅎㅎ</p>','25','F',3,'2023-04-24','Y'),
('사내 복지 제안함','<p>ㅇㅇㅇ 어떤가요?</p>','26','F',11,'2023-04-15','Y'),
('자율성 있는 회사의 조건','<p>은 뭐게요.</p>','27','F',3,'2023-04-11','Y'),
('코로나 때문에','<p>답답해요ㅠ</p>','28','F',4,'2023-04-10','Y'),
('음료 냉장고','<p>좀 놔주세요..ㅎ 몬스터 채워주세염</p>','9','F',5,'2023-04-06','Y'),
('자리가 넓어지니 좋아요','<p>굿</p>','23','F',8,'2023-04-05','Y'),
('스탠딩 책상이 있었으면 좋겠습니다','<p>그 남주혁이 광고하는 거..</p>','23','F',11,'2023-04-04','Y'),
('사내 카페 직원 친절함','<p>귯</p>','31','F',21,'2023-04-03','Y'),
('사내 카페 음료 추천좀','<p>하 하 하</p>','32','F',41,'2023-04-02','Y'),
('점메추 받아요','<p>하 하 하</p>','32','F',41,'2023-03-21','Y'),
('저만 졸린가요','<p>꽤나 졸려요</p>','33','F',143,'2023-04-01','Y'),
('사내 복지 제안함','<p>ㅇㅇㅇ 어떤가요?</p>','26','F',11,'2022-05-15','Y'),
('자율성 있는 회사의 조건','<p>은 뭐게요.</p>','27','F',3,'2022-04-11','Y'),
('코로나 때문에','<p>답답해요ㅠ</p>','28','F',4,'2022-04-10','Y'),
('음료 냉장고','<p>좀 놔주세요..ㅎ 몬스터 채워주세염</p>','9','F',5,'2022-04-06','Y'),
('자리가 넓어지니 좋아요','<p>굿</p>','23','F',8,'2022-04-05','Y'),
('스탠딩 책상이 있었으면 좋겠습니다','<p>그 남주혁이 광고하는 거..</p>','23','F',11,'2022-04-04','Y'),
('사내 카페 직원 친절함','<p>귯</p>','31','F',21,'2022-04-03','Y'),
('사내 카페 음료 추천좀','<p>하 하 하</p>','32','F',41,'2022-04-02','Y'),
('점메추 받아요','<p>하 하 하</p>','32','F',41,'2022-03-21','Y'),
('저만 졸린가요','<p>꽤나 졸려요</p>','33','F',143,'2022-04-01','Y'),
('사내 복지 제안함','<p>ㅇㅇㅇ 어떤가요?</p>','26','F',11,'2022-09-15','Y'),
('자율성 있는 회사의 조건','<p>은 뭐게요.</p>','27','F',3,'2022-09-11','Y'),
('코로나 때문에','<p>답답해요ㅠ</p>','28','F',4,'2022-09-10','Y'),
('음료 냉장고','<p>좀 놔주세요..ㅎ 몬스터 채워주세염</p>','9','F',5,'2022-09-06','Y'),
('자리가 넓어지니 좋아요','<p>굿</p>','23','F',8,'2022-09-05','Y'),
('스탠딩 책상이 있었으면 좋겠습니다','<p>그 남주혁이 광고하는 거..</p>','23','F',11,'2022-09-04','Y'),
('사내 카페 직원 친절함','<p>귯</p>','31','F',21,'2022-09-03','Y'),
('사내 카페 음료 추천좀','<p>하 하 하</p>','32','F',41,'2022-09-02','Y'),
('점메추 받아요','<p>하 하 하</p>','32','F',41,'2022-08-21','Y'),
('저만 졸린가요','<p>꽤나 졸려요</p>','33','F',143,'2022-08-01','Y'),
('사내 복지 제안함','<p>ㅇㅇㅇ 어떤가요?</p>','26','F',11,'2022-07-15','Y'),
('자율성 있는 회사의 조건','<p>은 뭐게요.</p>','27','F',3,'2022-07-11','Y'),
('코로나 때문에','<p>답답해요ㅠ</p>','28','F',4,'2022-07-10','Y'),
('음료 냉장고','<p>좀 놔주세요..ㅎ 몬스터 채워주세염</p>','9','F',5,'2022-07-06','Y'),
('자리가 넓어지니 좋아요','<p>굿</p>','23','F',8,'2022-07-05','Y'),
('스탠딩 책상이 있었으면 좋겠습니다','<p>그 남주혁이 광고하는 거..</p>','23','F',11,'2022-07-04','Y'),
('사내 카페 직원 친절함','<p>귯</p>','31','F',21,'2022-07-03','Y'),
('사내 카페 음료 추천좀','<p>하 하 하</p>','32','F',41,'2022-07-02','Y'),
('점메추 받아요','<p>하 하 하</p>','32','F',41,'2022-07-21','Y'),
('저만 졸린가요','<p>꽤나 졸려요</p>','33','F',143,'2022-07-01','Y'),
('사내 복지 제안함','<p>ㅇㅇㅇ 어떤가요?</p>','26','F',11,'2022-11-15','Y'),
('자율성 있는 회사의 조건','<p>은 뭐게요.</p>','27','F',3,'2022-11-11','Y'),
('코로나 때문에','<p>답답해요ㅠ</p>','28','F',4,'2022-11-10','Y'),
('음료 냉장고','<p>좀 놔주세요..ㅎ 몬스터 채워주세염</p>','9','F',5,'2022-11-06','Y'),
('자리가 넓어지니 좋아요','<p>굿</p>','23','F',8,'2022-11-05','Y'),
('스탠딩 책상이 있었으면 좋겠습니다','<p>그 남주혁이 광고하는 거..</p>','23','F',11,'2022-11-04','Y'),
('사내 카페 직원 친절함','<p>귯</p>','31','F',21,'2022-11-03','Y'),
('사내 카페 음료 추천좀','<p>하 하 하</p>','32','F',41,'2022-11-02','Y'),
('점메추 받아요','<p>하 하 하</p>','32','F',41,'2022-10-21','Y'),
('저만 졸린가요','<p>꽤나 졸려요</p>','33','F',143,'2022-10-01','Y'),
('배고프다','<p>배고팡</p>','30','F',156,'2023-03-31','Y');
/*팀게시판 데이터*/
INSERT INTO BOARD(DEPT_CODE,BOARD_TITLE,BOARD_CONTENT,BOARD_WRITER,BOARD_CD,COUNT,CREATE_DATE)
VALUES (8,'회의 시간 맞춰주세요.','<p>지각 금지.</p>','8','T',4,'2023-06-12'),
(8,'인사팀 회식 날짜 전달합니다.','<p>7월 3일 월요일로 정해졌습니다!</p>','24','T',3,'2023-06-11'),
(8,'00프로젝트 예시 자료 파일 첨부','<p>이미지 첨부합니다. 확인 부탁드립니다.</p>','24','T',2,'2023-06-09'),
(8,'전달사항 (필독)','<p>지각 금지.</p>','8','T',4,'2023-06-01'),
(8,'인사팀 회식 날짜 전달합니다.','<p>5월 31일로 정해졌습니다!</p>','24','T',7,'2023-05-27'),
(8,'00프로젝트 예시 자료 파일 첨부','<p>이미지 첨부합니다. 확인 부탁드립니다.</p>','24','T',2,'2023-04-27'),
(8,'전달사항','<p>지각 금지.</p>','26','T',4,'2023-04-01'),
(8,'인사팀 회식 날짜 전달합니다.','<p>5월 31일로 정해졌습니다!</p>','25','T',7,'2023-03-27'),
(8,'00프로젝트 예시 자료 파일 첨부','<p>이미지 첨부합니다. 확인 부탁드립니다.</p>','25','T',2,'2023-03-22'),
(8,'전달사항 (필독)','<p>지각 금지.</p>','8','T',24,'2023-03-09'),
(8,'인사팀 회식 날짜 전달드립니다.','<p>5월 31일로 정해졌습니다!</p>','45','T',7,'2023-02-21'),
(8,'00프로젝트 예시 자료 파일 첨부','<p>이미지 첨부합니다. 확인 부탁드립니다.</p>','44','T',2,'2023-02-12');

/* 게시판 댓글 더미데이터 */
INSERT INTO BOARD_REPLY(BOARD_NO,USER_NO,CONTENT,SECRET,CREATE_DATE)
VALUES(30, 24, 'ㅎㅎㅎ', 'Y', '2023-06-20 02:57:48'),
(31, 10, 'ㅋㅋㅋ어디로?', 'Y', '2023-06-20 02:58:48'),
(31, 21, '역삼 너무 멀긴 함', 'Y', '2023-06-20 02:59:48'),
(38, 26, 'ㅇㅈ', 'Y', '2023-06-20 02:55:48'),
(39, 51, '아아', 'Y', '2023-06-20 02:56:48'),
(39, 52, '아바라 최고존엄', 'Y', '2023-06-20 02:59:50'),
(83, 24, '넵', 'N', '2023-06-20 02:59:48'),
(83, 25, '넵', 'N', '2023-06-20 02:53:48'),
(83, 26, '넵', 'N', '2023-06-20 02:52:48'),
(83, 44, '넵', 'N', '2023-06-20 02:51:48'),
(83, 45, '넵', 'N', '2023-06-20 02:50:48'),
(86, 24, '확인했습니다.', 'N', '2023-06-20 02:59:48'),
(86, 25, '확인했습니다.', 'N', '2023-06-20 02:53:48'),
(86, 26, '확인했습니다.', 'N', '2023-06-20 02:52:48'),
(86, 44, '확인했습니다.', 'N', '2023-06-20 02:51:48'),
(86, 45, '확인했습니다.', 'N', '2023-06-20 02:50:48'),
(89, 24, '확인했습니다.', 'N', '2023-06-20 02:59:48'),
(89, 25, '확인했습니다.', 'N', '2023-06-20 02:53:48'),
(89, 26, '확인했습니다.', 'N', '2023-06-20 02:52:48'),
(89, 44, '확인했습니다.', 'N', '2023-06-20 02:51:48'),
(89, 45, '확인했습니다.', 'N', '2023-06-20 02:50:48'),
(92, 24, '확인했습니다.', 'N', '2023-06-20 02:59:48'),
(92, 25, '확인했습니다.', 'N', '2023-06-20 02:53:48'),
(92, 26, '확인했습니다.', 'N', '2023-06-20 02:52:48'),
(92, 44, '확인했습니다.', 'N', '2023-06-20 02:51:48'),
(92, 45, '확인했습니다.', 'N', '2023-06-20 02:50:48');

/* 캘린더 더미데이터 8번 정승민 인사팀 부장용 */
INSERT INTO CALENDAR(CATEGORY, USER_NO, DEPT_CODE, TITLE, CONTENT, START_DATE, END_DATE, COLOR, D_DAY)
VALUES('T', 8, 8,'새 프로젝트 1차 회의', '장소 : 대회의실 시간 : 오전 10시', '2023-06-21', '2023-06-21', 'var(--col11)', 'Y' ),
('T', 8, 8,'프로젝트 기간', '', '2023-06-05', '2023-06-09', 'var(--col14)', 'N' ),
('T', 24, 8,'팀 점심 회식', '장소 : 미정', '2023-06-14', '2023-06-14', 'var(--col12)', 'N' ),
('T', 8, 8,'프로젝트 발표', '', '2023-06-12', '2023-06-12', 'var(--col12)', 'N' );
INSERT INTO CALENDAR(CATEGORY, USER_NO, TITLE, CONTENT, START_DATE, END_DATE, COLOR, D_DAY)
VALUES('M', 8, '휴가 계획 중', '연차 신청하기', '2023-06-29','2023-06-30', 'var(--col1)', 'N'),
('M', 8, '저녁 약속', '역삼역 4번 출구 앞 7시', '2023-06-26','2023-06-26', 'var(--col2)', 'Y'),
('M', 8, '운동', '연차 신청하기', '2023-06-09','2023-06-09', 'var(--col5)', 'N'),
('M', 8, '운동', '연차 신청하기', '2023-06-16','2023-06-16', 'var(--col5)', 'N'),
('M', 8, '점심 약속', '미팅 : 강남역 12시', '2023-06-19','2023-06-19', 'var(--col2)', 'N');        
        
        
        

        
DELIMITER $$
CREATE PROCEDURE test() -- ⓐ  프로시져
BEGIN
    DECLARE i INT DEFAULT 1; -- ⓑ i변수 선언, defalt값으로 1설정
    WHILE (i <= 20) DO -- ⓒ for문 작성(i가 1000이 될 때까지 반복)

		INSERT INTO ATTENDANCE(WORK_DATE, USER_NO, WORK_ON, WORK_OFF)
		VALUES (DATE_FORMAT('2023-2-09','%Y-%m-%d'), i, '09:01:00', '18:01:00');
        INSERT INTO ATTENDANCE(WORK_DATE, USER_NO, WORK_ON, WORK_OFF)
		VALUES (DATE_FORMAT('2023-2-10','%Y-%m-%d'), i, '09:01:00', '18:01:00');
        INSERT INTO ATTENDANCE(WORK_DATE, USER_NO, WORK_ON, WORK_OFF)
		VALUES (DATE_FORMAT('2023-2-11','%Y-%m-%d'), i, '09:01:00', '18:01:00');
        INSERT INTO ATTENDANCE(WORK_DATE, USER_NO, WORK_ON, WORK_OFF)
		VALUES (DATE_FORMAT('2023-2-12','%Y-%m-%d'), i, '09:01:00', '18:01:00');
        INSERT INTO ATTENDANCE(WORK_DATE, USER_NO, WORK_ON, WORK_OFF)
		VALUES (DATE_FORMAT('2023-2-13','%Y-%m-%d'), i, '09:01:00', '18:01:00');

        SET i = i + 1; -- ⓔ i값에 1더해주고 WHILE문 처음으로 이동
    END WHILE;
END$$
DELIMITER ;

CALL test(); -- 프로시저 실행
DROP PROCEDURE IF EXISTS test; 

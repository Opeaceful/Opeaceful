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
   VALUES ( 230502 , 0,'test', 'test', SYSDATE(), 'test@gmail.com');


SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE  IF EXISTS SALARY;
DROP TABLE  IF EXISTS ATTENDANCE;
DROP TABLE  IF EXISTS CHAT_FILE;
DROP TABLE  IF EXISTS ANNUAL;
DROP TABLE  IF EXISTS BOARD_FILE;
DROP TABLE  IF EXISTS BOARD_REPLY;
DROP TABLE  IF EXISTS CALENDAR;
DROP TABLE  IF EXISTS CHAT_PARTICIPANT;
DROP TABLE  IF EXISTS USER_DEPARTMENT;
DROP TABLE  IF EXISTS RESIGNED_MEMBER;
DROP TABLE  IF EXISTS APPROVAL_FILE;
DROP TABLE  IF EXISTS APPROVAL_FORM;
DROP TABLE  IF EXISTS APPROVAL_LINE;
DROP TABLE  IF EXISTS APPROVAL_ACTUAL_FAVORITE_LINE;
DROP TABLE  IF EXISTS APPROVAL_FAVORITE_LINE;
DROP TABLE  IF EXISTS APPROVAL_MEMO;
DROP TABLE  IF EXISTS USER_ROLE;
DROP TABLE  IF EXISTS SIGNATURE_IMG;
DROP TABLE  IF EXISTS CALENDAR_MEMO;
DROP TABLE  IF EXISTS PERSONNEL;
DROP TABLE  IF EXISTS ONLINE_STATUS;
DROP TABLE  IF EXISTS BOARD_TYPE;
DROP TABLE  IF EXISTS APPROVAL;
DROP TABLE  IF EXISTS DEPARTMENT_ROLE;
DROP TABLE  IF EXISTS POSITION;
DROP TABLE  IF EXISTS DEPARTMENT;
DROP TABLE  IF EXISTS ROLE_LIST;
DROP TABLE  IF EXISTS BOARD;
DROP TABLE  IF EXISTS CHAT;
DROP TABLE  IF EXISTS CHAT_ROOM;
DROP TABLE  IF EXISTS MEMBER;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `MEMBER` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 PK',
	`ENO`	INT	NOT NULL UNIQUE	COMMENT '사원번호',
	`STATUS`	CHAR(1)	NOT NULL	DEFAULT 'Y'	COMMENT '계정상태',
	`PROFILE_IMG`	NVARCHAR(30)	NULL	COMMENT '프로필사진 저장경로/파일명',
	`STATUS_TYPE`	INT	NOT NULL	COMMENT '접속 종류FK',
	`USER_PWD`	NVARCHAR(200)	NOT NULL	COMMENT '비밀번호',
	`USER_NAME`	NVARCHAR(6)	NOT NULL	COMMENT '사원이름',
	`PHONE`	NVARCHAR(20)	NULL	COMMENT '핸드폰번호',
	`EXTENSION`	NVARCHAR(20)	NULL	COMMENT '내선번호',
	`EMAIL`	NVARCHAR(100)	NOT NULL	COMMENT '구글이메일 주소',
	`ADDRESS`	NVARCHAR(100)	NULL	COMMENT '주소',
	`ANNUAL_LEAVE_COUNT`	INT	NOT NULL	DEFAULT 0	COMMENT '연차개수',
	`HIRE_DATE`	DATE	NULL	COMMENT '입사일'
);

CREATE TABLE `SALARY` (
	`SALARY_NO`	INT	NOT NULL 	COMMENT '시퀀스 자동생성(pk)',
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FK',
	`YEAR_REPORTED`	DATE	NOT NULL	COMMENT '급여 귀속년',
	`MON_REPORTED`	DATE	NOT NULL	COMMENT '급여 귀속월',
	`PAYMENT_DATE`	DATE	NOT NULL	COMMENT '급여 지급년월',
	`TOTAL_GROSSPAY`	INT	NOT NULL	COMMENT '급여 지급총액',
	`TOTAL_DEDUCTIONS`	INT	NOT NULL	COMMENT '급여 공제총액',
	`NET_PAY`	INT	NOT NULL	COMMENT '급여 실지급액',
	`PAYMENTS`	NVARCHAR(1000)	NOT NULL	COMMENT '지급항목(사용자입력)',
	`DEDUCTION`	NVARCHAR(1000)	NOT NULL	COMMENT '공제항목(사용자입력)',
	`P_NAME`	NVARCHAR(20)	NOT NULL	COMMENT '급여당시 데이터',
	`DEPT_NAME`	NVARCHAR(20)	NOT NULL	COMMENT '급여당시 데이터'
);

CREATE TABLE `ATTENDANCE` (
	`WORK_DATE`	DATE	NOT NULL	COMMENT '날짜PK',
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`WORK_ON`	TIME	NULL	COMMENT '출근시간',
	`WORK_OFF`	TIME	NULL	COMMENT '퇴근시간'
);

CREATE TABLE `CHAT_ROOM` (
	`CHATROOM_NO`	INT	NOT NULL	COMMENT '시퀀스자동생성(PK)',
	`USER_NO`	INT	NULL	COMMENT '방 만든사람 FK',
	`LAST_CHAT`	INT	NOT NULL	COMMENT '마지막 채팅 넘버',
	`CREATED_CHAT`	DATE	NOT NULL	COMMENT '채팅방 생성시간'
);

CREATE TABLE `ANNUAL` (
	`YEAR`	INT	NOT NULL	COMMENT 'pk',
	`ANNUAL_UNIT`	INT	NULL	COMMENT '연차 총 개수'
);

CREATE TABLE `BOARD_FILE` (
	`FILE_NO`	INT	NOT NULL 	COMMENT '첨부파일번호 시퀀스PK',
	`BOARD_NO`	INT	NULL	COMMENT '게시글 번호 FK',
	`ORIGIN_FILE`	NVARCHAR(100)	NOT NULL	COMMENT '기존파일명',
	`CHANGE_FILE`	NVARCHAR(100)	NOT NULL	COMMENT '새파일명'
);

CREATE TABLE `BOARD` (
	`BOARD_NO`	INT	NOT NULL 	COMMENT '게시글 번호 PK',
	`BOARD_CD`	CHAR(1)	NOT NULL	COMMENT '게시판 종류FK',
    `DEPT_CODE`	INT	NULL	COMMENT '팀(부서)코드FK',
	`BOARD_TITLE`	NVARCHAR(50)	NOT NULL	COMMENT '글 제목',
	`BOARD_CONTENT`	NVARCHAR(5000)	NOT NULL	COMMENT '글내용',
	`BOARD_WRITER`	NVARCHAR(20)	NOT NULL	COMMENT '작성자',
	`CREATE_DATE`	DATE	NOT NULL	COMMENT '작성일',
	`COUNT` INT	NOT NULL	DEFAULT 0	COMMENT '조회수',
	`FIXED`	CHAR(1)	NULL	COMMENT '게시글 고정 여부',
	`SECRET`	CHAR(1)	NULL	COMMENT 'Y, N'
);

CREATE TABLE `BOARD_REPLY` (
	`REPLY_NO`	INT	NOT NULL 	COMMENT '시퀀스 댓글 번호 PK',
	`BOARD_NO`	INT	NOT NULL	COMMENT '게시글 번호 FK',
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FK(작성자)',
	`CONTENT`	NVARCHAR(500)	NOT NULL	COMMENT '댓글내용',
	`SECRET`	VARCHAR(1)	NULL	COMMENT 'Y, N',
	`TOP_REPLY_NO`	INT	NULL	COMMENT '상위댓글번호',
    `CREATE_DATE` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT  '생성시간'
);

CREATE TABLE `CALENDAR` (
	`CALENDAR_NO`	INT	NOT NULL 	COMMENT '시퀀스자동생성(PK)',
	`CATEGORY`	CHAR(1)	NOT NULL	COMMENT '캘린더 종류',
	`USER_NO`	INT	NULL	COMMENT '유저번호 FK',
	`DEPT_CODE`	INT	NULL	COMMENT '팀(부서)코드FK',
	`TITLE`	NVARCHAR(20)	NOT NULL	COMMENT '일정제목',
	`CONTENT`	NVARCHAR(500)	NOT NULL	COMMENT '일정내용',
	`START_DATE`	DATE	NOT NULL	COMMENT '시작일',
	`END_DATE`	DATE	NOT NULL	COMMENT '종료일',
	`COLOR`	NVARCHAR(10)	NOT NULL	COMMENT '일정 색상',
	`D_DAY`	CHAR(1)	NOT NULL	COMMENT '디데이지정여부'
);

CREATE TABLE `DEPARTMENT` (
	`DEPT_CODE`	INT	NOT NULL 	COMMENT '시퀀스PK',
	`DEPT_NAME`	NVARCHAR(20)	NULL	COMMENT '부서명',
	`TOP_DEPT_CODE`	INT	NULL	COMMENT '상위부서코드'
);

CREATE TABLE `POSITION` (
	`P_CODE`	INT	NOT NULL 	COMMENT '시퀀스PK',
	`P_NAME`	NVARCHAR(10)	NULL	COMMENT '직급명'
);

CREATE TABLE `CHAT_PARTICIPANT` (
	`CHATROOM_NO`	INT	NOT NULL	COMMENT '채팅방번호FPK',
	`USER_NO`	INT	NOT NULL	COMMENT '참가유저 FPK',
	`ROOM_NAME`	NVARCHAR(20)	NOT NULL	COMMENT '채팅방 이름',
	`NOT_READ_CHAT`	INT	NOT NULL	COMMENT '읽지 않은 채팅 수',
	`LAST_READ_CHAT_NO`	INT	NOT NULL	COMMENT '마지막으로 읽은 채팅 번호',
	`CREATE_DATE`	DATETIME	NOT NULL	COMMENT '생성날짜(입장일)',
	`BELL_SETTING`	CHAR(1)	NOT NULL	DEFAULT 'Y'	COMMENT '채팅방알림설정(N,Y)'
);

CREATE TABLE `USER_DEPARTMENT` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`P_CODE`	INT	NOT NULL	COMMENT '직급코드 FK',
	`DEPT_CODE`	INT	NOT NULL	COMMENT '부서코드 FK'
);

CREATE TABLE `RESIGNED_MEMBER` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`RESIGNED_DATE`	DATE	NOT NULL	COMMENT '퇴사일',
	`DEPT_NAME`	NVARCHAR(20)	NULL	COMMENT '부서명 텍스트로 입력',
	`T_NAME`	NVARCHAR(20)	NULL	COMMENT '팀명 텍스트로 입력',
	`P_NAME`	NVARCHAR(20)	NULL	COMMENT '직급명 텍스트로 입력'
);

CREATE TABLE `ROLE_LIST` (
	`ROLE_CODE`	NVARCHAR(5)	NOT NULL	COMMENT '권한코드 PK',
	`ROLE_NAME`	NVARCHAR(20)	NOT NULL	COMMENT '권한명'
);

CREATE TABLE `DEPARTMENT_ROLE` (
	`DEPT_CODE`	INT	NOT NULL	COMMENT '부서코드FPK',
	`P_CODE`	INT	NOT NULL	COMMENT '직급코드FPK',
	`ROLE_CODE`	NVARCHAR(5)	NOT NULL	COMMENT '권한번호 FPK'
);

CREATE TABLE `APPROVAL` (
	`APPROVAL_NO`	INT	NOT NULL 	COMMENT '시퀀스값PK',
	`USER_NO`	INT	NULL	COMMENT '기안자FK',
	`TYPE`	INT	NOT NULL	DEFAULT 0	COMMENT '결재 종류(일반0,휴가1,오전반차2,오후반차3)',
	`TITLE`	NVARCHAR(30)	NOT NULL	COMMENT '결재 제목',
	`CONTENT`	NVARCHAR(4000)	NULL	COMMENT '결재 내용',
	`DRAFT_DATE`	DATETIME	NOT NULL	COMMENT '기안일',
	`STATUS`	INT	NOT NULL	DEFAULT 0	COMMENT '결재 상태(진행중0,반려-1,완료1, 임시저장2)',
	`START_DATE`	DATE	NULL	COMMENT '시작날짜',
	`END_DATE`	DATE	NULL	COMMENT '종료날짜',
	`USER_NAME`	NVARCHAR(10)	NULL	COMMENT '기안자명',
	`APPROVAL_LINE_IMG`	NVARCHAR(30)	NULL	COMMENT '결재라인 이미지'
);
	
CREATE TABLE `APPROVAL_FORM` (
	`FORM_NO`	INT	NOT NULL 	COMMENT '시퀀스값PK',
	`TYPE`	NVARCHAR(5)	NOT NULL	COMMENT '결재종류',
	`TITLE`	NVARCHAR(20)	NOT NULL	COMMENT '양식명',
	`CONTENT`	NVARCHAR(4000)	NULL	COMMENT '양식내용'
);

CREATE TABLE `APPROVAL_LINE` (
	`LEVEL`	INT	NOT NULL	COMMENT '결재순서PK',
	`APPROVAL_NO`	INT	NOT NULL	COMMENT '전자결재번호FPK',
	`USER_NO`	INT	NOT NULL	COMMENT '결재자/참조자 유저번호FK',
	`TYPE`	CHAR(1)	NOT NULL	COMMENT '결재자(A)/참조자(R)',
	`STATUS`	INT	NOT NULL	DEFAULT 0	COMMENT '결재상태(기본0,대기1,승인2,반려-1)',
	`CONFIRM_STATUS`	CHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT '확인여부',
	`DATE`	DATETIME	NULL	COMMENT '결재일'
);

CREATE TABLE `APPROVAL_FAVORITE_LINE` (
	`LINE_NO`	INT	NOT NULL 	COMMENT '시퀀스PK',
	`USER_NO`	INT	NOT NULL	COMMENT '즐겨찾기 등록자FK',
	`TITLE`	NVARCHAR(20)	NOT NULL	COMMENT '즐겨찾기명'
);

CREATE TABLE `APPROVAL_ACTUAL_FAVORITE_LINE` (
	`LEVEL`	INT	NOT NULL	COMMENT '결재순서PK',
	`LINE_NO`	INT	NOT NULL	COMMENT '즐겨찾기된 결제라인번호FPK',
	`USER_NO`	INT	NOT NULL	COMMENT '결재/참조자',
	`TYPE`	CHAR(1)	NOT NULL	COMMENT '결재자(A)/참조자(R)'
);

CREATE TABLE `APPROVAL_MEMO` (
	`MEMO_NO`	INT	NOT NULL 	COMMENT '시퀀스PK',
	`APPROVAL_NO`	INT	NOT NULL	COMMENT '전자결재 번호FK',
	`USER_NO`	INT	NOT NULL	COMMENT '작성자FK',
	`CONTENT`	NVARCHAR(1000)	NULL	COMMENT '내용',
	`DATE`	DATETIME	NOT NULL	COMMENT '최초등록일'
);

CREATE TABLE `APPROVAL_FILE` (
	`FILE_NO`	INT	NOT NULL	COMMENT '시퀀스 PK',
    `REF_TYPE` NVARCHAR(10) NOT NULL COMMENT '파일이 속한 테이블 종류', 
	`REF_NO`	INT	NOT NULL	COMMENT '폼, 전자결재, 메모 NO값',
	`ORIGIN_NAME`	NVARCHAR(30)	 NULL	COMMENT '기존파일명',
	`CHANGE_NAME`	NVARCHAR(30)	NOT NULL	COMMENT '변경된파일명'
);

CREATE TABLE `USER_ROLE` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`ROLE_CODE`	NVARCHAR(5)	NOT NULL	COMMENT '권한번호 FPK'
);

CREATE TABLE `SIGNATURE_IMG` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`SIGNATURE_IMG`	NVARCHAR(30)	NOT NULL	COMMENT '서명이미지 파일명'
);

CREATE TABLE `CALENDAR_MEMO` (
	`USER_NO`	INT	NOT NULL	COMMENT '유저번호 FPK',
	`MEMO`	NVARCHAR(1000)	NULL	COMMENT '캘린더 메모'
);

CREATE TABLE `CHAT` (
	`CHAT_NO`	INT	NOT NULL 	COMMENT '시퀀스자동생성(PK)',
	`CHATROOM_NO`	INT	NOT NULL	COMMENT '채팅방번호FK',
	`USER_NO`	INT	NOT NULL	COMMENT '작성자 FK',
	`MESSAGE`	NVARCHAR(1000)	NULL	COMMENT '채팅 메세지',
	`NOT_RECEIVED`	INT	NULL	COMMENT '채팅 안읽은사람 수',
	`RECEIVED_DATE`	DATETIME	NOT NULL	COMMENT '채팅 생성날짜',
	`MESSAGE_TYPE`	INT	NOT NULL	COMMENT '메세지종류(일반1,이미지2,첨부3)'
);

CREATE TABLE `PERSONNEL` (
	`PERSONNEL_NO`	INT	NOT NULL 	COMMENT '시퀀스자동생성(PK)',
	`PERSONNEL_DATE`	DATETIME	NOT NULL	COMMENT '발령날짜',
	`USER_NO`	INT	NOT NULL	COMMENT '발령당한사람 FK',
	`P_BEFORE`	NVARCHAR(20)	NULL	COMMENT '이전부서(텍스트로 입력)',
	`P_PERSONNEL`	NVARCHAR(20)	NULL	COMMENT '발령부서(텍스트로 입력)',
	`D_BEFORE`	NVARCHAR(20)	NULL	COMMENT '이전직급(텍스트로 입력)',
	`D_PERSONNER`	NVARCHAR(20)	NULL	COMMENT '발령직급(텍스트로 입력)'
);

CREATE TABLE `CHAT_FILE` (
	`CHAT_FILE_NO`	INT	NOT NULL 	COMMENT '시퀀스자동생성(PK)',
	`CHAT_NO`	INT	NOT NULL	COMMENT '채팅번호FK',
	`ORIGINAL_FILENAME`	NVARCHAR(30)	NULL	COMMENT '기본파일명',
	`RENAME_FILENAME`	NVARCHAR(30)	NULL	COMMENT '바꿔준파일명'
);

CREATE TABLE `BOARD_TYPE` (
	`BOARD_CD`	CHAR(1)	NOT NULL	COMMENT '게시판 종류PK',
	`BOARD_NAME`	NVARCHAR(30)	NOT NULL	COMMENT '게시판명'
);

CREATE TABLE `ONLINE_STATUS` (
	`STATUS_TYPE`	INT	NOT NULL	COMMENT '접속 종류PK',
	`STATUS_NAME`	NVARCHAR(10)	NOT NULL	COMMENT '접속종류 명',
	`STATUS_IMG`	NVARCHAR(30)	NOT NULL	COMMENT '접속이미지명'
);

ALTER TABLE `MEMBER` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`USER_NO`
);

ALTER TABLE `SALARY` ADD CONSTRAINT `PK_SALARY` PRIMARY KEY (
	`SALARY_NO`
);

ALTER TABLE `ATTENDANCE` ADD CONSTRAINT `PK_ATTENDANCE` PRIMARY KEY (
	`WORK_DATE`,
	`USER_NO`
);

ALTER TABLE `CHAT_ROOM` ADD CONSTRAINT `PK_CHAT_ROOM` PRIMARY KEY (
	`CHATROOM_NO`
);

ALTER TABLE `ANNUAL` ADD CONSTRAINT `PK_ANNUAL` PRIMARY KEY (
	`YEAR`
);

ALTER TABLE `BOARD_FILE` ADD CONSTRAINT `PK_BOARD_FILE` PRIMARY KEY (
	`FILE_NO`
);

ALTER TABLE `BOARD` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`BOARD_NO`
);

ALTER TABLE `BOARD_REPLY` ADD CONSTRAINT `PK_BOARD_REPLY` PRIMARY KEY (
	`REPLY_NO`
);

ALTER TABLE `CALENDAR` ADD CONSTRAINT `PK_CALENDAR` PRIMARY KEY (
	`CALENDAR_NO`
);

ALTER TABLE `DEPARTMENT` ADD CONSTRAINT `PK_DEPARTMENT` PRIMARY KEY (
	`DEPT_CODE`
);

ALTER TABLE `POSITION` ADD CONSTRAINT `PK_POSITION` PRIMARY KEY (
	`P_CODE`
);

ALTER TABLE `CHAT_PARTICIPANT` ADD CONSTRAINT `PK_CHAT_PARTICIPANT` PRIMARY KEY (
	`CHATROOM_NO`,
	`USER_NO`
);

ALTER TABLE `USER_DEPARTMENT` ADD CONSTRAINT `PK_USER_DEPARTMENT` PRIMARY KEY (
	`USER_NO`
);

ALTER TABLE `RESIGNED_MEMBER` ADD CONSTRAINT `PK_RESIGNED_MEMBER` PRIMARY KEY (
	`USER_NO`
);

ALTER TABLE `ROLE_LIST` ADD CONSTRAINT `PK_ROLE_LIST` PRIMARY KEY (
	`ROLE_CODE`
);

ALTER TABLE `DEPARTMENT_ROLE` ADD CONSTRAINT `PK_DEPARTMENT_ROLE` PRIMARY KEY (
	`DEPT_CODE`,
	`P_CODE`,
	`ROLE_CODE`
);

ALTER TABLE `APPROVAL` ADD CONSTRAINT `PK_APPROVAL` PRIMARY KEY (
	`APPROVAL_NO`
);

ALTER TABLE `APPROVAL_FORM` ADD CONSTRAINT `PK_APPROVAL_FORM` PRIMARY KEY (
	`FORM_NO`
);

ALTER TABLE `APPROVAL_LINE` ADD CONSTRAINT `PK_APPROVAL_LINE` PRIMARY KEY (
	`LEVEL`,
	`APPROVAL_NO`
);

ALTER TABLE `APPROVAL_FAVORITE_LINE` ADD CONSTRAINT `PK_APPROVAL_FAVORITE_LINE` PRIMARY KEY (
	`LINE_NO`
);

ALTER TABLE `APPROVAL_ACTUAL_FAVORITE_LINE` ADD CONSTRAINT `PK_APPROVAL_ACTUAL_FAVORITE_LINE` PRIMARY KEY (
	`LEVEL`,
	`LINE_NO`
);

ALTER TABLE `APPROVAL_MEMO` ADD CONSTRAINT `PK_APPROVAL_MEMO` PRIMARY KEY (
	`MEMO_NO`
);

ALTER TABLE `APPROVAL_FILE` ADD CONSTRAINT `PK_APPROVAL_FILE` PRIMARY KEY (
	`FILE_NO`
);

ALTER TABLE `USER_ROLE` ADD CONSTRAINT `PK_USER_ROLE` PRIMARY KEY (
	`USER_NO`,
	`ROLE_CODE`
);

ALTER TABLE `SIGNATURE_IMG` ADD CONSTRAINT `PK_SIGNATURE_IMG` PRIMARY KEY (
	`USER_NO`
);

ALTER TABLE `CALENDAR_MEMO` ADD CONSTRAINT `PK_CALENDAR_MEMO` PRIMARY KEY (
	`USER_NO`
);

ALTER TABLE `CHAT` ADD CONSTRAINT `PK_CHAT` PRIMARY KEY (
	`CHAT_NO`
);

ALTER TABLE `PERSONNEL` ADD CONSTRAINT `PK_PERSONNEL` PRIMARY KEY (
	`PERSONNEL_NO`
);

ALTER TABLE `CHAT_FILE` ADD CONSTRAINT `PK_CHAT_FILE` PRIMARY KEY (
	`CHAT_FILE_NO`
);

ALTER TABLE `BOARD_TYPE` ADD CONSTRAINT `PK_BOARD_TYPE` PRIMARY KEY (
	`BOARD_CD`
);

ALTER TABLE `ONLINE_STATUS` ADD CONSTRAINT `PK_ONLINE_STATUS` PRIMARY KEY (
	`STATUS_TYPE`
);


ALTER TABLE MEMBER MODIFY USER_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE SALARY MODIFY SALARY_NO INT NOT NULL AUTO_INCREMENT;

ALTER TABLE BOARD_FILE MODIFY FILE_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE BOARD MODIFY BOARD_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE BOARD_REPLY MODIFY REPLY_NO INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CALENDAR MODIFY CALENDAR_NO INT NOT NULL AUTO_INCREMENT;

ALTER TABLE DEPARTMENT MODIFY DEPT_CODE INT NOT NULL AUTO_INCREMENT;
ALTER TABLE POSITION MODIFY P_CODE INT NOT NULL AUTO_INCREMENT;

ALTER TABLE APPROVAL MODIFY APPROVAL_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE APPROVAL_FORM MODIFY FORM_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE APPROVAL_FAVORITE_LINE MODIFY LINE_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE APPROVAL_MEMO MODIFY MEMO_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE APPROVAL_FILE MODIFY FILE_NO INT NOT NULL AUTO_INCREMENT;

ALTER TABLE PERSONNEL MODIFY PERSONNEL_NO INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CHAT_ROOM MODIFY CHATROOM_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE CHAT MODIFY CHAT_NO INT NOT NULL AUTO_INCREMENT;
ALTER TABLE CHAT_FILE MODIFY CHAT_FILE_NO INT NOT NULL AUTO_INCREMENT;



ALTER TABLE `MEMBER` ADD CONSTRAINT `FK_ONLINE_STATUS_TO_MEMBER_1` FOREIGN KEY (
	`STATUS_TYPE`
)
REFERENCES `ONLINE_STATUS` (
	`STATUS_TYPE`
);

ALTER TABLE `SALARY` ADD CONSTRAINT `FK_MEMBER_TO_SALARY_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `ATTENDANCE` ADD CONSTRAINT `FK_MEMBER_TO_ATTENDANCE_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `CHAT_ROOM` ADD CONSTRAINT `FK_MEMBER_TO_CHAT_ROOM_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE SET NULL;

ALTER TABLE `BOARD_FILE` ADD CONSTRAINT `FK_BOARD_TO_BOARD_FILE_1` FOREIGN KEY (
	`BOARD_NO`
)
REFERENCES `BOARD` (
	`BOARD_NO`
) ON DELETE SET NULL;

ALTER TABLE `BOARD` ADD CONSTRAINT `FK_BOARD_TYPE_TO_BOARD_1` FOREIGN KEY (
	`BOARD_CD`
)
REFERENCES `BOARD_TYPE` (
	`BOARD_CD`
);
ALTER TABLE `BOARD` ADD CONSTRAINT `FK_DEPT_CODE_TO_BOARD` FOREIGN KEY (
   `DEPT_CODE`
)

REFERENCES `DEPARTMENT` (
   `DEPT_CODE`
) ON DELETE CASCADE;

ALTER TABLE `BOARD_REPLY` ADD CONSTRAINT `FK_BOARD_TO_BOARD_REPLY_1` FOREIGN KEY (
	`BOARD_NO`
)
REFERENCES `BOARD` (
	`BOARD_NO`
) ON DELETE CASCADE;

ALTER TABLE `BOARD_REPLY` ADD CONSTRAINT `FK_MEMBER_TO_BOARD_REPLY_1` FOREIGN KEY (
	`USER_NO`
)


REFERENCES `MEMBER` (
	`USER_NO`
);

ALTER TABLE `CALENDAR` ADD CONSTRAINT `FK_MEMBER_TO_CALENDAR_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `CALENDAR` ADD CONSTRAINT `FK_DEPARTMENT_TO_CALENDAR_1` FOREIGN KEY (
	`DEPT_CODE`
)
REFERENCES `DEPARTMENT` (
	`DEPT_CODE`
) ON DELETE CASCADE;

ALTER TABLE `CHAT_PARTICIPANT` ADD CONSTRAINT `FK_CHAT_ROOM_TO_CHAT_PARTICIPANT_1` FOREIGN KEY (
	`CHATROOM_NO`
)
REFERENCES `CHAT_ROOM` (
	`CHATROOM_NO`
) ON DELETE CASCADE;

ALTER TABLE `CHAT_PARTICIPANT` ADD CONSTRAINT `FK_MEMBER_TO_CHAT_PARTICIPANT_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `USER_DEPARTMENT` ADD CONSTRAINT `FK_MEMBER_TO_USER_DEPARTMENT_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
);

ALTER TABLE `USER_DEPARTMENT` ADD CONSTRAINT `FK_POSITION_TO_USER_DEPARTMENT_1` FOREIGN KEY (
	`P_CODE`
)
REFERENCES `POSITION` (
	`P_CODE`
);

ALTER TABLE `USER_DEPARTMENT` ADD CONSTRAINT `FK_DEPARTMENT_TO_USER_DEPARTMENT_1` FOREIGN KEY (
	`DEPT_CODE`
)
REFERENCES `DEPARTMENT` (
	`DEPT_CODE`
) ON DELETE CASCADE;

ALTER TABLE `RESIGNED_MEMBER` ADD CONSTRAINT `FK_MEMBER_TO_RESIGNED_MEMBER_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `DEPARTMENT_ROLE` ADD CONSTRAINT `FK_DEPARTMENT_TO_DEPARTMENT_ROLE_1` FOREIGN KEY (
	`DEPT_CODE`
)
REFERENCES `DEPARTMENT` (
	`DEPT_CODE`
) ON DELETE CASCADE;

ALTER TABLE `DEPARTMENT_ROLE` ADD CONSTRAINT `FK_POSITION_TO_DEPARTMENT_ROLE_1` FOREIGN KEY (
	`P_CODE`
)
REFERENCES `POSITION` (
	`P_CODE`
) ON DELETE CASCADE;

ALTER TABLE `DEPARTMENT_ROLE` ADD CONSTRAINT `FK_ROLE_LIST_TO_DEPARTMENT_ROLE_1` FOREIGN KEY (
	`ROLE_CODE`
)
REFERENCES `ROLE_LIST` (
	`ROLE_CODE`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL` ADD CONSTRAINT `FK_MEMBER_TO_APPROVAL_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE SET NULL;

ALTER TABLE `APPROVAL_LINE` ADD CONSTRAINT `FK_APPROVAL_TO_APPROVAL_LINE_1` FOREIGN KEY (
	`APPROVAL_NO`
)
REFERENCES `APPROVAL` (
	`APPROVAL_NO`
)  ON DELETE CASCADE;

ALTER TABLE `APPROVAL_LINE` ADD CONSTRAINT `FK_MEMBER_TO_APPROVAL_LINE_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL_FAVORITE_LINE` ADD CONSTRAINT `FK_MEMBER_TO_APPROVAL_FAVORITE_LINE_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL_ACTUAL_FAVORITE_LINE` ADD CONSTRAINT `FK_APPROVAL_FAVORITE_LINE_TO_APPROVAL_ACTUAL_FAVORITE_LINE_1` FOREIGN KEY (
	`LINE_NO`
)
REFERENCES `APPROVAL_FAVORITE_LINE` (
	`LINE_NO`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL_ACTUAL_FAVORITE_LINE` ADD CONSTRAINT `FK_MEMBER_TO_APPROVAL_ACTUAL_FAVORITE_LINE_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL_MEMO` ADD CONSTRAINT `FK_APPROVAL_TO_APPROVAL_MEMO_1` FOREIGN KEY (
	`APPROVAL_NO`
)
REFERENCES `APPROVAL` (
	`APPROVAL_NO`
) ON DELETE CASCADE;

ALTER TABLE `APPROVAL_MEMO` ADD CONSTRAINT `FK_MEMBER_TO_APPROVAL_MEMO_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `USER_ROLE` ADD CONSTRAINT `FK_MEMBER_TO_USER_ROLE_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `USER_ROLE` ADD CONSTRAINT `FK_ROLE_LIST_TO_USER_ROLE_1` FOREIGN KEY (
	`ROLE_CODE`
)
REFERENCES `ROLE_LIST` (
	`ROLE_CODE`
) ON DELETE CASCADE;

ALTER TABLE `SIGNATURE_IMG` ADD CONSTRAINT `FK_MEMBER_TO_SIGNATURE_IMG_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `CALENDAR_MEMO` ADD CONSTRAINT `FK_MEMBER_TO_CALENDAR_MEMO_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `CHAT` ADD CONSTRAINT `FK_CHAT_ROOM_TO_CHAT_1` FOREIGN KEY (
	`CHATROOM_NO`
)
REFERENCES `CHAT_ROOM` (
	`CHATROOM_NO`
) ON DELETE CASCADE;

ALTER TABLE `CHAT` ADD CONSTRAINT `FK_MEMBER_TO_CHAT_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;

ALTER TABLE `PERSONNEL` ADD CONSTRAINT `FK_MEMBER_TO_PERSONNEL_1` FOREIGN KEY (
	`USER_NO`
)
REFERENCES `MEMBER` (
	`USER_NO`
) ON DELETE CASCADE;


ALTER TABLE `CHAT_FILE` ADD CONSTRAINT `FK_CHAT_TO_CHAT_FILE_1` FOREIGN KEY (
	`CHAT_NO`
)
REFERENCES `CHAT` (
	`CHAT_NO`
) ON DELETE CASCADE;




-- 계정 상태member 테이블 기본 데이터
INSERT INTO ONLINE_STATUS(STATUS_TYPE, STATUS_NAME, STATUS_IMG)
   VALUES ( 0 , '오프라인' , 'offline.svg'),
			( 1 , '온라인' , 'online.svg'), 
            ( 2 , '자리비움' , 'absence.svg'),
            ( 3 , '회의중' , 'meeting.svg'),
            ( 4 , '식사중' , 'eat.svg');

-- 연차 테이블 기본 데이터
  INSERT INTO ANNUAL(YEAR, ANNUAL_UNIT)
   VALUES ( 0, 0 ),
			( 1, 15 ), ( 2, 15 ), ( 3, 16 ), ( 4, 16 ), ( 5, 17 ),
			( 6, 17 ), ( 7, 18 ), ( 8, 18 ), ( 9, 19 ), ( 10, 19 ),
            ( 11, 20 ), ( 12, 20 ), ( 13, 21 ), ( 14, 21 ), ( 15, 22 ),
            ( 16, 22 ), ( 17, 23 ), ( 18, 23 ), ( 19, 24 ), ( 20, 24 ),
            ( 21, 25 ), ( 22, 25 ) ;



-- 권한 테이블 기본 데이터
  INSERT INTO ROLE_LIST(ROLE_CODE, ROLE_NAME)
   VALUES ( 'Y01', '연차 관리' ),
			( 'D01', '조직도 관리' ),
            ( 'A01', '근태 관리' ),
            ( 'B01', '공지사항 관리' ),
            ( 'B02', '자유게시판 관리' ),
            ( 'M01', '계정관리' ),
            ( 'R01', '권한관리' ),
            ( 'S01', '급여명세서관리' ),
            ( 'T01', '결재양식 관리' ),
            ( 'T02', '전체 결재조회' ) ;


-- 게시판 종류 기본 데이터 

  INSERT INTO BOARD_TYPE(BOARD_CD, BOARD_NAME)
   VALUES ( 'N', '공지사항' ),
			( 'F', '자유게시판' ),
            ( 'T', '팀게시판' );


-- 관리자 계정 데이터
INSERT INTO MEMBER(ENO, STATUS_TYPE, USER_PWD, USER_NAME, HIRE_DATE, EMAIL)
   VALUES ( 230501 , 0,'$2a$10$yxK11.vtoleH4hCUbWfIrezMoyK7Jf4pJQ4INP.5L1G4C3vkCO4Pm', 'admin', SYSDATE(), 'admin@gmail.com');

INSERT INTO USER_ROLE(USER_NO, ROLE_CODE)
   VALUES ( 1 , 'Y01'),
			( 1 , 'D01'),
            ( 1 , 'A01'),
            ( 1 , 'B01'),
            ( 1 , 'B02'),
			( 1 , 'M01'),
			( 1 , 'R01'),
            ( 1 , 'S01'),
            ( 1 , 'T01'),
            ( 1 , 'T02') ;
            





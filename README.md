# Opeaceful

> ## 팀원

- [한승은(조장)](#한승은)
- [김진기](#김진기)
- [김혜린](#김혜린)
- [노지의](#노지의)
- [박가영](#박가영)
- [윤지영](#윤지영)

---

> ## 프로젝트 소개

### 사내 그룹웨어 프로그램

실시간 협업, 보안과 접근제어, 업무 문서 및 파일공유
사원 친화적인 그룹웨어를 기획

반응형 웹페이지와 AWS를 통한 배포까지를 목표로 함.

- [[PPT] 다운로드](./Opeaceful/src/main/webapp/resources/etc/pdf/opeaceful.pdf)
- [기획서(바로가기)](https://docs.google.com/spreadsheets/d/1BetFMp64okyNTD5TSe3A4GyWWF_pxn_f3TOzRJlA34o/edit?usp=sharing)

<br>

![프로젝트 소개](./Opeaceful/src/main/webapp/resources/etc/video/opeaceful.gif)

<br>

---

<!-- > ## 주요 기능 -->

<blockquote>
<h2>주요기능</h2>
<p><small>※각 메뉴 클릭시 상세 내용 확인가능</small></p>
</blockquote>

<details>
<summary> 로그인 / 메인 </summary><br>
<div markdown="1">

![로그인 / 메인](./Opeaceful/src/main/webapp/resources/etc/video/login.gif)

</div>
</details>

<details>
<summary> 내정보 </summary><br>
<div markdown="1">

![내정보](./Opeaceful/src/main/webapp/resources/etc/video/mypage.gif)

</div>
</details>

<details>
<summary> 연차관리 </summary><br>
<div markdown="1">

![연차관리](./Opeaceful/src/main/webapp/resources/etc/video/annual.gif)

</div>
</details>

<details>
<summary> 조직도 </summary>
<div markdown="1">

![조직도](./Opeaceful/src/main/webapp/resources/etc/video/darkmode.gif)

</div>
</details>

<details>
<summary> 게시판 </summary>
<div markdown="1">

![게시판](./Opeaceful/src/main/webapp/resources/etc/video/board.gif)

</div>
</details>

<details>
<summary> 캘린더 </summary>
<div markdown="1">

![캘린더](./Opeaceful/src/main/webapp/resources/etc/video/calendar.gif)

</div>
</details>

<details>
<summary> 근태관리 </summary>
<div markdown="1">

![근태관리](./Opeaceful/src/main/webapp/resources/etc/video/darkmode.gif)

</div>
</details>

<details>
<summary> 계정관리 </summary>
<div markdown="1">

![계정관리](./Opeaceful/src/main/webapp/resources/etc/video/member.gif)

</div>
</details>

<details>
<summary> 권한관리 </summary>
<div markdown="1">

![권한관리](./Opeaceful/src/main/webapp/resources/etc/video/role.gif)

</div>
</details>

<details>
<summary> 급여관리 </summary>
<div markdown="1">

![급여관리](./Opeaceful/src/main/webapp/resources/etc/video/salary.gif)

</div>
</details>

<details>
<summary> 전자결제 </summary>
<div markdown="1">
  
  - 전자결재 양식
  ![전자결제양식](./Opeaceful/src/main/webapp/resources/etc/video/approvalForm.gif)
  - MY 전자결재
    ![전자결제](./Opeaceful/src/main/webapp/resources/etc/video/approval.gif)
  - 전자결재 관리
    ![전자결제관리](./Opeaceful/src/main/webapp/resources/etc/video/approvalManage.gif)

</div>
</details>

<details>
<summary> 메신저 </summary>
<div markdown="1">

![채팅](./Opeaceful/src/main/webapp/resources/etc/video/chat.gif)

</div>
</details>

<details>
<summary> 다크모드 </summary>
<div markdown="1">

![다크모드](./Opeaceful/src/main/webapp/resources/etc/video/darkmode.gif)

</div>
</details>

<br>

---

> ## 담당 기능

## 노지의

<a href="./Opeaceful/src/main/webapp/resources/etc/pdf/노지의_opeaceful.pdf" download="Opeaceful.pdf">[PPT] 다운로드</a>

- 로그인 / 로그아웃
  - [login.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/member/login.jsp) : 로그인 페이지
  - [LoginController.java](./Opeaceful/src/main/java/com/company/opeaceful/member/controller/LoginController.java) : 로그인 처리 / 비밀번호 제한 처리(임시비밀번호 생성) / 아이디 저장
- 메인
  - [main.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/main.jsp) : 메인 페이지
  - [main.js](./Opeaceful/src/main/webapp/resources/js/main.js) : 프로필 조회 / 현재 시간 및 출 퇴근 기록 / 접속상태
  - [weather.js](./Opeaceful/src/main/webapp/resources/js/weather.js) : 현재 날씨 및 주간 날씨
- 사이드바
  - [sidebar.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/sidebar.jsp) : 사이드바
  - [LoginController.java](./Opeaceful/src/main/java/com/company/opeaceful/member/controller/LoginController.java) : 사이드바 권한 조회
- 내정보변경
  - [mypage.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/member/mypage.jsp) : 정보변경 페이지
  - [mypage.js](./Opeaceful/src/main/webapp/resources/js/member/mypage.js) : 비밀번호 변경 데이터 처리
  - [LoginController.java](./Opeaceful/src/main/java/com/company/opeaceful/member/controller/MemberController.java) : 내 정보 변경 / 비밀번호 변경
- 연차관리
  - [annual.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/annual/annual.jsp) : 연차 조회 페이지
  - [annual-user.js](./Opeaceful/src/main/webapp/resources/js/annual-user.js) : 연차 조회 데이터 처리
  - [annual-user.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/annual/annual-user.jsp) : 사원 연차 등록 및 수정 페이지
  - [AnnualController.java](./Opeaceful/src/main/java/com/company/opeaceful/annual/controller/AnnualController.java) : 연차 관련 모든 처리
  - [spring-scheduler.xml](./Opeaceful/src/main/webapp/WEB-INF/spring/spring-scheduler.xml) : 연차 리셋 스케줄러
  - [LoginController.java](./Opeaceful/src/main/java/com/company/opeaceful/member/controller/LoginController.java) : 연차 리셋 스케줄링 메소드 생성 후 연차 조회 후 리셋

---

## 김진기

[[PPT] 링크](https://www.miricanvas.com/v/125yzpx) &nbsp; / &nbsp; [[PPT] 다운로드](./Opeaceful/src/main/webapp/resources/etc/pdf/김진기.pdf)

- 메신저

  - [chat.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/chat.jsp) : 메신저 페이지
  - [ChatController.java](./Opeaceful/src/main/java/com/company/opeaceful/chat/controller/ChatController.java) : 메신저 공통 컨트롤러
  - [ChatWebsocketHandler.java](./Opeaceful/src/main/java/com/company/opeaceful/chat/model/websocket/ChatWebsocketHandler.java) : 웹소켓 핸들러
  - [chat-mapper.xml](./Opeaceful/src/main/resources/mappers/chat-mapper.xml) : 메신저 공통 매퍼
  - [chat.js](./Opeaceful/src/main/webapp/resources/js/chat/chat.js) : 메신저 js 파일
  - [chatJs.js](./Opeaceful/src/main/webapp/resources/js/chat/chatJs.js) : 메신저 메뉴 이동 js 파일
  - [chatModal.js](./Opeaceful/src/main/webapp/resources/js/chat/chatModal.js) : 채팅방 초대 멤버 조회 js 파일


---

## 박가영

---

## 한승은

[[PPT] 링크](https://www.miricanvas.com/v/127mvz2) &nbsp; / &nbsp; [[PPT] 다운로드](./Opeaceful/src/main/webapp/resources/etc/pdf/한승은.pdf)

- SQL
  - [Opeaceful_TABLE.sql](./Opeaceful/SQL/Opeaceful_TABLE.sql) : MYSQL 테이블 기본 세팅용 sql파일
- 전자결재 공통 양식 메뉴
  - [ApprovalFormController.java](./Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalFormController.java) : 전자결재 양식용 컨트롤러
  - [approvalForm.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/approvalForm.jsp) : 전자결재 양식 페이지
  - [approvalFormData.js](./Opeaceful/src/main/webapp/resources/js/approval/approvalFormData.js) : 전자결재 양식 페이지용 Ajax를 모아둔 js 파일
  - [approvalFormFront.js](./Opeaceful/src/main/webapp/resources/js/approval/approvalFormFront.js) : 전자결재 양식 페이지용 페이지의 기본동작 이벤트를 부여한 js 파일
- 전자결재 관리 메뉴
  - [ApprovalController.java](./Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalController.java) : MY전자결재, 전자결재 관리 메뉴 공통 컨트롤러
  - [allApproval.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/allApproval.jsp) : 전자결재 관리 페이지
  - [allApprovalData.js](./Opeaceful/src/main/webapp/resources/js/approval/allApprovalData.js) : 전자결재 관리 페이지용 Ajax를 모아둔 js파일
  - [allApprovalFront.js](./Opeaceful/src/main/webapp/resources/js/approval/allApprovalFront.js) : 전자결재 관리 페이지용 기본동작 이벤트를 부여한 js 파일
- MY전자결재 메뉴
  - [ApprovalController.java](./Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalController.java) : MY전자결재, 전자결재 관리 메뉴 공통 컨트롤러
  - [myApproval.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/myApproval.jsp) : MY전자결재 페이지
  - [myApprovalData.js](./Opeaceful/src/main/webapp/resources/js/approval/myApprovalData.js) : MY전자결재 페이지용 Ajax를 모아둔 js파일
  - [myApprovalFront.js](./Opeaceful/src/main/webapp/resources/js/approval/myApprovalFront.js) : MY전자결재 페이지용 기본동작 이벤트를 부여한 js 파일
- 전자결재 공통 파일들
  - Mapper
    - [approval-mapper.xml](./Opeaceful/src/main/resources/mappers/approval-mapper.xml) : 전자결재 관련 공통 매퍼  
  - 메모
    - [memoModal.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/memoModal.jsp) : 전자결재 메모 모달 화면
    - [memo.js](./Opeaceful/src/main/webapp/resources/js/approval/memo.js) : 전자결재 메모 기본동작용 js 파일
  - 전자결재 작성/수정 모달
    - [approvalModal.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/approvalModal.jsp) : 전자결재 작성/수정용 모달 화면
    - [approvalModal.js](./Opeaceful/src/main/webapp/resources/js/approval/approvalModal.js) : 전자결재 작성/수정용 모달 기본 동작용 js 파일
  - 전자결재 조회 모달
    - [endApprovalModal.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/approval/endApprovalModal.jsp) : 전자결재 문서 조회용 모달 화면
  - 텍스트에디터
    - [tinyEditor.js](./Opeaceful/src/main/webapp/resources/js/approval/tinyEditor.js) : Tinymce 에디터 사용및 세팅을 위한 js 파일
  - 전자결재 알림
    - [AprWebsocketHandler.java](./Opeaceful/src/main/java/com/company/opeaceful/approval/model/websocket/AprWebsocketHandler.java) : 전자결재 알림을 위한 웹소켓 핸들러
    - [aprWebsocket.js](./Opeaceful/src/main/webapp/resources/js/approval/aprWebsocket.js) : 전자결재 알림용 웹소켓 js 파일


---

## 김혜린

[[PPT] 다운로드](./Opeaceful/src/main/webapp/resources/etc/pdf/김혜린.pdf)

- 캘린더
  - [calendarPage.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/calendar/calendarPage.jsp) : 캘린더 페이지
  - [calendarController.java](./Opeaceful/src/main/java/com/company/opeaceful/calendar/controller/calendarController.java) : 캘린더 관련 기능 공통 컨트롤러
  - [ApprovalController.java](./Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalController.java) : 개인 / 팀 캘린더 내 연차 일정 표기 컨트롤러
  - [calendar.js](./Opeaceful/src/main/webapp/resources/js/calendar/calendar.js) : fulcalendar 라이브러리 적용 /  캘린더 관련 기능 공통 스크립트
  - [calendar-mapper.xml](./Opeaceful/src/main/resources/mappers/calendar-mapper.xml) : 캘린더 관련 공통 매퍼
 
- 게시판
  - [boardList.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/board/boardList.jsp) : 게시글 목록 조회 페이지(공지사항 / 팀게시판 / 자유게시판)
  - [boardDetailView.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/board/boardDetailView.jsp) : 게시글 상세조회 페이지 / 댓글 조회, 추가, 삭제 스크립트
  - [boardEnrollForm.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/board/boardEnrollForm.jsp) : 게시글 등록 및 수정 페이지
  - [BoardController.java](./Opeaceful/src/main/java/com/company/opeaceful/board/controller/BoardController.java) : 게시판 관련 기능 공통 컨트롤러
  - [ReplyController.java](./Opeaceful/src/main/java/com/company/opeaceful/board/controller/ReplyController.java) : 댓글 관련 기능 공통 컨트롤러
  - [boardEnrollForm.js](./Opeaceful/src/main/webapp/resources/js/board/boardEnrollForm.js) : 텍스트 에디터 스크립트
  - [board-mapper.xml](./Opeaceful/src/main/resources/mappers/board-mapper.xml) : 게시판 관련 공통 매퍼
  - [reply-mapper.xml](./Opeaceful/src/main/resources/mappers/reply-mapper.xml) : 댓글 관련 공통 매퍼
 
---

## 윤지영
<a href="./Opeaceful/src/main/webapp/resources/etc/pdf/윤지영_opeaceful.pdf" download="Opeaceful.pdf">[PPT] 다운로드</a>  

- 공통사용
  - [member-select.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/member/member-select.jsp) : 사원 조희 모달
  - [memberSelect.js](Opeaceful/src/main/webapp/resources/js/common/memberSelect.js) : 사원 조희 모달 JS
  - [addressAPI](Opeaceful/src/main/webapp/resources/js/common/addressAPI.js) : 주소 API JS
  - [dtcodeselect.js](Opeaceful/src/main/webapp/resources/js/common/dtcodeselect.js) : 부서/직급 조회 기능 JS
  - [DeptController.java](Opeaceful/src/main/java/com/company/opeaceful/dept/controller/DeptController.java) : 부서/직급 조회 컨트롤러
  - [spring-scheduler.xml](./Opeaceful/src/main/webapp/WEB-INF/spring/spring-scheduler.xml) : 퇴사자/급여 삭제 관련 스케줄러
  - [dept-mapper.xml](Opeaceful/src/main/resources/mappers/dept-mapper.xml) : 부서 관련 공통 매퍼
  - [main.js](Opeaceful/src/main/webapp/resources/js/main.js) : 다크모드 설정

- 계정관리
  - 사원 조회
    - [member-allview.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/member/member-allview.jsp) : 사원 전체 조회 페이지
    - [memberAllview.js](Opeaceful/src/main/webapp/resources/js/member/memberAllview.js) : 사원 전체 조회/수정 기능 JS
  - 계정 생성
    - [member-create.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/member/member-create.jsp) : 사원 생성 페이지
    - [memberCreate.js](Opeaceful/src/main/webapp/resources/js/member/memberCreate.js) : 유효성 JS
  - [MemberController.java](Opeaceful/src/main/java/com/company/opeaceful/member/controller/MemberController.java) : 계정 관리 공통 컨트롤러 
  - [Scheduling.java](Opeaceful/src/main/java/com/company/opeaceful/commom/scheduling/Scheduling.java) : 퇴사자 관리 스케쥴러
  - [resignedmember-mapper.xml](Opeaceful/src/main/resources/mappers/resignedmember-mapper.xml) : 퇴사자 관련 공통 매퍼
  - [member-mapper.xml](Opeaceful/src/main/resources/mappers/member-mapper.xml) : 계정 관련 공통 매퍼

- 권한관리
  - 부서별 권한 관리
    - [granting-role.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/role/granting-role.jsp) : 부서별 권한 부여 페이지
    - [granting.js](./Opeaceful/src/main/webapp/resources/js/role/granting.js) : 부서별 권한 부여/삭제 기능 JS
  - 사원별 권한 관리
    - [user-role.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/role/user-role.jsp) : 사원별 권한 부여 페이지
    - [user-role.js](./Opeaceful/src/main/webapp/resources/js/role/user-role.js) : 사원별 권한 부여/삭제 기능 JS
  - [RoleController.java](Opeaceful/src/main/java/com/company/opeaceful/role/controller/RoleController.java) : 권한관리 공통 컨트롤러
  - [role-mapper.xml](Opeaceful/src/main/resources/mappers/role-mapper.xml) : 권한 관련 공통 매퍼

- 급여관리
  - 사원별 급여조회 
    - [employeeSalary.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/salary/employeeSalary.jsp) : 사원별 급여 조회 페이지
    - [employeeSalary.js](./Opeaceful/src/main/webapp/resources/js/salary/employeeSalary.js) : 사원별 급여 조회용 JS
  - 사원 급여 관리
    - [employeeAllSalary.jsp](./Opeaceful/src/main/webapp/WEB-INF/views/salary/employeeAllSalary.jsp) : 사원 급여 관리 페이지
    - [salaryAll.js](./Opeaceful/src/main/webapp/resources/js/salary/salaryAll.js) : 사원 급여 수정/삭제/생성 기능 JS 
  - [dateBox.js](./Opeaceful/src/main/webapp/resources/js/salary/dateBox.js) : salary date 세팅용 JS
  - [SalaryController.java](Opeaceful/src/main/java/com/company/opeaceful/salary/controller/SalaryController.java) : 급여관리 공통 컨트롤러
  - [salary-mapper.xml](Opeaceful/src/main/resources/mappers/salary-mapper.xml) : 급여 관련 공통 매퍼

---

> ## 사용 기술 스택

### 협업 툴

- 미리캔버스
- 구글 시트

### 사용 언어

- FE (Front-End)

  - <img src="https://img.shields.io/badge/JSP-F46D01?style=flat&logo=JSP&logoColor=white"/>
  - <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white"/>
  - <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=CSS3&logoColor=white"/>
  - <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=JavaScript&logoColor=white"/>
  - <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat&logo=jQuery&logoColor=white"/>

- BE (Back-End)

  - Language: <img src="https://img.shields.io/badge/JAVA-007396?style=flat&logo=JAVA&logoColor=white"/> <img src="https://img.shields.io/badge/Ajax-2AA5DC?style=flat&logo=Ajax&logoColor=white"/>
  - WAS(Web-Application-Server): <img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=flat&logo=ApacheTomcat&logoColor=white"/> 9.0
  - Database
    - <img src="https://img.shields.io/badge/MySQL-232F3E?style=flat&logo=MySQL&logoColor=white"/>
    - MySQL Workbench 8.0 CE
    - <img src="https://img.shields.io/badge/Amazon RDS-527FFF?style=flat&logo=AmazonRDS&logoColor=white"/>
  - Developer tool
    - Java: <img src="https://img.shields.io/badge/STS-6DB33F?style=flat&logo=STS&logoColor=white"/>
    - Server: <img src="https://img.shields.io/badge/Amazon AWS-232F3E?style=flat&logo=AmazonAWS&logoColor=white"/>
  - Framework

    - <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=Spring&logoColor=white"/>

    - <img src="https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=Bootstrap&logoColor=white"/>

- 사용 디자인 패턴: **MVC 패턴**

### 사용한 오픈 API

- OpenWeather API
- geolocation API
- fulcalendar API

---

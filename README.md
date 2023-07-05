a# Opeaceful

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
<summary> 채팅 </summary>
<div markdown="1">

![채팅](./Opeaceful/src/main/webapp/resources/etc/video/darkmode.gif)

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

---

## 박가영

---

## 한승은

[[PPT] 링크](https://www.miricanvas.com/v/127mvz2) &nbsp; / &nbsp; [[PPT] 다운로드](./Opeaceful/src/main/webapp/resources/etc/pdf/한승은.pdf)

- SQL
  - [Opeaceful_TABLE.sql](./Opeaceful/SQL/Opeaceful_TABLE.sql) : MYSQL 테이블 기본 세팅용 sql파일  

- 전자결재 공통 양식 메뉴
  - [ApprovalFormController.java](./Opeaceful/Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalFormController.java) : 전자결재 양식용 컨트롤러
  - [approvalForm.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/approvalForm.jsp) : 전자결재 양식 페이지
  - [approvalFormData.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/approvalFormData.js) : 전자결재 양식 페이지용 Ajax를 모아둔 js 파일
  - [approvalFormFront.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/approvalFormFront.js) : 전자결재 양식 페이지용 페이지의 기본동작 이벤트를 부여한 js 파일

- 전자결재 관리 메뉴
  - [ApprovalController.java](./Opeaceful/Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalController.java) : MY전자결재, 전자결재 관리 메뉴 공통 컨트롤러
  - [allApproval.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/allApproval.jsp) : 전자결재 관리 페이지
  - [allApprovalData.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/allApprovalData.js) : 전자결재 관리 페이지용 Ajax를 모아둔 js파일
  - [allApprovalFront.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/allApprovalFront.js) : 전자결재 관리 페이지용 기본동작 이벤트를 부여한 js 파일

- MY전자결재 메뉴
  - [ApprovalController.java](./Opeaceful/Opeaceful/src/main/java/com/company/opeaceful/approval/controller/ApprovalController.java) : MY전자결재, 전자결재 관리 메뉴 공통 컨트롤러
  - [myApproval.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/myApproval.jsp) : MY전자결재 페이지
  - [myApprovalData.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/myApprovalData.js) : MY전자결재 페이지용 Ajax를 모아둔 js파일
  - [myApprovalFront.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/myApprovalFront.js) : MY전자결재 페이지용 기본동작 이벤트를 부여한 js 파일

- 전자결재 공통 파일들
  - 메모
    - [memoModal.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/memoModal.jsp) : 전자결재 메모 모달 화면
    - [memo.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/memo.js) : 전자결재 메모 기본동작용 js 파일

  - 전자결재 작성/수정 모달
    - [approvalModal.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/approvalModal.jsp) : 전자결재 작성/수정용 모달 화면
    - [approvalModal.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/approvalModal.js) : 전자결재 작성/수정용 모달 기본 동작용 js 파일

  - 전자결재 조회 모달
    - [endApprovalModal.jsp](./Opeaceful/Opeaceful/src/main/webapp/WEB-INF/views/approval/endApprovalModal.jsp) : 전자결재 문서 조회용 모달 화면

  - 텍스트에디터
    - [tinyEditor.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/tinyEditor.js) : Tinymce 에디터 사용및 세팅을 위한 js 파일

  - 전자결재 알림
    - [AprWebsocketHandler.java](./Opeaceful/Opeaceful/src/main/java/com/company/opeaceful/approval/model/websocket/AprWebsocketHandler.java) : 전자결재 알림을 위한 웹소켓 핸들러
    - [aprWebsocket.js](./Opeaceful/Opeaceful/src/main/webapp/resources/js/approval/aprWebsocket.js) : 전자결재 알림용 웹소켓 js 파일


---

## 김혜린

---

## 윤지영

어떻게 설정될지 몰라서 비워뒀어요
나중에 채워두겠습니다!

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

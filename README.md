# Opeaceful

> ## 팀원

- [한승은(조장)](#한승은---ppt-p-참조)
- [김진기](#김진기---ppt-p-참조)
- [김혜린](#김혜린---ppt-p-참조)
- [노지의](#노지의---ppt-p-참조)
- [박가영](#박가영---ppt-p-참조)
- [윤지영](#윤지영---ppt-p-참조)

---

> ## 프로젝트 소개

### 사내 그룹웨어 프로그램

실시간 협업, 보안과 접근제어, 업무 문서 및 파일공유
사원 친화적인 그룹웨어를 기획

반응형 웹페이지와 AWS를 통한 배포까지를 목표로 함.

- <a href="./Opeaceful/src/main/webapp/resources/etc/Opeaceful_PPT.pdf" download="Opeaceful.pdf">[PPT] 다운로드</a>

- 로그인

- 메인

- 내정보

- 연차관리

- 조직도

- 게시판

- 캘린더

- 근태관리

- 계정관리
  [![권한관리](./Opeaceful/src/main/webapp/resources/etc/video/member.gif)](#프로젝트-소개)

- 권한관리
  [![권한관리](./Opeaceful/src/main/webapp/resources/etc/video/role.gif)](#프로젝트-소개)

- 급여관리
  [![급여관리](./Opeaceful/src/main/webapp/resources/etc/video/salary.gif)](#프로젝트-소개)

- 전자결제

- 채팅

- 다크모드
  [![다크모드](./Opeaceful/src/main/webapp/resources/etc/video/darkmode.gif)](#프로젝트-소개)

<br>

---

<!-- > ## 주요 기능 -->

<blockquote>
<h2>주요기능</h2>
<p><small>※메뉴 클릭시 상세 내용 확인가능</small></p>
</blockquote>

<details>
   <summary>메인</summary>
    <ul>
     <li>프로필 조회</li>
     <li>테마 변경</li>
     <li>현재 시간 및 출 퇴근 기록</li>
     <li>접속상태</li>
     <li>현재 날씨</li>
    </ul>
    <div markdown="1">
        [![급여관리](./Opeaceful/src/main/webapp/resources/etc/video/salary.gif)](#프로젝트-소개)
    </div>
</details>

- 사원
  - 로그인 / 로그아웃
  - 사원 정보 변경
- 조직도
  - 조직도 조회
  - 부서 생성 및 수정
  - 직급 생성 및 수정
- 계정관리
  - 사원 조회
  - 계정 생성 및 수정
  - 퇴사자 관리
    [![권한관리](./Opeaceful/src/main/webapp/resources/etc/video/member.gif)](#프로젝트-소개)
- 권한관리
  - 부서별 권한 관리
  - 사원별 권한 관리
- 급여관리
  - 급여 명세서 생성 및 수정
  - 사원 급여 관리
- 연차관리
  - 연차 조회
  - 연차 등록 및 수정
- 근태관리
  - 출 퇴근 기록 조회
- 전자결재
  - 임시저장 / 기안 / 반려 / 참조 / 결재
  - 결재 공통 양식 생성 및 수정
  - 전체 결재 문서 조회 및 삭제
  - 결재라인 즐겨찾기 기능
  - 결재 문서 상태 실시간 알림
- 게시판(공지사항 / 자유 게시판 / 팀 게시판)
  - 게시글 등록(익명) 및 수정
  - 댓글 등록(익명) 및 삭제
  - 파일첨부
- 캘린더(개인 / 팀 / 전체)
  - 일정 조회
  - 일정 등록 및 수정
  - 디데이 / 메모
- 메신저
  - 1:1 채팅
  - 그룹 채팅
  - 프로필 조회
  - 즐겨찾기
  - 접속상태
  - 최신 공지사항 조회

---

> ## 담당 기능

## 공통

예시로 일단 아래 넣어둠 변경해야됨

- [common.js](./Opeaceful/src/main/webapp/resources/js/common.js)
  - 위 파일 상 setip의 ip주소를 본인 환경에 맞게 변경하여 사용
- [common java(하위 파일 전체)](./SEMI_MZ/src/mz/common) : 공용 java 파일들

- SQL

---

## 노지의 - [PPT] 7p 참조

---

## 김진기 - [PPT] 27p 참조

---

## 박가영 - [PPT] 45p 참조

---

## 한승은 - [PPT] 51p 참조

---

## 김혜린 - [PPT] 66p 참조

---

## 윤지영 - [PPT] 84p 참조

어떻게 설정될지 몰라서 비워뒀어요
나중에 채워두겠습니다!

---

> ## 사용 기술 스택

### 협업 툴

- 미리캔버스
- 구글 시트

### 사용 언어

- FE(Front End)

  - JSP
  - CSS
  - Javascript
  - jQuery
    <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white"/>
    <img src="https://img.shields.io/badge/CSS5-1572B6?style=flat&logo=CSS5&logoColor=white"/>
    <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat&logo=javascript&logoColor=white"/>
    <img src="https://img.shields.io/badge/jquery-0769AD?style=flat&logo=jquery&logoColor=white"/>

- BE(Back-End)

  - Language: Java, Ajax
  - WAS(Web-Application-Server): Apache Tomcat 9.0
  - Database
    - RDBMS: MySQL Workbench 8.0 CE
  - Developer tool
    - Java: STS
    - Server: aws
    - MySQL:SQL-Developer ...???????????????????????????????
  - Framework
    - Spring
    - BootStrap
      <img src="https://img.shields.io/badge/mysql-4479A1?style=flat&logo=mysql&logoColor=white"/>
      <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=Spring&logoColor=white"/>

- 사용 디자인 패턴: **MVC 패턴**

### 사용한 오픈 API

- OpenWeather API
- geolocation API
- fulcalendar API
- kakaoMaps API ??? ??????????????????????????

---

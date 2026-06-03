# 🌏 GONGGAN — K-Culture 종합 문화 플랫폼

<p align="center">
  <img src="https://github.com/user-attachments/assets/178a0286-bbfc-417a-a788-245fe69e6e65" width="80%" alt="GONGGAN 메인 화면"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-007396?style=flat-square&logo=openjdk&logoColor=white"/>
  <img src="https://img.shields.io/badge/Servlet%2FJSP-MVC-FF6C37?style=flat-square&logo=apache&logoColor=white"/>
  <img src="https://img.shields.io/badge/MySQL-8.x-4479A1?style=flat-square&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Tomcat-10.1-F8DC75?style=flat-square&logo=apache-tomcat&logoColor=black"/>
  <img src="https://img.shields.io/badge/Bootstrap-5-7952B3?style=flat-square&logo=bootstrap&logoColor=white"/>
  <img src="https://img.shields.io/badge/jQuery-3.6-0769AD?style=flat-square&logo=jquery&logoColor=white"/>
  <img src="https://img.shields.io/badge/Naver_Maps_API-03C75A?style=flat-square&logo=naver&logoColor=white"/>
</p>

---

## 목차

1. [프로젝트 소개](#1-프로젝트-소개)
2. [주요 기능 & 화면](#2-주요-기능--화면)
3. [기술 스택](#3-기술-스택)
4. [시스템 아키텍처](#4-시스템-아키텍처)
5. [프로젝트 구조](#5-프로젝트-구조)
6. [ERD](#6-erd)
7. [실행 방법](#7-실행-방법)

---

## 1. 프로젝트 소개

**GONGGAN(공간)** 은 외국인 및 국내 사용자를 위해 한국 문화(K-Food, K-Beauty, Location)를 소개하는 종합 정보 웹 서비스입니다.

사용자는 한식 커뮤니티 게시판에 글을 작성하고, 화장품 정보를 조회하며, 네이버 지도와 연동된 관광지 정보를 확인할 수 있습니다.  
관리자 페이지를 통해 콘텐츠 전반을 관리하고 예약 현황을 통계로 확인할 수 있습니다.

| 항목 | 내용 |
|---|---|
| 개발 기간 | 2025.05.04 – 2025.05.21 (약 3주) |
| 참여 인원 | 팀 프로젝트 |
| 주요 대상 | K-Culture에 관심 있는 국내외 사용자 |
| 배포 환경 | 로컬 (Apache Tomcat 10.1, MySQL 8.x) |

---

## 2. 주요 기능 & 화면

### 메인 페이지

슬라이드 배너(DB 기반 동적 구성)와 K-Food / K-Beauty / Location 카테고리 진입점을 제공합니다.

<p align="center">
  <img src="https://github.com/user-attachments/assets/178a0286-bbfc-417a-a788-245fe69e6e65" width="80%" alt="메인 페이지"/>
</p>

---

### K-Food — 한식 게시판

- 게시글 작성 / 수정 / 삭제 (이미지 파일 첨부 지원)
- 제목·내용 키워드 검색 및 페이징 처리
- 게시글 좋아요, 댓글 기능

<p align="center">
  <img src="https://github.com/user-attachments/assets/c906f44e-f47d-4e3d-be93-b079bafda943" width="70%" alt="게시판 목록"/>
  <img src="https://github.com/user-attachments/assets/4627a5b8-72f0-4e91-a7fc-f73cbc4edf07" width="70%" alt="게시글 상세"/>
</p>

---

### K-Beauty — 화장품

- 카테고리별 목록 조회 (스킨케어, 메이크업, 헤어케어 등)
- 화장품 상세 정보 및 좋아요 기능
- 관련 게시판 연동 표시

<p align="center">
  <img src="https://github.com/user-attachments/assets/1dc3f617-309b-472a-98de-0f0e50d775f4" width="80%" alt="K-Beauty 페이지"/>
</p>

---

### Location — 관광지

- 도시 / 구역별 관광지 정보 조회
- 네이버 지도 API 연동 지도 표시
- 체험 활동 목록 및 상세 정보

<p align="center">
  <img src="https://github.com/user-attachments/assets/f4386ae3-33b1-4093-bcad-cc542531afb4" width="80%" alt="Location 페이지"/>
</p>

---

### 예약 시스템

- 체험 활동 예약 (인원 수 초과 방지 처리)
- 마이페이지에서 예약 내역 확인 및 취소

---

### 회원 기능

- 회원가입 / 로그인 / 로그아웃
- 아이디·비밀번호 찾기
- 마이페이지 (내 게시글, 내 예약 내역, 회원정보 수정)

<p align="center">
  <img src="https://github.com/user-attachments/assets/522fe460-3d9c-4d2c-b102-2a7333716e24" width="60%" alt="회원가입 페이지"/>
</p>

---

### 관리자 페이지

- 회원 목록 조회 및 탈퇴 처리
- 화장품 정보 CRUD (이미지 업로드 포함)
- 게시글 숨김 처리
- 여행지 정보 등록 / 수정 / 삭제
- 체험 활동 관리
- 예약 현황 통계 차트

---

## 3. 기술 스택

### Backend

| 기술 | 버전 | 용도 |
|---|---|---|
| Java | 17 | 메인 언어 |
| Servlet / JSP | — | MVC 패턴 웹 프레임워크 |
| MySQL | 8.x | 관계형 데이터베이스 |
| Apache Tomcat | 10.1 | WAS |
| mysql-connector-j | 9.3.0 | MySQL JDBC 연결 |
| jstl | 1.2 | JSP 태그 라이브러리 |
| json-simple | 1.1.1 | JSON 데이터 처리 |
| cos2.jar | — | 파일 업로드 |

### Frontend

| 기술 | 버전 | 용도 |
|---|---|---|
| JSP / HTML5 / CSS3 | — | 뷰 템플릿 및 스타일 |
| Bootstrap | 5 | UI 컴포넌트 |
| JavaScript / jQuery | 3.6 | 동적 UI 처리 |
| Naver Maps API | — | 관광지 지도 표시 |

---

## 4. 시스템 아키텍처

```
[Browser]
    │  HTTP Request (*.do)
    ▼
[Apache Tomcat 10.1]
    │
    ├─ [Controller (Servlet)]
    │       ├─ BoardController
    │       ├─ CosmeticsController
    │       ├─ FileDownloadServlet
    │       └─ ...
    │
    ├─ [Model (DAO / DTO)]
    │       ├─ BoardDAO / BoardDTO
    │       ├─ CosmeticsDAO / CosmeticsDTO
    │       ├─ CommentDAO / CommentDTO
    │       ├─ activityDAO
    │       └─ UserDAO / UserDTO
    │
    ├─ [View (JSP)]
    │
    └─ [MySQL 8.x — fs_semi DB]
```

**요청 처리 흐름**

```
사용자 요청 (*.do URL)
    │
    ▼
Servlet Controller
    │
    ├─ DAO → DB 조회 / 변경
    │
    ├─ request.setAttribute() 로 데이터 전달
    │
    ▼
JSP View 렌더링 → 클라이언트 응답
```

---

## 5. 프로젝트 구조

```
SEMI/
├── setup_db.sql                               # DB 초기화 스크립트
└── src/main/
    ├── java/
    │   ├── dao/
    │   │   └── CosmeticsRepository.java
    │   ├── dto/
    │   │   └── Cosmetics.java
    │   └── mvc/
    │       ├── controller/
    │       │   ├── BoardController.java
    │       │   ├── CosmeticsController.java
    │       │   └── FileDownloadServlet.java
    │       ├── database/
    │       │   └── DBConnection.java
    │       ├── model/
    │       │   ├── BoardDAO.java / BoardDTO.java
    │       │   ├── CommentDAO.java / CommentDTO.java
    │       │   ├── CosmeticsDAO.java / CosmeticsDTO.java
    │       │   ├── activityDAO.java
    │       │   └── UserDAO.java / UserDTO.java
    │       └── util/
    │           └── FileUtil.java
    └── webapp/
        ├── resources/
        │   ├── css/
        │   ├── js/
        │   └── img/
        ├── boardF/                            # 게시판 JSP (list, view, write)
        ├── WEB-INF/
        │   ├── web.xml
        │   └── lib/                           # 외부 라이브러리 (.jar)
        ├── index.jsp
        ├── header.jsp / footer.jsp
        ├── login.jsp / signin.jsp
        ├── mypage.jsp
        ├── food.jsp / foodActivity.jsp
        ├── beauty.jsp / cosmetics_detail.jsp
        ├── location.jsp / location_detail.jsp
        ├── map.jsp / mapB.jsp
        ├── reservation.jsp
        └── adminPage.jsp
```

---

## 6. ERD

```
users
  id (PK) · password · name · gender · birth · email · phone · address
  │
  ├── board_likes   (board_num ↔ boardf.num,   user_id ↔ users.id)
  ├── cosmetic_likes(cosmetic_id ↔ cosmetics.id, user_id ↔ users.id)
  └── reservation   (rsv_num PK, id ↔ users.id, act_id ↔ activity.ACT_ID)

boardf                       cosmetics                    activity
  num (PK)                     id (PK)                    ACT_ID (PK)
  id (FK → users)              name                       TITLE
  subject                      brand                      PRICE
  content                      category                   MAX_COUNT
  category                     likes                      ACT_DATE
  liking
  file_name
  │
  └── comments
        num (PK)
        board_num (FK → boardf)
        id (FK → users)
        content

city
  city_num (PK) · title · img
  │
  └── city_district
        id (PK)
        d_city_num (FK → city)
        d_title
```

---

## 7. 실행 방법

### 사전 요구사항

| 항목 | 버전 |
|---|---|
| Java (JDK) | 17 이상 |
| Apache Tomcat | 10.1 |
| MySQL | 8.x 이상 |
| IDE | Eclipse (Enterprise Java) 또는 IntelliJ IDEA |

---

### 1단계 — 저장소 클론

```bash
git clone https://github.com/go-nu/GONGGAN.git
cd GONGGAN
```

---

### 2단계 — 데이터베이스 초기화

MySQL에 접속 후 아래 명령을 실행합니다.

```sql
source setup_db.sql;
```

또는 MySQL Workbench에서 `setup_db.sql` 파일을 직접 실행합니다.  
기본 관리자 계정이 자동으로 생성됩니다.

---

### 3단계 — DB 연결 설정

`src/main/java/mvc/database/DBConnection.java` 에서 접속 정보를 수정합니다.

```java
private static final String URL      = "jdbc:mysql://localhost:3306/fs_semi?useSSL=false&serverTimezone=Asia/Seoul";
private static final String USER     = "root";        // 본인 DB 계정
private static final String PASSWORD = "비밀번호";     // 본인 DB 비밀번호
```

---

### 4단계 — 프로젝트 빌드 및 서버 실행

1. Eclipse에서 프로젝트를 import합니다 (`File > Import > Existing Projects`)
2. Tomcat 10.1 서버를 등록합니다
3. 프로젝트를 서버에 추가한 뒤 서버를 시작합니다

---

### 5단계 — 접속

```
http://localhost:8080/SEMI/index.jsp
```

---

## 라이선스

이 프로젝트는 포트폴리오 목적으로 개발되었습니다.

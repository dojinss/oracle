-- Active: 1725502741976@@127.0.0.1@1521@orcl@ALOHA

-- 52. 학생관리 테이블 생성코드
CREATE TABLE MS_STUDENT 
(
  ST_NO NUMBER NOT NULL 
, NAME VARCHAR2(20 BYTE) NOT NULL 
, CTZ_NO CHAR(14 BYTE) NOT NULL 
, EMAIL VARCHAR2(100 BYTE) NOT NULL 
, ADDRESS VARCHAR2(1000 BYTE) 
, DEPT_NO NUMBER(*, 0) NOT NULL 
, MJ_NO NUMBER(*, 0) NOT NULL 
, REG_DATE DATE DEFAULT SYSDATE NOT NULL 
, UPD_DATE DATE DEFAULT SYSDATE NOT NULL 
, ETC VARCHAR2(1000 BYTE) DEFAULT '없음' 
, CONSTRAINT MS_STUDENT_PK PRIMARY KEY 
  (
    ST_NO 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX MS_STUDENT_PK ON MS_STUDENT (ST_NO ASC) 
      LOGGING 
      TABLESPACE USERS 
      PCTFREE 10 
      INITRANS 2 
      STORAGE 
      ( 
        BUFFER_POOL DEFAULT 
      ) 
      NOPARALLEL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NO INMEMORY 
NOPARALLEL;

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_UK UNIQUE 
(
  EMAIL 
)
USING INDEX 
(
    CREATE UNIQUE INDEX MS_STUDENT_UK ON MS_STUDENT (EMAIL ASC) 
    LOGGING 
    TABLESPACE USERS 
    PCTFREE 10 
    INITRANS 2 
    STORAGE 
    ( 
      BUFFER_POOL DEFAULT 
    ) 
    NOPARALLEL 
)
 ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민등록번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '학부번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';


INSERT INTO "ALOHA"."MS_STUDENT" (ST_NO, NAME, CTZ_NO, EMAIL, ADDRESS, DEPT_NO, MJ_NO, REG_DATE, UPD_DATE) VALUES ('1', '김조은', '030101-1234567', 'joeun@naver.com', '인천시 부평구 동수천로 1004호', '10', '20', TO_DATE('2024-09-05 11:12:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-09-05 11:12:48', 'YYYY-MM-DD HH24:MI:SS'));
DELETE FROM "ALOHA"."MS_STUDENT" WHERE ROWID = 'AAAR2kAAHAAAAIlAAA' AND ORA_ROWSCN = '2140739' and ( "ST_NO" is null or "ST_NO" is not null )


-- 52.
-- MS_STUDENT 테이블을 생성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명2   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명3   타입   [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        ...
    );
*/
-- ALOHA 계정 접속
CREATE Table MS_STUDENT (
      ST_NO       NUMBER            NOT NULL PRIMARY KEY,
      NAME        VARCHAR2(20)      NOT NULL,
      CTZ_NO      CHAR(24)          NOT NULL,
      EMAIL       VARCHAR2(100)     NOT NULL UNIQUE,
      ADDRESS     VARCHAR2(1000)    NULL,
      DEPT_NO     NUMBER            NOT NULL,
      MJ_NO       NUMBER            NOT NULL,
      REG_DATE    DATE              DEFAULT SYSDATE   NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE   NOT NULL,
      ETC         VARCHAR2(1000)    DEFAULT '없음'    NULL
      -- 기본키 제약조건 별도로 지정
      -- ,CONSTRAINT MS_STUDENT_PK  PRIMARY KEY(ST_NO) ENABLE
);

-- UQ(고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK UNIQUE ( EMAIL ) ENABLE;

-- 테이블 삭제
DROP TABLE MS_STUDENT;

-- 53.
-- MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.

-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];

-- 성별 속성 추가
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별'

-- 재적 속성 추가
ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

-- 입학일자 속성 추가
ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

-- 졸업일자 속성 추가
ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 54.
-- MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE 로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.

-- CTZ_NO → BIRTH 이름 변경
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
-- DATE 타입으로 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 설명을 '생년월일'로 변경
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 55.
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56.
-- MS_STUDENT 테이블을 삭제하시오.
DROP TABLE MS_STUDENT;

-- 57.
-- 테이블 정의서 대로 학생테이블(MS_STUDENT) 를 생성하시오.
CREATE Table MS_STUDENT (
      ST_NO       NUMBER            NOT NULL PRIMARY KEY,
      NAME        VARCHAR2(20)      NOT NULL,
      BIRTH       DATE              NOT NULL,
      EMAIL       VARCHAR2(100)     NOT NULL UNIQUE,
      ADDRESS     VARCHAR2(1000)    NULL,
      MJ_NO       CHAR(4)           NOT NULL,
      GENDER      CHAR(6)           DEFAULT '기타'    NOT NULL,
      STATUS      VARCHAR2(10)      DEFAULT '대기'    NOT NULL,
      ADM_DATE    DATE              NULL,
      GRD_DATE    DATE              NULL,
      REG_DATE    DATE              DEFAULT SYSDATE   NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE   NOT NULL,
      ETC         VARCHAR2(1000)    DEFAULT '없음'    NULL
      -- 기본키 제약조건 별도로 지정
      -- ,CONSTRAINT MS_STUDENT_PK  PRIMARY KEY(ST_NO) ENABLE
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58.
-- 데이터 삽입 (INSERT)
INSERT INTO MS_STUDENT (ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER,
                        STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC)
VALUES ( '20240001', '최서아', '2005/10/05', 'csa@univ.ac.kr', '서울', 'I01', '여',
         '재학', '2024/03/01', NULL, SYSDATE, SYSDATE, NULL);
-- 문자타입이 DATE타입 으로 내부적으로 변환되서 데이터 추가
-- DB툴을 이용하여 INSERT 한다면, COMMIT 을 실행하여 LOCK 걸리지 않고 적용됨.
COMMIT;
SELECT * FROM MS_STUDENT;

-- 59.
-- MS_STUDENT 테이블의 데이터를 수정
-- UPDATE
/*
    UPDATE 테이블명
       SET 컬럼1 = 변경할 값,
           컬럼2 = 변경할 값,
           ...
   [WHERE] 조건;
*/
-- 1) 학생번호가 20160001 인 학생의 주소를 '서울'로,
--    재적상태를 '휴학'으로 수정하시오.
UPDATE MS_STUDENT
   SET ADDRESS = '서울'
      ,STATUS = '휴학'
WHERE ST_NO = '20160001';

-- 2) 학생번호가 20150010 인 학생의 주소를 '서울'로,
--    재적 상태를 '졸업', 졸업일자를 '20200220', 수정일자 현재날짜로 
--    그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
   SET ADDRESS = '서울'
      ,STATUS = '졸업'
      ,GRD_DATE = '20200220'
      ,UPD_DATE = SYSDATE
      ,ETC = '수석'
WHERE ST_NO = '20150010';

-- 3) 학생번호가 20130007 인 학생의 재적 상태를 '졸업', 졸업일자를 '20200220', 
--    수정일자 현재날짜로 수정하시오.
UPDATE MS_STUDENT
   SET STATUS = '졸업'
      ,GRD_DATE = '20200220'
      ,UPD_DATE = SYSDATE
WHERE ST_NO = '20130007';

-- 4) 학생번호가 20110002 인 학생의 재적 상태를 '퇴학', 
--    수정일자를 현재날짜, 특이사항 '자진 퇴학' 으로 수정하시오.
UPDATE MS_STUDENT
   SET STATUS = '퇴학'
      ,UPD_DATE = SYSDATE
      ,ETC = '자진퇴학'
WHERE NAME = '한성호';

-- 60.
-- MS_STUDENT 테이블에서 학번이 20110002 인 학생을 삭제하시오.
DELETE FROM MS_STUDENT
WHERE ST_NO = '20110002';

-- 61.
-- MS_STUDENT 테이블의 모든 속성을 조회하시오.
SELECT * FROM MS_STUDENT;

-- 62.
-- MS_STUDENT 테이블을 조회하여 MS_STUDENT_BACK 테이블 생성하시오.
-- 백업 테이블 만들기
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT_BACK;

-- 63.
-- MS_STUDENT 테이블의 튜플을 삭제하시오.

-- 데이터 전체 삭제
DELETE FROM MS_STUDENT;

-- 데이터 및 내부 구조 삭제
TRUNCATE TABLE MS_STUDENT;

-- 테이블 구조 삭제
DROP TABLE MS_STUDENT;
DROP TABLE MS_STUDENT_BACK;

SELECT * FROM MS_STUDENT_BACK;

-- 64.
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여
-- MS_STUDENT 테이블에 삽입하시오.
INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

SELECT * FROM MS_STUDENT;

-- 65.
-- MS_STUDENT 테이블의 성별(gender) 속성에 대하여,
-- ('여', '남', '기타') 값만 입력가능하도록 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_GENDER_CHECK
CHECK ( GENDER IN ('여','남','기타') );

UPDATE MS_STUDENT
   SET GENDER = '남'
WHERE NAME = '윤도현';
-- * 도메인 무결성 보장
-- * 조건으로 지정한 값이 아닌 다른 값을 입력/수정하는 경우

-- 66.
-- 아래 <예시>의 TABLE 기술서를 참고하여 MS_USER 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_USER (
      USER_NO     NUMBER            NOT NULL    PRIMARY KEY,
      USER_ID     VARCHAR2(100)     NOT NULL    UNIQUE,
      USER_PW     VARCHAR2(200)     NOT NULL,
      USER_NAME   VARCHAR2(50)      NOT NULL,
      BIRTH       DATE              NOT NULL,
      TEL         VARCHAR2(20)      NOT NULL    UNIQUE,
      ADDRESS     VARCHAR2(200)     NULL,
      REG_DATE    DATE              DEFAULT SYSDATE NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE NOT NULL    
);
COMMENT ON TABLE MS_USER IS '커뮤니티 회원의 정보를 관리한다.';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원정보';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '수정일자';

SELECT * FROM MS_USER;

-- 67.
-- 아래 <예시>의 TABLE 기술서를 참고하여 MS_BOARD 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_BOARD (
      BOARD_NO    NUMBER            NOT NULL    PRIMARY KEY,
      TITLE       VARCHAR2(200)     NOT NULL,
      CONTENT     CLOB              NOT NULL,
      WRITER      VARCHAR2(100)     NOT NULL,
      HIT         NUMBER            NOT NULL,
      LIKE_CNT    NUMBER            NOT NULL,
      DEL_YN      CHAR(2)           NULL,
      DEL_DATE    DATE              NULL,
      REG_DATE    DATE              DEFAULT SYSDATE   NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE   NOT NULL
);
COMMENT ON TABLE MS_BOARD IS '커뮤니티 게시판 정보를 관리한다.';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';

SELECT * FROM MS_BOARD;

-- 68.
-- 아래 <예시>의 TABLE 기술서를 참고하여 MS_FILE 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_FILE (
      FILE_NO     NUMBER            NOT NULL    PRIMARY KEY,
      BOARD_NO    NUMBER            NOT NULL,
      FILE_NAME   VARCHAR2(2000)    NOT NULL,
      FILE_DATA   BLOB              NOT NULL,
      REG_DATE    DATE              DEFAULT SYSDATE NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE NOT NULL
);
COMMENT ON TABLE MS_FILE IS '커뮤니티 게시판 첨부파일의 정보를 관리한다.';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

SELECT * FROM MS_FILE;

-- 69.
-- 아래 <예시>의 TABLE 기술서를 참고하여 MS_REPLY 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_REPLY (
      REPLY_NO    NUMBER            NOT NULL    PRIMARY KEY,
      BOARD_NO    NUMBER            NOT NULL,
      CONTENT     VARCHAR2(2000)    NOT NULL,
      WRITER      VARCHAR2(100)     NOT NULL,
      DEL_YN      CHAR(2)           NOT NULL,
      DEL_DATE    DATE              NULL,
      REG_DATE    DATE              DEFAULT SYSDATE     NOT NULL,
      UPD_DATE    DATE              DEFAULT SYSDATE     NOT NULL
);
COMMENT ON TABLE MS_REPLY IS '커뮤니티 게시판의 댓글 정보를 관리한다.';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';

SELECT * FROM MS_REPLY;
-- 72.
-- MS_BOARD 의 WRITER 속성을 NUMBER 타입으로 변경하고
-- MS_USER 의 USER_NO 를 참조하는 외래키로 지정하시오.

-- 1)
-- 데이터 타입 변경
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

-- 왜리키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키 컬럼) REFERENCES 참조테이블(기본키);

-- MS_BOARD(WRITER) ----> MS_USER(USER_NO)
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);

-- 2) 외래키 지정 : MS_FILE ( BOARD_NO ) ----> MS_BOARD( BOARD_NO )
-- MS_FILE 테이블의 BOARD_NO 를 외래키로 지정하여, MS_BOARD 테이블의
-- BOARD_NO 를 참조하도록 지정
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 3) 외래키 지정 : MS_REPLY ( BOARD_NO ) ----> MS_BOARD( BOARD_NO )
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 제약조건 삭제
-- ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
ALTER TABLE MS_FILE DROP CONSTRAINT MS_FILE_BOARD_NO_FK;
ALTER TABLE MS_REPLY DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;

-- 73.
-- MS_USER 테이블에 속성을 추가하시오.
DELETE FROM MS_USER;
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

-- 74.
-- MS_USER 의 GENDER 속성이 ('여', '남', '기타') 값만 갖도록
-- 제약조건을 추가하시오.
-- CHECK 제약조건 추가
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK ( GENDER IN ('여','남','기타'));

-- 75.
-- MS_FILE 테이블에 확장자(EXT) 속성을 추가하시오.
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- 76.
-- 테이블 MS_FILE 의 FILE_NAME 속성에서 확장자를 추출하여 
-- EXT 속성에 UPDATE 하는 SQL 문을 작성하시오.
MERGE INTO MS_FILE T    -- 대상 테이블 지정
-- 사용할 테이블 지정
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F
-- 매치 조건
ON (T.FILE_NO = F.FILE_NO)
-- 매치 시 처리
WHEN MATCHED THEN
    -- 이미지 ㅍ파일 확장자를 추출하여 수정
    UPDATE SET T.EXT = SUBSTR( F.FILE_NAME, INSTR(F.FILE_NAME, '.',-1) + 1)
    -- 이미지 확장자(jpeg,jpg,gif,png,webbp)가 아니면 삭제
    DELETE WHERE LOWER( SUBSTR( F.FILE_NAME, INSTR(F.FILE_NAME, '.',-1) +1 ))
                NOT IN ('jpeg', 'jpg', 'gif', 'png', 'webp')
    -- WHEN NOT MATCHED THEN
;

SELECT * FROM MS_FILE;




-- 파일 추가
INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (4, 1, '고양이.png', '123', sysdate, sysdate, 'png' );


INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (3, 1, 'main.html', '123', sysdate, sysdate, 'html' );

-- 게시글 추가
INSERT INTO MS_BOARD (
                BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
                DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
                )
VALUES (
        1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );


-- 유저 추가
INSERT INTO MS_USER(
                USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
                TEL, ADDRESS, REG_DATE, UPD_DATE,
                CTZ_NO, GENDER
                )
VALUES ( 1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
         '010-1234-1234', '부평', sysdate, sysdate,
         '030101-3334444', '기타');

-- 77.
-- 테이블 MS_FILE 의 EXT 속성이
-- ('jpg', 'jpeg', 'gif', 'png', 'webp') 값을 갖도록 하는 제약조건을 추가하시오.
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK ( EXT IN ('jpg', 'jpeg', 'gif', 'png', 'webp') );

ALTER TABLE MS_FILE
DROP CONSTRAINT MS_FILE_EXT_CHECK;

SELECT * from MS_FILE;

-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의
-- 모든 데이터를 삭제하는 명령어를 작성하시오.

-- DDL - TRUNCATE
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_REPLY;

-- DML -- DELETE
DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_FILE;
DELETE FROM MS_REPLY;

-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
-- - 한 행 단위로 데이터를 삭제한다.
-- - WHERE 조건절을 기준으로 일부 삭제 가능.
-- - COMMIT, ROLLBACK 을 이용하여 변경사항을
--   적용하거나 되돌릴 수 있다.

-- * TRUNCATE - 데이터 정의어(DDL)
-- - 모든 행을 삭제한다.
-- - 삭제된 데이터를 되돌릴 수 없음


-- 79.
-- 테이블의 속성을 삭제하시오.
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성

ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오.
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제 시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오.

-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
-- ** 외래키가 참조하는 참조칼럼의 데이터 삭제 시, 동작할 옵션 지정
-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- * NO ACTION  : 아무 행위도 안함.
-- * RESTRICT   : 자식 테이블의 데이터가 존재하면, 삭제안함
-- * CASCADE    : 자식 테이블의 데이터도 함께 삭제
-- * SET NULL   : 자식 테이블의 데이터를 NULL 로 지정

-- 1)
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY(WRITER) REFERENCES MS_USER(USER_NO)
        ON DELETE CASCADE
;

-- 2)
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY(BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
        ON DELETE CASCADE
;
-- 3)
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO
FOREIGN KEY(BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
        ON DELETE CASCADE
;

-- 댓글 추가
INSERT INTO MS_REPLY ( 
            BOARD_NO,CONTENT,DEL_DATE,DEL_YN,REG_DATE,REPLY_NO,UPD_DATE,WRITER
            )
VALUES (1,'댓글ㄹㄹㄹㄹ',NULL,NULL,SYSDATE,1,SYSDATE,1);


-- 파일 추가
INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (10, 1, '강아지.jpg', '123', sysdate, sysdate, 'jpg' );


INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
            )
VALUES (2, 1, 'main.html', '123', sysdate, sysdate, 'jpg' );



-- 게시글 추가
INSERT INTO MS_BOARD (
                BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
                DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
                )
VALUES (
        1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );


-- 유저 추가
INSERT INTO MS_USER(
                USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
                TEL, ADDRESS, REG_DATE, UPD_DATE,
                CTZ_NO, GENDER
                )
VALUES ( 1, 'ALOHA', '123456', '김조은', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
         '010-1234-1234', '부평', sysdate, sysdate,
         '030101-3334444', '기타');


SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;
SELECT * FROM MS_USER;

DELETE FROM MS_USER
WHERE USER_NO = 1;

-- 외래키 제약 조건
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키 속성)
REFERENCES 참조테이블(참조 속성)
ON UPDATE [NO ACTION, RESTRICT, CASCADE, SET NULL]
ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
;

-- 옵션
-- ON UPDATE            -- 참조 테이블 수정 시,
--  * CASCADE           : 자식 데이터 수정
--  * SET NULL          : 자식 데이터는 NULL 
--  * SET DEFAULT       : 자식 데이터는 기본값
--  * RESTRICT          : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정 불가
--  * NO ACTION         : 아무런 행위도 취하지 않는다 (기본값)

-- ON DELETE            -- 참조 테이블 삭제 시,
--  * CASCADE           : 자식 데이터 삭제
--  * SET NULL          : 자식 데이터는 NULL 
--  * SET DEFAULT       : 자식 데이터는 기본값
--  * RESTRICT          : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 삭제 불가
--  * NO ACTION         : 아무런 행위도 취하지 않는다 (기본값)
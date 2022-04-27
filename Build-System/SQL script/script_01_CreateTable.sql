USE master
GO
IF DB_ID('DATABASE_ASS2') IS NOT NULL
    DROP DATABASE DATABASE_ASS2
GO 
CREATE DATABASE DATABASE_ASS2
GO
USE DATABASE_ASS2
GO
-------------- BUOI 1 ----------------------
CREATE TABLE GIAO_LO
(
	MA_GIAO_LO varchar(3),
	LONG float not null,
	LAT float not null
	CONSTRAINT pk_GIAO_LO PRIMARY KEY (MA_GIAO_LO)
)
-------------- BUOI 2 ----------------------
CREATE TABLE CON_DUONG
(
	MA_CON_DUONG varchar(3),
	TEN_DUONG NVARCHAR(30) not null,
	CONSTRAINT pk_CON_DUONG PRIMARY KEY (MA_CON_DUONG)
)
--------------------------------------------
-------------- BUOI 3 ----------------------
CREATE TABLE DOAN_DUONG
(
	MA_GIAO_LO1 varchar(3) not null,
	MA_GIAO_LO2 varchar(3) not null,
	MA_CON_DUONG varchar(3) not null,
	CHIEU_DAI FLOAT not null,
	STT int not null,
	CONSTRAINT pk_DOAN_DUONG PRIMARY KEY (MA_GIAO_LO1,MA_GIAO_LO2),
	CONSTRAINT fk_MA_GIAO_LO1 FOREIGN KEY(MA_GIAO_LO1) REFERENCES GIAO_LO(MA_GIAO_LO),
	CONSTRAINT fk_MA_GIAO_LO2 FOREIGN KEY(MA_GIAO_LO2) REFERENCES GIAO_LO(MA_GIAO_LO),
	CONSTRAINT fk_MA_CON_DUONG FOREIGN KEY(MA_CON_DUONG) REFERENCES CON_DUONG(MA_CON_DUONG)

)
--------------------------------------------
-------------- BUOI 4 ----------------------

CREATE TABLE TUYEN_TAU_XE
(
	MA_TUYEN VARCHAR(4) CHECK (MA_TUYEN LIKE '[BT][0-9][0-9][0-9]'),
	CONSTRAINT pk_TUYEN_TAU_XE PRIMARY KEY (MA_TUYEN)
)

--------------------------------------------
-------------- BUOI 5 -----------------------
CREATE TABLE TUYEN_XE_BUS
(
	NUMBER INT IDENTITY(1,1),
	MA_TUYEN_XE VARCHAR(4) NOT NULL CHECK (MA_TUYEN_XE LIKE 'B%'),
	CONSTRAINT pk_TUYEN_XE_BUS PRIMARY KEY(NUMBER),
	CONSTRAINT fk_MA_TUYEN_TAU_XE FOREIGN KEY(MA_TUYEN_XE) REFERENCES TUYEN_TAU_XE(MA_TUYEN)
)

--------------------------------------------
-------------- BUOI 6 -----------------------
CREATE TABLE TUYEN_TAU_DIEN
(
	MA_TUYEN_TAU VARCHAR(1) ,
	TEN_TUYEN_TAU NVARCHAR(100) not null UNIQUE,
	MA_TUYEN_TAU_XE VARCHAR(4) NOT NULL CHECK (MA_TUYEN_TAU_XE LIKE 'T%'),
	DON_GIA MONEY NOT NULL,
	CONSTRAINT pk_TUYEN_TAU_DIEN PRIMARY KEY(MA_TUYEN_TAU),
	CONSTRAINT fk_TUYEN_TAU_DIEN FOREIGN KEY(MA_TUYEN_TAU_XE) REFERENCES TUYEN_TAU_XE(MA_TUYEN)
)

--------------------------------------------
-------------- BUOI 7 ----------------------
CREATE TABLE CHUYEN_TAU_XE
(
	MA_TUYEN VARCHAR(4),
	STT INT,
	CONSTRAINT pk_CHUYEN_TAU_XE PRIMARY KEY(MA_TUYEN,STT),
	CONSTRAINT fk_CHUYEN_TAU_XE FOREIGN KEY(MA_TUYEN) REFERENCES TUYEN_TAU_XE(MA_TUYEN)
)
--------------------------------------------
-------------- BUOI 8 ----------------------
CREATE TABLE GA_TRAM
(
	MA_GA_TRAM VARCHAR(7) PRIMARY KEY 
	CONSTRAINT CH_MA_GA  CHECK (MA_GA_TRAM LIKE '[BT]T[0-9][0-9][0-9][0-9][0-9]') ,
	DIA_CHI VARCHAR(50) NOT NULL UNIQUE,
	TEN_GA_TRAM VARCHAR(20),
	GA_TRAM  VARCHAR(11) NOT NULL CHECK (GA_TRAM IN('TRAM_XE_BUS', 'GA_TAU_DIEN')),
	MA_GIAO_LO1 VARCHAR(3), 
	MA_GIAO_LO2 VARCHAR(3),
	CONSTRAINT CHECK_MA_GIAO_LO1 FOREIGN KEY (MA_GIAO_LO1,MA_GIAO_LO2) REFERENCES DOAN_DUONG(MA_GIAO_LO1,MA_GIAO_LO2),
)
--------------------------------------------
-------------- BUOI 9 ----------------------
--DROP TABLE CHUYEN_TAU_GHE_TRAM
CREATE TABLE CHUYEN_TAU_GHE_TRAM
(
	MA_TUYEN VARCHAR(4),
	STT INT,
	MA_GA VARCHAR(7),
	STT_TRAM_DUNG INT,
	GIO_GHE TIME,
	GIO_DI TIME,
	CONSTRAINT pk_MA_TUYEN_STT PRIMARY KEY (MA_TUYEN,STT,MA_GA),
	CONSTRAINT fk_MA_TUYEN_STT FOREIGN KEY(MA_TUYEN,STT) REFERENCES CHUYEN_TAU_XE(MA_TUYEN,STT),
	CONSTRAINT fk_MA_GA_TRAM_1 FOREIGN KEY(MA_GA) REFERENCES GA_TRAM(MA_GA_TRAM)
)

--------------------------------------------
-------------- BUOI 10 ----------------------
create table VE
(
  MA_VE varchar(15) PRIMARY KEY
  CONSTRAINT CK_ContactNo2  CHECK (MA_VE LIKE 'V[OMD][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') ,
  GIA_VE MONEY,
  LOAI_VE VARCHAR(10) NOT NULL CHECK (LOAI_VE IN('VE_LE', 'VE_THANG', 'VE_1_NGAY')),
  NGAY_GIO_MUA DATETIME
)

-------------- BUOI 11 ----------------------
CREATE TABLE VE_LE
(
	MA_VE varchar(15) primary key CHECK (MA_VE LIKE 'VO%')NOT NULL ,
	MA_TUYEN varchar(4) NOT NULL,
	NGAY_SU_DUNG DATE,
	MA_GA_LEN varchar(7),
	MA_GA_XUONG varchar(7),
	GIO_LEN TIME,
	GIO_XUONG TIME,
	CONSTRAINT CHECK_MAVE_VE_LE FOREIGN KEY (MA_VE) REFERENCES VE (MA_VE),	
	CONSTRAINT CHECK_TUYEN_VE_LE FOREIGN KEY (MA_TUYEN) REFERENCES TUYEN_TAU_XE (MA_TUYEN),
	CONSTRAINT CHECK_LEN_VE_LE FOREIGN KEY (MA_GA_LEN) REFERENCES GA_TRAM (MA_GA_TRAM),
	CONSTRAINT CHECK_XUONG_VE_LE FOREIGN KEY (MA_GA_XUONG) REFERENCES GA_TRAM (MA_GA_TRAM),
	CHECK (GIO_LEN < GIO_XUONG)
)	
--------------------------------------------
-------------- BUOI 12 ---------------------
CREATE TABLE VE_THANG
(
	MA_VE varchar(15) primary key CHECK (MA_VE LIKE 'VM%') NOT NULL ,
	MA_TUYEN varchar(4) NOT NULL,
	MA_GA_1 varchar(7),
	MA_GA_2 varchar(7),
	CONSTRAINT CHECK_MAVE_VE_THANG FOREIGN KEY (MA_VE) REFERENCES VE (MA_VE),
	CONSTRAINT CHECK_TUYEN_VE_THANG FOREIGN KEY (MA_TUYEN) REFERENCES TUYEN_TAU_XE (MA_TUYEN),
	CONSTRAINT CHECK_1_THANG FOREIGN KEY (MA_GA_1) REFERENCES GA_TRAM (MA_GA_TRAM),
	CONSTRAINT CHECK_2_THANG FOREIGN KEY (MA_GA_2) REFERENCES GA_TRAM (MA_GA_TRAM),
)	
--------------------------------------------
-------------- BUOI 13 ----------------------
CREATE TABLE HD_VE_THANG
(
	MA_VE varchar(15) ,
	NGAY_SU_DUNG DATE,
	MA_GA_LEN varchar(7),
	MA_GA_XUONG varchar(7),
	GIO_LEN TIME,
	GIO_XUONG TIME,
	CONSTRAINT pk_MA_VE_NSD_H_LEN PRIMARY KEY (MA_VE,NGAY_SU_DUNG,GIO_LEN),
	CONSTRAINT CHECK_MAVE_HD_VE_THANG FOREIGN KEY (MA_VE) REFERENCES VE_THANG (MA_VE),
	CHECK (GIO_LEN < GIO_XUONG),
	CONSTRAINT CHECK_LEN_HD_VE_THANG FOREIGN KEY (MA_GA_LEN) REFERENCES GA_TRAM (MA_GA_TRAM),
	CONSTRAINT CHECK_XUONG_VHD_VE_THANG FOREIGN KEY (MA_GA_XUONG) REFERENCES GA_TRAM (MA_GA_TRAM),
)
--------------------------------------------
-------------- BUOI 14 ---------------------
CREATE TABLE VE_1_NGAY
(
	MA_VE varchar(15) primary key CHECK (MA_VE LIKE 'VD%') NOT NULL ,
	NGAY_SU_DUNG DATE,
	CONSTRAINT CHECK_MAVE_VE_1_NGAY FOREIGN KEY (MA_VE) REFERENCES VE (MA_VE)
)
--------------------------------------------
-------------- BUOI 15 ---------------------
CREATE TABLE HD_VE_1_NGAY
(
	MA_VE varchar(15) ,
	STT INT,
	MA_TUYEN varchar(4),
	MA_GA_LEN varchar(7),
	MA_GA_XUONG varchar(7),
	GIO_LEN TIME,
	GIO_XUONG TIME,
	CONSTRAINT pk_MA_VE_STT PRIMARY KEY (MA_VE,STT),
	CONSTRAINT CHECK_MAVE_HD_VE_1_NGAY FOREIGN KEY (MA_VE) REFERENCES VE_1_NGAY (MA_VE),
	CONSTRAINT CHECK_TUYEN_VE_1_NGAY FOREIGN KEY (MA_TUYEN) REFERENCES TUYEN_TAU_XE (MA_TUYEN),
	CHECK (GIO_LEN < GIO_XUONG),
	CONSTRAINT CHECK_LEN_HD_VE_1_NGAY FOREIGN KEY (MA_GA_LEN) REFERENCES GA_TRAM (MA_GA_TRAM),
	CONSTRAINT CHECK_XUONG_HD_VE_1_NGAY FOREIGN KEY (MA_GA_XUONG) REFERENCES GA_TRAM (MA_GA_TRAM),
)
--------------------------------------------
-------------- BUOI 16 ---------------------
CREATE TABLE HANH_KHACH
(
MA_HANH_KHACH CHAR(8) PRIMARY KEY,
CMND_CCCD NVARCHAR(30) UNIQUE NOT NULL,
NGHE_NGHIEP NVARCHAR(30),
DIEN_THOAI CHAR(11) UNIQUE,
GIOI_TINH NVARCHAR(5),
EMAIL NVARCHAR(30),
NGAY_SINH DATE,
CONSTRAINT CK_MA_HANH_KHACH CHECK (MA_HANH_KHACH LIKE 'KH[0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

--------------------------------------------
-------------- BUOI 17 ----------------------

CREATE TABLE THE_TU
(
MA_THE_TU CHAR(8) primary key,
NGAY_MUA DATETIME NOT NULL,
MA_HANH_KHACH CHAR(8) UNIQUE NOT NULL 
FOREIGN KEY (MA_HANH_KHACH) REFERENCES dbo.HANH_KHACH (MA_HANH_KHACH),
CONSTRAINT CK_THE_TU CHECK (MA_THE_TU LIKE 'TT[0-9][0-9][0-9][0-9][0-9][0-9]' AND 
                            MA_HANH_KHACH LIKE 'KH[0-9][0-9][0-9][0-9][0-9][0-9]')
)
--------------------------------------------
-------------- BUOI 18 ----------------------
CREATE TABLE NHAN_VIEN
(
MA_NHAN_VIEN CHAR(6) primary key,
LOAI_CONG_VIEC NVARCHAR(30) NOT NULL,
NGAY_SINH DATE,--
EMAIL NVARCHAR(30),--
GIOI_TINH NVARCHAR(5),--
DIEN_THOAI_DI_DONG CHAR(11),--
DIEN_THOAI_NOI_BO CHAR(11),
CONSTRAINT CK_MA_NHAN_VIEN CHECK (MA_NHAN_VIEN LIKE 'NV[0-9][0-9][0-9][0-9]')
)
GO
--------------------------------------------
-------------- BUOI 19 ----------------------
CREATE TABLE GA_TRAM_LAM_VIEC
(
	MA_NHAN_VIEN CHAR(6) PRIMARY KEY 
	REFERENCES dbo.NHAN_VIEN (MA_NHAN_VIEN),
	MA_GA_TRAM VARCHAR(7) NOT NULL,
	CONSTRAINT CK_GA_TRAM_LAM_VIEC CHECK (MA_NHAN_VIEN LIKE 'NV[0-9][0-9][0-9][0-9]'),
	CONSTRAINT fk_MA_GA_TRAM_LAM FOREIGN KEY(MA_GA_TRAM) REFERENCES GA_TRAM(MA_GA_TRAM)
)
--------------------------------------------
-------------- BUOI 20 ----------------------
CREATE TABLE BANG_GIA
(
DON_GIA_XE_BUYT MONEY NOT NULL,
GIA_VE_TRONG_TUAN MONEY NOT NULL,
GIA_VE_CUOI_TUAN MONEY NOT NULL
)
GO
--------- BO SUNG BANG ACCCOUNT -----------------
CREATE TABLE ACCOUNT
(
USERNAME VARCHAR(30) NOT NULL PRIMARY KEY ,
PASSWORD_  VARCHAR(30) NOT NULL UNIQUE,
)
GO
-------------------------------------------------------- KET THUC TAO BANG -----------------------------------------------
-------------------------------------------------------- PHAN INSERT -----------------------------------------------------



GO
--------------- TAO TRIGGER VA FUNTION CHO TABLE -----------------------------
-- ----------------------------FUNCTION MA_GIAO_LO--------------------------------------
create function FUNC_MAGIAOLO(@last_GL_ID varchar(3),@GL varchar(3))
returns varchar(3)
as
	BEGIN
		IF(@last_GL_ID = '')
			set @last_GL_ID = @GL
		declare @num_next_GL_ID int, @next_GL_ID varchar(3)
		set @last_GL_ID = LTRIM(RTRIM(@last_GL_ID))
		set @num_next_GL_ID = replace(@last_GL_ID,@GL,'') + 1
		set @next_GL_ID = @GL + CONVERT(VARCHAR(MAX),@num_next_GL_ID)
		return @next_GL_ID
	END
GO
-- TRIGGER CHO MA_GIAO_LO
--drop trigger tr_next_GL_ID
CREATE trigger tr_next_GL_ID on GIAO_LO
for INSERT
as
	BEGIN
		DECLARE @last_GL_ID varchar(3)
		SET @last_GL_ID = (SELECT TOP 1 MA_GIAO_LO from GIAO_LO order by MA_GIAO_LO desc)
		UPDATE GIAO_LO set MA_GIAO_LO = dbo.FUNC_MAGIAOLO (@last_GL_ID,'GL') where MA_GIAO_LO = ''
	END
GO
------------------------------------------------------------------------------------------
------------------------------- FUNCTION MA_CON_DUONG---------------------------------------
--drop function FUNC_MA_CON_DUONG
create function FUNC_MA_CON_DUONG(@LAST_CD_ID varchar(3),@CD varchar(3))
returns varchar(3)
as
	BEGIN
		IF(@last_CD_ID = '')
			set @last_CD_ID = @CD
		declare @num_next_CD_ID int, @next_CD_ID varchar(3)
		set @last_CD_ID = LTRIM(RTRIM(@last_CD_ID))
		set @num_next_CD_ID = replace(@last_CD_ID,@CD,'') + 1
		set @next_CD_ID = @CD + CONVERT(VARCHAR(MAX),@num_next_CD_ID)
		return @next_CD_ID
	END
GO

-- TRIGGER CHO MA_CON_DUONG
--drop trigger TR_NEXT_CD_ID
CREATE trigger TR_NEXT_CD_ID on CON_DUONG
for INSERT
as
	BEGIN
		DECLARE @last_CD_ID varchar(3)
		SET @last_CD_ID = (SELECT TOP 1 MA_CON_DUONG from CON_DUONG order by MA_CON_DUONG desc)
		UPDATE CON_DUONG set MA_CON_DUONG = dbo.FUNC_MA_CON_DUONG (@last_CD_ID,'CD') where MA_CON_DUONG = ''
	END
GO
-------------------------------------------------------------------------------------------------
--------------------------------- FUNTION INSERT_VE----------------------------------------------
if OBJECT_ID ('Insert_Ve','P') is not null
drop proc INSERT_VE
GO
create proc INSERT_VE
	@MAVE VARCHAR(15),
	@GIA_VE MONEY,
	@LOAI_VE VARCHAR(10),
	@NGAY_GIO_MUA DATETIME

AS
BEGIN TRANSACTION 
	DECLARE @NGAY_THANG_NAM VARCHAR(8)
	DECLARE @NGAY_ VARCHAR(2)
	DECLARE @THANG_ VARCHAR(2)
	DECLARE @NAM_ VARCHAR(4)
BEGIN TRY
	SET @NGAY_ = SUBSTRING(@MAVE, 3, 2);
	SET @THANG_ = SUBSTRING(@MAVE, 5, 2);
	SET @NAM_ = SUBSTRING(@MAVE, 7, 4);
	SET @NGAY_THANG_NAM = CONCAT(@NAM_,@THANG_,@NGAY_);
	IF ISDATE(@NGAY_THANG_NAM) = 1
	BEGIN
		INSERT INTO VE VALUES(@MAVE,@GIA_VE,@LOAI_VE,@NGAY_GIO_MUA);
	END
END TRY
BEGIN CATCH
	PRINT N'FAIL'
	ROLLBACK TRANSACTION
END CATCH
IF @@TRANCOUNT > 0
COMMIT TRANSACTION
go
-------------------------------------------------END-----------------------------------------------------------------------------
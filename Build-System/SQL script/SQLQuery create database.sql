-- Khoi tao Database
CREATE DATABASE CSDL_ass2
GO
-- Su dung Database
USE CSDL_ass2
GO
 -- Drop Table
 -------------------------------------------------------
IF  EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE Table_Schema = 'dbo'  AND Table_Name ='The_tu')
BEGIN
     drop table The_tu
END
---------------------------------------------------------
 IF  EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE Table_Schema = 'dbo'  AND Table_Name ='Hanh_khach')
BEGIN
     drop table Hanh_khach
END
---------------------------------------------------------
IF  EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE Table_Schema = 'dbo'  AND Table_Name ='Ga_tram_lam_viec')
BEGIN
     drop table Ga_tram_lam_viec
END
----------------------------------------------------------
IF  EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE Table_Schema = 'dbo'  AND Table_Name ='Nhan_vien')
BEGIN
     drop table Nhan_vien
END
----------------------------------------------------------
IF  EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE Table_Schema = 'dbo'  AND Table_Name ='Bang_gia')
BEGIN
     drop table Bang_gia
END
----------------------------------------------------------


----------------------------------------------------------------------------
----------------------------------------------------------------------------
--Tao Table Hanh_khach
CREATE TABLE Hanh_khach
(
Ma_hanh_khach CHAR(8) PRIMARY KEY,
CMND_CCCD NVARCHAR(30) UNIQUE NOT NULL,
Nghe_nghiep NVARCHAR(30),
Dien_thoai CHAR(11) UNIQUE,
Gioi_tinh NVARCHAR(5),
Email NVARCHAR(30),
Ngay_sinh DATE,
CONSTRAINT CK_Ma_hanh_khach CHECK (Ma_hanh_khach LIKE 'KH[0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

----- INSERT BANG Hanh_khach--------
INSERT dbo.Hanh_khach
(    Ma_hanh_khach,CMND_CCCD,Nghe_nghiep,Dien_thoai,Gioi_tinh,Email,Ngay_sinh)
VALUES
(   'KH000001',N'201484041',N'sinh viên','0909650661',N'Nam',N'dn_291@yahoo.com',GETDATE()),
(   'KH000002',N'201484042',N'giáo viên','0909650662',N'Nam',N'dn_292@yahoo.com',GETDATE()),
(   'KH000003',N'201484043',N'học sinh','0909650663',N'Nữ',N'dn_293@yahoo.com',GETDATE()),
(   'KH000004',N'201484044',N'công nhân','0909650664',N'Nữ',N'dn_294@yahoo.com',GETDATE())
SELECT * FROM dbo.Hanh_khach 
GO	



----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Tao Table The_tu

CREATE TABLE The_tu
(
Ma_the_tu CHAR(8) primary key,
Ngay_mua DATETIME NOT NULL,
Ma_hanh_khach CHAR(8) UNIQUE NOT NULL 
FOREIGN KEY (Ma_hanh_khach) REFERENCES dbo.Hanh_khach (Ma_hanh_khach),
CONSTRAINT CK_The_tu CHECK (Ma_the_tu LIKE 'TT[0-9][0-9][0-9][0-9][0-9][0-9]' AND 
                            Ma_hanh_khach LIKE 'KH[0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO
INSERT dbo.The_tu
(    Ma_the_tu,Ngay_mua,Ma_hanh_khach)
VALUES
(   'TT000001',GETDATE(),'KH000001'),
(   'TT000002',GETDATE(),'KH000002'),
(   'TT000003',GETDATE(),'KH000003'),
(   'TT000004',GETDATE(),'KH000004')
SELECT * FROM dbo.The_tu
GO


----------------------------------------------------------------------------
----------------------------------------------------------------------------
--Tao Table Nhan_vien

CREATE TABLE Nhan_vien
(
Ma_nhan_vien CHAR(6) primary key,--
Loai_cong_viec NVARCHAR(30) NOT NULL,
Ngay_sinh DATE,--
Email NVARCHAR(30),--
Gioi_tinh NVARCHAR(5),--
Dien_thoai_di_dong CHAR(11),--
Dien_thoai_noi_bo CHAR(11),
CONSTRAINT CK_Ma_nhan_vien CHECK (Ma_nhan_vien LIKE 'NV[0-9][0-9][0-9][0-9]')
)
GO
INSERT dbo.Nhan_vien
(    Ma_nhan_vien,Loai_cong_viec,Ngay_sinh,Email,Gioi_tinh,Dien_thoai_di_dong,Dien_thoai_noi_bo)
VALUES
(   'NV0001',N'bán vé',GETDATE(),N'abc1@yahoo.com',N'Nữ','0909625321','001'),
(   'NV0002',N'bán vé',GETDATE(),N'abc2@yahoo.com',N'Nữ','0909625322','002'),
(   'NV0003',N'bán vé',GETDATE(),N'abc3@yahoo.com',N'Nam','0909625323','003'),
(   'NV0004',N'bán vé',GETDATE(),N'abc4@yahoo.com',N'Nam','0909625324','004')
SELECT * FROM dbo.Nhan_vien
GO	


----------------------------------------------------------------------------
----------------------------------------------------------------------------
--Tao Table Ga_tram_lam_viec

CREATE TABLE Ga_tram_lam_viec
(
	Ma_nhan_vien CHAR(6) PRIMARY KEY 
	REFERENCES dbo.Nhan_vien (Ma_nhan_vien),
	Ma_ga_tram CHAR(8) NOT NULL,
	CONSTRAINT CK_Ga_tram_lam_viec CHECK (Ma_nhan_vien LIKE 'NV[0-9][0-9][0-9][0-9]' AND
	                                      Ma_ga_tram LIKE 'BT[0-9][0-9][0-9][0-9][0-9]')	
)
GO
INSERT dbo.Ga_tram_lam_viec
(    Ma_nhan_vien,Ma_ga_tram)
VALUES
(   'NV0001','BT00001'),
(   'NV0002','BT00002'),
(   'NV0003','BT00003'),
(   'NV0004','BT00004')
SELECT * FROM dbo.Ga_tram_lam_viec
GO



----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- Tao Table Bang_gia
CREATE TABLE Bang_gia
(
Don_gia_xe_buyt MONEY NOT NULL,
Gia_ve_trong_tuan MONEY NOT NULL,
Gia_ve_cuoi_tuan MONEY NOT NULL
)
GO
INSERT dbo.Bang_gia
(    Don_gia_xe_buyt,    Gia_ve_trong_tuan,    Gia_ve_cuoi_tuan)
VALUES
(   5000, 30000,40000)
SELECT * FROM dbo.Bang_gia
GO	



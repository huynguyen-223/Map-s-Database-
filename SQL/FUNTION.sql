
USE DATABASE_ASS2
GO
 -----------------------------------------------------------------------------------------------------------
------------------------------------------ TRIGGER I.1------------------------------------------------------
CREATE trigger CHECK_HD_VE_THANG 
ON HD_VE_THANG
for INSERT
AS
BEGIN
    DECLARE @MA_VE VARCHAR(15)
    SET @MA_VE = (SELECT MA_VE FROM INSERTED)

    IF EXISTS (select MA_GA_LEN FROM inserted where MA_GA_LEN != (SELECT MA_GA_1 FROM [VE_THANG] WHERE MA_VE = @MA_VE))
    BEGIN
    PRINT N'MA GA LEN KHONG DUNG'
    ROLLBACK TRAN
    END
    ELSE IF EXISTS (select MA_GA_XUONG FROM inserted where MA_GA_XUONG != (SELECT MA_GA_2 FROM [VE_THANG] WHERE MA_VE = @MA_VE))
    BEGIN
    PRINT N'MA GA XUONG KHONG DUNG'
    ROLLBACK TRAN
    END
END
GO
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------- TRIGGER I.2-----------------------------------------------------------
--CAP_NHAP_GIA_VE_LE
GO
CREATE trigger CAP_NHAP_GIA_VE_LE on VE_LE
for INSERT
as
	BEGIN
		DECLARE @MA_VE VARCHAR(15)
		SET @MA_VE = (SELECT MA_VE FROM INSERTED)

		DECLARE @MA_TUYEN VARCHAR(4)
		SET @MA_TUYEN = (SELECT MA_TUYEN FROM INSERTED)

		DECLARE @DON_GIA MONEY
		 SET @DON_GIA = 0;
		IF (@MA_TUYEN LIKE 'B%') SET @DON_GIA = (SELECT DON_GIA_XE_BUYT FROM BANG_GIA)
		IF (@MA_TUYEN LIKE 'T%') SET @DON_GIA = (SELECT DON_GIA FROM TUYEN_TAU_DIEN WHERE MA_TUYEN_TAU_XE= @MA_TUYEN)

		DECLARE @TONG_TRAM INT
		SET @TONG_TRAM = (SELECT COUNT(*) FROM  CHUYEN_TAU_GHE_TRAM ctgt INNER JOIN GA_TRAM gt ON ctgt.MA_GA = gt.MA_GA_TRAM 
		WHERE ctgt.MA_TUYEN = @MA_TUYEN);
		DECLARE @TONG_TRAM_MONEY MONEY
		SET @TONG_TRAM_MONEY = (SELECT CAST(@TONG_TRAM AS MONEY));
		SET @TONG_TRAM_MONEY = ROUND(@TONG_TRAM_MONEY/2,0);
		UPDATE VE set GIA_VE = @DON_GIA * @TONG_TRAM_MONEY  where MA_VE = @MA_VE  

	END
GO
-- CAP_NHAP_GIA_VE_THANG
CREATE trigger CAP_NHAP_GIA_VE_THANG on VE_THANG
for INSERT
as
	BEGIN
		DECLARE @MA_VE VARCHAR(15)
		SET @MA_VE = (SELECT MA_VE FROM INSERTED)

		DECLARE @MA_TUYEN VARCHAR(4)
		SET @MA_TUYEN = (SELECT MA_TUYEN FROM INSERTED)

		DECLARE @DON_GIA MONEY
		SET @DON_GIA =0;
		IF (@MA_TUYEN LIKE 'B%') SET @DON_GIA = (SELECT DON_GIA_XE_BUYT FROM BANG_GIA)
		IF (@MA_TUYEN LIKE 'T%') SET @DON_GIA = (SELECT DON_GIA FROM TUYEN_TAU_DIEN WHERE MA_TUYEN_TAU_XE= @MA_TUYEN)

		DECLARE @TONG_TRAM INT
		SET @TONG_TRAM = (SELECT COUNT(*) FROM  CHUYEN_TAU_GHE_TRAM ctgt INNER JOIN GA_TRAM gt ON ctgt.MA_GA = gt.MA_GA_TRAM 
		WHERE ctgt.MA_TUYEN = @MA_TUYEN);
		DECLARE @TONG_TRAM_MONEY MONEY
		SET @TONG_TRAM_MONEY = (SELECT CAST(@TONG_TRAM AS MONEY));
		SET @TONG_TRAM_MONEY = ROUND(@TONG_TRAM_MONEY/2,0);
		UPDATE VE set GIA_VE = @DON_GIA * @TONG_TRAM_MONEY *40  where MA_VE = @MA_VE  
	END
GO
--CAP_NHAP_GIA_VE_1_NGAY
CREATE trigger CAP_NHAP_GIA_VE_1_NGAY on VE_1_NGAY
for INSERT
as
	BEGIN
		DECLARE @MA_VE VARCHAR(15)
		SET @MA_VE = (SELECT MA_VE FROM INSERTED)

		DECLARE @NGAY_SU_DUNG DATE
		SET @NGAY_SU_DUNG = (SELECT NGAY_SU_DUNG FROM INSERTED)

		DECLARE @DON_GIA MONEY
		SET @DON_GIA = 0 
		
		DECLARE @THU INT
		SET @THU = (SELECT DATEPART(dw,@NGAY_SU_DUNG))
		IF (@THU != 1 ) SET @DON_GIA = (SELECT GIA_VE_TRONG_TUAN FROM BANG_GIA)
		IF (@THU = 1) SET @DON_GIA = (SELECT GIA_VE_CUOI_TUAN FROM BANG_GIA)
		DECLARE @TONG_TRAM INT
		UPDATE VE set GIA_VE =  @DON_GIA  where MA_VE = @MA_VE 
	END
GO

---------------------------------------------------------------------------------------------------------
------------------------------------------- Procedure I.1------------------------------------------------
if OBJECT_ID ('LoTrinhTuyenXeTau','P') is not null
drop proc LoTrinhTuyenXeTau
GO
create proc LoTrinhTuyenXeTau
    @MATUYEN VARCHAR(4)
AS
BEGIN TRANSACTION 
BEGIN TRY
    SELECT gt.ten_ga_tram FROM CHUYEN_TAU_GHE_TRAM ctgt INNER JOIN GA_TRAM gt ON ctgt.MA_GA = gt.MA_GA_TRAM 
    WHERE ctgt.MA_TUYEN = @MATUYEN ORDER BY ctgt.STT_TRAM_DUNG ASC;
END TRY
BEGIN CATCH
    PRINT N'FAIL'
    ROLLBACK TRANSACTION
END CATCH
IF @@TRANCOUNT > 0
COMMIT TRANSACTION
GO

---------------------------------------------------------------------------------------------------
--------------------------------------------- Procedure I.2----------------------------------------

if OBJECT_ID ('ThongKeLuotNguoi','P') is not null
drop proc ThongKeLuotNguoi
GO
create proc ThongKeLuotNguoi
    @MATUYEN VARCHAR(4),
    @TU_NGAY DATE,
    @TOI_NGAY DATE
AS
CREATE TABLE #Temp
(
    Ngay date,
    Tongsoluotnguoi int
)
BEGIN TRANSACTION 
BEGIN TRY
    ----tao bien day----
    declare @DAYRUN DATE;
    SET @DAYRUN = @TU_NGAY;
    ----- tao bien tong -------
    ----- tuyen ve le ---------
    declare @TONG INT;

    WHILE @DAYRUN < = @TOI_NGAY
    BEGIN
        SET @TONG = 0;
        ----tong ve le----------
        SET @TONG = @TONG + (SELECT COUNT(*) FROM VE_LE WHERE NGAY_SU_DUNG = @DAYRUN AND  MA_TUYEN = @MATUYEN);
        -------------------------------------------------------------
        ----tong ve 1 ngay----------
        SET @TONG = @TONG + (SELECT COUNT(*) FROM HD_VE_1_NGAY hd INNER JOIN VE_1_NGAY v1 ON hd.MA_VE = v1.MA_VE WHERE MA_TUYEN = @MATUYEN AND NGAY_SU_DUNG = @DAYRUN);
        -------------------------------------------------------------
        ---- TONG VE THANG -----------------------
        SET @TONG = @TONG + (SELECT COUNT(*) FROM HD_VE_THANG hd INNER JOIN VE_THANG v1 ON hd.MA_VE = v1.MA_VE WHERE MA_TUYEN = @MATUYEN AND NGAY_SU_DUNG = @DAYRUN);
        Insert #Temp(Ngay, Tongsoluotnguoi) values(@DAYRUN, @TONG);
        ------------------------------------------------------------
        SET @DAYRUN = DATEADD(day, 1, @DAYRUN);
        --Print N'Ngay            Tong so luot nguoi';
        --Print CONVERT(VARCHAR(10), @DAYRUN) + '                '  + CONVERT(VARCHAR(1), @TONG);
    END
    select *from #Temp;
END TRY
BEGIN CATCH
    PRINT N'FAIL'
    ROLLBACK TRANSACTION
END CATCH
IF @@TRANCOUNT > 0
COMMIT TRANSACTION
GO
---------------------------------------------END CREATE --------------------------------------------
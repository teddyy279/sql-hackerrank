--1)
--a)
--SELECT * FROM [dbo].[VATTU];

--b)
--SELECT 
--    SoPN,
--    MaVTu,
--    SlNhap,
--    DgNhap,
--	SlNhap * DgNhap AS ThanhTien
--FROM [dbo].[CTPNHAP]

--c)
--SELECT
--    SoPN,
--    MaVTu,
--    SlNhap,
--    DgNhap,
--    SUM(SlNhap) OVER (PARTITION BY MaVTu) AS TongSLNhap_TheoVTu,
--    MIN(DgNhap) OVER (PARTITION BY MaVTu) AS GiaThapNhat_TheoVTu,
--    MAX(DgNhap) OVER (PARTITION BY MaVTu) AS GiaCaoNhat_TheoVTu
--FROM
--    CTPNHAP
--ORDER BY
--    MaVTu, SoPN;


--d)
--C1 Join
--SELECT DISTINCT
--    N.MaNCC,
--	  N.TenNCC
--FROM [dbo].[NCC] N
--JOIN [dbo].[DONDH] D
--    ON N.MaNCC = D.MaNCC;

--C2 subquery
--SELECT
--    MaNCC,
--    TenNCC
--FROM
--    NCC
--WHERE
--    MaNCC IN (SELECT MaNCC FROM DONDH); 

--e)
--SELECT DISTINCT
--    N.MaNCC,
--	N.TenNCC
--FROM [dbo].[NCC] N
--JOIN [dbo].[DONDH] D 
--    ON N.MaNCC = D.MaNCC
--JOIN [dbo].[PNHAP] P
--    ON D.SoDH = P.SoDH

--f)
--SELECT (có thể hiện 5 hoặc ... đơn bằng SELECT TOP...) 
--    SoDH,
--    NgayDH,
--    MaNCC
--FROM
--    DONDH
--ORDER BY
--    NgayDH DESC;


--g)
--SELECT 
--    SoPX, 
--    SUM(SlXuat * DgXuat) AS TongTriGia 
--FROM [dbo].[CTPXUAT]
--GROUP BY SoPX
--ORDER BY TongTriGia DESC;


--h)
--SELECT 
--    CTDH.MaVTu,
--	  V.TenVtu,
--	  SUM(CTPN.SlNhap) AS TONG_SO_LUONG_NHAP
--FROM [dbo].[CTDONDH] CTDH
--JOIN [dbo].[VATTU] V
--   ON CTDH.MaVTu = V.MaVTu  
--JOIN [dbo].[CTPNHAP] CTPN
--   ON V.MaVTu = CTPN.MaVTu
--GROUP BY CTDH.MaVTu, V.TenVTu;


--i)
--SELECT
--    CTDH.MaVTu,
--    V.TenVTu,
--    SUM(CTPN.SlNhap) AS TONG_SO_LUONG_NHAP
--FROM [dbo].[CTDONDH] CTDH
--JOIN [dbo].[VATTU] V
--    ON CTDH.MaVTu = V.MaVTu
--JOIN [dbo].[CTPNHAP] CTPN
--    ON V.MaVTu = CTPN.MaVTu
--GROUP BY CTDH.MaVTu, V.TenVTu
--ORDER BY CTDH.MaVTu ASC
--OFFSET 1 ROWS
--FETCH NEXT 2 ROWS ONLY;

--WITH CTE_TONG_NHAP AS (
--    SELECT 
--        CTDH.MaVTu,
--        V.TenVTu,
--        SUM(CTPN.SlNhap) OVER (PARTITION BY CTDH.MaVTu, V.TenVTu) AS TONG_SO_LUONG_NHAP,
--        ROW_NUMBER() OVER (ORDER BY CTDH.MaVTu ASC) AS rn
--    FROM [dbo].[CTDONDH] AS CTDH
--    JOIN [dbo].[VATTU] AS V
--        ON CTDH.MaVTu = V.MaVTu
--    JOIN [dbo].[CTPNHAP] AS CTPN
--        ON V.MaVTu = CTPN.MaVTu
--)
--SELECT 
--    MaVTu,
--   TenVTu,
--    TONG_SO_LUONG_NHAP
--FROM CTE_TONG_NHAP
--GROUP BY MaVTu, TenVTu, TONG_SO_LUONG_NHAP, rn
--ORDER BY MaVTu
--OFFSET 1 ROWS
--FETCH NEXT 2 ROWS ONLY;


--2)


--ALTER TABLE CTDONDH DROP CONSTRAINT FK_CTDONDH_DONDH;

--ALTER TABLE CTDONDH
--ADD CONSTRAINT FK_CTDONDH_DONDH
--FOREIGN KEY (SoDH) REFERENCES DONDH(SoDH)
--ON DELETE CASCADE;

--ALTER TABLE PNHAP DROP CONSTRAINT FK_PNHAP_DONDH;

--ALTER TABLE PNHAP
--ADD CONSTRAINT FK_PNHAP_DONDH
--FOREIGN KEY (SoDH) REFERENCES DONDH(SoDH)
--ON DELETE CASCADE;

--ALTER TABLE CTPNHAP DROP CONSTRAINT FK_CTPNHAP_PNHAP;

--ALTER TABLE CTPNHAP
--ADD CONSTRAINT FK_CTPNHAP_PNHAP
--FOREIGN KEY (SoPN) REFERENCES PNHAP(SoPN)
--ON DELETE CASCADE;

--a)
--DELETE FROM DONDH 
--WHERE NgayDH = '2002-01-15';


--b)
-- 1. Chèn lại vào DONDH
--INSERT INTO DONDH (SoDH, NgayDH, MaNCC) VALUES
--('D001', '2002-01-15', 'C01');

-- 2. Chèn lại vào PNHAP (Phiếu nhập N001, N002)
--INSERT INTO PNHAP (SoPN, Ngaynhap, SoDH) VALUES
--('N001', '2002-01-17', 'D001'),
--('N002', '2002-01-20', 'D001');

-- 3. Chèn lại vào CTDONDH (Chi tiết đơn hàng D001)
--INSERT INTO CTDONDH (SoDH, MaVTu, SlDat) VALUES
--('D001', 'DD01', 10),
--('D001', 'DD02', 15);

--c)
--UPDATE CTPXUAT
--SET 
--    DgXuat = DgXuat * DgXuat -- Giá trị mới bằng bình phương của giá trị cũ
--WHERE 
--    DgXuat < 4000000;


--d)
--SELECT
--    D.SoDH,
--    CTDH.MaVTu,
--    CTDH.SlDat
--FROM
--    DONDH D
--INNER JOIN
--    CTDONDH CTDH ON D.SoDH = CTDH.SoDH
--WHERE
--    DATENAME(dw, D.NgayDH) = 'Sunday'; 

--e)
--SELECT
--    CTDH.MaVTu,
--    COUNT(DISTINCT D.SoDH) AS TongSoDonDatHang, 
--    FORMAT(D.NgayDH, 'dd/MM/yy') AS NgayDatHang 
--FROM
--    CTDONDH CTDH
--INNER JOIN
--    DONDH D ON CTDH.SoDH = D.SoDH
--WHERE
--    CTDH.MaVTu = 'DD01'
--GROUP BY
--    CTDH.MaVTu,
--    D.NgayDH;


--ALTER TABLE CTDONDH
--ALTER COLUMN SlDat INT NULL; 


--UPDATE CTDONDH
--SET SlDat = NULL
--WHERE SoDH = 'D002';


--UPDATE CTDONDH
--SET SlDat = 0   
--WHERE SlDat IS NULL; 

--SELECT SlDat 
--FROM CTDONDH

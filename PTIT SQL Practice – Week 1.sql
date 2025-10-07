-- 1. VATTU
CREATE TABLE VATTU (
    MaVTu     CHAR(4)         PRIMARY KEY, 
    TenVTu    NVARCHAR(100)   NOT NULL,
    DvTinh    NVARCHAR(10)    NULL,
    PhanTram  DECIMAL(5,2)    NULL CHECK (PhanTram >= 0 AND PhanTram <= 100)
);

-- 2. NCC
CREATE TABLE NCC (
    MaNCC      CHAR(3)       PRIMARY KEY,
    TenNCC     NVARCHAR(100) NOT NULL,
    Diachi     NVARCHAR(100) NULL,
    Dienthoai  VARCHAR(20)   NULL
);

-- 3. DONDH
CREATE TABLE DONDH (
    SoDH      CHAR(4)      PRIMARY KEY,
    NgayDH    DATETIME     NOT NULL DEFAULT GETDATE(),
    MaNCC     CHAR(3)      NOT NULL,
    CONSTRAINT FK_DONDH_NCC FOREIGN KEY (MaNCC) REFERENCES NCC (MaNCC)
        -- ON DELETE NO ACTION ON UPDATE NO ACTION  -- tùy chọn
);

-- 4. CTDONDH
CREATE TABLE CTDONDH (
    SoDH    CHAR(4)   NOT NULL,
    MaVTu   CHAR(4)   NOT NULL,
    SlDat   INT       NOT NULL DEFAULT 0 CHECK (SlDat >= 0),
    PRIMARY KEY (SoDH, MaVTu),
    CONSTRAINT FK_CTDONDH_DONDH FOREIGN KEY (SoDH) REFERENCES DONDH (SoDH),
    CONSTRAINT FK_CTDONDH_VATTU FOREIGN KEY (MaVTu) REFERENCES VATTU (MaVTu)
);

-- 5. PNHAP
CREATE TABLE PNHAP (
    SoPN     CHAR(4)    PRIMARY KEY,
    Ngaynhap DATETIME   NOT NULL DEFAULT GETDATE(),
    SoDH     CHAR(4)    NULL,
    CONSTRAINT FK_PNHAP_DONDH FOREIGN KEY (SoDH) REFERENCES DONDH (SoDH) 
        -- nếu muốn: ON DELETE SET NULL
);

-- 6. CTPNHAP
CREATE TABLE CTPNHAP (
    SoPN     CHAR(4)   NOT NULL,
    MaVTu    CHAR(4)   NOT NULL,
    SlNhap   INT       NOT NULL DEFAULT 0 CHECK (SlNhap >= 0),
    DgNhap   DECIMAL(18,2)   NULL,
    PRIMARY KEY (SoPN, MaVTu),
    CONSTRAINT FK_CTPNHAP_PNHAP FOREIGN KEY (SoPN) REFERENCES PNHAP (SoPN),
    CONSTRAINT FK_CTPNHAP_VATTU FOREIGN KEY (MaVTu) REFERENCES VATTU (MaVTu)
);

-- 7. PXUAT (bổ sung) - nếu bạn muốn có bảng phiếu xuất
CREATE TABLE PXUAT (
    SoPX     CHAR(4)     PRIMARY KEY,
    NgayXuat DATETIME    NOT NULL DEFAULT GETDATE(),
	TenKh    NVARCHAR(100) NOT NULL
    -- bổ sung cột khác nếu cần
);

-- 8. CTPXUAT (bổ sung FK SoPX -> PXUAT)
CREATE TABLE CTPXUAT (
    SoPX    CHAR(4)   NOT NULL,
    MaVTu   CHAR(4)   NOT NULL,
    SlXuat  INT       NOT NULL DEFAULT 0 CHECK (SlXuat >= 0),
    DgXuat  DECIMAL(18,2) NULL,
    PRIMARY KEY (SoPX, MaVTu),
    CONSTRAINT FK_CTPXUAT_PXUAT FOREIGN KEY (SoPX) REFERENCES PXUAT (SoPX),
    CONSTRAINT FK_CTPXUAT_VATTU FOREIGN KEY (MaVTu) REFERENCES VATTU (MaVTu)
);

-- 9. TONKHO
CREATE TABLE TONKHO (
    Namthang CHAR(6)   NOT NULL,  -- 'YYYYMM'
    MaVTu    CHAR(4)   NOT NULL,
    SlDau    INT       NOT NULL DEFAULT 0 CHECK (SlDau >= 0),
    TongSLN  INT       NOT NULL DEFAULT 0 CHECK (TongSLN >= 0),
    TongSLX  INT       NOT NULL DEFAULT 0 CHECK (TongSLX >= 0),
    SlCuoi   INT       NOT NULL DEFAULT 0 CHECK (SlCuoi >= 0),
    PRIMARY KEY (Namthang, MaVTu),
    CONSTRAINT FK_TONKHO_VATTU FOREIGN KEY (MaVTu) REFERENCES VATTU (MaVTu)
);


INSERT INTO VATTU (MaVTu, TenVTu, DvTinh, PhanTram) VALUES
('DD01', N'Đầu DVD Hitachi 1 đĩa', N'Bộ', 40),
('DD02', N'Đầu DVD Hitachi 3 đĩa', N'Bộ', 40),
('L001', N'Loa Panasonic 1000W', N'Bộ', 10),
('TL15', N'Tủ lạnh Sanyo 120 lít', N'Cái', 25),
('TL90', N'Tủ lạnh Sanyo 90 lít', N'Cái', 20),
('TV14', N'TV Sony 14 inches', N'Cái', 15),
('TV21', N'TV Sony 21 inches', N'Cái', 10),
('TV29', N'TV Sony 29 inches', N'Cái', 10),
('VD01', N'Đầu VCD Sony 1 đĩa', N'Bộ', 30),
('VD02', N'Đầu VCD Sony 3 đĩa', N'Bộ', 30);


INSERT INTO NCC (MaNCC, TenNCC, Diachi, Dienthoai) VALUES
('C01', N'Lưu Thanh Duyên', N'334 Thanh Xuân HN', 'Chua có'),
('C02', N'Nguyễn Thanh Hoài', N'225 Định Công HN', '8253467'),
('C03', N'Dương Đức Mạnh', N'120 Lý Thái Tổ HN', '8257456'),
('C04', N'Nguyễn Hoài Nguyên', N'45A Liễu Giai HN', '8287654'),
('C05', N'Nguyễn Thị Trang', N'18 Trường Chinh HN', '8587648'),
('C06', N'Trần Ngọc Anh', N'58 Quán Sứ HN', '853128'),
('C07', N'Trần Ngọc Trâm', N'125 Tôn Đức Thắng HN', '8567381');


INSERT INTO DONDH (SoDH, NgayDH, MaNCC) VALUES
('D001', '2002-01-15', 'C01'),
('D002', '2002-01-30', 'C03'),
('D003', '2002-02-10', 'C02'),
('D004', '2002-02-17', 'C05'),
('D005', '2002-03-01', 'C02'),
('D006', '2002-03-12', 'C05');


INSERT INTO CTDONDH (SoDH, MaVTu, SlDat) VALUES
('D001', 'DD01', 10),
('D001', 'DD02', 15),
('D002', 'VD02', 30),
('D003', 'TV14', 10),
('D003', 'TV29', 20),
('D004', 'TL90', 10),
('D005', 'TV14', 10),
('D005', 'TV29', 20),
('D006', 'TV14', 10),
('D006', 'TV29', 20),
('D006', 'VD01', 20);


INSERT INTO PNHAP (SoPN, Ngaynhap, SoDH) VALUES
('N001', '2002-01-17', 'D001'),
('N002', '2002-01-20', 'D001'),
('N003', '2002-01-31', 'D002'),
('N004', '2002-02-15', 'D003');


INSERT INTO CTPNHAP (SoPN, MaVTu, SlNhap, DgNhap) VALUES
('N001', 'DD01', 8, 2500000),
('N001', 'DD02', 10, 3500000),
('N002', 'DD01', 2, 2500000),
('N002', 'DD02', 5, 3500000),
('N003', 'VD02', 30, 2500000),
('N004', 'TV14', 5, 2500000),
('N004', 'TV29', 12, 3500000);


INSERT INTO PXUAT (SoPX, NgayXuat, TenKh) VALUES
('X000', '2008-05-20', N'Trần Thành Trung'),
('X001', '2002-01-17', N'Trần Phương Hoa'),
('X002', '2002-01-25', N'Đào Minh Chung'),
('X003', '2002-01-31', N'Nguyễn Thúy Hạnh'),
('X005', '2008-05-20', N'Hàn Ngọc Đức');


INSERT INTO CTPXUAT (SoPX, MaVTu, SlXuat, DgXuat) VALUES
('X001', 'DD01', 2, 3500000),
('X002', 'DD01', 1, 3500000),
('X002', 'DD02', 5, 4900000),
('X003', 'DD01', 3, 3500000),
('X003', 'DD02', 2, 4900000),
('X003', 'VD02', 10, 3250000);

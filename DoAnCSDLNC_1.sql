create database DoAnCSDLNC_1
go
use DoANCSDLNC_1
go

CREATE TABLE TheLoai 
(
	MaTheLoai CHAR(10) NOT NULL,
	TenTheLoai NVARCHAR(100) NOT NULL,
	SoLuongSach_TL INT CHECK (SoLuongSach_TL>=0),
	PRIMARY KEY (MaTheLoai)
);

CREATE TABLE UuDai(
    MaUuDai CHAR(10) PRIMARY KEY,
    TenUuDai NVARCHAR(100) NOT NULL,
    Mota_UD NVARCHAR (200),
    NgayBatDau_UD DATE NOT NULL,
    NgayKetThuc_UD DATE NOT NULL,
    GiamGia FLOAT NOT NULL CHECK (GiamGia>=0)
);

CREATE TABLE TacGia 
(
	MaTacGia CHAR(10) NOT NULL,
	TenTacGia NVARCHAR(100) NOT NULL,
	TieuSu_TG NVARCHAR(200),
	NgaySinh_TG DATE,
	PRIMARY KEY (MaTacGia)
);

CREATE TABLE NhaXuatBan 
(
	MaNXB CHAR(10) NOT NULL,
	TenNXB NVARCHAR(100) NOT NULL,
	DiaChi_NXB NVARCHAR(200) NOT NULL,
	Email_NXB NVARCHAR(50) NOT NULL,
	SoDienThoai_NXB CHAR(11) NOT NULL,
	PRIMARY KEY (MaNXB)
);

CREATE TABLE Sach
(
	MaSach CHAR(10) NOT NULL,
	TenSach NVARCHAR(50) NOT NULL,	
	NamXuatBan INT CHECK (NamXuatBan >=1000),
	GiaBan INT NOT NULL CHECK (GiaBan>=0),
	SoLuongTon INT NOT NULL CHECK (SoLuongTon>=0),
	MaTheLoai CHAR(10) NOT NULL,
	MaTacGia CHAR(10) NOT NULL,
	MaNXB CHAR(10) NOT NULL,
	MaUuDai CHAR(10) ,
	PRIMARY KEY (MaSach),
	FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai),
	FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia),
	FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB),
	FOREIGN KEY (MaUuDai) REFERENCES UuDai(MaUuDai)
);

CREATE TABLE LoaiKH
(
	MaLoaiKH CHAR(10)  NOT NULL,
	TenLoaiKH NVARCHAR(100) NOT NULL, 
	ChietKhau FLOAT NOT NULL CHECK (ChietKhau>=0), 
	PRIMARY KEY (MaLoaiKH)
);

CREATE TABLE KhachHang
(
	MaKH CHAR(10) NOT NULL,
	TenKH NVARCHAR(100) NOT NULL,
	SoDT_KH CHAR(11) NOT NULL,
	DiaChi_KH NVARCHAR(200),
	Email_KH NVARCHAR(100),
	MaLoaiKH CHAR(10) NOT NULL,
	SoTienMuaHang INT CHECK (SoTienMuaHang>=0),
	PRIMARY KEY (MaKH),
	FOREIGN KEY (MaLoaiKH) REFERENCES LoaiKH(MaLoaiKH)
);


CREATE TABLE LoaiNhanVien(
    MaLoaiNV CHAR(10) PRIMARY KEY,
    TenLoaiNV NVARCHAR(100),
	SoLuongNV_LNV INT
);

CREATE TABLE NhanVien(
    MaNV CHAR(10) PRIMARY KEY,
    Email_NV NVARCHAR(100) NOT NULL,
    MatKhau_NV Varchar(50) NOT NULL,
    HoTen_NV NVARCHAR(100) NOT NULL,
    DiaChi_NV NVARCHAR(200) NOT NULL,
    SoDienThoai_NV CHAR(11) NOT NULL,
	GioiTinh_NV BIT NOT NULL,
    MaLoaiNV CHAR(10) FOREIGN KEY REFERENCES LoaiNhanVien(MaLoaiNV)
);

CREATE TABLE PhuongThucThanhToan(
    MaPTTT CHAR(10) PRIMARY KEY,
    TenPTTT NVARCHAR(30) NOT NULL,
);

CREATE TABLE DonHang
(
	MaDH CHAR(10) NOT NULL,
	NgayLap_DH DATE NOT NULL, 
	MaPTTT CHAR(10) NOT NULL,
	TongTien_DH INT CHECK (TongTien_DH>=0),
	DaHuy_DH BIT NOT NULL, 
	MaKH CHAR(10),
	MaNV CHAR(10) NOT NULL,
	TongSoLuong_DH INT CHECK (TongSoLuong_DH>=0),
	PRIMARY KEY (MaDH),
	FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	FOREIGN KEY (MaPTTT) REFERENCES PhuongThucThanhToan(MaPTTT)
);

CREATE TABLE ChiTietDonHang 
(
	MaDH CHAR(10) NOT NULL,
	MaSach CHAR(10)  NOT NULL,
	DonGiaMua INT NOT NULL CHECK (DonGiaMua>=0),
	SoLuongMua INT NOT NULL CHECK (SoLuongMua>=0),
	ThanhTien_CTDH INT CHECK (ThanhTien_CTDH>=0),
	PRIMARY KEY (MaSach, MaDH),  
	FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
	FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH)
);

CREATE TABLE PhieuNhap
(
	MaPN CHAR(10) NOT NULL,
	NgayNhap DATE NOT NULL,
	TongTien_PN INT CHECK (TongTien_PN>=0),
	MaNXB CHAR(10) NOT NULL,
	MaNV CHAR(10) NOT NULL,
	TongSoLuong_PN INT CHECK (TongSoLuong_PN>=0),
	PRIMARY KEY (MaPN),
	FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE ChiTietPhieuNhap
(
	MaPN CHAR(10) NOT NULL,
	MaSach CHAR(10) NOT NULL,
	SoLuongNhap INT NOT NULL CHECK (SoLuongNhap>=0),
	DonGiaNhap INT NOT NULL CHECK (DonGiaNhap>=0),
	ThanhTien_PN INT CHECK (ThanhTien_PN>=0),
	PRIMARY KEY (MaPN, MaSach),
	FOREIGN KEY (MaPN) REFERENCES PHIEUNHAP(MaPN),
	FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE Quyen(
    MaQuyen CHAR(10)PRIMARY KEY,
    TenQuyen NVARCHAR(100) NOT NULL,
);

CREATE TABLE LoaiNhanVien_Quyen(
    MaLoaiNV CHAR(10),
    MaQuyen CHAR(10),
	PRIMARY KEY (MaLoaiNV, MaQuyen),
	FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen),
	FOREIGN KEY (MaLoaiNV) REFERENCES LoaiNhanVien(MaLoaiNV)
);
GO
--Các thao tác sửa đổi dữ liệu khi cần thiết 
ALTER TABLE DonHang
ADD TongTienChietKhau INT CHECK(TongTienChieuKhau >=0);
GO


--Thao tác nhập liêu thông qua Stored procedure
--1.Thêm dữ liệu vào bảng TheLoai
CREATE PROC sp_ThemTheLoai
	@matheloai CHAR(10),
	@tentheloai NVARCHAR(100),
	@soluongsach_tl INT
AS
BEGIN
	INSERT INTO TheLoai
	VALUES (@matheloai, @tentheloai,@soluongsach_tl)
END

EXEC sp_ThemTheLoai 'TL001', N'Truyện ngắn', null
EXEC sp_ThemTheLoai 'TL002', N'Hồi ký', null
select * from TheLoai
GO

--2.Thêm dữ liệu vào bảng UuDai
create proc sp_ThemUuDai
	@maud Char(10),
	@tenud Nvarchar(100),
	@mota Nvarchar(200),
	@ngaybd date,
	@ngaykt date,
	@giamgia float
as
begin
	insert into UuDai
	values(@maud, @tenud, @mota, @ngaybd,@ngaykt, @giamgia)
end

exec sp_ThemUuDai'UD01',N'Sale cuối tháng', N'Sale cuối tháng 7','2023-7-25', '2023-7-31',0.05
exec sp_ThemUuDai'UD02',N'Xử lý hàng tồn ', N'Xử lý hàng tồn năm 2022','2023-8-5', '2023-8-20',0.1

select * from UuDai
GO

--3.Thêm dữ liệu vào bảng TacGia
CREATE PROC sp_ThemTacGia
	@matacgia CHAR(10),
	@tentacgia NVARCHAR(100),
	@tieusu_tg NVARCHAR(200),
	@ngaysinh_tg DATE
AS
BEGIN
	INSERT INTO TacGia
	VALUES (@matacgia, @tentacgia,@tieusu_tg, @ngaysinh_tg)
END

EXEC sp_ThemTacGia 'TG001'
, N'Nguyễn Nhật Ánh'
, N'Nguyễn Nhật Ánh là một nhà văn, nhà thơ, bình luận viên Việt Nam.
Ông được biết đến qua nhiều tác phẩm văn học về đề tài tuổi trẻ, 
các tác phẩm của ông rất được độc giả ưa chuộng và nhiều tác phẩm đã được chuyển thể thành phim.'
, '5/7/1955'
EXEC sp_ThemTacGia 'TG002'
, N'Hồ Chí Minh'
, N'Hồ Chí Minh, tên khai sinh là Nguyễn Sinh Cung, còn được biết với tên gọi Bác Hồ, là một nhà cách mạng và chính khách người Việt Nam.'
, '5/19/1890'

EXEC sp_ThemTacGia 'TG003'
, N'Dương Thụy'
, N'Dương Thụy là nhà văn nữ của Việt Nam, được biết đến qua những bài viết trên báo Hoa Học Trò và hiện nay là cây bút khá nổi bật trên văn đàn Việt Nam'
, '5/20/1980'
select * from TacGia
GO
--4.Thêm dữ liệu vào bảng NhaXuatBan 
CREATE PROC sp_ThemNXB
	@maNXB CHAR(10),
	@tenNXB NVARCHAR(100),
	@diachi_nxb NVARCHAR(200),
	@email_nxb NVARCHAR(100),
	@sodienthoai_nxb CHAR(11)
AS
BEGIN
	INSERT INTO NhaXuatBan
	VALUES (@maNXB, @tenNXB,@diachi_nxb, @email_nxb, @sodienthoai_nxb)
END
exec sp_ThemNXB 'NXB01',N'NXB Trẻ'
, N'161B Lý Chính Thắng, Phường Võ Thị Sáu, Quận 3 , TP. Hồ Chí Minh'
,'hopthubandoc@nxbtre.com.vn'
,'02839316289'
exec sp_ThemNXB 'NXB02',N'NXB Kim Đồng'
, N'Số 55 Quang Trung, Nguyễn Du, Hai Bà Trưng, Hà Nội'
,'cskh_online@nxbkimdong.com.vn'
,'1900571595'
exec sp_ThemNXB 'NXB03',N'NXB Giáo dục'
, N'Số 81 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội'
,'nxbgd@moet.edu.vn'
,'02438220801'
GO
--5.Thêm dữ liệu vào bảng Sach 
CREATE PROC sp_ThemSach
	@masach CHAR(10),
	@tensach NVARCHAR(100),
	@namxuatban INT,
	@giaban INT,
	@soluongton INT,
	@matheloai CHAR(10),
	@matacgia CHAR(10),
	@manxb CHAR(10), 
	@mauudai CHAR(10)
AS
BEGIN
	INSERT INTO Sach
	VALUES (@masach, @tensach,@namxuatban, @giaban, @soluongton, @matheloai, @matacgia, @manxb, @mauudai)
END

exec sp_ThemSach 'S0001',N'Nhật ký trong tù',2010,'100000',10, 'TL002', 'TG002', 'NXB01', null
exec sp_ThemSach 'S0002',N'Cô gái đến từ hôm quan',2019,'120000',15, 'TL001', 'TG001', 'NXB02', null
exec sp_ThemSach 'S0003',N'Mắc biếc',2020,'110000',20, 'TL001', 'TG001', 'NXB02', null
exec sp_ThemSach 'S0004',N'Tôi thấy hoa vàng trên cỏ xanh',2021,'150000',25, 'TL001', 'TG001', 'NXB03', null

GO

--6.Thêm dữ liệu vào bảng LoaiKH 
CREATE PROC sp_ThemLoaiKH
	@maloaikh CHAR(10),
	@tenloaikh NVARCHAR(100),
	@chietkhau FLOAT
AS
BEGIN
	INSERT INTO LoaiKH
	VALUES (@maloaikh, @tenloaikh,@chietkhau)
END

exec sp_ThemLoaiKH 'LKH01',N'VIP',0.15
exec sp_ThemLoaiKH 'LKH02',N'Thân thiết',0.1
exec sp_ThemLoaiKH 'LKH03',N'Thành viên',0.05
GO

--7.Thêm dữ liệu vào bảng KhachHang 
CREATE PROC sp_ThemKhachHang
	@makh CHAR(10),
	@tenkh NVARCHAR(100),
	@sodienthoai_kh CHAR(11),
	@diachi_kh NVARCHAR(200),
	@email_kh NVARCHAR(100),
	@maloaikh CHAR(10), 
	@sotienmuahang INT
AS
BEGIN
	INSERT INTO KhachHang
	VALUES (@makh, @tenkh,@sodienthoai_kh, @diachi_kh, @email_kh, @maloaikh, @sotienmuahang)
END

exec sp_ThemKhachHang 'KH001',N'Nguyễn Văn A','0123456789'
, N'828 Sư Vạn Hạnh, Phường 13, Quận 10, TP. HCM'
,'contact@huflit.edu.vn', 'LKH03', null
exec sp_ThemKhachHang 'KH002',N'Lý Văn G','0123456799'
, N'Quốc lộ 22, xã Tân Xuân, huyện Hóc Môn, TP. HCM'
,'contact1@huflit.edu.vn', 'LKH03', null
GO

--8.Thêm dữ liệu vào bảng LoaiNhanVien 
CREATE PROC sp_ThemLoaiNV
	@maloainv CHAR(10),
	@tenloainv NVARCHAR(100),
	@soluongnv_lnv INT
AS
BEGIN
	INSERT INTO LoaiNhanVien
	VALUES (@maloainv, @tenloainv, @soluongnv_lnv)
END

exec sp_ThemLoaiNV 'LNV01',N'Nhân viên bán hàng', null
exec sp_ThemLoaiNV 'LNV02',N'Quản lý', null
exec sp_ThemLoaiNV 'LNV03',N'Thủ kho', null

GO
--9.Thêm dữ liệu vào bảng NhanVien 
ALTER PROC sp_ThemNhanVien
	@manv CHAR(10),
	@email_nv NVARCHAR(100),
	@matkhau_nv VARCHAR(50),
	@hoten_nv NVARCHAR(100),
	@diachi_nv NVARCHAR(200),
	@sodienthoai_nv CHAR(11),
	@gioitinh_nv BIT,
	@maloainv CHAR(10)
AS
BEGIN
	INSERT INTO NhanVien
	VALUES (@manv, @email_nv, @matkhau_nv,@hoten_nv,@diachi_nv,@sodienthoai_nv,@gioitinh_nv, @maloainv)
END

exec sp_ThemNhanVien 'NV001','tranvanb@gmail.com', '12345678', N'Trần Văn B', N'M4-M7-M9 Thất Sơn, Quận 10, TPHCM','0987654321',1, 'LNV02'
exec sp_ThemNhanVien 'NV002','lethic@gmail.com', '12345678', N'Lê Thị C', N'298-304 Cao Thắng, Quận 10, TPHCM','0989876541',0, 'LNV01'
exec sp_ThemNhanVien 'NV003','huynhthid@gmail.com', '12345679', N'Huỳnh Thị D', N'Cơ sở 357 Lê Hồng Phong, Quận 10, TPHCM','0989876341',0, 'LNV03'
exec sp_ThemNhanVien 'NV004','nguyenvane@gmail.com', '12345675', N'Nguyễn Văn E', N'32 Trường Sơn, Quận Tân Bình, TPHCM','0989876541',1, 'LNV01'


select * from NhanVien
GO
--10.Thêm dữ liệu vào bảng PhuongThucThanhToan 
CREATE PROC sp_ThemPTTT
	@mapttt CHAR(10),
	@tenpttt NVARCHAR(30)
AS
BEGIN
	INSERT INTO PhuongThucThanhToan
	VALUES (@mapttt, @tenpttt)
END

exec sp_ThemPTTT 'PTTT1',N'Tiền mặt'
exec sp_ThemPTTT 'PTTT2',N'Thẻ ATM'
GO
--11.Thêm dữ liệu vào bảng DonHang 
ALTER PROC sp_ThemDonHang
	@madh CHAR(10),
	@ngaylapdh DATE,
	@mapttt CHAR(10),
	@tongtien_dh INT, 
	@tongsoluong_dh INT,
	@dahuy_hd BIT,
	@makh CHAR(10),
	@manv CHAR(10)
AS
BEGIN
	INSERT INTO DonHang 
	VALUES (@madh, @ngaylapdh, @mapttt, @tongtien_dh,@dahuy_hd, @makh, @manv,  @tongsoluong_dh)
END

exec sp_ThemDonHang 'DH0001','8/1/2023', 'PTTT1', null, null, 0, 'KH001', 'NV002'
exec sp_ThemDonHang 'DH0002','8/2/2023', 'PTTT1', null, NULL, 0 ,NULL,'NV002'
exec sp_ThemDonHang 'DH0003','8/2/2023', 'PTTT1', null, NULL, 0 ,'KH001','NV002'
exec sp_ThemDonHang 'DH0004','8/8/2023', 'PTTT1', null, NULL, 0 ,'KH002','NV002'
GO


--12.Thêm dữ liệu vào bảng ChiTietDonHang 
ALTER PROC sp_ThemChiTietDonHang
	@madh CHAR(10),
	@masach CHAR(10),
	@soluongmua INT
AS
BEGIN

	DECLARE @dongiamua INT, @thanhtien_CTDH INT 
	SELECT @dongiamua=GiaBan, @thanhtien_CTDH= @dongiamua*(1-GiamGia) * @soluongmua
	FROM Sach s, UuDai u
	WHERE s.MaUuDai=u.MaUuDai
	AND MaSach=@masach

	INSERT INTO ChiTietDonHang
	VALUES (@madh, @masach, @dongiamua, @soluongmua, @thanhtien_CTDH)
END

exec sp_ThemChiTietDonHang 'DH0001','S0001', 2 
exec sp_ThemChiTietDonHang 'DH0001','S0002', 3 
exec sp_ThemChiTietDonHang 'DH0001','S0003', 1 
exec sp_ThemChiTietDonHang 'DH0001','S0004', 10
exec sp_ThemChiTietDonHang 'DH0002','S0003', 2
exec sp_ThemChiTietDonHang 'DH0003','S0001', 1
exec sp_ThemChiTietDonHang 'DH0004','S0002', 15

select* from ChiTietDonHang
select* from Sach
GO
--13.Thêm dữ liệu vào bảng PhieuNhap 
ALTER PROC sp_ThemPhieuNhap
	@mapn CHAR(10),
	@ngaynhap DATE,
	@tongtiennhap INT, 
	@tongsoluong_pn INT,
	@manxb CHAR(10),
	@manv CHAR(10)
AS
BEGIN
	INSERT INTO PhieuNhap
	VALUES (@mapn, @ngaynhap, @tongtiennhap,@manxb, @manv,@tongsoluong_pn)
END

exec sp_ThemPhieuNhap 'PN001','7/1/2023', null, null, 'NXB01', 'NV003'
exec sp_ThemPhieuNhap 'PN002','7/2/2023', null, null, 'NXB01', 'NV003'

GO
--14.Thêm dữ liệu vào bảng ChiTietPhieuNhap 
ALTER PROC sp_ThemChiTietPhieuNhap
	@mapn CHAR(10),
	@masach CHAR(10),
	@soluongnhap INT,
	@dongianhap INT
AS
BEGIN
	DECLARE @thanhtien_CTPN INT 
	SELECT @thanhtien_CTPN= @dongianhap * @soluongnhap
	FROM Sach
	WHERE MaSach=@masach

	INSERT INTO ChiTietPhieuNhap
	VALUES (@mapn, @masach, @soluongnhap, @dongianhap, @thanhtien_CTPN)
END

exec sp_ThemChiTietPhieuNhap 'PN001','S0001', 50 , 90000
exec sp_ThemChiTietPhieuNhap 'PN001','S0002', 30 , 100000
exec sp_ThemChiTietPhieuNhap 'PN002','S0003', 20 , 95000

select* from ChiTietPhieuNhap
GO
--15.Thêm dữ liệu vào bảng Quyen 
CREATE PROC sp_ThemQuyen
	@maquyen CHAR(10),
	@tenquyen NVARCHAR(100)
AS
BEGIN
	INSERT INTO Quyen
	VALUES (@maquyen, @tenquyen)
END

exec sp_ThemQuyen 'Q01',N'Quản lý sách'
exec sp_ThemQuyen 'Q02',N'Quản lý đơn hàng'
exec sp_ThemQuyen 'Q03', N'Quản lý nhân viên'
GO

--16.Thêm dữ liệu vào bảng LoaiNV_Quyen 
CREATE PROC sp_ThemPhanQuyen
	@maloainv CHAR(10),
	@maquyen CHAR(10)
AS
BEGIN
	INSERT INTO LoaiNhanVien_Quyen
	VALUES (@maloainv, @maquyen)
END

exec sp_ThemPhanQuyen 'LNV01','Q02'
exec sp_ThemPhanQuyen 'LNV02','Q03'
exec sp_ThemPhanQuyen 'LNV03', 'Q01'
GO


--CÁC LỆNH PROC
--1. Tính tổng tiền, tổng số lượng cho đơn hàng 
ALTER PROC sp_tinh_tongtien_tongsoluong_dh
AS
BEGIN
	UPDATE DonHang
	SET TongTien_DH=(SELECT SUM(ThanhTien_CTDH)
					FROM ChiTietDonHang CTDH
					WHERE DonHang.MaDH=CTDH.MaDH)
	UPDATE DonHang
	SET TongSoLuong_DH =(SELECT SUM(SoLuongMua)
					FROM ChiTietDonHang CTDH
					WHERE DonHang.MaDH=CTDH.MaDH)
END

exec sp_tinh_tongtien_tongsoluong_dh

SELECT * FROM DonHang
GO
--2. Tính tổng tiền chiết khấu
ALTER PROC sp_tong_tienchietkhau_dh
AS
BEGIN
	DECLARE c_chietkhau CURSOR 
	SCROLL
	FOR
		SELECT MaDH FROM DonHang
	DECLARE @madh CHAR(10)

	OPEN c_chietkhau

	FETCH FIRST FROM c_chietkhau INTO @madh
	WHILE @@FETCH_STATUS=0
	BEGIN 
		print @madh

		DECLARE @tongtienchietkhau INT

		SELECT @tongtienchietkhau=SUM(TongTien_DH *ChietKhau)
		FROM DonHang DH, KhachHang KH, LoaiKH L
		WHERE DH.MaKH=KH.MaKH
		AND KH.MaLoaiKH=L.MaLoaiKH
		AND MaDH=@madh
 
		UPDATE DonHang
		SET TongTienChietKhau=@tongtienchietkhau
		WHERE MaDH=@madh
		FETCH NEXT FROM c_chietkhau INTO @madh
	END 

	CLOSE c_chietkhau
	DEALLOCATE c_chietkhau
END

exec sp_tong_tienchietkhau_dh

SELECT * FROM DonHang
GO
--3. Tính tổng tiền, tổng số lượng cho phiếu nhập 
CREATE PROC sp_tinh_tongtien_tongsoluong_pn
AS
BEGIN
	UPDATE PhieuNhap
	SET TongTien_PN=(SELECT SUM(ThanhTien_PN)
					FROM ChiTietPhieuNhap CTPN
					WHERE PhieuNhap.MaPN=CTPN.MaPN)
	UPDATE PhieuNhap
	SET TongSoLuong_PN =(SELECT SUM(SoLuongNhap)
					FROM ChiTietPhieuNhap CTPN
					WHERE PhieuNhap.MaPN=CTPN.MaPN)
END

exec sp_tinh_tongtien_tongsoluong_pn

SELECT * FROM PhieuNhap
GO

--4. Cập nhật giá bán sách 
CREATE PROC sp_capnhat_giaban
	@masach CHAR(10),
	@giaban INT 
AS
BEGIN
	UPDATE Sach
	SET GiaBan=@giaban
	where MaSach=@masach
END

exec sp_capnhat_giaban 'S0002', 110000

SELECT * FROM Sach
GO
--5. Cập nhật Số lượng sách theo thể loại 
CREATE PROC sp_capnhat_sach_thl
AS
BEGIN
	UPDATE TheLoai
	SET SoLuongSach_TL = (SELECT COUNT(*)
							FROM Sach
							WHERE Sach.MaTheLoai = TheLoai.MaTheLoai)

END

exec sp_capnhat_sach_thl

SELECT * FROM Sach
SELECT * FROM TheLoai
GO

--6. Cập nhật số lượng nhân viên theo loại nhân viên
CREATE PROC sp_capnhat_nv_lnv
AS
BEGIN
	UPDATE LoaiNhanVien
	SET SoLuongNV_LNV = (SELECT COUNT(*)
							FROM NhanVien
							WHERE NhanVien.MaLoaiNV = LoaiNhanVien.MaLoaiNV)

END

exec sp_capnhat_nv_lnv

SELECT * FROM NhanVien
SELECT * FROM LoaiNhanVien
GO

--7. tính tổng số tiền khách hàng đã mua
ALTER PROC sp_tongtienkhdamua
AS
BEGIN
	DECLARE c_KhachHang CURSOR 
	SCROLL
	FOR
		SELECT MAKH FROM KHACHHANG
	DECLARE @makh CHAR(10)

	OPEN c_KhachHang

	FETCH FIRST FROM c_KhachHang INTO @makh
	WHILE @@FETCH_STATUS=0
	BEGIN 
		print @makh

		DECLARE @tongsotiendamua int

		SELECT @tongsotiendamua=SUM(TongTien_DH-TongTienChietKhau)
		FROM DonHang
		WHERE MAKH=@makh
 
		UPDATE KHACHHANG
		SET SoTienMuaHang=@tongsotiendamua
		WHERE MAKH=@makh
		FETCH NEXT FROM c_KhachHang INTO @makh
	END 

	CLOSE c_KhachHang
	DEALLOCATE c_KhachHang
END

EXEC sp_tongtienkhdamua

SELECT * FROM KHACHHANG
GO
--8. Xuất ra thông tin các nhân viên theo giới tính
CREATE PROC nv_theo_gt
	@GioiTinh NVARCHAR(10)
AS
BEGIN
	 DECLARE @BitGioiTinh BIT

    IF @GioiTinh = N'Nam'
        SET @BitGioiTinh = 1;
    ELSE IF @GioiTinh = N'Nữ'
        SET @BitGioiTinh = 0;
    ELSE
        BEGIN
            PRINT 'Giới tính không hợp lệ. Hãy nhập "Nam" hoặc "Nữ".';
            RETURN;
        END

    SELECT *
    FROM NhanVien
    WHERE GioiTinh_NV = @BitGioiTinh;
END

EXEC nv_theo_gt N'Nữ'
GO
--9. Tính doanh thu theo ngày 
CREATE PROC doanhthu_theo_ngay
	@ngay DATE, 
	@tongdoanhthu INT output
AS
BEGIN
	SELECT @tongdoanhthu =SUM(TongTien_DH)
	FROM DonHang
	WHERE NgayLap_DH=@ngay
END

DECLARE @tongdoanhthutheongay INT
EXEC doanhthu_theo_ngay '8/2/2023', @tongdoanhthutheongay output
PRINT N'Tổng doanh thu trong ngày: '+ CAST(@tongdoanhthutheongay AS VARCHAR)
GO
--10. Tính doanh thu theo tháng
ALTER PROC doanhthu_theo_thang
	@thang INT, 
	@nam INT,
	@tongdoanhthu INT output
AS
BEGIN
	SELECT @tongdoanhthu =SUM(TongTien_DH)
	FROM DonHang
	WHERE MONTH(NgayLap_DH)= @thang
	AND YEAR(NgayLap_DH)=@nam
END

DECLARE @tongdoanhthutheothang INT
EXEC doanhthu_theo_thang 8, 2023,@tongdoanhthutheothang output
PRINT N'Tổng doanh thu trong tháng: '+ CAST(@tongdoanhthutheothang AS VARCHAR)
GO
--11. Cập nhật chương trình ưu đãi cho sách
CREATE PROC sp_capnhat_uudai_sach
	@masach CHAR(10),
	@mauudai CHAR(10) 
AS
BEGIN
	UPDATE Sach
	SET MaUuDai=@mauudai
	where MaSach=@masach
END

exec sp_capnhat_uudai_sach 'S0002', 'UD02'

SELECT * FROM Sach
GO

--12. Xóa nhân viên 
CREATE PROC sp_xoa_nv
	@manv CHAR(10)
AS
BEGIN
	DELETE FROM NhanVien
	WHERE MaNV=@manv
END

exec sp_xoa_nv 'NV004'

SELECT * FROM NhanVien
GO

--Các lệnh trigger 
--1. Khi thêm hoặc sửa dữ liệu cột NgayBatDau_UD và NgayKetThuc_UD thì kiểm tra là NgayBatDau_UD < NgayKetThuc_UD
create trigger trg_ThemSuaUuDai
on UuDai
for insert, update
as
begin  
	declare @ngaykt Date
	declare @ngaybd Date
	select @ngaybd=NgayBatDau_UD, @ngaykt =NgayKetThuc_UD
	from inserted
 
	If @ngaybd > @ngaykt
	Begin
	rollback transaction
	raiserror (N'Ngày kết thúc phải lớn hơn ngày bắt đầu', 16,1)
	end
end

exec sp_ThemUuDai'012',N'sale cuoi thang', null,'2023-06-14', '2023-4-15',0.1

go
--2. Khi thêm hoặc sửa dữ liệu cột SoDienThoai trong bảng NhaXuatBan thì kiểm tra định dạng số điện thoại
ALTER TRIGGER trg_SDT_NXB
ON NhaXuatBan
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE NOT (ISNUMERIC(SoDienThoai_NXB)=1 AND LEN(SoDienThoai_NXB) IN (10, 11)))
									  
	BEGIN
	    ROLLBACK TRANSACTION
        RAISERROR('Số điện thoại không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemNXB 'NXB05',N'NXB Phụ nữ Việt Nam'
, N'39 Hàng Chuối, Q. Hai Bà Trưng, Hà Nội'
,' truyenthongvaprnxbpn@gmail.com'
,'024397107b'

GO
--3. Khi thêm hoặc sửa dữ liệu cột Email trong bảng NhaXuatBan thì kiểm tra định dạng email
ALTER TRIGGER trg_email_nxb
ON NhaXuatBan
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS (SELECT * FROM inserted WHERE NOT Email_NXB LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%')
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Email không hợp lệ', 16, 1)
        RETURN
    END
END;
exec sp_ThemNXB 'NXB05',N'NXB Phụ nữ Việt Nam'
, N'39 Hàng Chuối, Q. Hai Bà Trưng, Hà Nội'
,' truyenthongvaprnxbpngmail.com'
,'024397107b'
GO
--4. Khi thêm hoặc sửa dữ liệu cột SoDienThoai trong bảng  KhachHang thì kiểm tra định dạng số điện thoại
CREATE TRIGGER trg_SDT_kh
ON KhachHang
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE NOT (ISNUMERIC(SoDT_KH)=1 AND LEN(SoDT_KH) IN (10, 11)))
									  
	BEGIN
	    ROLLBACK TRANSACTION
        RAISERROR('Số điện thoại không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemKhachHang 'KH002',N'Nguyễn Văn A','012345678b'
, N'828 Sư Vạn Hạnh, Phường 13, Quận 10, TP. HCM'
,'contact@huflit.edu.vn', 'LKH01', null

GO
--5. Khi thêm hoặc sửa dữ liệu cột Email trong bảng KhachHang thì kiểm tra định dạng email
CREATE TRIGGER trg_email_kh
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS (SELECT * FROM inserted WHERE NOT Email_KH LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%')
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Email không hợp lệ', 16, 1)
        RETURN
    END
END;
exec sp_ThemKhachHang 'KH002',N'Nguyễn Văn A','0123456789'
, N'828 Sư Vạn Hạnh, Phường 13, Quận 10, TP. HCM'
,'contacthuflit.edu.vn', 'LKH01', null
GO
--6. Khi thêm hoặc sửa dữ liệu cột SoDienThoai trong bảng  NhanVien thì kiểm tra định dạng số điện thoại
CREATE TRIGGER trg_SDT_nv
ON NhanVien
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE NOT (ISNUMERIC(SoDienThoai_NV)=1 AND LEN(SoDienThoai_NV) IN (10, 11)))
									  
	BEGIN
	    ROLLBACK TRANSACTION
        RAISERROR('Số điện thoại không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemNhanVien 'NV002','tranvana@gmail.com', '12345678', 'Trần Văn A', 'M4-M7-M9 Thất Sơn, Quận 10, TPHCM','098765432b', 1,'LNV02'

GO
--7. Khi thêm hoặc sửa dữ liệu cột Email trong bảng NhanVien thì kiểm tra định dạng email
CREATE TRIGGER trg_email_nv
ON NhanVien
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS (SELECT * FROM inserted WHERE NOT Email_NV LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%')
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Email không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemNhanVien 'NV002','tranvanb@gmailcom', '12345678', 'Trần Văn B', 'M4-M7-M9 Thất Sơn, Quận 10, TPHCM','0987654321',1, 'LNV02'

GO
--8. Khi thêm hoặc sửa mật khẩu dữ liệu cột MatKhau_NV thì kiểm tra là MatKhau_NV phải >= 6 ký tự 
CREATE TRIGGER trg_matkhau_nv
ON NhanVien
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @dodaimatkhaunv int
	SELECT @dodaimatkhaunv =LEN(MatKhau_NV)
	FROM inserted

    IF @dodaimatkhaunv<6
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Mật khẩu không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemNhanVien 'NV002','tranvanb@gmail.com', '12345', 'Trần Văn B', 'M4-M7-M9 Thất Sơn, Quận 10, TPHCM','0987654321', 1,'LNV02'

GO

--9.Khi thêm hoặc sửa dữ liệu cột GiaBan trong bảng Sach thì kiểm tra là GiaBan >=GiaNhap 
CREATE TRIGGER trg_giaban_sach
ON Sach
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @giaban int
	DECLARE @gianhap int

	SELECT @giaban = GiaBan,@gianhap = DonGiaNhap 
	FROM inserted i, ChiTietPhieuNhap c
	where i.MaSach=c.MaSach

    IF @giaban < @gianhap
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Giá bán không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_capnhat_giaban 'S0002', 90000

GO
--10. Khi thêm dữ liệu cột SoLuongMua trong bảng ChiTietDonHang thì kiểm tra là SoLuongMua <=SoLuongTon
CREATE TRIGGER trg_soluongmua_ctdh
ON ChiTietDonHang
FOR INSERT
AS
BEGIN
	DECLARE @soluongton int
	DECLARE @soluongmua int

	SELECT @soluongton = SoLuongTon, @soluongmua = SoLuongMua 
	FROM inserted i, Sach s
	where i.MaSach=s.MaSach

    IF @soluongton < @soluongmua
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Số lượng mua không hợp lệ', 16, 1)
        RETURN
    END
END;

exec sp_ThemChiTietDonHang 'DH0002','S0001', 100

select * from ChiTietDonHang
select * from Sach
GO

--11. Khi có đơn hàng mới thì cập nhật lại SoLuongTon của Sach
ALTER TRIGGER trg_cn_soluongton_sach
ON ChiTietDonHang
FOR INSERT
AS
BEGIN
		UPDATE Sach
		SET SoLuongTon=SoLuongTon-SoLuongMua
		FROM inserted i, Sach s
		where i.MaSach=s.MaSach
END;

exec sp_ThemChiTietDonHang 'DH0002','S0001', 4

select * from ChiTietDonHang
select * from Sach
select * from DonHang
GO

--12. Khi có nhập hàng mới thì cập nhật lại SoLuongTon của Sach
CREATE TRIGGER trg_cn_slt_nh 
ON ChiTietPhieuNhap
FOR INSERT
AS
BEGIN
	UPDATE Sach
	SET SoLuongTon=SoLuongTon+SoLuongNhap
	FROM inserted i, Sach s
	where i.MaSach=s.MaSach
END;

exec sp_ThemChiTietPhieuNhap 'PN002','S0001', 4,90000 

select * from ChiTietPhieuNhap
select * from Sach
GO

--13.Sau mỗi lần cập nhật, thực hiện kiểm tra lại số tiền mua hàng của mỗi khách hàng.
--•	Nếu khách hàng có tổng số tiền mua hàng từ 1.000.000 trở lên thì cập nhật loại khách hàng là TV
--•	Nếu khách hàng có tổng số tiền mua hàng từ 3.000.000 trở lên thì cập nhật loại khách hàng từ TV lên TT
--•	Nếu khách hàng có tổng số tiền mua hàng từ 5.000.000 trở lên thì cập nhật loại khách hàng từ TT lên VIP

CREATE TRIGGER trg_cn_lkh
ON KHACHHANG
FOR UPDATE 
AS
BEGIN
	DECLARE @sotienmuahangmoi INT, @makh CHAR(10)
	SELECT @sotienmuahangmoi=SoTienMuaHang, @makh=MAKH
	FROM inserted 

	IF @sotienmuahangmoi >=100000 AND @sotienmuahangmoi<3000000
	BEGIN 
		UPDATE KHACHHANG
		SET MaLoaiKH='LKH03'
		WHERE MaKH=@makh
	END

	IF @sotienmuahangmoi >=3000000 AND @sotienmuahangmoi<5000000
	BEGIN 
		UPDATE KHACHHANG
		SET MaLoaiKH='LKH02'
		WHERE MAKH=@makh
	END

	IF @sotienmuahangmoi >=5000000 
	BEGIN 
		UPDATE KHACHHANG
		SET MaLoaiKH='LKH01'
		WHERE MAKH=@makh
	END
END 

EXEC sp_tongtienkhdamua

SELECT * FROM DonHang
SELECT * FROM LoaiKH
SELECT * FROM KhachHang
GO

--14. Khi xóa nhân viên thì cập nhật lại số lượng nhân viên trong Loại nhân viên
ALTER TRIGGER trg_cn_sl_lnv
ON NhanVien
FOR INSERT, DELETE
AS
BEGIN
	UPDATE LoaiNhanVien
	SET SoLuongNV_LNV = (SELECT COUNT(*)
							FROM NhanVien
							WHERE NhanVien.MaLoaiNV = LoaiNhanVien.MaLoaiNV)	
END;

exec sp_xoa_nv 'NV004'

select * from LoaiNhanVien
select* from NhanVien
select * from ChiTietPhieuNhap
select * from Sach
GO
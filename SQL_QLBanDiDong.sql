go
create database QLTHEGIOIDIDONG
go
use QLTHEGIOIDIDONG
set dateformat dmy
--drop database QLTHEGIOIDIDONG

--tao bang NHANVIEN
go
create table NHANVIEN(
MaNV char(11) not null,
HotenNV nvarchar(20) not null,
NgaySinh datetime,
DiaChiNV nvarchar(50),
EmailNV nvarchar(50),
GioiTinh nvarchar(5),
SDTNV int,
ChucVu nvarchar(30)
)


--tao bang hoa don (ok)
go
create table HOADON(MaHD char(11) not null,
MaKH char(11)not null,
NgayLap datetime,
MaNVLapHD char(11))


go
create table CTHD(MaHD char(11) not null,
MaSP char(11) not null,
SoLuong int,
TongTien float)

--tao bang khach hang
go
create table KHACHHANG(
MaKH char(11) not null ,
TenKH nvarchar(10)not null,
SDTKH nvarchar(12)not null,
CCCDKH nvarchar(12) not null,
DiaChiKH nvarchar(30)not null
)

--tao bang mat hang 
go
create table SANPHAM(MaSP char(11) not null,	
	MaLoai char(11) not null,
	TenSP nvarchar(30),
	XuatXu nvarchar(30),
	GiaNhap int,
	GiaBan int,
	SoLuong int,
	NgayNH date,
	GhiChu nvarchar(50))

--tao bang loai sp(ok)
go
Create table LOAISP(MaLoai char(11) primary key not null, 
TenLoai nvarchar(30))

--tao bang tinh luong
go
create table TINHLUONG(
MaNV char(11) not null ,
TenNV nvarchar(20),
SoNC int default 24,
Thuong int default 0,
Luong int default 4800000
)


--tao bang kho hang (ok)
go
create table KHOHANG(MaKho char(11)not null
,TenKho nvarchar(30)not null,
MaSP char(11)not null,
SL int,
DiaChi nvarchar(60))


--tao bang chi nhanh (ok)
create table CHINHANH(MaCN char(11)not null,
MaNV char(11)not null,
DiaChi nvarchar(60))


---Tạo bảng Đăng nhập
CREATE TABLE DangNhap
(
    [username] NVARCHAR(50) NOT NULL,
    [password] NVARCHAR(50) NOT NULL,
	Primary Key([username],[password])
)
---Tạo bảng Đăng ký
CREATE TABLE DangKy
(
    [username] NVARCHAR(50) NOT NULL,
    [password] NVARCHAR(50) NOT NULL,
	[PasswordAgain] NVARCHAR(50) NULL,
	Primary Key([username],[password])
)

--them cac rang buoc toan ven
--them khoa chinh----------------------------------------------------------------------------------

--Them khoa chinh NHANVIEN
alter table NHANVIEN
add constraint pk_nhanvien primary key(MaNV)

--them khoa chinh HOADON
alter table HOADON
add constraint pk_hoadon primary key(MaHD)

--them khoa chinh CTHD
alter table CTHD
add constraint pk_cthd primary key(MaHD,MaSP)

--them khoa chinh KHACHHANG
alter table KHACHHANG
add constraint pk_khachhang primary key(MaKH)

--them khoa chinh SANPHAM
alter table SANPHAM
add constraint pk_sanpham primary key(MaSP)

--them khoa chinh TINHLUONG
alter table TINHLUONG
add constraint pk_tinhluong primary key(MaNV)

--Them khoa chinh KHOHANG
alter table KHOHANG
add constraint pk_khohang primary key(MaKho)

--Them khoa chinh CHINHANH
alter table CHINHANH
add constraint pk_chinhanh primary key(MACN)


--rang buoc khoa ngoai--------------------------------------------------------------------------------
--them khoa ngoai HOADON
go
alter table HOADON
add constraint pk_nv_hd foreign key(MaNVLapHD) references NHANVIEN(MaNV)
go
alter table HOADON
add constraint pk_kh_hd foreign key(MaKH) references KHACHHANG(MaKH)

--them khoa ngoai CTHD
go
alter table CTHD
add constraint fk_sp_cthd foreign key(MaSP) references SANPHAM(MaSP)
go
alter table CTHD
add constraint fk_hd_cthd foreign key(MaHD) references HOADON(MaHD)

--Them khoa ngoai SANPHAM
go
alter table SANPHAM
add constraint pk_loai_sp foreign key(MaLoai) references LOAISP(MaLoai)

--them khoa ngoai TINHLUONG
go
alter table TINHLUONG
add constraint pf_nv_tl foreign key(MaNV) references NHANVIEN(MaNV)

--them khoa ngoai KHOHANG
go
alter table KHOHANG
add constraint pf_sp_kho foreign key(MaSP) references SANPHAM(MaSP)

--them khoa ngoai CHINHANH
go
alter table CHINHANH
add constraint pf_nv_cn foreign key(MaNV) references NHANVIEN(MaNV)

--them khoa ngoai DangNhap
go
alter table DangNhap
add constraint RB_DN_DK_User foreign key ([username],[password]) references DangKy([username],[password])



--TẠO CÁC STORE
--Thủ tục thêm mới
go
create proc sp_KHO(@MaKho char(11),@TenKho nvarchar(30),@MaSP char(11),@SL int,@DiaChi nvarchar(60))
as 
	insert into KHOHANG(MaKho,TenKho,MaSP,SL,DiaChi)
	values (@MaKho,@TenKho,@MaSP,@SL,@DiaChi)

go
create proc sp_ChiNhanh(@MaCN char(11),@MaNV char(11),@DiaChi nvarchar(60))
as 
	insert into CHINHANH(MaCN,MaNV,DiaChi)
	values (@MaCN,@MaNV,@DiaChi)

go
create proc sp_HoaDon(@MaHD char(11),@MaKH char(11),@NgayLap datetime,@MaNVLapHD char(11))
as 
	insert into HOADON(MaHD,MaKH,NgayLap,MaNVLapHD)
	values (@MaHD,@MaKH,@NgayLap,@MaNVLapHD)

go
create proc sp_CTHD(@MaHD char(11),@MaSP char(11),@SoLuong int,@TongTien float)
as 
	insert into CTHD(MaHD,MaSP,SoLuong,TongTien)
	values (@MaHD,@MaSP,@SoLuong,@TongTien)

go
create proc sp_NHANVIEN(@MaNV char(11),@HotenNV nvarchar(20),@NgaySinh datetime,@DiaChiNV nvarchar(50),@EmailNV nvarchar(50),@GioiTinh nvarchar(5),@SDTNV int,@ChucVu nvarchar(30))
as 
	insert into NHANVIEN(MaNV,HotenNV,NgaySinh,DiaChiNV,EmailNV,GioiTinh,SDTNV,ChucVu)
	values (@MaNV,@HotenNV,@NgaySinh,@DiaChiNV,@EmailNV,@GioiTinh,@SDTNV,@ChucVu)

go
create proc sp_LOAISP(@MaLoai char(11), @TenLoai nvarchar(30))
as 
	insert into LOAISP(MaLoai, TenLoai)
	values (@MaLoai,@TenLoai)

go
create proc sp_SANPHAM(@MaSP char(11),@MaLoai char(11),@TenSP nvarchar(30),@XuatXu nvarchar(30),@GiaNhap int,@GiaBan int,@SoLuong int,@NgayNH date,@GhiChu nvarchar(50))
as 
	insert into SANPHAM(MaSP,MaLoai,TenSP,XuatXu,GiaNhap,GiaBan,SoLuong,NgayNH,GhiChu)
	values (@MaSP,@MaLoai,@TenSP,@XuatXu,@GiaNhap,@GiaBan,@SoLuong,@NgayNH,@GhiChu)

go
create proc sp_TINHLUONG(@MaNV char(11),@SoNC int,@Thuong int)
as 
	insert into TINHLUONG(MaNV,SoNC,Thuong)
	values (@MaNV,@SoNC,@Thuong)

go
create proc sp_KHACHHANG(@MaKH char(11),@TenKH nvarchar(10),@SDTKH nvarchar(12),@CCCDKH nvarchar (12),@DiaChiKH nvarchar (30))
as 
	insert into KHACHHANG(MaKH,TenKH,SDTKH,CCCDKH,DiaChiKH)
	values (@MaKH,@TenKH,@SDTKH,@CCCDKH,@DiaChiKH)


--Thủ tục xóa 
go
Create proc sp_XoaKho(@MaKho char(11))
as
begin
Delete from KHOHANG where MaKho = @MaKho
end

go
Create proc sp_XoaChiNhanh(@MaCN char(11))
as
begin
Delete from CHINHANH where MaCN = @MaCN
end

go
Create proc sp_XoaHD(@MaHD char(11))
as
begin
Delete from HOADON where MaHD = @MaHD
end

go
Create proc sp_XoaCTHD(@MaHD char(11),@MaSP char(11))
as
begin
Delete from CTHD where MaHD=@MaHD and MaSP=@MaSP
end

go
Create proc sp_XoaNV(@MaNV char(11))
as
begin
Delete from NHANVIEN where MaNV = @MaNV
end

go
Create proc sp_XoaKH(@MaKH char(11))
as
begin
Delete from KHACHHANG where MaKH = @MaKH
end

go
Create proc sp_XoaTL(@MaNV char(11))
as
begin
Delete from TINHLUONG where MaNV = @MaNV
end

go
Create proc sp_XoaLoai(@MaLoai char(11))
as
begin
Delete from LOAISP where MaLoai = @MaLoai
end

go
Create proc sp_XoaSP(@MaSP char(11))
as
begin
Delete from SANPHAM where MaSP = @MaSP
end

go 
--Thủ tục sửa 
Create proc sp_SuaKho(@MaKho char(11),@TenKho nvarchar(30),@MaSP char(11),@SL int,@DiaChi nvarchar(60))
as
begin
Update KHOHANG set TenKho = @TenKho, MaSP=@MaSP,SL=@SL,DiaChi=@DiaChi where MaKho = @MaKho
end

go
Create proc sp_SuaChiNhanh(@MaCN char(11),@MaNV char(11),@DiaChi nvarchar(60))
as
begin
Update CHINHANH set MaNV=@MaNV,DiaChi=@DiaChi where MaCN = @MaCN
end

go
Create proc sp_SuaHD(@MaHD char(11),@MaKH char(11),@NgayLap datetime,@MaNVLapHD char(11))
as
begin
Update HOADON set MaKH=@MaKH,NgayLap=@NgayLap,MaNVLapHD=@MaNVLapHD where MaHD = @MaHD
end

go
Create proc sp_SuaCTHD(@MaHD char(11),@MaSP char(11),@SoLuong int,@TongTien float)
as
begin
Update CTHD set SoLuong=@SoLuong,TongTien=@TongTien where MaHD = @MaHD and MaSP=@MaSP
end

go
Create proc sp_SuaNV(@MaNV char(11),@HotenNV nvarchar(20),@NgaySinh datetime,@DiaChiNV nvarchar(50),@EmailNV nvarchar(50),@GioiTinh nvarchar(5),@SDTNV int,@ChucVu nvarchar(30))
as
begin
Update NHANVIEN set HotenNV=@HotenNV,NgaySinh=@NgaySinh,DiaChiNV=@DiaChiNV,EmailNV=@EmailNV,GioiTinh=@GioiTinh,SDTNV=@SDTNV,ChucVu=@ChucVu where MaNV=@MaNV
end

go
Create proc sp_SuaKH(@MaKH char(11),@TenKH nvarchar(20),@SDTKH int,@CCCDKH nvarchar(12), @DiaChiKH nvarchar(30))
as
begin
Update KHACHHANG set TenKH=@TenKH,SDTKH=@SDTKH,CCCDKH=@CCCDKH,DiaChiKH=@DiaChiKH where MaKH=@MaKH
end

go
Create proc sp_SuaNTL(@MaNV char(11),@TenNV nvarchar(20))
as
begin
Update TINHLUONG set TenNV = @TenNV where MaNV=@MaNV
end

go
Create proc sp_SuaTL(@MaNV char(11),@SoNC int,@Thuong int)
as
begin
Update TINHLUONG set SoNC=@SoNC,Thuong=@Thuong where MaNV=@MaNV
end

go
Create proc sp_SuaSP(@MaSP char(11),@MaLoai char(11),@TenSP nvarchar(30),@XuatXu nvarchar(30),@GiaNhap int,@GiaBan int,@SoLuong int,@NgayNH date,@GhiChu nvarchar(50))
as
begin
Update SANPHAM set MaLoai=@MaLoai,TenSP=@TenSP,XuatXu=@XuatXu,GiaNhap=@GiaNhap,GiaBan=@GiaBan,SoLuong=@SoLuong,NgayNH=@NgayNH,GhiChu=@GhiChu where MaSP=@MaSP
end

go
Create proc sp_SuaLoai(@MaLoai char(11), @TenLoai nvarchar(30))
as
begin
Update LOAISP set TenLoai=@MaLoai where MaLoai=@MaLoai
end

go
--Lay danh sach kho
create proc sp_LayDSKho
as
	select * from KHOHANG
go
--Lay danh sach sinh vien
create proc sp_LayDSChiNhanh
as
	select * from CHINHANH
go
--Lay danh sach Hoa Don
create proc sp_LayDSHD
as
	select * from HOADON
go
--Lay danh sach Ket Qua
create proc sp_LayDSCTHD
as
	select * from CTHD
go
--Lay danh sach khach hang
create proc sp_LayDSKH
as
	select * from KHACHHANG
go
--Lay danh sach nhan vien
create proc sp_LayDSNV
as
	select * from NHANVIEN
go
--Lay danh sach tinh luong
create proc sp_LayDSTL
as
	select * from TINHLUONG
go
--Lay danh sach loai sp
create proc sp_LayDSLoai
as
	select * from LOAISP
go
--Lay danh sach sp
create proc sp_LayDSSP
as
	select * from SANPHAM
go


create proc sp_laytensp(@ma char(11))
as 
	select TenSP
	from SANPHAM
	where MaSP = @ma

go

create proc sp_laytenNV(@ma char(11))
as 
	select HotenNV
	from NHANVIEN
	where MaNV = @ma

go
create proc sp_laycthd(@ma char(11))
as 
select MaSP 
from CTHD 
where MaHD=@ma

--Tìm kiếm 
go
CREATE proc sp_TimKiemNhanVien(@maNV char(11))
AS
BEGIN
    SELECT * FROM NhanVien
    WHERE MaNV = @maNV
END
go

CREATE proc sp_TimKiemTheoNhanVien(@tenNV nvarchar(20))
AS
BEGIN
    SELECT * FROM NhanVien
   WHERE HotenNV LIKE N'%' + @tenNV + N'%'
END
go

CREATE proc sp_TimKiemTheoMaKH(@maKH char(11))
AS
BEGIN
    SELECT * FROM KHACHHANG
    WHERE MaKH = @maKH
END
go

CREATE proc sp_TimKiemTheoTenKH(@tenKH nvarchar(20))
AS
BEGIN
    SELECT * FROM KHACHHANG
   WHERE TenKH LIKE N'%' + @tenKH + N'%'
END
go

--them du lieu

--them du lieu nhan vien

--them du lieu nhan vien
exec sp_NHANVIEN 'NV01',N'Nguyễn Văn An','01/01/1997',N'TP HCM','nv01@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV02',N'Nguyễn Thị Thi','02/01/1993',N'TP Hà Nội','nv02@mail.com',N'Nữ',0998765432,N'nhân viên'
exec sp_NHANVIEN 'NV03',N'Lê Văn Bi','03/01/2000',N'TP HCM','nv03@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV04',N'Đặng Văn Vở','04/01/1999',N'TP HCM','nv04@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'QL01',N'Nguyễn Thị Dở','05/01/2002',N'TP HCM','ql01@mail.com',N'Nữ',0912345678,N'quản lý'
exec sp_NHANVIEN 'QL02',N'Nguyễn Văn Em','06/01/1999',N'TP Hải Phòng','ql02@mail.com',N'Nam',0912345678,N'quản lý'
exec sp_NHANVIEN 'NV05',N'Vũ Thị Thanh','07/01/1999',N'TP HCM','nv05@mail.com',N'Nữ',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV06',N'Chu Văn An','08/01/1999',N'TP HCM','nv06@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV07',N'Nguyễn Thị Hung','09/01/2001',N'TP HCM','nv07@mail.com',N'Nữ',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV08',N'Nguyễn Văn Nhi','10/01/1992',N'TP HCM','nv08@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV09',N'Nguyễn Thị Minh','11/01/1998',N'TP HCM','nv09@mail.com',N'Nữ',0912345678,N'nhân viên'
exec sp_NHANVIEN 'QL03',N'Nguyễn Văn Khang','12/01/1996',N'TP Hà Nội','ql03@mail.com',N'Nam',0912345678,N'quản lý'
exec sp_NHANVIEN 'QL04',N'Nguyễn Thị Lam','13/01/1997',N'TP Hồ Chí Minh','ql04@mail.com',N'Nữ',0912345678,N'quản lý'
exec sp_NHANVIEN 'NV10',N'Nguyễn Văn Mú','14/01/1995',N'TP HCM','nv10@mail.com',N'Nam',0912345678,N'nhân viên'
exec sp_NHANVIEN 'NV11',N'Nguyễn Thị N','15/01/1994',N'TP HCM','nv11@mail.com',N'Nữ',0912345678,N'nhân viên'
EXEC sp_NHANVIEN 'NV12', N'Võ Thị G', '07/09/1998', N'TP Hà Nội', 'nv12@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV13', N'Lý Thị H', '08/10/1999', N'TP HCM', 'nv13@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV14', N'Đỗ Thị I', '09/11/1991', N'TP HCM', 'nv14@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV15', N'Nguyễn Thị K', '10/12/1993', N'TP HCM', 'nv15@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV16', N'Phạm Thị L', '11/01/1995', N'TP Hà Nội', 'nv16@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV17', N'Huỳnh Thị M', '12/02/1997', N'TP HCM', 'nv17@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV18', N'Lê Thị N', '01/03/1999', N'TP HCM', 'nv18@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV19', N'Võ Thị P', '02/04/1991', N'TP HCM', 'nv19@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'NV20', N'Nguyễn Thị Q', '03/05/1993', N'TP Hà Nội', 'nv20@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD01', N'Đỗ Thị R', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD02', N'Đỗ Thị Hằng', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD04', N'Đỗ Thanh Thảo', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD03', N'Lê Minh Châu', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD06', N'Vũ Văn Vọng', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
EXEC sp_NHANVIEN 'GD07', N'Đào Vĩnh Tường', '04/06/1995', N'TP HCM', 'nv21@mail.com', N'Nữ', '0912345678', N'nhân viên'
go
select * from NHANVIEN


--them du lieu chi nhanh
exec sp_ChiNhanh 'CN01','QL01',N'TP HCM'
exec sp_ChiNhanh 'CN02','QL02',N'TP Hải Phòng'
go
select * from CHINHANH


--them du lieu khach hang
exec sp_KHACHHANG 'KH01',N'Võ Văn An','0123456789','012345678912',N'Thành Phố Hồ Chí Minh'
exec sp_KHACHHANG 'KH02',N'Đặng Văn Bi','0923123456','000123456789',N'Thủ Đức'
exec sp_KHACHHANG 'KH03',N'Đoàn Bích Chi','0123456789','000123456789',N'Hà Nội'
EXEC sp_KHACHHANG 'KH04', N'Trần Thị Anh', '0123456789', '000123456789', N'Hải Phòng'
EXEC sp_KHACHHANG 'KH05', N'Nguyễn Thị Bình', '0123456789', '000123456789', N'Hưng Yên'
EXEC sp_KHACHHANG 'KH06', N'Lê Thị Cúc', '0123456789', '000123456789', N'Bình Dương'
EXEC sp_KHACHHANG 'KH07', N'Phạm Thị Dung', '0123456789', '000123456789', N'Đồng Nai'
EXEC sp_KHACHHANG 'KH08', N'Vũ Thị Hoa', '0123456789', '000123456789', N'Đà Nẵng'
EXEC sp_KHACHHANG 'KH09', N'Nguyễn Thị Hương', '0123456789', '000123456789', N'Hải Dương'
EXEC sp_KHACHHANG 'KH10', N'Hoàng Thị Lan', '0123456789', '000123456789', N'Nghệ An'
EXEC sp_KHACHHANG 'KH11', N'Trương Thị Linh', '0123456789', '000123456789', N'Hải Phòng'
EXEC sp_KHACHHANG 'KH12', N'Lý Thị Mỹ', '0123456789', '000123456789', N'Hưng Yên'
EXEC sp_KHACHHANG 'KH13', N'Đặng Thị Ngọc', '0123456789', '000123456789', N'Bình Dương'
EXEC sp_KHACHHANG 'KH14', N'Nguyễn Thị Phương', '0123456789', '000123456789', N'Đồng Nai'
EXEC sp_KHACHHANG 'KH15', N'Lê Thị Quỳnh', '0123456789', '000123456789', N'Đà Nẵng'
EXEC sp_KHACHHANG 'KH16', N'Phạm Thị Sang', '0123456789', '000123456789', N'Hải Dương'
EXEC sp_KHACHHANG 'KH17', N'Vũ Thị Tâm', '0123456789', '000123456789', N'Nghệ An'
EXEC sp_KHACHHANG 'KH18', N'Nguyễn Thị Uyên', '0123456789', '000123456789', N'Hải Phòng'
EXEC sp_KHACHHANG 'KH19', N'Trần Thị Vân', '0123456789', '000123456789', N'Hưng Yên'
EXEC sp_KHACHHANG 'KH20', N'Lý Thị Xuân', '0123456789', '000123456789', N'Bình Dương'
EXEC sp_KHACHHANG 'KH21', N'Đặng Thị Yến', '0123456789', '000123456789', N'Đồng Nai'
EXEC sp_KHACHHANG 'KH22', N'Nguyễn Thị Zung', '0123456789', '000123456789', N'Đà Nẵng'
EXEC sp_KHACHHANG 'KH23', N'Lê Thị Ánh', '0123456789', '000123456789', N'Hải Dương'
EXEC sp_KHACHHANG 'KH24', N'Phạm Thị Bích', '0123456789', '000123456789', N'Nghệ An'
EXEC sp_KHACHHANG 'KH25', N'Vũ Thị Cẩm', '0123456789', '000123456789', N'Hải Phòng'
EXEC sp_KHACHHANG 'KH26', N'Nguyễn Thị Đan', '0123456789', '000123456789', N'Hưng Yên'
EXEC sp_KHACHHANG 'KH27', N'Trần Thị Eo', '0123456789', '000123456789',N'Ninh Bình'
EXEC sp_KHACHHANG 'KH28', N'Lê Thị Gấm', '0123456789', '000123456789', N'Bình Dương'
EXEC sp_KHACHHANG 'KH29', N'Phạm Thị Hân', '0123456789', '000123456789', N'Đồng Nai'
EXEC sp_KHACHHANG 'KH30', N'Vũ Thị Ích', '0123456789', '000123456789', N'Đà Nẵng'
go
select * from KHACHHANG


--them loai san pham
exec sp_LOAISP 'L01',N'Điện thoại'
exec sp_LOAISP 'L02',N'Laptop'
exec sp_LOAISP 'L03',N'Ipad'
exec sp_LOAISP 'L04',N'Phụ kiện'
go
select * from LOAISP


--them san pham
exec sp_SANPHAM 'SP01','L01',N'Iphone',N'Mỹ',100,200,10,'01/01/2023',''
exec sp_SANPHAM 'SP02','L01',N'Samsung',N'Anh',300,400,20,'01/01/2023',''
exec sp_SANPHAM 'SP03','L01',N'Redmi',N'Mỹ',150,200,30,'01/01/2023',''
exec sp_SANPHAM 'SP04','L02',N'Dell',N'Pháp',160,200,40,'01/01/2023',''
exec sp_SANPHAM 'SP05','L03',N'Apple',N'Mỹ',170,200,10,'01/01/2023',''
go
select * from SANPHAM


--them kho hang
exec sp_KHO 'K01',N'Kho hàng 1','SP01',10,N'Tp HCM'
exec sp_KHO 'K02',N'Kho hàng 2','SP01',20,N'Tp HCM'
exec sp_KHO 'K03',N'Kho hàng 3','SP01',5,N'Tp Hà Nội'
go
select * from KHOHANG


--them hoa don
exec sp_HoaDon 'HD01','KH01','01/01/2023','NV01'
exec sp_HoaDon 'HD02','KH02','02/01/2023','NV01'
exec sp_HoaDon 'HD03','KH03','03/01/2023','NV02'
go
select * from HOADON

--them chi tiet hoa don
exec sp_CTHD 'HD01','SP01',1,1500000
exec sp_CTHD 'HD01','SP02',1,2000000
exec sp_CTHD 'HD02','SP01',1,1500000
go
select * from CTHD


INSERT INTO TINHLUONG (MaNV, TenNV)
SELECT MaNV, HotenNV
FROM NHANVIEN;
select * from TINHLUONG



--tạo store report
--report DS chi nhanh
go
create proc sp_DSChiNhanh
as 
	select cn.MaCN, cn.MaNV,nv.HotenNV,cn.DiaChi
	from NHANVIEN nv,CHINHANH cn
	where cn.MaNV=nv.MaNV
	
go
create proc sp_lay1ChiNhanh(@ma char(11))
as 
select cn.MaCN, cn.MaNV,nv.HotenNV,cn.DiaChi
from CHINHANH cn,NHANVIEN nv 
where cn.MaCN=@ma and cn.MaNV=nv.MaNV

--report DS kho hang
go
create proc sp_DSKhoHang
as 
	select kho.MaKho,kho.TenKho,kho.MaSP,sp.TenSP,kho.SL,kho.DiaChi
	from KHOHANG kho,SANPHAM sp
	where kho.MaSP=sp.MaSP

go
create proc sp_lay1KhoHang(@ma char(11))
as 
select kho.MaKho,kho.TenKho,kho.MaSP,sp.TenSP,kho.SL,kho.DiaChi
from KHOHANG kho,SANPHAM sp 
where kho.MaKho=@ma and kho.MaSP=sp.MaSP

--report DS hoa don
go
create proc sp_DSHoaDon
as 
	select hd.MaHD,ct.MaSP,ct.SoLuong,ct.TongTien,hd.NgayLap,hd.MaNVLapHD
	from HOADON hd,CTHD ct
	where hd.MaHD=ct.MaHD

go
create proc sp_lay1HoaDon(@ma char(11))
as 
select hd.MaHD,ct.MaSP,ct.SoLuong,ct.TongTien,hd.NgayLap,hd.MaNVLapHD
from HOADON hd,CTHD ct
where hd.MaHD=@ma and hd.MaHD=ct.MaHD
drop database QLNS

create database QLNS
go

use QLNS
set dateformat DMY
go

create table CHITIETHOADON
(
	MAHOADON char(7) not null,
	MASACH char(7),
	SOLUONG int,
	GIATIEN int,
	THANHTIEN int
)
go
select * from CHITIETHOADON
insert into CHITIETHOADON
values
('HD01','S01',20,60000,1200000),
('HD02','S01',6,3000,18000),
('HD03','S05',30,150000,45000000),
('HD04','S02',15,12000,180000),
('HD05','S03',2,60000,120000)
create table HOADON
(
	MAHOADON char(7) primary key not null,
	TENKHACHHANG nvarchar(50),
	NGAYLAP datetime,
	TONGTIEN decimal(10, 2) 
)
insert into HOADON
values
('HD01',N'Lê Hữu Đán','10-10-2018',1200000),
('HD02',N'Hà Phú Quý','11-08-2018',18000),
('HD03',N'Lê Nhật Minh','01-11-2017',45000000),
('HD04',N'Lâm Anh Tú','23-02-2019',180000),
('HD05',N'A Nguyễn Hoàng Phúc','10-12-2020',120000)
go
Select * From HOADON
Select SUM(TONGTIEN) AS [DOANH THU] From HOADON
Select CHITIETHOADON.MASACH, TENSACH, SUM(SOLUONG) AS [SỐ LƯỢNG BÁN RA], GIAMUA, GIABIA From CHITIETHOADON RIGHT JOIN SACH 
ON CHITIETHOADON.MASACH = SACH.MASACH Group By CHITIETHOADON.MASACH, SACH.TENSACH, GIAMUA, GIABIA


create table KHO
(
	MASACH char(7) primary key not null,
	SOLUONG int
)
insert into KHO
values
('S01',100),
('S02',240),
('S03',5000),
('S04',200),
('S05',10)
go
Select * From KHO

create table LINHVUC
(
	TENLINHVUC nvarchar(30) primary key not null
)
insert into LINHVUC
values
(N'Học'),
(N'Đời sống'),
(N'Trinh thám'),
(N'Khoa học'),
(N'Từ điển')
go
Select * from LINHVUC

create table LOAISACH
(
	TENLOAISACH nvarchar(30) primary key not null
)
insert into LOAISACH
values
(N'Tâm linh & tiểu thuyết'),
(N'Tiểu thuyết'),
(N'Truyện'),
(N'Tâm linh ')
go
Select * from LOAISACH

create table NHAXUATBAN
(
	TENNHAXUATBAN nvarchar(50) primary key not null
)
insert into NHAXUATBAN
values
(N'NXB Trẻ'),
(N'NXB Tổng hợp TPHCM'),
(N'NXB Tri thức'),
(N'NXB Hồng Đức'),
(N'NXB Văn học')
go
Select * from NHAXUATBAN

create table SACH
(
	MASACH char(7) primary key not null,
	TENSACH nvarchar(100),
	MATG char(7) not null,
	TENLINHVUC nvarchar(30),
	TENLOAISACH nvarchar(30),
	GIAMUA int,
	GIABIA int,
	LANTAIBAN int,
	TENNHAXUATBAN nvarchar(50),
	NAMXUATBAN datetime
)
go
insert into SACH
values
('S01',N'Hoa sen trên tuyết','TG01',N'Đời sống',N'Tâm linh & tiểu thuyết',81400,2000,2020,N'NXB Tổng hợp TPHCM',2020),
('S02',N'Nguồn gốc các loài','TG02',N'Đời sống',N'Tiểu thuyết',171600,7000,20,N'NXB Tri Thức',2019),
('S03',N'Tất Cả Đều Là Chuyện Nhỏ','TG03',N'Đời sống',N'Tiểu thuyết',72400,1000,10,N'NXB Tổng hợp TPHCM',2018),
('S04',N'Đề Thi Đẫm Máu','TG04',N'Trinh Thám',N'Tiểu thuyết',51400,5000,12,N'NXB Hồng Đức',2020),
('S05',N'Thần Thoại Bắc Âu','TG05',N'Đời sống',N'Truyện',64100,10000,22,N'NXB Văn học',2019)
Select * From SACH

create table TACGIA
(
    MATG char(7) primary key not null,
	TENTG nvarchar(40),
	NAMSINH date,
	NAMMAT date,
	QUEQUAN nvarchar(20)
)
go
insert into TACGIA
values
('TG01',N'John Vu','1950','9999',N'Hà Nội'),
('TG02',N'Charles Darwin','1809','1882',N'Vương quốc Anh'),
('TG03',N'Richard Carlson','1961','2006',N'Hoa Kỳ'),
('TG04',N'Lôi Mễ','1978' ,'9999',N'Trung Quốc'),
('TG05',N'Neil Gaiman','1960','9999',N'Vương quốc Anh')
Select * from TACGIA

create table TAIKHOAN
(
    USERNAME nvarchar(20) primary key not null,
	PASS_WORD nvarchar(100)
)
--go
--INSERT INTO TAIKHOAN VALUES ('uit', 'uit');
--Select * from TAIKHOAN Where USERNAME = 'uit' and PASS_WORD = 'uit'

--CREATE PROC USP_Login
--@username nvarchar(20), @password nvarchar(100)
--AS
--BEGIN
--	SELECT * FROM TAIKHOAN WHERE USERNAME = @username AND PASS_WORD = @password
--END
--GO



--Thêm khóa ngoại
alter table CHITIETHOADON add constraint FK_CHITIETHOADON_HOADON foreign key(MAHOADON) references HOADON(MAHOADON)
alter table CHITIETHOADON add constraint FK_CHITIETHOADON_SACH foreign key(MASACH) references SACH(MASACH)
alter table KHO add constraint FK_KHO_SACH foreign key(MASACH) references SACH(MASACH)
alter table SACH add constraint FK_SACH_LOAISACH foreign key(TENLOAISACH) references LOAISACH(TENLOAISACH)
alter table SACH add constraint FK_SACH_TACGIA foreign key(MATG) references TACGIA(MATG)
alter table SACH add constraint FK_SACH_LINHVUC foreign key(TENLINHVUC) references LINHVUC(TENLINHVUC)
alter table SACH add constraint FK_SACH_NHAXUATBAN foreign key(TENNHAXUATBAN) references NHAXUATBAN(TENNHAXUATBAN)

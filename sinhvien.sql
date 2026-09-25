-- Bước 1: Tạo cơ sở dữ liệu QuanLyDiemThi
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Bước 2: Chọn cơ sở dữ liệu QuanLyDiemThi để thao tác
USE QuanLyDiemThi;

-- Xóa các bảng cũ (nếu có) để tránh lỗi khi chạy lại
DROP TABLE IF EXISTS BangDiem;
DROP TABLE IF EXISTS MonHoc;
DROP TABLE IF EXISTS GiaoVien;
DROP TABLE IF EXISTS HocSinh;

-- Bước 3: Tạo bảng HocSinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bước 4: Tạo bảng GiaoVien (Nên tạo trước MonHoc để thiết lập khóa ngoại dễ dàng hơn)
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bước 5: Tạo bảng MonHoc
CREATE TABLE MonHoc (
    MaMH VARCHAR(20) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bước 6: Tạo bảng BangDiem (Bảng trung gian giữa HocSinh và MonHoc)
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(20),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bước 7: Bổ sung khóa ngoại MaGV cho bảng MonHoc
ALTER TABLE MonHoc 
ADD CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);
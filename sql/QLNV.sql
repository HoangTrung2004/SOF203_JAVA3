CREATE DATABASE QuanLyNV;
USE QuanLyNV;
CREATE TABLE NhanVien (
  maNV VARCHAR(10) PRIMARY KEY,
  hoTen NVARCHAR(100),
  ngaySinh DATE,
  phongBan NVARCHAR(50),
  luong FLOAT
);

-- Thêm 5 bản ghi mẫu vào bảng NhanVien
INSERT INTO NhanVien(maNV, hoTen, ngaySinh, phongBan, luong) VALUES
  ('NV01', N'Nguyễn Văn A', '1985-05-10', N'HCNS',     7000.50),
  ('NV02', N'Lê Thị B',     '1990-07-20', N'KeToan',   8000.00),
  ('NV03', N'Phạm Văn C',   '1988-03-15', N'CNTT',    10000.75),
  ('NV04', N'Trần Thị D',   '1992-11-30', N'KinhDoanh',9000.20),
  ('NV05', N'Hoàng Văn E',  '1987-09-25', N'Marketing',7500.00);


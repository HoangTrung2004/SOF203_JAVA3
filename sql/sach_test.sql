-- 1. Tạo database (nếu chưa có)
CREATE DATABASE Test
  
USE Test;

CREATE TABLE Sach (
    masach VARCHAR(4) PRIMARY KEY,
    tensach NVARCHAR(50),
    gia FLOAT,
    namxb INT,
    loai NVARCHAR(10)	
);
INSERT INTO Sach VALUES 
('sh01', N'Tho Xuan Dieu', 600.0, 2019, 'vh'),
('sh02', N'Lap trinh C', 45.6, 2019, 'kh'),
('sh03', N'Hon dat', 123.0, 2019, 'vh'),
('sh04', N'Bai tap Java', 150.0, 2020, 'kh'),
('sh05', N'Python', 340.0, 2022, 'kh');

select * from Sach
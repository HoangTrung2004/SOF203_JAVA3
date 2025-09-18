CREATE DATABASE QuanLySV;
GO
USE QuanLySV;
GO
CREATE TABLE SinhVien (
    maSV      VARCHAR(10)    PRIMARY KEY,
    hoTen     NVARCHAR(100)  NOT NULL,
    ngaySinh  DATE           NOT NULL,
    lop       NVARCHAR(20)   NOT NULL,
    diemTB    FLOAT          NOT NULL
);
-- Chèn 5 bản ghi mẫu
INSERT INTO SinhVien VALUES
  ('SV01', N'Nguyễn Văn A', '2000-01-15', N'CTK43', 8.5),
  ('SV02', N'Lê Thị B',     '1999-05-20', N'CTK43', 7.2),
  ('SV03', N'Phạm Văn C',   '2001-03-10', N'CTK44', 6.8),
  ('SV04', N'Hoàng Thị D',  '2000-07-22', N'CTK44', 9.1),
  ('SV05', N'Trần Văn E',   '1998-11-30', N'CTK45', 5.9);
GO

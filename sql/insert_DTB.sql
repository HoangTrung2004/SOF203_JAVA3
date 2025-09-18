

CREATE DATABASE NewDB_Java3;
GO

USE  NewDB_Java3;
GO


CREATE TABLE Categories (
    Id NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);


CREATE TABLE Users (
    Id NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Birthday DATE,
    Gender BIT, -- true: Nam, false: Nữ
    Mobile NVARCHAR(20),
    Email NVARCHAR(100),
    Role BIT -- true: Quản trị, false: Phóng viên
);


CREATE TABLE News (
    Id NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Content NVARCHAR(MAX),
    Image NVARCHAR(255),
    PostedDate DATE,
    Author NVARCHAR(50), -- FK -> Users(Id)
    ViewCount INT DEFAULT 0,
    CategoryId NVARCHAR(50), -- FK -> Categories(Id)
    Home BIT,
    FOREIGN KEY (Author) REFERENCES Users(Id),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);


CREATE TABLE Newsletters (
    Email NVARCHAR(100) PRIMARY KEY,
    Enabled BIT -- true: còn hiệu lực
);


INSERT INTO dbo.Categories (Id, Name) VALUES
  ('VH', N'Văn Hóa'),
  ('PL', N'Pháp Luật'),
  ('TT', N'Thể Thao'),
  ('CN', N'Công Nghệ'),
  ('KT', N'Kinh Tế');
GO


-- Role: 1 = Admin, 0 = Phóng viên
INSERT INTO dbo.Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
  ('admin',   'admin@123',    N'Nguyễn Văn A',   '1985-04-15', 1, '0912345678', 'admin@news.com', 1),
  ('rep001',  'pass001',      N'Lê Thị B',       '1990-07-20', 0, '0987654321', 'b.le@news.com',  0),
  ('rep002',  'pass002',      N'Phạm Văn C',     '1988-12-05', 1, '0901122334', 'c.pham@news.com', 0);
GO

-- 3. Dữ liệu cho bảng News
-- Home: 1 = hiển thị trang nhất, ViewCount khởi tạo
-- 3. Dữ liệu cho bảng News
-- Home: 1 = hiển thị trang nhất, ViewCount khởi tạo
INSERT INTO dbo.News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
  ('N001', N'Chương trình văn hóa đầu xuân', 
    N'Những ngày đầu năm mới, không gian của hồ Văn trở nên rực rỡ hơn bao giờ hết, với sắc màu của mực tàu, giấy đỏ, hoành phi, câu đối.
	Sắc xuân còn thể hiện rõ hơn trong không gian của những khu trưng bày, trải nghiệm. Điểm đặc biệt, năm nay, hồ Văn được cải tạo sạch đẹp,
	sắp xếp theo từng khu vực, mang đến không gian thoáng đãng, an toàn, góp phần nâng cao chất lượng khi du khách đến tham quan, trải nghiệm văn hóa tại Hội chữ Xuân Ất Tỵ 2025.', 
    'image1.jpg', '2025-01-10', 'rep001', 120, 'VH', 1),
  ('N002', N'Pháp luật giao thông: Cập nhật quy định mới', 
    N'Theo quy định tại Điều 58 Luật Trật tự, an toàn giao thông đường bộ 2024 có hiệu lực thi hành từ ngày 01/01/2025, mỗi giấy phép lái xe sẽ có 12 điểm/năm để đánh giá mức độ tuân thủ luật lệ giao thông của người lái xe.
	Mỗi lần vi phạm quy định của pháp luật về an toàn giao thông, lái xe sẽ bị trừ điểm theo tính chất và mức độ nghiêm trọng của lỗi vi phạm. Thông tin về số điểm bị trừ sẽ được ghi nhận vào hệ thống cơ sở dữ liệu quản lý và thông báo đến người lái xe liên quan ngay khi có quyết định xử phạt có hiệu lực.
	Nếu còn điểm trong năm, giấy phép lái xe sẽ được phục hồi lại đủ 12 điểm vào năm sau. Trường hợp bị trừ hết điểm trong một năm, lái xe sẽ không được phép điều khiển phương tiện giao thông theo loại giấy phép đã đăng ký.', 
    'image2.jpg', '2025-02-05', 'rep002', 85, 'PL', 0),
  ('N003', N'Kết quả vòng 1 V-League 2025', 
    N'Vòng 1 V-League 2025 đã khởi tranh với những trận cầu hấp dẫn. Trong trận đấu mở màn, đội X giành chiến thắng 2-1 trước đội Y với pha lập công ở phút 88. Trận đấu diễn ra trong không khí sôi động với sự cổ vũ cuồng nhiệt của người hâm mộ. 
	Các huấn luyện viên đánh giá chất lượng chuyên môn của mùa giải năm nay cao hơn các mùa trước, hứa hẹn mang lại nhiều kịch tính và bất ngờ. Bên cạnh đó, công nghệ VAR đã chính thức được áp dụng trong mùa giải này.', 
    'image3.jpg', '2025-03-18', 'rep001', 230, 'TT', 1),
  ('N004', N'Ra mắt smartphone thế hệ mới', 
    N'Hãng công nghệ Samsung vừa giới thiệu dòng smartphone Samsung thế hệ mới với nhiều cải tiến nổi bật. Máy được trang bị chip xử lý Snapdragon 8 Gen 3, RAM 16GB, camera 108MP, pin 5000mAh cùng công nghệ sạc siêu tốc 120W. Ngoài ra, máy hỗ trợ kết nối 5G, màn hình AMOLED 6.8 inch tần số quét 144Hz, 
	cùng hệ điều hành tùy biến cho trải nghiệm mượt mà. Dòng sản phẩm được định vị ở phân khúc cao cấp, cạnh tranh trực tiếp với các ông lớn như Samsung, Apple', 
    'image4.jpg', '2025-04-22', 'rep002', 150, 'CN', 0),
  ('N005', N'Thị trường chứng khoán khởi sắc', 
    N'Kết thúc phiên giao dịch ngày 15/5, VN-Index tăng mạnh 15 điểm, chốt ở mức 1.250 điểm. Dòng tiền đổ mạnh vào nhóm cổ phiếu ngân hàng, bất động sản và công nghệ, trong đó nhiều mã như VCB, VHM, FPT đạt mức tăng trần. 
	Các chuyên gia nhận định xu hướng thị trường đang tích cực nhờ sự ổn định vĩ mô, lãi suất thấp và kỳ vọng kết quả kinh doanh quý II khởi sắc. Nhà đầu tư được khuyến nghị theo dõi diễn biến vĩ mô để đưa ra chiến lược phù hợp', 
    'image5.jpg', '2025-05-15', 'rep001', 95, 'KT', 0),
  ('N006', N'Lễ hội pháo hoa quốc tế Đà Nẵng 2025', 
    N'Lễ hội pháo hoa quốc tế Đà Nẵng (DIFF) 2025 chính thức khai mạc với màn trình diễn rực rỡ trên sông Hàn. Các đội thi đến từ Pháp, Nhật, Ý và chủ nhà Việt Nam mang đến những màn pháo hoa sáng tạo, đầy màu sắc. Ngoài ra, không gian quanh khu vực tổ chức còn diễn ra các hoạt động văn hóa như ca múa nhạc, 
	triển lãm nghệ thuật, gian hàng ẩm thực và trò chơi dân gian. DIFF 2025 không chỉ góp phần quảng bá hình ảnh Đà Nẵng mà còn kích cầu du lịch nội địa mạnh mẽ.', 
    'image6.jpg', '2025-05-20', 'rep001', 180, 'VH', 1),
  ('N007', N'Tăng cường xử phạt vi phạm nồng độ cồn', 
    N'Cảnh sát giao thông trên toàn quốc đồng loạt ra quân thực hiện kiểm tra nồng độ cồn với người điều khiển phương tiện. Theo quy định mới, mức xử phạt được nâng cao, bao gồm tước giấy phép lái xe từ 12 đến 24 tháng và phạt tiền từ 7 đến 40 triệu đồng.
	Mục tiêu của đợt cao điểm lần này là tuyên truyền nâng cao ý thức người dân, phòng chống tai nạn do rượu bia gây ra, đặc biệt trong dịp nghỉ lễ và mùa du lịch hè.', 
    'image7.jpg', '2025-05-22', 'rep002', 60, 'PL', 0),
  ('N008', N'Sôi động giải bóng đá sinh viên toàn quốc', 
    N'Giải bóng đá sinh viên toàn quốc 2025 chính thức khởi tranh tại TP.HCM với sự góp mặt của hơn 30 đội bóng đến từ các trường đại học, 
	cao đẳng trên cả nước. Giải đấu năm nay được tổ chức theo thể thức vòng bảng và loại trực tiếp, với tổng giải thưởng lên đến 500 triệu đồng.
	Bên cạnh việc cổ vũ tinh thần thể thao, giải còn là sân chơi bổ ích, giúp sinh viên rèn luyện thể chất, phát triển kỹ năng làm việc nhóm và tạo sự gắn kết giữa các đơn vị giáo dục.', 
    'image8.jpg', '2025-05-24', 'rep001', 140, 'TT', 1),
  ('N009', N'Công nghệ AI tiếp tục phát triển mạnh mẽ', 
    N'Các doanh nghiệp Việt Nam đang tăng tốc đầu tư vào trí tuệ nhân tạo (AI) nhằm tối ưu quy trình sản xuất, chăm sóc khách hàng và dự đoán hành vi tiêu dùng. Nhiều startup công nghệ đã ứng dụng AI vào chatbot, tự động hóa marketing, và phân tích dữ liệu lớn. 
	Các chuyên gia nhận định rằng, trong 5 năm tới, AI sẽ đóng vai trò then chốt trong chuyển đổi số, đặc biệt tại các ngành tài chính, giáo dục, và logistics. Chính phủ cũng đang có chiến lược phát triển AI cấp quốc gia đến năm 2030.', 
    'image9.jpg', '2025-05-25', 'rep002', 170, 'CN', 1),
  ('N010', N'Giá vàng biến động trước kỳ nghỉ lễ', 
    N'Trước kỳ nghỉ lễ dài ngày, thị trường vàng trong nước ghi nhận biến động mạnh. Giá vàng miếng SJC tăng lên mức 75 triệu đồng/lượng trong bối cảnh lo ngại lạm phát tăng và USD biến động khó lường. 
	Các chuyên gia khuyến cáo nhà đầu tư nên cẩn trọng, tránh đầu cơ ngắn hạn và cần theo sát các yếu tố kinh tế vĩ mô, đặc biệt là quyết định lãi suất từ FED và tình hình địa chính trị thế giới. Nhu cầu mua vàng tích trữ cũng tăng cao trong dịp này.', 
    'image10.jpg', '2025-05-26', 'rep001', 105, 'KT', 0);


-- 4. Dữ liệu cho bảng Newsletters
INSERT INTO dbo.Newsletters (Email, Enabled) VALUES
  ('admin@gmail.com', 1),
  ('abc2@gmail.com', 1),
  ('aaaa@gmail.com', 0);
GO

SELECT * FROM News WHERE home = 1&0


SELECT * FROM News 
WHERE CategoryId = 'VH';


SELECT * FROM News WHERE home = 1

SELECT * FROM Newsletters

SELECT * FROM newsletters WHERE email = 'admin@gmail.com'

SELECT TOP 5 * FROM News ORDER BY ViewCount DESC
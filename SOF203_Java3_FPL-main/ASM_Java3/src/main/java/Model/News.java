package Model;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class News {
	
	private String id;             
    private String title;          // Tiêu đề
    private String content;        // Nội dung
    private String image;          
    private Date postedDate;       // Ngày đăng
    private String author;         // Tác giả (mã phóng viên)
    private int viewCount;         // Số lượt xem
    private String categoryId;     // Mã loại tin
    private boolean home;          // Trang nhất (true nếu hiển thị trên trang chủ)
	
  

    
}

package Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import Member.MemberPage;
import dao.CommentDao;
import dto.CommentDTO;
import jdbc.connection.ConnectionProvider;

public class CommentListService {

	private CommentDao commentDao = new CommentDao();
	
	public ReviewPage getReviewPage() {
		try(Connection conn = ConnectionProvider.getConnection()){
			
			List<CommentDTO> commentdto = commentDao.select(conn);
			
//			List<MemberPage> member = commentDao.select(conn);
			return new ReviewPage(commentdto);
		}catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
}

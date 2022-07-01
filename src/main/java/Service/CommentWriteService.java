package Service;

import java.sql.Connection;
import java.util.Date;

import dao.CommentDao;
import dto.CommentDTO;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class CommentWriteService {

	private CommentDao commentDao = new CommentDao();

	public Integer submit(CommentDTO commentDTO) {
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			CommentDTO cCommentDTO= toPage(commentDTO);
			//CommentSubmitPage cexecution = commentDao.insert(conn, member);
			
			
			if(cCommentDTO == null) {
				throw new RuntimeException("fail to insert");
			}
			
			CommentDTO savedContent = commentDao.insert(conn, cCommentDTO);
			if(savedContent == null) {
				throw new RuntimeException("fail to insert");
			}
			conn.commit();
			
			return 0;//reviewValue
		}catch(Exception e){
			JdbcUtil.rollback(conn);
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
		}
		return 1;

	}
	
	private CommentDTO toPage(CommentDTO commentDTO) {
		Date nowDate = new Date();
		return new CommentDTO(commentDTO.getmId(),commentDTO.getContent(),nowDate);
	}
}

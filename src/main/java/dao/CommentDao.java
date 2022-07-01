package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Member.MemberPage;
import dto.CommentDTO;
import jdbc.JdbcUtil;

public class CommentDao {

	public CommentDTO insert(Connection conn, CommentDTO commentDTO) {

		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("insert into review (mId,content,regdate) values (?,?,?)");
//			pstmt.setInt(1,(int)commentDTO.getrNo());
			pstmt.setString(1, commentDTO.getmId());
			pstmt.setString(2, commentDTO.getContent());
			pstmt.setDate(3, new java.sql.Date(commentDTO.getRegDate().getTime()));
			
			pstmt.executeUpdate();//필수
			
			return new CommentDTO(commentDTO.getmId(),commentDTO.getContent(),commentDTO.getRegDate());
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(pstmt);
		}
		return null;

	}
	
	//수정필요
	public List<CommentDTO> select(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("select * from review order by regDate desc");
			/*
			 * pstmt.setInt(1,startRow); pstmt.setInt(2, size);
			 */
			rs = pstmt.executeQuery();
			List<CommentDTO> result = new ArrayList<>();
			while(rs.next()) {
				result.add(convertCDTO(rs));
			}
			return result;
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}

	private CommentDTO convertCDTO(ResultSet rs)throws SQLException {
		return new CommentDTO(rs.getString("mId"),rs.getString("content"),rs.getDate("regDate"));
	}
	
	/*
	 * public CommentSubmitPage insert(Connection conn , CommentSubmitPage
	 * commentSubmitpage) throws SQLException{ PreparedStatement pstmt = null;
	 * 
	 * try { pstmt =
	 * conn.prepareStatement("insert into review (mId,reviews) values(?,?)");
	 * pstmt.setString(1, commentSubmitpage.getMember().getmId());
	 * pstmt.setString(2, commentSubmitpage.getReviews());
	 * 
	 * pstmt.executeUpdate();
	 * 
	 * conn.commit(); } finally { JdbcUtil.close(pstmt); } return null;
	 * 
	 * }
	 */

}
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.OrderComment;

public class OrderCommentDao {
	OrderComment oct = new OrderComment();
	
	// [관리자] 상품평 삭제
	public void deleteOrderComment(int orderCommentNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderCommentDao.deleteOrderComment param orderCommentNo : "+orderCommentNo);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "Delete FROM order_comment WHERE order_comment_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderCommentNo);
		stmt.executeQuery();
		
		System.out.println("[Debug] OrderCommentDao.deleteOrderComment stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
	
	// [모든 사용자] 상품평 마지막 페이지 도출
		public int selectOrderCommentLastPageByOne(int ebookNo,int rowPerPage) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage ebookNo : "+ebookNo);
			System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage rowPerPage : "+rowPerPage);

			
			int lastPage = 0;
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT COUNT(*) from order_comment WHERE ebook_no = ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			ResultSet rs = stmt.executeQuery();
			int totalRowCount = 0;
			
			System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage stmt : "+stmt);
			System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage rs : "+rs);
			
			if(rs.next()) {
				totalRowCount = rs.getInt("COUNT(*)");
			}
			lastPage = totalRowCount / rowPerPage;
			if(totalRowCount % rowPerPage != 0) {
				lastPage++;
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
			return lastPage;
		}
	
	// [관리자] 상품평 마지막 페이지 도출
	public int selectOrderCommentLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage rowPerPage : "+rowPerPage);

		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) from order_comment";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;
		
		System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage stmt : "+stmt);
		System.out.println("[Debug] OrderCommentDao.selectOrderCommentLastPage rs : "+rs);
		
		if(rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / rowPerPage;
		if(totalRowCount % rowPerPage != 0) {
			lastPage++;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return lastPage;
	}
	
	// [모든 사용자] ebook 상품평 리스트 출력
	public ArrayList<OrderComment> selectOrderCommentList(int beginRow, int rowPerPage) throws SQLException, ClassNotFoundException {
		System.out.println("[Debug] OrderCommentDao.selectEbookContentList beginRow : "+beginRow);
		System.out.println("[Debug] OrderCommentDao.selectEbookContentList rowPerPage : "+rowPerPage);
		
		ArrayList<OrderComment> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT order_comment_no orderCommentNo,member_no memberNo,ebook_no ebookNo,order_score orderScore,order_comment_content orderContent,create_date createDate,update_date updateDate FROM order_comment ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		System.out.println("[Debug] OrderCommentDao.selectEbookContentList stmt : "+stmt);
		System.out.println("[Debug] OrderCommentDao.selectEbookContentList rs : "+rs);
		
		while(rs.next()) {
			OrderComment o = new OrderComment();
			o.setOrderCommentNo(rs.getInt("orderCommentNo"));
			o.setMemberNo(rs.getInt("memberNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setOrderScore(rs.getInt("orderScore"));
			o.setOrderContent(rs.getString("orderContent"));
			o.setCreateDate(rs.getString("createDate"));
			o.setUpdateDate(rs.getString("updateDate"));
			list.add(o);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [회원] 해당 memberNo의 상품평이 있는지
		public ArrayList<OrderComment> selectOrderCommentOne(int ebookNo, int memberNo) throws SQLException, ClassNotFoundException {
			System.out.println("[Debug] OrderCommentDao.selectOrderComment ebookNo : "+memberNo);
			
			ArrayList<OrderComment> list = new ArrayList<>();
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT member_no memberNo,ebook_no ebookNo,order_score orderScore,order_comment_content orderContent,create_date createDate,update_date updateDate FROM order_comment WHERE ebook_no=? AND member_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			stmt.setInt(2, memberNo);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				OrderComment o = new OrderComment();
				o.setMemberNo(rs.getInt("memberNo"));
				o.setEbookNo(rs.getInt("ebookNo"));
				o.setOrderScore(rs.getInt("orderScore"));
				o.setOrderContent(rs.getString("orderContent"));
				o.setCreateDate(rs.getString("createDate"));
				o.setUpdateDate(rs.getString("updateDate"));
				list.add(o);
			}
			
			System.out.println("[Debug] OrderCommentDao.selectOrderComment stmt : "+stmt);
			System.out.println("[Debug] OrderCommentDao.selectOrderComment rs : "+rs);
			
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
	
	// [모든 사용자] 해당 ebook 상품평 출력
	public ArrayList<OrderComment> selectOrderComment(int beginRow, int rowPerPage, int ebookNo) throws SQLException, ClassNotFoundException {
		System.out.println("[Debug] OrderCommentDao.selectOrderComment ebookNo : "+ebookNo);
		
		ArrayList<OrderComment> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo,ebook_no ebookNo,order_score orderScore,order_comment_content orderContent,create_date createDate,update_date updateDate FROM order_comment WHERE ebook_no = ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderComment o = new OrderComment();
			o.setMemberNo(rs.getInt("memberNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setOrderScore(rs.getInt("orderScore"));
			o.setOrderContent(rs.getString("orderContent"));
			o.setCreateDate(rs.getString("createDate"));
			o.setUpdateDate(rs.getString("updateDate"));
			list.add(o);
		}
		
		System.out.println("[Debug] OrderCommentDao.selectOrderComment stmt : "+stmt);
		System.out.println("[Debug] OrderCommentDao.selectOrderComment rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [회원] 상품평 작성
	public void insertComment(OrderComment orderComment) throws ClassNotFoundException, SQLException {
		// 매개변수값은 무조건 디버깅
		System.out.println("[Debug] OrderCommentDao.insertComment "+oct.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO order_comment(order_no,ebook_no,order_score,order_comment_content,create_date,update_date,member_no) VALUE(?,?,?,?,NOW(),NOW(),?)";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderComment.getOrderNo());
		stmt.setInt(2, orderComment.getEbookNo());
		stmt.setInt(3, orderComment.getOrderScore());
		stmt.setString(4, orderComment.getOrderContent());
		stmt.setInt(5, orderComment.getMemberNo());
		stmt.executeQuery();
		
		System.out.println("[Debug] OrderCommentDao.insertContent param orderNo : "+stmt);
		
		stmt.close();
		conn.close();
	}
}

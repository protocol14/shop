package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderEbookMember;

public class OrderDao {
	Order ot = new Order();
	
	// [회원] 방금 구매한 상품 날짜 확인
	public String selectOrderByMember(int memberNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderDao.selectOrderByMember memberNo : "+memberNo);
		
		String r = "";
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select MAX(create_date) date from orders where member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			r = rs.getString("date");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return r;
	}
	
	// [회원] 상품 구매
	public void insertOrderByMember(Order order) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderDao.insertOrderByMember "+ot.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO orders(ebook_no,member_no,order_price,create_date,update_date) VALUE(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getEbookNo());
		stmt.setInt(2, order.getMemberNo());
		stmt.setInt(3, order.getOrderPrice());
		ResultSet rs = stmt.executeQuery();
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [회원] 주문 목록
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderDao.selectOrderByMember memberNo : "+memberNo);
		
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate, o.update_date updateDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? ORDER BY o.create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// 빈 OrderEbookMember oem 생성 후 조합한 후 추가
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreate_date(rs.getString("createDate"));
			o.setUpdate_date(rs.getString("updateDate"));
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			
			oem.setOrder(o);
			oem.setEbook(e);
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [관리자] order 목록
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int ROW_PER_PAGE) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderDao.selectOrderList beginRow : "+beginRow);
		System.out.println("[Debug] OrderDao.selectOrderList ROW_PER_PAGE : "+ROW_PER_PAGE);
		
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate, o.update_date updateDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// 빈 OrderEbookMember oem 생성 후 조합한 후 추가
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreate_date(rs.getString("createDate"));
			o.setUpdate_date(rs.getString("updateDate"));
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			
			oem.setOrder(o);
			oem.setEbook(e);
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [관리자] order 마지막 페이지 도출
	public int selectOrderLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] OrderDao.selectOrderLastPage rowPerPage : "+rowPerPage);
		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) from orders";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;
		
		System.out.println("[Debug] selectebookLastPage stmt : "+stmt);
		System.out.println("[Debug] selectebookLastPage rs : "+rs);
		
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
}

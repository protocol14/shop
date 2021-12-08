package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	Ebook et = new Ebook();
	
	// [모든 사용자] 별점 평균 계산
	public float selectAVGEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.selectAVGEbookOne ebookNo : "+ebookNo);
		
		float scoreAVG = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no, COUNT(ebook_no), AVG(order_score) AVG FROM order_comment WHERE ebook_no = ? GROUP BY ebook_no";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.selectAVGEbookOne stmt : "+stmt);
		System.out.println("[Debug] EbookDao.selectAVGEbookOne rs : "+rs);
		
		if(rs.next()) {
			scoreAVG = rs.getFloat("AVG");
			System.out.println(scoreAVG);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return scoreAVG;
	}
	// [모든 사용자] 신간도서 5개
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException {
		
		ArrayList<Ebook> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM ebook ORDER BY create_date DESC LIMIT 0,5;";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.popularEbook5 stmt : "+stmt);
		System.out.println("[Debug] EbookDao.popularEbook5 rs : "+rs);
		
		while(rs.next()) {
			Ebook e = new Ebook();
			
			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebook_no"));
			e.setEbookTitle(rs.getString("ebook_title"));
			e.setEbookImg(rs.getString("ebook_img"));
			e.setEbookPrice(rs.getInt("ebook_price"));
			
			list.add(e);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [모든 사용자] 베스트셀러 5개
	public ArrayList<Ebook> selectPopularEbookList() throws ClassNotFoundException, SQLException {
		
		ArrayList<Ebook> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN ( SELECT ebook_no, COUNT(ebook_no) cnt FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0,5) t ON e.ebook_no = t.ebook_no";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.selectPopularEbookList stmt : "+stmt);
		System.out.println("[Debug] EbookDao.selectPopularEbookList rs : "+rs);
		
		while(rs.next()) {
			Ebook e = new Ebook();
			
			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			
			list.add(e);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [관리자] 상품삭제
	public void deleteEbookOneByAdmin(int ebookNo) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.deleteEbookOneByAdmin ebookNo : "+ebookNo);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "Delete FROM ebook WHERE ebook_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.deleteEbookOneByAdmin stmt : "+stmt);
		System.out.println("[Debug] EbookDao.deleteEbookOneByAdmin rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [관리자] 전자책 수정
	public void updateEbookOne(Ebook ebook) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.updateEbookOne "+et.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE ebook SET ebook_isbn=?,ebook_title=?,category_name=?,ebook_author=?,ebook_company=?,ebook_page_count=?,ebook_price=?,ebook_summary=?,ebook_state=?,update_date=NOW() WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getEbookTitle());
		stmt.setString(3, ebook.getCategoryName());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		stmt.setString(9, ebook.getEbookState());
		stmt.setInt(10, ebook.getEbookNo());
		stmt.executeQuery();
		// debug
		System.out.println("[Debug] EbookDao.updateEbookOne stmt2 : "+stmt);

		stmt.close();
		conn.close();
	}
	
	// [관리자] 전자책 추가
	public void insertEbook(Ebook ebook) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.insertEbook "+et.toString());
		
		String setCategoryState = "";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_state categoryState FROM category WHERE category_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getCategoryName());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			setCategoryState = rs.getString("categoryState");
		}
		// debug
		System.out.println("[Debug] EbookDao.insertEbook stmt : "+stmt);
		System.out.println("[Debug] EbookDao.insertEbook rs : "+rs);
		
		Connection conn2 = dbUtil.getConnection();
		String sql2 = "INSERT INTO ebook(ebook_isbn,ebook_title,category_name,category_state,ebook_author,ebook_company,ebook_page_count,ebook_price,ebook_img,ebook_summary,ebook_state,update_date,create_date) VALUES (?,?,?,'"+setCategoryState+"',?,?,?,?,'noimage.jpg',?,'판매중', NOW(), NOW())";
		PreparedStatement stmt2 = conn2.prepareStatement(sql2);
		stmt2.setString(1, ebook.getEbookISBN());
		stmt2.setString(2, ebook.getEbookTitle());
		stmt2.setString(3, ebook.getCategoryName());
		stmt2.setString(4, ebook.getEbookAuthor());
		stmt2.setString(5, ebook.getEbookCompany());
		stmt2.setInt(6, ebook.getEbookPageCount());
		stmt2.setInt(7, ebook.getEbookPrice());
		stmt2.setString(8, ebook.getEbookSummary());
		stmt2.executeQuery();
		// debug
		System.out.println("[Debug] EbookDao.insertEbook stmt2 : "+stmt2);
		

		stmt2.close();
		conn2.close();
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [관리자] 이미지 교체
	public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.updateEbookImg "+et.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE ebook SET ebook_img=?, update_date=NOW() WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setInt(2, ebook.getEbookNo());
		stmt.executeUpdate();
		
		System.out.println("[Debug] EbookDao.updateEbookImg stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
	
	// [모든 사용자] 해당 ebook 요소 출력
	public Ebook selectEbookOne(int ebookNo) throws SQLException, ClassNotFoundException {
		// [Debug]
		System.out.println("[Debug] EbookDao.selectEbookOne ebookNo : "+ebookNo);
		
		Ebook ebook = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM ebook WHERE ebook_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebook_no"));
			ebook.setEbookISBN(rs.getString("ebook_isbn"));
			ebook.setEbookTitle(rs.getString("ebook_title"));
			ebook.setCategoryName(rs.getString("category_name"));
			ebook.setEbookAuthor(rs.getString("ebook_author"));
			ebook.setEbookCompany(rs.getString("ebook_company"));
			ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
			ebook.setEbookPrice(rs.getInt("ebook_price"));
			ebook.setEbookImg(rs.getString("ebook_img"));
			ebook.setEbookSummary(rs.getString("ebook_summary"));
			ebook.setEbookState(rs.getString("ebook_state"));
			ebook.setUpdateDate(rs.getString("update_date"));
			ebook.setCreateDate(rs.getString("create_date"));
		}
		
		System.out.println("[Debug] EbookDao.EbookDao.selectEbookOne stmt : "+stmt);
		System.out.println("[Debug] EbookDao.EbookDao.selectEbookOne rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
		
		return ebook;
	}
	
	// [모든 사용자] 사용중인 ebook 목록출력
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("[Debug] EbookDao.selectEbookList beginRow : "+beginRow);
		System.out.println("[Debug] EbookDao.selectEbookList rowPerPage : "+rowPerPage);
		
		ArrayList<Ebook> list = new ArrayList<>();
		/*
		 * SELECT ebook_no ebookNo, ebook_title ebookTitle, category_name categoryName, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, category_name categoryName, ebook_state ebookState FROM ebook WHERE category_state='Y' ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.EbookDao.selectEbookList stmt : "+stmt);
		System.out.println("[Debug] EbookDao.EbookDao.selectEbookList rs : "+rs);
		
		while(rs.next()) {
			Ebook e = new Ebook();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookState(rs.getString("ebookState"));
			
			list.add(e);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [모든 사용자] 카테고리별 사용중인 ebook 목록출력
	public ArrayList<Ebook> selectEbookListByCategory(int beginRow, int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException{
		// [Debug]
		System.out.println("[Debug] EbookDao.selectEbookList beginRow : "+beginRow);
		System.out.println("[Debug] EbookDao.selectEbookList rowPerPage : "+rowPerPage);
		System.out.println("[Debug] EbookDao.selectEbookList categoryName : "+categoryName);
		
		ArrayList<Ebook> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, category_name categoryName, ebook_state ebookState  FROM ebook WHERE category_name LIKE ? AND category_state='Y' ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+categoryName+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] EbookDao.selectEbookListByCategory stmt : "+stmt);
		System.out.println("[Debug] EbookDao.selectEbookListByCategory rs : "+rs);
		
		while(rs.next()) {
			Ebook e = new Ebook();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookState(rs.getString("ebookState"));
			
			list.add(e);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
		
	// [모든 사용자] ebook 사용중인 마지막 페이지 도출
	public int selectEbookLastPage(int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] EbookDao.selectEbookLastPage rowPerPage : "+rowPerPage);
		System.out.println("[Debug] EbookDao.selectEbookLastPage categoryName : "+categoryName);
		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "";
		if(categoryName.equals("") == true) {
			sql = "SELECT COUNT(*) from ebook WHERE category_state='Y'";
		} else {
			sql = "SELECT COUNT(*) from ebook WHERE category_state='Y' AND category_name LIKE '%"+categoryName+"%'";
		}
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;
		
		System.out.println("[Debug] EbookDao.selectebookLastPage stmt : "+stmt);
		System.out.println("[Debug] EbookDao.selectebookLastPage rs : "+rs);
		
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

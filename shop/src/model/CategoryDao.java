package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Category;

public class CategoryDao {
	Category ct = new Category();
	
	// [관리자] 카테고리 리스트 출력
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException {
		ArrayList<Category> list = new ArrayList<Category>();

		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT category_name categoryName, category_state categoryState, update_date updateDate, create_date createDate FROM category ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Category categoryResult = new Category();
			categoryResult.setCategoryName(rs.getString("categoryName"));
			categoryResult.setCategoryState(rs.getString("categoryState"));
			categoryResult.setUpdateDate(rs.getString("updateDate"));
			categoryResult.setCreateDate(rs.getString("createDate"));
			list.add(categoryResult);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	
	
	// [관리자] 카테고리 및 목록 사용 상태 결정
	public void updateCategoryState(Category category) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println("[Debug] CategoryDao.updateCategoryState "+ct.toString());

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "UPDATE category c, ebook e SET c.category_state=?, c.update_date=NOW(), e.category_state=?, e.update_date=NOW() WHERE c.category_name=e.category_name AND c.category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryState());
		stmt.setString(2, category.getCategoryState());
		stmt.setString(3, category.getCategoryName());
		stmt.executeQuery();
		// debug
		System.out.println("[Debug] CategoryDao.updateCategoryState stmt : "+stmt);
		

		stmt.close();
		conn.close();
	}
	
	
	// [관리자] 카테고리 아이디 중복 검사
	public String selectCategoryNameCheck(String categoryNameCheck) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println("[Debug] CategoryDao.selectCategoryNameCheck categoryNameCheck : "+categoryNameCheck);
		
		String categoryNameResult = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println("[Debug] CategoryDao.selectCategoryNameCheck stmt : "+stmt);
		System.out.println("[Debug] CategoryDao.selectCategoryNameCheck rs : "+rs);
		
		if(rs.next()) {
			categoryNameResult = rs.getString("categoryName");
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
			
		return categoryNameResult;  // null이 나오면 사용 가능한 Id, 아니면 사용 불가한 아이디(이미 사용중)
	}
	
	// [관리자] 카테고리 추가
	public void insertCategory(String categoryName) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println("[Debug] CategoryDao.insertCategory categoryName : "+categoryName);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO category(category_name, category_state, update_date, create_date) VALUES (?,'Y', NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.executeQuery();
		// debug
		System.out.println("[Debug] CategoryDao.insertCategory stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
	
}

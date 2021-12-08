package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class QnaDao {
		Qna qt = new Qna();
	
		// [회원] Qna 수정
		public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
			// 매개변수값은 무조건 디버깅
			System.out.println("[Debug] QnaDao.updateQna "+qt.toString());
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "UPDATE qna SET qna_category=?,qna_content=?,update_date=NOW() WHERE qna_no=?";     
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, qna.getQnaCategory());
			stmt.setString(2, qna.getQnaContent());
			stmt.setInt(3, qna.getQnaNo());
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] QnaDao.updateQna stmt : "+stmt);
			System.out.println("[Debug] QnaDao.updateQna rs : "+rs);
			
			rs.close();
			stmt.close();
			conn.close();
		}
		
		
		// [관리자] Qna 삭제
		public void deleteQna(int qnaNo) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.deleteQna param qnaNo : "+qnaNo);
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "Delete FROM qna WHERE qna_no=?";     
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnaNo);
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] QnaDao.deleteQna stmt : "+stmt);
			System.out.println("[Debug]QnaDao.deleteQna rs : "+rs);
			
			rs.close();
			stmt.close();
			conn.close();
		}
		
		// [모든 사용자] qna 출력 #일반 사용자는 비밀글 못보게 함
		public ArrayList<Qna> selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaOne qnaNo : "+qnaNo);
			
			ArrayList<Qna> list = new ArrayList<>();
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT qna_no qnaNo,qna_category qnaCategory,qna_title qnaTitle,qna_content qnaContent,qna_secret qnaSecret,member_no memberNo,create_date createDate,update_date updateDate FROM qna WHERE qna_no=?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnaNo);
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] selectNoticeOne stmt : "+stmt);
			System.out.println("[Debug] selectNoticeOne rs : "+rs);
			
			while(rs.next()) {
				Qna q = new Qna();
				q.setCreateDate(rs.getString("createDate"));
				q.setMemberNo(rs.getInt("memberNo"));
				q.setQnaCategory(rs.getString("qnaCategory"));
				q.setQnaNo(rs.getInt("qnaNo"));
				q.setQnaTitle(rs.getString("qnaTitle"));
				q.setUpdateDate(rs.getString("updateDate"));
				q.setQnaContent(rs.getString("qnaContent"));
				q.setQnaSecret(rs.getString("qnaSecret"));
				list.add(q);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
		// [모든 사용자] Ebook 단위 qna 출력 #일반 사용자는 비밀글 못보게 함
		public ArrayList<Qna> selectEbookQnaList(int beginRow, int rowPerPage, int ebookNo) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectEbookQnaList rowPerPage : "+rowPerPage);
			System.out.println("[Debug] QnaDao.selectEbookQnaList rowPerPage : "+rowPerPage);
			System.out.println("[Debug] QnaDao.selectEbookQnaList qnaNo : "+ebookNo);
			
			ArrayList<Qna> list = new ArrayList<>();
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT qna_secret qnaSecret, qna_no qnaNo,qna_category qnaCategory,qna_title qnaTitle,qna_content qnaContent,qna_secret qnaSecret,member_no memberNo,create_date createDate,update_date updateDate FROM qna WHERE ebook_no=? ORDER BY create_date DESC LIMIT ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] selectEbookQnaList stmt : "+stmt);
			System.out.println("[Debug] selectEbookQnaList rs : "+rs);
			
			while(rs.next()) {
				Qna q = new Qna();
				q.setCreateDate(rs.getString("createDate"));
				q.setMemberNo(rs.getInt("memberNo"));
				q.setQnaCategory(rs.getString("qnaCategory"));
				q.setQnaNo(rs.getInt("qnaNo"));
				q.setQnaTitle(rs.getString("qnaTitle"));
				q.setUpdateDate(rs.getString("updateDate"));
				q.setQnaSecret(rs.getString("qnaSecret"));
				list.add(q);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
		
		// [관리자] Qna 목록 출력
		public ArrayList<Qna> selectQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaList beginRow : "+beginRow);
			System.out.println("[Debug] QnaDao.selectQnaList rowPerPage : "+rowPerPage);
			
			ArrayList<Qna> list = new ArrayList<>();
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT qna_secret qnaSecret,qna_no qnaNo,qna_category qnaCategory,qna_title qnaTitle,member_no memberNo,create_date createDate,update_date updateDate FROM qna ORDER BY create_date DESC LIMIT ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] QnaDao.selectQnaList stmt : "+stmt);
			System.out.println("[Debug] QnaDao.selectQnaList rs : "+rs);
			
			while(rs.next()) {
				Qna q = new Qna();
				q.setCreateDate(rs.getString("createDate"));
				q.setMemberNo(rs.getInt("memberNo"));
				q.setQnaCategory(rs.getString("qnaCategory"));
				q.setQnaNo(rs.getInt("qnaNo"));
				q.setQnaTitle(rs.getString("qnaTitle"));
				q.setUpdateDate(rs.getString("updateDate"));
				q.setQnaSecret(rs.getString("qnaSecret"));
				list.add(q);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
		
		// [회원] 개인별 Qna 목록 출력
		public ArrayList<Qna> selectQnaListOne(int beginRow, int rowPerPage, int memberNo) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaListOne beginRow : "+beginRow);
			System.out.println("[Debug] QnaDao.selectQnaListOne rowPerPage : "+rowPerPage);
			System.out.println("[Debug] QnaDao.selectQnaListOne memberNo : "+memberNo);
			
			ArrayList<Qna> list = new ArrayList<>();
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT qna_secret qnaSecret,qna_no qnaNo,qna_category qnaCategory,qna_title qnaTitle,member_no memberNo,create_date createDate,update_date updateDate FROM qna WHERE member_no = ? ORDER BY create_date DESC LIMIT ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] QnaDao.selectQnaListOne stmt : "+stmt);
			System.out.println("[Debug] QnaDao.selectQnaListOne rs : "+rs);
			
			while(rs.next()) {
				Qna q = new Qna();
				q.setCreateDate(rs.getString("createDate"));
				q.setMemberNo(rs.getInt("memberNo"));
				q.setQnaCategory(rs.getString("qnaCategory"));
				q.setQnaNo(rs.getInt("qnaNo"));
				q.setQnaTitle(rs.getString("qnaTitle"));
				q.setUpdateDate(rs.getString("updateDate"));
				q.setQnaSecret(rs.getString("qnaSecret"));
				list.add(q);
			}
				
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}

		
		// [회원] qna 생성
		public void insertQna(Qna qna) throws ClassNotFoundException, SQLException {
			// 매개변수값은 무조건 디버깅
			System.out.println("[Debug] QnaDao.insertQna "+qt.toString());
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "INSERT INTO qna(qna_category,qna_title,qna_content,qna_secret,member_no,ebook_no,create_date,update_date) VALUE(?,?,?,?,?,?,NOW(),NOW())";     
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, qna.getQnaCategory());
			stmt.setString(2, qna.getQnaTitle());
			stmt.setString(3, qna.getQnaContent());
			stmt.setString(4, qna.getQnaSecret());
			stmt.setInt(5, qna.getMemberNo());
			stmt.setInt(6, qna.getEbookNo());
			ResultSet rs = stmt.executeQuery();
			
			System.out.println("[Debug] QnaDao.insertQna stmt : "+stmt);
			System.out.println("[Debug] QnaDao.insertQna rs : "+rs);
			
			rs.close();
			stmt.close();
			conn.close();
		}
		
		// [관리자] Qna 목록 마지막 페이지 도출
		public int selectQnaLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaLastPage rowPerPage : "+rowPerPage);
	
			
			int lastPage = 0;
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT COUNT(*) from qna";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			int totalRowCount = 0;
			
			System.out.println("[Debug] QnaDao.selectQnaLastPage stmt : "+stmt);
			System.out.println("[Debug] QnaDao.selectQnaLastPage rs : "+rs);
			
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
		
		// [모든 사용자] 해당 ebook Qna 목록 마지막 페이지 도출
		public int selectQnaLastPageByOne(int ebookNo, int rowPerPage) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaLastPageByOne ebookNo : "+ebookNo);
			System.out.println("[Debug] QnaDao.selectQnaLastPageByOne rowPerPage : "+rowPerPage);
	
			
			int lastPage = 0;
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT COUNT(*) from qna WHERE ebook_no = ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			ResultSet rs = stmt.executeQuery();
			int totalRowCount = 0;
			
			System.out.println("[Debug] QnaDao.selectQnaLastPage stmt : "+stmt);
			System.out.println("[Debug] QnaDao.selectQnaLastPage rs : "+rs);
			
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
		
		// [회원] 개인별 Qna 목록 마지막 페이지 도출
		public int selectQnaLastPageByMember(int memberNo, int rowPerPage) throws ClassNotFoundException, SQLException {
			System.out.println("[Debug] QnaDao.selectQnaLastPageByMember memberNo : "+memberNo);
			System.out.println("[Debug] QnaDao.selectQnaLastPageByMember rowPerPage : "+rowPerPage);
	
			
			int lastPage = 0;
			// 마리아db 연결 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT COUNT(*) from qna WHERE member_no = ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			ResultSet rs = stmt.executeQuery();
			int totalRowCount = 0;
			
			System.out.println("[Debug] QnaDao.selectQnaLastPageByMember stmt : "+stmt);
			System.out.println("[Debug] QnaDao.selectQnaLastPageByMember rs : "+rs);
			
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

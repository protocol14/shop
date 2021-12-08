package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Qna;
import vo.QnaComment;

public class QnaCommentDao {
	QnaComment qct = new QnaComment();
	
	// [관리자] 답글 달지 않은 Qna 목록 마지막 페이지 도출
	public int selectNotAnswerQnaLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] QnaDao.selectQnaLastPageByOne rowPerPage : "+rowPerPage);

		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) from qna q left JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE qc.qna_no IS NULL";
		
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
	
	// [관리자, 회원] 문의 상태
	public boolean selectQnaAnswerState(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] QnaCommentDao.selectQnaAnswerState qna_no : "+qnaNo);
		
		boolean result = true;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT q.*, qc.* from qna q left JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE q.qna_no=? AND qc.qna_no IS NULL";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] QnaDao.selectQnaList stmt : "+stmt);
		System.out.println("[Debug] QnaDao.selectQnaList rs : "+rs);
		
		if(rs.next()) {
			result = false;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return result;
	}
	
	// [관리자] 답글 달지 않은 Qna 목록 출력
	public ArrayList<Qna> selectNotAnswerQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] QnaCommentDao.selectNotAnswerQnaList beginRow : "+beginRow);
		System.out.println("[Debug] QnaCommentDao.selectNotAnswerQnaList rowPerPage : "+rowPerPage);
		
		ArrayList<Qna> list = new ArrayList<>();
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT q.*, qc.* from qna q left JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE qc.qna_no IS NULL ORDER BY q.create_date DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] QnaDao.selectQnaList stmt : "+stmt);
		System.out.println("[Debug] QnaDao.selectQnaList rs : "+rs);
		
		while(rs.next()) {
			Qna q = new Qna();
			q.setCreateDate(rs.getString("create_date"));
			q.setMemberNo(rs.getInt("member_no"));
			q.setQnaCategory(rs.getString("qna_category"));
			q.setQnaNo(rs.getInt("qna_no"));
			q.setQnaTitle(rs.getString("qna_title"));
			q.setCreateDate(rs.getString("create_date"));
			q.setUpdateDate(rs.getString("update_date"));
			list.add(q);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [관리자] 답변 상세
	public ArrayList<QnaComment> selectQnaCommentOne(int qnaNo) throws SQLException, ClassNotFoundException {
		System.out.println("[Debug] QnaCommentDao.updateQnaComment param qnaNo : "+qnaNo);
		
		ArrayList<QnaComment> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo,qna_comment_content qnaCommentContent,member_no memberNo,create_date createDate, update_date updateDate FROM qna_comment WHERE qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			QnaComment q = new QnaComment();
			q.setMemberNo(rs.getInt("memberNo"));
			q.setQnaNo(rs.getInt("QnaNo"));
			q.setQnaCommentContent(rs.getString("qnaCommentContent"));
			q.setCreateDate(rs.getString("createDate"));
			q.setUpdateDate(rs.getString("updateDate"));
			list.add(q);
		}
		
		System.out.println("[Debug] QnaCommentDao.updateQnaComment stmt : "+stmt);
		System.out.println("[Debug] QnaCommentDao.updateQnaComment rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [관리자] 문의 답변 수정
	public void updateQnaComment(String QnaCommentContent, int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] QnaCommentDao.updateQnaComment "+qct.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE qna_comment SET qna_comment_content,update_date=NOW() WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, QnaCommentContent);
		stmt.setInt(2, qnaNo);
		stmt.executeQuery();
		// debug
		System.out.println("[Debug] QnaCommentDao.updateQnaComment param stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
	
	// [관리자] 문의 답변 추가
	public void insertQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] QnaCommentDao.insertQnaComment "+qct.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna_comment(qna_no,qna_comment_content,member_no, update_date, create_date) VALUES (?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		stmt.executeQuery();
		// debug
		System.out.println("[Debug] QnaCommentDao.insertQnaComment param stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
}

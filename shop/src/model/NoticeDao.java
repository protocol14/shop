package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Notice;

public class NoticeDao {
	Notice nt = new Notice();
	
	// [관리자] 공지글 수정
	public void updateNoticeByAdmin(Notice notice) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] NoticeDao.updateNoticeByAdmin "+nt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_content=?,update_date=NOW() WHERE notice_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeContent());
		stmt.setInt(2, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] NoticeDao.updateNoticeByAdmin stmt : "+stmt);
		System.out.println("[Debug] NoticeDao.updateNoticeByAdmin rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [관리자] 공지글 삭제
	public void deleteNoticeByAdmin(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] NoticeDao.deleteNoticeByAdmin param No : "+noticeNo);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "Delete FROM notice WHERE notice_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] NoticeDao.deleteNoticeByAdmin stmt : "+stmt);
		System.out.println("[Debug] NoticeDao.deleteNoticeByAdmin rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [모든 사용자] 공지글 출력
	public ArrayList<Notice> selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] NoticeDao.selectNoticeOne noticeNo : "+noticeNo);
		
		ArrayList<Notice> list = new ArrayList<>();
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo,member_no memberNo,notice_title noticeTitle,notice_content noticeContent,create_date createDate,update_date updateDate FROM notice WHERE notice_no=?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] selectNoticeOne stmt : "+stmt);
		System.out.println("[Debug] selectNoticeOne rs : "+rs);
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setMemberNo(rs.getInt("memberNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreateDate(rs.getString("createDate"));
			n.setUpdateDate(rs.getString("updateDate"));
			list.add(n);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [모든 사용자] 공지글 목록 출력
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] NoticeDao.selectNoticeList beginRow : "+beginRow);
		System.out.println("[Debug] NoticeDao.selectNoticeList rowPerPage : "+rowPerPage);
		
		ArrayList<Notice> list = new ArrayList<>();
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM notice ORDER BY create_date DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] selectNoticeList stmt : "+stmt);
		System.out.println("[Debug] selectNoticeList rs : "+rs);
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("notice_no"));
			n.setMemberNo(rs.getInt("member_no"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setCreateDate(rs.getString("create_date"));
			n.setUpdateDate(rs.getString("update_date"));
			list.add(n);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	
	// [관리자] 공지글 생성
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		// 매개변수값은 무조건 디버깅
		System.out.println("[Debug] NoticeDao.updateNoticeByAdmin "+nt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(member_no,notice_title,notice_content,create_date,update_date) VALUE(?,?,?,NOW(),NOW())";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getMemberNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] NoticeDao.insertNotice stmt : "+stmt);
		System.out.println("[Debug] NoticeDao.insertNotice rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [관리자] 공지탭 마지막 페이지 도출
	public int selectNoticeLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] NoticeDao.selectNoticeLastPage rowPerPage : "+rowPerPage);

		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) from notice";
		
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

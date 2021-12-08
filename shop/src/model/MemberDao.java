package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	Member mt = new Member();
	
	// [관리자] 회원등급수정
	public void updateMemberLevelByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// 매개변수값은 무조건 디버깅
		// [Debug]
		System.out.println("[Debug] MemberDao.updateMemberLevelByAdmin "+mt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_level=? WHERE member_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.updateMemberLevelByAdmin stmt : "+stmt);
		System.out.println("[Debug] MemberDao.updateMemberLevelByAdmin rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}

	// [관리자] 회원PW수정
	public void updateMemberPwByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.updateMemberPwByAdmin "+mt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw=PASSWORD(?) WHERE member_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberPw());
		stmt.setInt(2, member.getMemberNo());
		stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.updateMemberLevelByAdmin stmt : "+stmt);
		
		stmt.close();
		conn.close();
	}
	
	// [관리자] 회원삭제
	public void deleteMemberByAdmin(int memberNo) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.deleteMemberByAdmin memberNo : "+memberNo);
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "Delete FROM member WHERE member_no=?";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.deleteMemberByAdmin stmt : "+stmt);
		System.out.println("[Debug] MemberDao.deleteMemberByAdmin rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [관리자] 회원목록출력
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int ROW_PER_PAGE, String searchMemberId) throws ClassNotFoundException, SQLException{
		// [Debug]
		System.out.println("[Debug] MemberDao.selectMemberListAllBySearchMemberId beginRow : "+beginRow);
		System.out.println("[Debug] MemberDao.selectMemberListAllBySearchMemberId ROW_PER_PAGE : "+ROW_PER_PAGE);
		System.out.println("[Debug] MemberDao.selectMemberListAllBySearchMemberId searchMemberId : "+searchMemberId);
		
		ArrayList<Member> Memberlist = new ArrayList<Member>();
		/*
		 * SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_age memberAge, member_gender memberGender,
		 * update_date updateDate, create_date createDate FROM member 
		 * WHERE member_id LIKE %?%
		 * ORDER BY create_date DESC LIMIT ?, ?
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId,member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, ROW_PER_PAGE);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.selectMemberListAllBySearchMemberId stmt : "+stmt);
		System.out.println("[Debug] MemberDao.selectMemberListAllBySearchMemberId rs : "+rs);
		
		while(rs.next()) {
			Member returnMember = new Member();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			// board.boardCategory = rs.getString("board_category");
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			returnMember.setMemberName(rs.getString("memberName"));
			returnMember.setMemberAge(rs.getInt("memberAge"));
			returnMember.setMemberGender(rs.getString("memberGender"));
			returnMember.setUpdateDate(rs.getString("updateDate"));
			returnMember.setCreateDate(rs.getString("createDate"));
			Memberlist.add(returnMember);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return Memberlist;
	}
	
	// [관리자] 멤버 마지막 페이지 도출
	public int selectMemberLastPage(int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.selectMemberLastPage rowPerPage : "+rowPerPage);
		System.out.println("[Debug] MemberDao.selectMemberLastPage searchMemberId : "+searchMemberId);
		
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "";
		if(searchMemberId.equals("") == true) {
			sql = "SELECT COUNT(*) from member";
		} else {
			sql = "SELECT COUNT(*) from member WHERE member_id LIKE '%"+searchMemberId+"%'";
		}
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;
		
		System.out.println("[Debug] selectLastPage stmt : "+stmt);
		System.out.println("[Debug] selectLastPage rs : "+rs);
		
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
	
	
	// [관리자] 회원목록출력
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int ROW_PER_PAGE) throws ClassNotFoundException, SQLException{
		System.out.println("[Debug] MemberDao.selectMemberListAllByPage beginRow : "+beginRow);
		System.out.println("[Debug] MemberDao.selectMemberListAllByPage ROW_PER_PAGE : "+ROW_PER_PAGE);
		
		
		ArrayList<Member> Memberlist = new ArrayList<Member>();
		/*
		 * SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_age memberAge, member_gender memberGender,
		 * update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?, ?
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId,member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.selectMemberListAllByPage stmt : "+stmt);
		System.out.println("[Debug] MemberDao.selectMemberListAllByPage rs : "+rs);
		
		while(rs.next()) {
			Member returnMember = new Member();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			// board.boardCategory = rs.getString("board_category");
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			returnMember.setMemberName(rs.getString("memberName"));
			returnMember.setMemberAge(rs.getInt("memberAge"));
			returnMember.setMemberGender(rs.getString("memberGender"));
			returnMember.setUpdateDate(rs.getString("updateDate"));
			returnMember.setCreateDate(rs.getString("createDate"));
			Memberlist.add(returnMember);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return Memberlist;
	}
	
	// [회원]
	// 1. 회원탈퇴
	// Member member : memberId와 memberPw값
	public String deleteMember(Member member) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.deleteMember "+mt.toString());
		
		String deleteMemberResult = null;
		
		// 비밀번호가 틀리면 여기서 막힘
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_pw memberPw FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			deleteMemberResult = rs.getString("memberId");
		}
		
		Connection conn2 = dbUtil.getConnection();
		String sql2 = "Delete FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, member.getMemberId());
		stmt2.setString(2, member.getMemberPw());
		stmt2.executeQuery();
		
		System.out.println("[Debug] MemberDao.deleteMember stmt : "+stmt);
		
		rs.close();
		stmt.close();
		conn.close();
		stmt2.close();
		conn2.close();
		
		return deleteMemberResult; // null이 나오면 막힘
	}
	
	
	// 2. 수정
	// [회원]
	// 2-1. 비밀번호 수정
	// Member member : memberId와 변경전 memberPw값
	// String memberPwNew : 변경할 memberPw
	public String updateMemberPw(Member member, String memberPwNew) throws SQLException, ClassNotFoundException {
		// [Debug]
		System.out.println("[Debug] MemberDao.updateMemberPw "+mt.toString());
		System.out.println("[Debug] MemberDao.updateMemberPw memberPwNew : "+memberPwNew);
		
		String updateMemberPwResult = null;
		
		// 비밀번호가 틀리면 여기서 막힘
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_pw memberPw FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			updateMemberPwResult = rs.getString("memberId");
		}
		
		Connection conn2 = dbUtil.getConnection();
		String sql2 = "UPDATE member SET member_pw=PASSWORD(?), update_date=NOW() WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, memberPwNew);
		stmt2.setString(2, member.getMemberId());
		stmt2.setString(3, member.getMemberPw());
		stmt2.executeQuery();
		
		System.out.println("[Debug] MemberDao.updateMemberPw stmt : "+stmt);
		
		rs.close();
		stmt.close();
		conn.close();
		stmt2.close();
		conn2.close();
		 
		return updateMemberPwResult; // null이 나오면 막힘
	}
	
	// 2-2. 기타수정 추가(Name, Age, Gender)
	public void updateMember(Member member) throws SQLException, ClassNotFoundException {
		// [Debug]
		System.out.println("[Debug] MemberDao.updateMember "+mt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name=?, member_age=?, member_gender=? WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberName());
		stmt.setInt(2, member.getMemberAge());
		stmt.setString(3, member.getMemberGender());
		stmt.setString(4, member.getMemberId());
		stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.updateMember stmt : "+stmt);

		stmt.close();
		conn.close();
	}
	
	// [회원]
	// 3. 회원정보출력
	public ArrayList<Member> selectMemberOne(int memberNo) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.selectMemberOne memberNo : "+memberNo);
		
		ArrayList<Member> memberListOne = new ArrayList<>();	
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.selectMemberOne stmt : "+stmt);
		System.out.println("[Debug] MemberDao.selectMemberOne rs : "+rs);
		
		while(rs.next()) {
			Member returnMember = new Member();
			
			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			// board.boardCategory = rs.getString("board_category");
			returnMember.setMemberNo(rs.getInt("member_no"));
			returnMember.setMemberId(rs.getString("member_id"));
			returnMember.setMemberPw(rs.getString("member_pw"));
			returnMember.setMemberName(rs.getString("member_name"));
			returnMember.setMemberAge(rs.getInt("member_age"));
			returnMember.setMemberGender(rs.getString("member_gender"));
			returnMember.setCreateDate(rs.getString("create_date"));
			memberListOne.add(returnMember);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return memberListOne;
	}
	
	// [비회원] 회원가입 아이디 중복 검사
	public String selectMemberIdCheck(String MemberIdCheck) throws ClassNotFoundException, SQLException {
		System.out.println("[Debug] MemberDao.selectMemberIdCheck MemberIdCheck : "+MemberIdCheck);
		
		String MemberIdResult = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, MemberIdCheck);
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println("[Debug] MemberDao.selectMemberIdCheck stmt : "+stmt);
		
		if(rs.next()) {
			MemberIdResult = rs.getString("memberId");
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
			
		return MemberIdResult;  // null이 나오면 사용 가능한 Id, 아니면 사용 불가한 아이디(이미 사용중)
	}
	
	// [비회원]
	// 4. 회원가입
	// Member member : member의 모든 값
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.insertMember "+mt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUE(?,PASSWORD(?),0,?,?,?,NOW(),NOW())";     
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.insertMember stmt : "+stmt);
		System.out.println("[Debug] MemberDao.insertMember rs : "+rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// [회원]
	// 로그인
	// 로그인 성공 시 리턴값 Member : memberId + memberName
	// 로그인 실패 시 리턴값 Member : null
	// Member member : memberId와 memberPw값
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		// [Debug]
		System.out.println("[Debug] MemberDao.login "+mt.toString());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("[Debug] MemberDao.login stmt : "+stmt);
		System.out.println("[Debug] MemberDao.login rs : "+rs);
		
		/*
		if(rs.next()) {
			Member returnMember = new Member();
			return returnMember;
		} else {
			return null;
		}
		
		if문 뒤에 오는 코드가 return null;밖에 없으므로 사실상 else의 의미가 없음
		*/
		
		if(rs.next()) {
			Member returnMember = new Member();
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			returnMember.setMemberName(rs.getString("memberName"));
			return returnMember;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return null;
	}
}

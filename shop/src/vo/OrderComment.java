package vo;

public class OrderComment {
	private int orderCommentNo;
	private int orderNo;
	private int memberNo;
	private int ebookNo;
	private int orderScore;
	private String orderContent;
	private String createDate;
	private String updateDate;
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public int getOrderScore() {
		return orderScore;
	}
	public void setOrderScore(int orderScore) {
		this.orderScore = orderScore;
	}
	public String getOrderContent() {
		return orderContent;
	}
	public void setOrderContent(String orderContent) {
		this.orderContent = orderContent;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	public int getOrderCommentNo() {
		return orderCommentNo;
	}
	public void setOrderCommentNo(int orderCommentNo) {
		this.orderCommentNo = orderCommentNo;
	}
	@Override
	public String toString() {
		return "OrderComment [orderNo=" + orderNo + ", memberNo=" + memberNo + ", ebookNo=" + ebookNo + ", orderScore="
				+ orderScore + ", orderContent=" + orderContent + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}
	
}

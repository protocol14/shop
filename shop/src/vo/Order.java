package vo;

public class Order {
	private int orderNo;
	private int ebookNo;	// private Ebook ebook;
	private int memberNo;	// private Member member;
	private int orderPrice;
	private String create_date;
	private String update_date;
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
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", memberNo=" + memberNo + ", orderPrice="
				+ orderPrice + ", create_date=" + create_date + ", update_date=" + update_date + "]";
	}
	
	
}

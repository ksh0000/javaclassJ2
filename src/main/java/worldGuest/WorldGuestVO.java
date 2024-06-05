package worldGuest;

public class WorldGuestVO {
	private int idx;
	private String masterId;
	private String guestId;
	private String nickName;
	private String content;
	private String email;
	private String visitDate;
	
	private String mid;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getVisitDate() {
		return visitDate;
	}
	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	
	@Override
	public String toString() {
		return "WorldGuestVO [idx=" + idx + ", masterId=" + masterId + ", guestId=" + guestId + ", nickName=" + nickName
				+ ", content=" + content + ", email=" + email + ", visitDate=" + visitDate + ", mid=" + mid + "]";
	}
	
}

package collabo.wato.springboot.web.WeDaily.vo;

public class WeDailyVO {
	
	// 회원관리
	private String userid = "";
	private String userpw = "";
	private String nickname = "";
	private String phone = "";
	private String use = "";
	private String createDt = "";
	private String updateDt = "";
	private int moveLike = 0;
	
	// 영화리스트 ( 번호 , 제목 , 개봉일 , 찜한 ID , 찜한 날짜 )
	private int move_num = 0; 
	private String moveTitle = ""; 
	private String moveOpen = ""; 
	private String likeID = ""; 
	private String likeCreateDt = "";
	
	// 영화순위
	private String rank  = ""; 	
	private String movieNm = ""; 
	private String openDt = ""; 
	private String audiCnt = "";
	private String audiAcc = "";
		
	// 영화검색 
	private String title = "";
	private String actor = "";
	private String image = "";
		
	 
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUse() {
		return use;
	}
	public void setUse(String use) {
		this.use = use;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getUpdateDt() {
		return updateDt;
	}
	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}
	public int getMoveLike() {
		return moveLike;
	}
	public void setMoveLike(int moveLike) {
		this.moveLike = moveLike;
	}
	
	public int getMove_num() {
		return move_num;
	}
	public void setMove_num(int move_num) {
		this.move_num = move_num;
	}
	public String getMoveTitle() {
		return moveTitle;
	}
	public void setMoveTitle(String moveTitle) {
		this.moveTitle = moveTitle;
	}
	public String getMoveOpen() {
		return moveOpen;
	}
	public void setMoveOpen(String moveOpen) {
		this.moveOpen = moveOpen;
	}
	public String getLikeID() {
		return likeID;
	}
	public void setLikeID(String likeID) {
		this.likeID = likeID;
	}
	public String getLikeCreateDt() {
		return likeCreateDt;
	}
	public void setLikeCreateDt(String likeCreateDt) {
		this.likeCreateDt = likeCreateDt;
	}
	
	public String getAudiCnt() {
		return audiCnt;
	}
	public void setAudiCnt(String audiCnt) {
		this.audiCnt = audiCnt;
	}
	public String getAudiAcc() {
		return audiAcc;
	}
	public void setAudiAcc(String audiAcc) {
		this.audiAcc = audiAcc;
	}	
	
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	

}

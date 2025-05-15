package mvc.model;

public class BoardDTO {
	private int num;
	private String id;
	private String name;
	private String subject;
	private String content;
	private String regist_day;
	private int hit;
	private String ip;
	private int liking;
	
    // 첨부파일 관련 필드 추가
    private String fileName;     // 저장된 파일명
    private String originalFileName; // 원본 파일명
    private long fileSize;       // 파일 크기
	
    private int commet_count; // 댓글 카운트
	
    
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
	public int getCommet_count() {
		return commet_count;
	}
	public void setCommet_count(int commet_count) {
		this.commet_count = commet_count;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegist_day() {
		return regist_day;
	}
	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getLiking() {
		return liking;
	}
	public void setLiking(int liking) {
		this.liking = liking;
	}
}

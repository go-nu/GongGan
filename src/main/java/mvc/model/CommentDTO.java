package mvc.model;

public class CommentDTO {
    private int num;            // 댓글 번호
    private int boardNum;       // 게시글 번호
    private String id;          // 작성자 ID
    private String content;     // 댓글 내용
    private String regist_day;  // 등록일
    
    public CommentDTO() {
        // 기본 생성자
    }
    
    // Getters & Setters
    public int getNum() {
        return num;
    }
    
    public void setNum(int num) {
        this.num = num;
    }
    
    public int getBoardNum() {
        return boardNum;
    }
    
    public void setBoardNum(int boardNum) {
        this.boardNum = boardNum;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
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
}
package mvc.model;

public class CosmeticsDTO {
    private int id;
    private String name;
    private String brand;
    private int price;
    private String main_ingredient;
    private String effect;
    private String category;
    private String image_file;
    private int likes;  //DB에 화장품 좋아요수
    
    private boolean liked;  //회원 개인의 화장품 좋아요

    // 기본 생성자
    public CosmeticsDTO() {}

    // 전체 생성자
    public CosmeticsDTO(int id, String name, String brand, int price, String main_ingredient, String effect, String category, String image_file, int likes) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.main_ingredient = main_ingredient;
        this.effect = effect;
        this.category = category;
        this.image_file = image_file;
        this.likes = likes;
    }

    // Getter / Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getMain_ingredient() { return main_ingredient; }
    public void setMain_ingredient(String main_ingredient) { this.main_ingredient = main_ingredient; }

    public String getEffect() { return effect; }
    public void setEffect(String effect) { this.effect = effect; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImage_file() { return image_file; }
    public void setImage_file(String image_file) { this.image_file = image_file; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }
    
    public boolean isLiked() { return liked; }
    public void setLiked(boolean liked) { this.liked = liked; }
}

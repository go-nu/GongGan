package dto;

import java.io.Serializable;

public class Cosmetics implements Serializable {

		private static final long serialVersionUID = -4274700572038677000L;
		
		private int id; 	        // 화장품ID
		private String name; 	    // 화장품이름
		private String brand; 	    // 화장품브랜드
		private int price;          // 가격
		private String main_ingredient; //메인성분
		private String effect;      // 효과효능
		private String category; 	// 카테고리
		private String image_file; 	// 이미지파일
		private int likes; 	        // 좋아요
		
		
		
		

		public Cosmetics() {
		        super();
		}

		public Cosmetics(String name) {
	        super();
	        this.name = name;
		}
		 
		
		
		
		public int getId() {
			return this.id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getBrand() {
			return brand;
		}

		public void setBrand(String brand) {
			this.brand = brand;
		}

		public int getPrice() {
			return price;
		}

		public void setPrice(int price) {
			this.price = price;
		}

		public String getMain_ingredient() {
			return main_ingredient;
		}

		public void setMain_ingredient(String main_ingredient) {
			this.main_ingredient = main_ingredient;
		}

		public String getEffect() {
			return effect;
		}

		public void setEffect(String effect) {
			this.effect = effect;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public String getImage_file() {
			return image_file;
		}

		public void setImage_file(String image_file) {
			this.image_file = image_file;
		}

		public int getLikes() {
			return likes;
		}

		public void setLikes(int likes) {
			this.likes = likes;
		}

		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		
}
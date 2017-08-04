package model;

import java.util.Date;

public class Board {
	private int no;
	private int category_major;
	private int category_minor;
	private String title;
	private String writer;
	private String content;
	private String date;
	private String end_date;
	private int count;
	private int quantity;
	private int state;
	private int price;
	private int optionprice;
	private int read_count;
	private int premium;
	private int total_star;
	private int num_evaluator;
	private float ratingForDetail;
	private float ratingForMain;
	private String file_name1;
	private String path;
	private int salesvolume;
	
	
	public void ratingForDetail(){
		if(total_star != 0 && num_evaluator != 0){
			this.ratingForDetail = (float)total_star / (float)num_evaluator *25;
		}else{
			this.ratingForDetail = 0;
		}
	}
	
	
	public void ratingForMain(){
		if(total_star != 0 && num_evaluator != 0){
			this.ratingForMain = (float)total_star / (float)num_evaluator *15;
		}else{
			this.ratingForMain = 0;
		}
	}
	
	
	public float getRatingForDetail() {
		return ratingForDetail;
	}
	
	public float getRatingForMain() {
		return ratingForMain;
	}

	


	public int getSalesvolume() {
		return salesvolume;
	}


	public void setSalesvolume(int salesvolume) {
		this.salesvolume = salesvolume;
	}


	public String getPath() {
		return path;
	}



	public void setPath(String path) {
		this.path = path;
	}



	public void setRatingForDetail(float ratingForDetail) {
		this.ratingForDetail = ratingForDetail;
	}
	
	public void setRatingForMain(float ratingForMain) {
		this.ratingForMain = ratingForMain;
	}




	public String getFile_name1() {
		return file_name1;
	}




	public void setFile_name1(String file_name1) {
		this.file_name1 = file_name1;
	}




	public int getCount() {
		return count;
	}




	public void setCount(int count) {
		this.count = count;
	}




	public Board() {
		super();
	}

	
	

	public Board(int no, int category_major, int category_minor, String title, String writer, String content, String date,
			String end_date, int quantity, int state, int price, int optionprice, int read_count, int premium,
			int total_star, int num_evaluator, int salesvolume) {
		super();
		this.no = no;
		this.category_major = category_major;
		this.category_minor = category_minor;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.date = date;
		this.end_date = end_date;
		this.quantity = quantity;
		this.state = state;
		this.price = price;
		this.optionprice = optionprice;
		this.read_count = read_count;
		this.premium = premium;
		this.total_star = total_star;
		this.num_evaluator = num_evaluator;
		this.salesvolume = salesvolume;
	}




	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getCategory_major() {
		return category_major;
	}


	public void setCategory_major(int category_major) {
		this.category_major = category_major;
	}


	public int getCategory_minor() {
		return category_minor;
	}


	public void setCategory_minor(int category_minor) {
		this.category_minor = category_minor;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getEnd_date() {
		return end_date;
	}


	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public int getState() {
		return state;
	}


	public void setState(int state) {
		this.state = state;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getOptionprice() {
		return optionprice;
	}


	public void setOptionprice(int optionprice) {
		this.optionprice = optionprice;
	}


	public int getRead_count() {
		return read_count;
	}


	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}


	public int getPremium() {
		return premium;
	}


	public void setPremium(int premium) {
		this.premium = premium;
	}


	public int getTotal_star() {
		return total_star;
	}


	public void setTotal_star(int total_star) {
		this.total_star = total_star;
	}


	public int getNum_evaluator() {
		return num_evaluator;
	}


	public void setNum_evaluator(int num_evaluator) {
		this.num_evaluator = num_evaluator;
	}




	@Override
	public String toString() {
		return "Board [no=" + no + ", category_major=" + category_major + ", category_minor=" + category_minor
				+ ", title=" + title + ", writer=" + writer + ", content=" + content + ", date=" + date + ", end_date="
				+ end_date + ", count=" + count + ", quantity=" + quantity + ", state=" + state + ", price=" + price
				+ ", optionprice=" + optionprice + ", read_count=" + read_count + ", premium=" + premium
				+ ", total_star=" + total_star + ", num_evaluator=" + num_evaluator + ", file_name1=" + file_name1
				+ "]";
	}



	
	
	
	
		
	
	
	
	

}

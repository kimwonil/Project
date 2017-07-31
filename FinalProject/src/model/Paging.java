package model;



public class Paging {

	private int pageSize = 5;//한페이지에 표시될 레코드 갯수
	private int count;//총 레코드 갯수
	private int lastPage;//최종 페이지
	private int currentPage;//현재 페이지
	private int start;//시작 레코드(표시되는)
	private int end;//마지막 레코드(표시되는)
	private int startPage;//시작 페이지 인덱스
	private int endPage;//마지막 페이지 인덱스
	
	@Override
	public String toString() {
		return "Paging [표시할 레코드 갯수=" + pageSize
				+ ",\n 총 레코드=" + count + ",\n 최종 페이지=" + lastPage + ",\n 현재 페이지=" + currentPage + 
				",\n시작 인덱스="+startPage+",\n마지막 인덱스="+endPage+	",\n 시작레코드="
				+ start + ",\n 마지막레코드=" + end + "]";
	}
	
	public Paging(int count, int currentPage) {
		//표시할 레코드 갯수(고정)
		pageSize=5;
		//총 레코드 갯수
		this.count=count;
		//현재 페이지
		this.currentPage=currentPage;
		
	}
	
	
	public void boardPaging(){
		lastPage = (count/pageSize) + (count%pageSize==0?0:1);
		
		if(currentPage<=3){
			startPage = 1;
			endPage = 5;
		}else if(currentPage>=lastPage-2){
			startPage = currentPage - 2;
			endPage = lastPage;
		}else{
			startPage = currentPage - 2;
			endPage = currentPage + 2;
		}
		
		start = (currentPage-1)*pageSize+1;
		end = currentPage * pageSize;
		
	}

//	public void myPagePaging(){
//		lastPage = (count/pageSize) + (count%pageSize==0?0:1);
//		
//		if(currentPage<3){
//			startPage=1;
//			endPage=3;
//		}else if(currentPage==lastPage || currentPage==lastPage-1){
//			startPage = currentPage-1;
//			endPage = lastPage;
//		}else{
//			startPage = currentPage-1;
//			endPage = currentPage+1;
//		}
//		
//		start = (currentPage-1)*pageSize;
//		end = currentPage * pageSize;
//		
//	}
	
	
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getCount() {
		return count;
	}

	public int getLastPage() {
		return lastPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getStart() {
		return start;
	}

	public int getEnd() {
		return end;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}


	
	
	
	
	
}



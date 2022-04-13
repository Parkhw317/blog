package vo;
// category 테이블 VO(도메인 객체) : VO, DTO, Domain
public class Category {
	public Category() {}
		private String categoryName;
		private String createDate;
		private String updateDate;
		
		
		public String getCategoryName() {
			return categoryName;
		}
		public void setCategoryName(String categoryName) {
			this.categoryName = categoryName;
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
	
}


/* 

	카테고리 지정 안했을때... 
	
	[1]
	Select board_no, category_name, board_title, create_date from board
	order by create_date DESC
	limit 0,10;
		
	위 [1] 쿼리을 받아서 화면에 나타내면 된다.
	
	근데 만약에 카테고리를 지정 할경우엔 
	
	[2]
	Select board_no, category_name, board_title, create_date from board
	WHERE category_name=?
	order by create_Date DESC
	limit 0,10;

	[2] 쿼리값을 받아서 화면에 나타내면 된다.
	
	
	이럴 경우 if [1] else [2] 
	

*/
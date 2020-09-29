package commons;

import java.util.*;

public class ListPage {
	private int currentPage;
	private int rowPerPage;
	private int naviAmount;

	private int totalRow;

	public int getCurrentPage() {
		return this.currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return this.rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getNaviAmount() {
		return this.naviAmount;
	}
	public void setNaviAmount(int naviAmount) {
		this.naviAmount = naviAmount;
	}
	public int getTotalRow() {
		return this.totalRow;
	}
	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
		
		System.out.println(getNaviStartPage()+"<-ListPage.getNaviStartPage()");
		System.out.println(getNaviEndPage()+"<-ListPage.getNaviEndPage()");
		System.out.println(getNaviLastPage()+"<-ListPage.getNaviLastPage()");
		System.out.println(getNaviPageList()+"<-ListPage.getNaviPageList()");
	}
	
	public int getQueryIndex() {
		int currentPage = this.getCurrentPage();
		int rowPerPage = this.getRowPerPage();
		
		return (currentPage-1)*rowPerPage;
	}
	
	public boolean isFirstNaviPage() {
		int naviStartPage = this.getNaviStartPage();
		
		return naviStartPage <= 1;
	}
	public boolean isLastNaviPage() {
		int naviEndPage = this.getNaviEndPage();
		int naviLastPage = this.getNaviLastPage();
		
		return naviEndPage >= naviLastPage;
	}
	public int getNaviStartPage() {
		int currentPage = this.getCurrentPage();
		int naviAmount = this.getNaviAmount();
		
		int result = currentPage - (currentPage%naviAmount) + 1;
		if (currentPage%naviAmount == 0) {
			result -= naviAmount;
		}
		
		return result;
	}
	public int getNaviEndPage() {
		int naviStartPage = this.getNaviStartPage();
		int naviAmount = this.getNaviAmount();
		
		return naviStartPage + naviAmount - 1;
	}
	public int getNaviLastPage() {
		int totalRow = this.getTotalRow();
		int rowPerPage = this.getRowPerPage();
		
		int result = totalRow/rowPerPage;
		if (totalRow%rowPerPage != 0) {
			result += 1;
		}
		
		return result;
	}
	public ArrayList<Integer> getNaviPageList() {
		ArrayList<Integer> returnList = new ArrayList<Integer>();
		
		int naviStartPage = this.getNaviStartPage();
		int naviEndPage = this.getNaviEndPage();
		
		for (int naviPage = naviStartPage; naviPage <= naviEndPage; naviPage += 1) {
			if (naviPage > this.getNaviLastPage()) {
				break;
			}
			
			returnList.add(naviPage);
		}
		
		return returnList;
	}
}

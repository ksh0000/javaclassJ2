package common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import free.FreeDAO;
import free.FreeVO;
//import pds.PdsVO;

public class Pagination {

	public static void pageChange(HttpServletRequest request, int pag, int pageSize, String contentsShow, String section, String part, String friendId) {
		// 사용하는 vo가 각각 다르기에 하나의 DAO를 사용하는것 보다는, 해당 DAO에서 처리하는것이 더 편리하다.
		FreeDAO freeDao = new FreeDAO();
		
		String search = "", searchString = "";
		if(part != null && !part.equals("")) {
			if(section.equals("free")) {
				search = part.split("/")[0];
				searchString = part.split("/")[1];
			}
		}
		
		int totRecCnt = 0;
		
		if(section.equals("free")) {
			if(part == null || part.equals("")) {
			  totRecCnt = freeDao.getTotRecCnt(contentsShow, "", "",friendId);	// 게시판의 전체/조건에 따른 레코드수 구하기
			}
			else {
				totRecCnt = freeDao.getTotRecCnt(contentsShow, search, searchString,friendId);	// 게시판의 전체/조건에 따른 레코드수 구하기
			}
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<FreeVO> freeVos = null;
		
		if(section.equals("free")) {
			if(part == null || part.equals("")) {
				freeVos = freeDao.getfreeList(startIndexNo, pageSize, contentsShow, "", "",friendId);	// 게시판의 전체 자료 가져오기
			}
			else {
				freeVos = freeDao.getfreeList(startIndexNo, pageSize, contentsShow, search, searchString,friendId);
			}
			request.setAttribute("vos", freeVos);
		}
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		if(section.equals("free") && part != null && !part.equals("")) {
			String searchTitle = "";
			if(search.equals("title")) searchTitle = "글제목";
			else if(search.equals("nickName")) searchTitle = "글쓴이";
			else searchTitle = "글내용";
			request.setAttribute("search", search);
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("searchString", searchString);
			request.setAttribute("searchCount", totRecCnt);
		}
	}


}

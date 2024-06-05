package admin.free;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminInterface;
import common.Pagination;
import free.FreeDAO;
import free.FreeVO;

public class FreeListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
		HttpSession session = request.getSession();
		int level = (int) session.getAttribute("sLevel");
		String friendId = (String) session.getAttribute("sFriendId");
		String contentsShow = "";
		if(level == 3) contentsShow = "adminOK";
		else contentsShow = (String) session.getAttribute("sFriendId");
		
		FreeDAO dao = new FreeDAO();
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = 0;
		int totPage = 0;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		ArrayList<FreeVO> vos = null;
		
		if(flag.equals("admin")) {
			totRecCnt = dao.getTotRecCnt("all");
			totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
			if(pag > totPage) pag = 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStartNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage - 1) / blockSize;
			
			vos = dao.getFreeList(startIndexNo, pageSize);
			request.setAttribute("flag", flag);
		}
		else {
			if(flag.equals("admin")) {
			totRecCnt = dao.getTotRecCnt("friendId");
			totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
			if(pag > totPage) pag = 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStartNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage - 1) / blockSize;
			
			vos = (ArrayList<FreeVO>) dao.getfreeList(startIndexNo, pageSize, contentsShow, "", "", friendId);
		}
		request.setAttribute("vos", vos);
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		}
	}
}

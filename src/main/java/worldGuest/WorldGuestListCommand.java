package worldGuest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorldGuestListCommand implements WorldGuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
		HttpSession session = request.getSession();
		String sFriendId = (String) session.getAttribute("sFriendId");
		
		WorldGuestDAO dao = new WorldGuestDAO();

		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 2 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = 0;
		int totPage = 0;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		ArrayList<WorldGuestVO> vos = null;
		if(flag.equals("admin")) {
			totRecCnt = dao.getTotRecCnt("all");
			totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
			if(pag > totPage) pag = 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStartNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage - 1) / blockSize;
			
			vos = dao.getWdgAllList(startIndexNo, pageSize);
			request.setAttribute("flag", flag);
		}
		else {
			totRecCnt = dao.getTotRecCnt(sFriendId);
			totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
			if(pag > totPage) pag = 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStartNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage - 1) / blockSize;
			vos = dao.getWorldGuestList(startIndexNo, pageSize, sFriendId);
		}
		request.setAttribute("vos", vos);
		
		// 설정(지정)된 페이지의 모든 자료(변수)들을 viewPage지로 넘겨줄 준비를 한다.
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

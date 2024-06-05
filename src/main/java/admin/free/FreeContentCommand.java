package admin.free;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminInterface;
import free.FreeDAO;
import free.FreeVO;

public class FreeContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		
		FreeDAO dao = new FreeDAO();
		FreeVO vo = new FreeVO();
		
		HttpSession session = request.getSession();
		String friend = (String) session.getAttribute("sFriendId");
		
		// 게시글 조회수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "free" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setFreeReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		vo = dao.getFreeContent(idx);
		request.setAttribute("vo", vo);
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		// 이전글/다음글처리
		FreeVO preVo = dao.getPreNextSearch(idx, "preVo", friend);
		FreeVO nextVo = dao.getPreNextSearch(idx, "nextVo", friend);
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
	}
}

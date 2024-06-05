package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeInputOkCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String masterId = request.getParameter("masterId")==null ? "" : request.getParameter("masterId");
		String guestId = request.getParameter("guestId")==null ? "" : request.getParameter("guestId");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		FreeVO vo = new FreeVO();
		
		vo.setMasterId(masterId);
		vo.setGuestId(guestId);
		vo.setNickName(nickName);
		title = title.replace("<", "&lt").replace(">", "&gt");
		vo.setTitle(title);
		vo.setContent(content);
		
		FreeDAO dao = new FreeDAO();
		
		int res = dao.setFreeInput(vo);
		
		if(res != 3) {
			request.setAttribute("message", "게시글이 등록되었습니다.");
			request.setAttribute("url", "FreeList.fr");
		}
		else {
			request.setAttribute("message", "게시글 등록실패~");
			request.setAttribute("url", "FreeInput.fr");
		}
	}
}

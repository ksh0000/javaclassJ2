package worldGuest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldGuestInputOkCommand implements WorldGuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String guestId = request.getParameter("guestId")==null ? "" : request.getParameter("guestId");
		String masterId = request.getParameter("masterId")==null ? "" : request.getParameter("masterId");
		
		nickName = nickName.replace("<", "&lt");
		nickName = nickName.replace("<", "&gt");
		
		WorldGuestVO vo = new WorldGuestVO();
		
		vo.setNickName(nickName);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setGuestId(guestId);
		vo.setMasterId(masterId);
		System.out.println("vo(guest) : " + vo);
		WorldGuestDAO dao = new WorldGuestDAO();
		
		int res = dao.setWorldGuestInput(vo);
		
		
		if(res != 0) {
			request.setAttribute("message", "방명록에 글이 등록되었습니다.");
			request.setAttribute("url", "WorldGuestList.wdg");
		}
		else {
			request.setAttribute("message", "방명록에 글이 등록'안'되었습니다.");
			request.setAttribute("url", "WorldGuestInput.wdg");
		}
	}
}

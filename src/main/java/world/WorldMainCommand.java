package world;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorldMainCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String friendId = request.getParameter("friendId")==null ? "" :request.getParameter("friendId");
		WorldDAO dao = new WorldDAO();
		WorldVO vo = new WorldVO();
		HttpSession session = request.getSession();
		
		if(friendId.equals("")) {
			friendId = (String) session.getAttribute("sMid");
		}
		session.setAttribute("sFriendId", friendId);
		vo = dao.getWorldIdCheck(friendId);
		request.setAttribute("vo", vo);
		
		// 가입된 모든 회원 아이디를 검색후 넘겨준다.
		ArrayList<WorldVO> wVos = dao.getWorldList();
		request.setAttribute("wVos", wVos);
		request.setAttribute("friendId", friendId);
	}
}

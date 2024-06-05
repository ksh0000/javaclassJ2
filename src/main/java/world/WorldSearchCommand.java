package world;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldSearchCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		
		WorldDAO dao = new WorldDAO();
		
		WorldVO vo = dao.getWorldIdCheck(mid);
		
		request.setAttribute("vo", vo);
	}
}

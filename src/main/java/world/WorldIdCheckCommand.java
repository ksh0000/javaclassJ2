package world;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldIdCheckCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
			
			WorldDAO dao = new WorldDAO();
			
			WorldVO vo = dao.getWorldIdCheck(mid);
			
			String str = "0";
			if(vo.getMid() != null) str = "1";
			
			response.getWriter().write(str);
	}
}

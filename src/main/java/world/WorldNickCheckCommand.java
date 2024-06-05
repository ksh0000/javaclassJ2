package world;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldNickCheckCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String nickName = request.getParameter("nickName")==null ? "" :request.getParameter("nickName");
			
			WorldDAO dao = new WorldDAO();
			
			WorldVO vo = dao.getWorldNickCheck(nickName);
			
			String str = "0";
			if(vo.getNickName() != null) str = "1";
			
			response.getWriter().write(str);
	}
}

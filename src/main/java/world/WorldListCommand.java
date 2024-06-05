package world;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldListCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WorldDAO dao = new WorldDAO();
		
		ArrayList<WorldVO> vos = dao.getWorldList();
		
		request.setAttribute("vos", vos);
	}
}

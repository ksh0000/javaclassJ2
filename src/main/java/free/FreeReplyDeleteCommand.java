package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeReplyDeleteCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		FreeDAO dao = new FreeDAO();
		
		int res = dao.setFreeReplyDelete(idx);
		
		response.getWriter().write(res + "");
	}
}

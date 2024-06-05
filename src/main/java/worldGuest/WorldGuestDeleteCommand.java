package worldGuest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WorldGuestDeleteCommand implements WorldGuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		
		WorldGuestDAO dao = new WorldGuestDAO();
		
		int res = dao.setWorldGuestDelete(idx);
		
		
		if(res != 0) {
			request.setAttribute("message", "방명록에 글이 삭제되었습니다.");
			request.setAttribute("url", "WorldGuestList.wdg");
			
		}
		else {
			request.setAttribute("message", "방명록 글 삭제 실패!");
			request.setAttribute("url", "WorldGuestList.wdg");
		}
	}
}

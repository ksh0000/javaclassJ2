package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeDeleteCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		FreeDAO dao = new FreeDAO();
		
		int res = dao.setFreeDelete(idx);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 삭제되었습니다.");
			request.setAttribute("url", "FreeList.fr");
		}
		else {
			request.setAttribute("message", "게시글 삭제실패~");
			request.setAttribute("url", "FreeContent.fr?idx=" + idx);
		}
	}
}

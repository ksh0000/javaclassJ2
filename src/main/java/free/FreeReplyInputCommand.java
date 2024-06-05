package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeReplyInputCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int freeIdx = request.getParameter("freeIdx")==null ? 0 : Integer.parseInt(request.getParameter("freeIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		FreeReplyVO vo = new FreeReplyVO();
		
		vo.setFreeidx(freeIdx);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setContent(content);
		
		FreeDAO dao = new FreeDAO();
		
		int res = dao.setReplyInput(vo);
		
		response.getWriter().write(res + "");
	}
}

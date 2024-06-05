package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeUpdateOkCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		FreeVO vo = new FreeVO();
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setContent(content);
		
		
		FreeDAO  dao = new FreeDAO();
		
		int res = dao.setFreeUpdateOk(vo);
		
		if(res != 0) request.setAttribute("message", "게시글이 수정되었습니다.");
		else request.setAttribute("message", "게시글이 수정실패.");
		
		request.setAttribute("url", "FreeContent.fr?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
	}
}

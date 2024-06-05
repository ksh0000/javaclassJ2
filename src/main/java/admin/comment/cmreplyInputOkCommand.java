package admin.comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class cmreplyInputOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewIdx = request.getParameter("reviewIdx")==null ? 0 : Integer.parseInt(request.getParameter("reviewIdx"));
		String replyMid = request.getParameter("replyMid")==null ? "" : request.getParameter("replyMid");
		String replyNickName = request.getParameter("replyNickName")==null ? "" : request.getParameter("replyNickName");
		String replyContent = request.getParameter("replyContent")==null ? "" : request.getParameter("replyContent");
		
		CommentVO vo = new CommentVO();
		
		vo.setIdx(reviewIdx);
		vo.setReplyMid(replyMid);
		vo.setReplyNickName(replyNickName);
		vo.setReplyContent(replyContent);
		
		AdminDAO dao = new AdminDAO();
		
		int res = dao.setCmreplyInputOk(vo);
		
		response.getWriter().write(res + "");
	}
}

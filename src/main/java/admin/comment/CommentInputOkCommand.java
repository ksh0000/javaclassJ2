package admin.comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class CommentInputOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String part = request.getParameter("part")==null ? "" : request.getParameter("part");
		int partIdx = request.getParameter("partIdx")==null ? 0 : Integer.parseInt(request.getParameter("partIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		CommentVO vo = new CommentVO();
		
		vo.setPart(part);
		vo.setPartIdx(partIdx);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setContent(content);
		
		AdminDAO  dao = new AdminDAO();
		
		String str = "";
		int res = 0;
		res = dao.getCommentSearch(vo);
		
		if(res != 0) str = "현재 게시물에 이미 댓글을 작성 하셨습니다.";
		else {
			res = dao.setCommentInputOk(vo);
			if(res != 0) str = "댓글 작성 완료!!";
			else str = "댓글 작성 실패";
		}
		response.getWriter().write(str);
	}

}

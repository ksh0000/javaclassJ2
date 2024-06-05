package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
//		신규등록회원
		int mCount = dao.getNewWorldListCount();
//		방명록 새글 카운트
		int gCount = dao.getNewWorldGuestListCount();
//		자유게시판 새글 카운트
		int fCount = dao.getNewFreeListCount();
//		신고글 카운트		
		int cCount = dao.getNewComplaintListCount();
		
		
		request.setAttribute("mCount", mCount);
		request.setAttribute("gCount", gCount);
		request.setAttribute("fCount", fCount);
		request.setAttribute("cCount", cCount);
	}
}

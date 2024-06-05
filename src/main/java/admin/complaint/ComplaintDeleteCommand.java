package admin.complaint;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class ComplaintDeleteCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 :Integer.parseInt(request.getParameter("idx"));
		
		AdminDAO dao = new AdminDAO();
		
		int res = dao.setComplaintDelete(idx);
		
		if(res != 0) {
			request.setAttribute("message", "신고글이 삭제되었습니다.");
			request.setAttribute("url", "ComplaintList.ad");
		}
		else {
			request.setAttribute("message", "신고글 삭제실패~");
			request.setAttribute("url", "ComplaintList.ad" );
		}
	}

}

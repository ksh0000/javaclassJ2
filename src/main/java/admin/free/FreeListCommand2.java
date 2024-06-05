package admin.free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminInterface;
import common.Pagination;

public class FreeListCommand2 implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int level = (int) session.getAttribute("sLevel");
		String contentsShow = "";
		if(level == 3) contentsShow = "adminOK";
		else contentsShow = (String) session.getAttribute("sMid");
		
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		String friendId =request.getParameter("friendId")==null ? "" :request.getParameter("friendId");
		
		Pagination.pageChange(request, pag, pageSize, contentsShow, "free", "",friendId);
	}
}

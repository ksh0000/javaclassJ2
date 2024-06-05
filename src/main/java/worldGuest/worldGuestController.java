package worldGuest;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.wdg")
public class worldGuestController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WorldGuestInterface command = null;
		String viewPage = "/WEB-INF/worldGuest";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		 if(com.equals("/WorldGuestList")) {
			 	command = new WorldGuestListCommand();
				command.execute(request, response);
				viewPage += "/worldGuestList.jsp";
		 }
		 else if(com.equals("/WorldGuestInput")) {
			 	viewPage += "/worldGuestInput.jsp";
		 }
		 else if(com.equals("/WorldGuestInputOk")) {
				command = new WorldGuestInputOkCommand();
				command.execute(request, response);
				viewPage = "/include/message.jsp";
		 }
		 else if(com.equals("/WorldGuestDelete")) {
			 command = new WorldGuestDeleteCommand();
			 command.execute(request, response);
			 viewPage = "/include/message.jsp";
		 }
		 
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
}

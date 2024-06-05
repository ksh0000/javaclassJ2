package world;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@SuppressWarnings("serial")
@WebServlet("*.wd")
public class WorldController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WorldInterface command = null;
		String viewPage = "/WEB-INF/world";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"),com.lastIndexOf("."));
		
	// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("slevel")==null ? 999 :(int) session.getAttribute("slevel");
			
		if(com.equals("/WorldLogin")) {
			viewPage += "/worldLogin.jsp";
		}
		else if(com.equals("/WorldLoginOk")) {
			command = new WorldLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldLogout")) {
			command = new WorldLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldJoin")) {
			viewPage += "/WorldJoin.jsp";
		}
		else if(com.equals("/WorldJoinOk")) {
			command = new WorldJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldIdCheck")) {
			command = new WorldIdCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/WorldNickCheck")) {
			command = new WorldNickCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(level == 1) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/WorldLogin.wd");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldMain")) {
			command = new WorldMainCommand();
			command.execute(request, response);
			viewPage += "/WorldMain.jsp";
		}
		else if(com.equals("/WorldPwdCheck")) {
			viewPage += "/worldPwdCheck.jsp";
		}
		else if(com.equals("/WorldList")) {
			command = new WorldListCommand();
			command.execute(request, response);
			viewPage += "/worldList.jsp";
		}
		else if(com.equals("/WorldSearch")) {
			command = new WorldSearchCommand();
			command.execute(request, response);
			viewPage += "/worldSearch.jsp";
		}
		else if(com.equals("/WorldPwdCheckAjax")) {
			command = new WorldPwdCheckAjaxCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/WorldPwdChangeCheck")) {
			command = new WorldPwdChangeCheckCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldPwdCheckOk")) {
			command = new WorldPwdCheckOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldUpdate")) {
			command = new WorldUpdateCommand();
			command.execute(request, response);
			viewPage += "/worldUpdate.jsp";
		}
		else if(com.equals("/WorldUpdateOk")) {
			command = new WorldUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WorldDelete")) {
			viewPage += "/worldPwdDeleteCheck.jsp";
		}
		else if(com.equals("/WorldDeleteCheckOk")) {
			command = new WorldDeleteCheckOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

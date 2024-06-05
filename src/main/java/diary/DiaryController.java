package diary;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.da")
public class DiaryController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DiaryInterface command = null;
		String viewPage = "/WEB-INF/diary";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
//		if(level > 3) {
//			request.setAttribute("message", "로그인후 사용하세요");
//			request.setAttribute("url", request.getContextPath()+"/WorldLogin.wd");
//			viewPage = "/include/message.jsp";
//		}
		 if(com.equals("/Diary")) {
			command = new DiaryCommand();
			command.execute(request, response);
			viewPage += "/diary.jsp";
		}
		else if(com.equals("/DiaryMenu")) {
			command = new DiaryMenuCommand();
			command.execute(request, response);
			viewPage += "/diaryMenu.jsp";
		}
		else if(com.equals("/DiaryInputOk")) {
			command = new DiaryInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/DiaryDeleteOk")) {
			command = new DiaryDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/DiaryUpdateOk")) {
			command = new DiaryUpdateOkCommand();
			command.execute(request, response);
			return;
		}
		 
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
}

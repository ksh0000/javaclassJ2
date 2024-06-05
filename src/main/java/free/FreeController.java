package free;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.fr")
public class FreeController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FreeInterface command = null;
		String viewPage = "/WEB-INF/free";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
//		if(level == 1) {
//			request.setAttribute("message", "로그인후 사용하세요");
//			request.setAttribute("url", request.getContextPath()+"/WorldLogin.wd");
//			viewPage = "/include/message.jsp";
//		}
		 if(com.equals("/FreeList")) {
			command = new FreeListCommand();
			command.execute(request, response);
			viewPage += "/freeList.jsp";
		}
		 else if(com.equals("/FreeInput")) {
				viewPage += "/freeInput.jsp";
			}
		 else if(com.equals("/FreeInputOk")) {
				command = new FreeInputOkCommand();
				command.execute(request, response);
				viewPage = "/include/message.jsp";
			}
		 else if(com.equals("/FreeContent")) {
				command = new FreeContentCommand();
				command.execute(request, response);
				viewPage += "/freeContent.jsp";
			}
		 else if(com.equals("/FreeUpdate")) {
				command = new FreeUpdateCommand();
				command.execute(request, response);
				viewPage += "/FreeUpdate.jsp";
			}
		 else if(com.equals("/FreeUpdateOk")) {
				command = new FreeUpdateOkCommand();
				command.execute(request, response);
				viewPage = "/include/message.jsp";
			}
		 else if(com.equals("/FreeDelete")) {
				command = new FreeDeleteCommand();
				command.execute(request, response);
				viewPage = "/include/message.jsp";
			}
		 else if(com.equals("/FreeGoodCheck")) {
				command = new FreeGoodCheckCommand();
				command.execute(request, response);
				return;
			}
		 else if(com.equals("/FreeGoodCheckPlusMinus")) {
				command = new FreeGoodCheckPlusMinusCommand();
				command.execute(request, response);
				return;
			}
		 else if(com.equals("/FreeSearchList")) {
				command = new FreeSearchListCommand();
				command.execute(request, response);
				viewPage += "/freeSearchList.jsp";
			}
		 else if(com.equals("/FreeReplyInput")) {
				command = new FreeReplyInputCommand();
				command.execute(request, response);
				return;
			}
		 else if(com.equals("/FreeReplyDelete")) {
				command = new FreeReplyDeleteCommand();
				command.execute(request, response);
				return;
			}
		 
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
}

package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.comment.CommentDeleteCommand;
import admin.comment.CommentInputOkCommand;
import admin.comment.cmreplyInputOkCommand;
import admin.complaint.ComplaintCheckCommand;
import admin.complaint.ComplaintDeleteCommand;
import admin.complaint.ComplaintListCommand;
import admin.complaint.FreeComplaintInputCommand;
import admin.free.FreeContentCommand;
import admin.free.FreeListCommand;
import admin.world.WorldDeleteOkCommand;
import admin.world.WorldListCommand;

@SuppressWarnings("serial")
@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF/admin";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/FreeComplaintInput")) {
			command = new FreeComplaintInputCommand();
			command.execute(request, response); 
			return;
		}
		else if(com.equals("/CommentInputOk")) {
			command = new CommentInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/CommentDelete")) {
			command = new CommentDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/cmreplyInputOk")) {
			command = new cmreplyInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(level > 3) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
			}
			else if(com.equals("/AdminMain")) {
				viewPage += "/adminMain.jsp";
			}
			else if(com.equals("/AdminLeft")) {
				viewPage += "/adminLeft.jsp";
			}
			else if(com.equals("/AdminContent")) {
				command = new AdminContentCommand();
				command.execute(request, response);
				viewPage += "/adminContent.jsp";
			}
			else if(com.equals("/WorldList")) {
				command = new WorldListCommand();
				command.execute(request, response);
				viewPage += "/world/worldList.jsp";
			}
			else if(com.equals("/WorldDeleteOk")) {
				command = new WorldDeleteOkCommand();
				command.execute(request, response);
				return;
			}
			else if(com.equals("/FreeList")) {
				command = new FreeListCommand();
				command.execute(request, response);
				viewPage += "/free/freeList.jsp";
			}
			else if(com.equals("/FreeContent")) {
				command = new FreeContentCommand();
				command.execute(request, response);
				viewPage += "/free/freeContent.jsp";
			}
			else if(com.equals("/ComplaintList")) {
				command = new ComplaintListCommand();
				command.execute(request, response);
				viewPage += "/complaint/complaintList.jsp";
			}
			else if(com.equals("/ComplaintCheck")) {
				command = new ComplaintCheckCommand();
				command.execute(request, response);
				return;
			}
			else if(com.equals("/ComplaintDelete")) {
				command = new ComplaintDeleteCommand();
				command.execute(request, response);
				viewPage = "/include/message.jsp";
			}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
}

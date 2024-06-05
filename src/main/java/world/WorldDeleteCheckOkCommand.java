package world;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class WorldDeleteCheckOkCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd")==null? "" :request.getParameter("pwd");
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		WorldDAO dao = new WorldDAO();
		WorldVO vo = dao.getWorldIdCheck(mid);
		
		String salt = vo.getPwd().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("message", "비밀번호를 확인하세요.");
			request.setAttribute("url", "WorldDelete.wd");
			return;
		}
		
		int res = dao.setWorldDeleteUpdate(mid);
		
		if(res != 0) {
			session.invalidate();
			request.setAttribute("message", "회원 탈퇴 되셨습니다.");
			request.setAttribute("url", request.getContextPath()+"/WorldLogin");
		}
		else {
			request.setAttribute("message", "회원 탈퇴 실패~~");
			request.setAttribute("url", "WorldMain.wd");
		}
		
	}
}

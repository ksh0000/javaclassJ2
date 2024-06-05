package world;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class WorldPwdChangeCheckCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwdCheck")==null? "" : request.getParameter("pwdCheck");
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		WorldDAO dao = new WorldDAO();
		
		String salt = UUID.randomUUID().toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		int res = dao.setWorldPwdChange(mid, (salt + pwd));
		
		if(res != 0) {
			request.setAttribute("message", "비밀번호가 변경되었습니다.\\n다시 로그인 해주세요.");
			request.setAttribute("url", "WorldLogout.wd");
		}
		else {
			request.setAttribute("message", "비밀번호가 변경 실패~~");
			request.setAttribute("url", "WorldPwdCheck.wd");
		}
	}
}

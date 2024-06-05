package world;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;

public class WorldLoginOkCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" :request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" :request.getParameter("pwd");
		
		WorldDAO dao = new WorldDAO();
		
		WorldVO vo = dao.getWorldIdCheck(mid);
		
//		회원 인증처리
		if(vo.getPwd() == null || vo.getUserDel().equals("OK")) {
			request.setAttribute("message", "입력하신 회원정보가 없습니다.\\n확인하고 다시 로그인하세요.");
			request.setAttribute("url", "WorldLogin.wd");
			return;
		}
		
		String salt = vo.getPwd().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("message", "비밀번호를 확인하세요");
			request.setAttribute("url", "WorldLogin.wd");
			return;
		}
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);
		
		if(!strToday.equals(vo.getLastDate().substring(0,10))) {
			vo.setTodayCnt(1);
		}
		else {
			vo.setTodayCnt(vo.getTodayCnt()+1);
		}
		 dao.setLoginUpdate(vo);
	
			
//	   쿠키에 아이디를 저장/해제 처리한다.
			String idSave = request.getParameter("idSave")==null ? "off" : "on";
			Cookie cookieMid = new Cookie("cMid", mid);
			cookieMid.setPath("/");
			if(idSave.equals("on")) {
				cookieMid.setMaxAge(60*60*24*7);	
			}
			else {
				cookieMid.setMaxAge(0);
			}
			response.addCookie(cookieMid);
			
			String strLevel = "";
			if(vo.getLevel() == 3 ) strLevel = "관리자";
			else if(vo.getLevel() == 1 ) strLevel = "비로그인";
			else if(vo.getLevel() == 2 ) strLevel = "로그인";
			
//		 필요한 정보를 session에 저장처리한다.
			HttpSession session = request.getSession();
			session.setAttribute("sMid", mid);
			session.setAttribute("sFriendId", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			
			request.setAttribute("message", mid+"님 로그인 되셨습니다.");
			request.setAttribute("url", request.getContextPath()+"/WorldMain.wd");
	}
}

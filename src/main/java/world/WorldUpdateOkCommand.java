package world;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorldUpdateOkCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null? "" : request.getParameter("tel");
		String email = request.getParameter("email")==null? "" : request.getParameter("email");
		String content = request.getParameter("content")==null? "" : request.getParameter("content");
		String photo = request.getParameter("photo")==null? "noimage.jpg" : request.getParameter("photo");
		
		HttpSession session = request.getSession();
		String sNickName = (String) session.getAttribute("sNickName");
		
		WorldDAO dao = new WorldDAO();
		WorldVO vo = dao.getWorldNickCheck(nickName);
		
		if(!nickName.equals(sNickName)) {
			if(vo.getNickName() != null) {
				request.setAttribute("msg", "이미 사용중인 닉네임 입니다.");
				request.setAttribute("url", "WorldJoin.wd");
				return;
			}
		}
		
		vo = new WorldVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setEmail(email);
		vo.setPhoto(photo);
		vo.setContent(content);
		
		int res = dao.setWorldUpdateOk(vo);
		
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			request.setAttribute("message", "회원 정보가 수정되었습니다.");
			request.setAttribute("url", "WorldMain.wd");
		}
		else {
			request.setAttribute("message", "회원정보 수정 실패~~");
			request.setAttribute("url", "WorldUpdate.wd");
		}
	}
}

package world;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class WorldJoinOkCommand implements WorldInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/pic");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String mid = multipartRequest.getParameter("mid")==null? "" :multipartRequest.getParameter("mid"); 
		String pwd = multipartRequest.getParameter("pwd")==null? "" :multipartRequest.getParameter("pwd"); 
		String nickName = multipartRequest.getParameter("nickName")==null? "" :multipartRequest.getParameter("nickName"); 
		String name = multipartRequest.getParameter("name")==null? "" :multipartRequest.getParameter("name"); 
		String email = multipartRequest.getParameter("email")==null? "" :multipartRequest.getParameter("email"); 
		String gender = multipartRequest.getParameter("gender")==null? "" :multipartRequest.getParameter("gender"); 
		String birthday = multipartRequest.getParameter("birthday")==null? "" :multipartRequest.getParameter("birthday"); 
		String tel = multipartRequest.getParameter("tel")==null? "" :multipartRequest.getParameter("tel"); 
		String photo = multipartRequest.getFilesystemName("fName")==null? "a.jpg" : multipartRequest.getFilesystemName("fName");  
		String hostIp = multipartRequest.getParameter("hostIp")==null? "" :multipartRequest.getParameter("hostIp"); 
		
		
	// 아이디/닉네임 중복체크....
		WorldDAO dao = new WorldDAO();
		WorldVO vo = dao.getWorldIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("message", "이미 사용중인 아이디 입니다.");
			request.setAttribute("uRl", "WorldJoin.wd");
			return;
		}
		
		vo = dao.getWorldNickCheck(nickName);
		if(vo.getNickName() != null) {
			request.setAttribute("message", "이미 사용중인 닉네임 입니다.");
			request.setAttribute("uRl", "WorldJoin.wd");
			return;
		}
		
		
		String salt = UUID.randomUUID().toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		pwd = salt + pwd;
		
		
		
	// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장
		vo = new WorldVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setEmail(email);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setPhoto(photo);
		vo.setHostIp(hostIp);
		
		int res = dao.setWorldJoinOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원 가입되셨습니다.\\n다시 로그인해 주세요.");
			request.setAttribute("url", "WorldLogin.wd");
		}
		else {
			request.setAttribute("message", "회원가입에 실패 하셨어요😛😛");
			request.setAttribute("url", "WorldJoin.wd");		
			}
		
	}
}

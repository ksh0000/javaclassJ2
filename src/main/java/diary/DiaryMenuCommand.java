package diary;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DiaryMenuCommand implements DiaryInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		String[] ymds = request.getParameter("ymd").toString().split("-");
		
		if(ymds[1].length() == 1) ymds[1] = "0" + ymds[1];
		if(ymds[2].length() == 1) ymds[2] = "0" + ymds[2];
		
		String ymd = ymds[0] + "-" + ymds[1] + "-" + ymds[2];
		
		DiaryDAO dao = new DiaryDAO();
		
		ArrayList<DiaryVO> vos = dao.getDiaryList(mid, ymd, 1);
		
		request.setAttribute("vos", vos);
		request.setAttribute("ymd", ymd);
		request.setAttribute("diaryCnt", vos.size());
	}
}

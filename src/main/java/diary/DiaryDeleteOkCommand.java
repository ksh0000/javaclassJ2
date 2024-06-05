package diary;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DiaryDeleteOkCommand implements DiaryInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		DiaryDAO dao = new DiaryDAO();
		
		int res = dao.setDiaryDeleteOk(idx);
		
		response.getWriter().write(res + "");
	}
}

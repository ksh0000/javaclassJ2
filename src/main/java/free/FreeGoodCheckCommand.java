package free;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FreeGoodCheckCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		FreeDAO dao = new FreeDAO();
		
		String sw = "0";
		HttpSession session = request.getSession();
		ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentGood == null) contentGood = new ArrayList<String>();
		String imsiContentGood = "FreeGood" + idx;
		if(!contentGood.contains(imsiContentGood)) {
			dao.setFreeGoodCheck(idx);
			contentGood.add(imsiContentGood);
			sw = "1";
		}
		session.setAttribute("sContentGood", contentGood);
		
		response.getWriter().write(sw);
	}
}

package free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreeGoodCheckPlusMinusCommand implements FreeInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int goodCnt = request.getParameter("goodCnt")==null ? 0 : Integer.parseInt(request.getParameter("goodCnt"));
		
		FreeDAO dao = new FreeDAO();
		
		dao.setFreeGoodCheckPlusMinus(idx,goodCnt);
	}
}

package diary;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DiaryCommand implements DiaryInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(calToday.YEAR);
		int toMonth = calToday.get(calToday.MONTH);
		int toDay = calToday.get(calToday.DATE);
		
		int yy = request.getParameter("yy")==null ? toYear : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? toMonth : Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0) {
			yy--;
			mm = 11;
		}
		if(mm > 11) {
			yy++;
			mm = 0;
		}
		
		calToday.set(yy, mm, 1);
		
		int startWeek = calToday.get(calToday.DAY_OF_WEEK);
		
		int lastDay = calToday.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		int prevYear = yy;
		int prevMonth = mm - 1;
		int nextYear = yy;
		int nextMonth = mm + 1;
		
		if(prevMonth == -1) {
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) {
			nextYear++;
			nextMonth = 0;
		}
		
		calToday.set(prevYear, prevMonth, 1);
		int prevLastDay = calToday.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		calToday.set(nextYear, nextMonth, 1);
		int nextStartWeek = calToday.get(Calendar.DAY_OF_WEEK);
		
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("prevLastDay", prevLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		String ym = "";
		if((mm+1) < 10) ym = yy + "-0" + (mm + 1);
		else ym = yy + "-" + (mm + 1);
		
		DiaryDAO dao = new DiaryDAO();
		
		ArrayList<DiaryVO> vos = dao.getDiaryList(mid, ym, 0);
		
		request.setAttribute("vos", vos);
	}
}

package guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuestListCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		  페이징 처리
		  1. 처음 접속시의 페이지 번호는 1이다. : pag = 1
		  2. 한 페이지 분량을 정한다. : pageSize = 5 (사용자가 정한다. 여기선 5건으로...)
		  3. 총 레코드 건수를 구한다. : totRecCnt => (SQL함수중 count(*)를 사용)
		  4. 총 페이지 수를 구한다.   : totPage => totRecCnt % pageSize 값이 0이면 '몫의 정수값'으로, 0이 아니면 '몫의 정수값 + 1' 로 처리한다.
		  5. 현재페이지의 시작 인덱스번호 : startIndexNo => (pag-1)*pageSize
		  6. 현재 화면에 보이는 방문소감의 시작번호 : curScrStartNo = totRecCnt - startIndexNo
		*/
		
		GuestDAO dao = new GuestDAO();
		
		// 1. 현재 페이지 구하기
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		// 2. 한 페이지 분량을 정한다.(여기선 5건으로 한다.)
		int pageSize = 5;
		
		// 3. 총 레코드 건수를 구한다.
		int totRecCnt = dao.totRecCnt();
		
		// 4. 총 페이지 수를 구한다.
		int totPage = (totRecCnt%pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		
		// 5. 현재페이지의 시작 인덱스번호
		int startIndexNo = (pag - 1) * pageSize;
		
		// 6. 현재 화면에 보이는 방문소감의 시작번호
		int curScrStartNo = totRecCnt - startIndexNo;
		
		// 총 레코드를 구한다.(페이징처리시는 한페이지의 분량만 구해온다.)
		ArrayList<GuestVO> vos = dao.getGuestList(startIndexNo, pageSize);
		
		request.setAttribute("vos", vos);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("pageSize", pageSize);
	}

}

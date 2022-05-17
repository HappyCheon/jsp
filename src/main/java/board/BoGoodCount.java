package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/boGoodCount")
public class BoGoodCount extends HttpServlet {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요수 증가처리하기
		String sw = "1"; // 이미 '좋아요'를 한번 눌렀으면 '0'으로 처음이면 '1'로 sw값을 보내준다.
		HttpSession session = request.getSession();
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "good" + idx;
		if(!goodIdx.contains(imsiGoodIdx)) {
			dao.setGoodCount(idx);
			goodIdx.add(imsiGoodIdx);
			sw = "0";	// 좋아요 버튼을 클릭했을경우는 '0'을 반환
		}
		session.setAttribute("sGoodIdx", goodIdx);
		
		response.getWriter().write(sw);	// '좋아요'를 눌렸으면 '0'을 반환, 처음이면 '1'을 반환~~
	}
}

package webMessage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WmMessageCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int mSw = request.getParameter("mSw")==null ? 1 : Integer.parseInt(request.getParameter("mSw"));
		int mFlag = (request.getParameter("mFlag")==null || request.getParameter("mFlag").equals("")) ? 1 : Integer.parseInt(request.getParameter("mFlag"));
		
		WebMessageDAO dao = new WebMessageDAO();
		WebMessageVO vo = null;
		
		if(mSw == 6) {	// 메세지 상세보기(제목클릭)클릭하면 처리부분(mSw가 6번으로 넘어온다.)
			vo = dao.getWmMessageOne(idx, mFlag);
			request.setAttribute("vo", vo);
		}
		else {
			ArrayList<WebMessageVO> vos = dao.getWmMessageList(mid,mSw);
			
			request.setAttribute("vos", vos);
			request.setAttribute("mFlag", mFlag);
		}
		request.setAttribute("mSw", mSw);
	}

}

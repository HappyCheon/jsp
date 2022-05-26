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
		
		int mSw = request.getParameter("mSw")==null ? 1 : Integer.parseInt(request.getParameter("mSw"));
		int mFlag = (request.getParameter("mFlag")==null || request.getParameter("mFlag").equals("")) ? 1 : Integer.parseInt(request.getParameter("mFlag"));
		
		WebMessageDAO dao = new WebMessageDAO();
		
		ArrayList<WebMessageVO> vos = dao.getWmMessageList(mid,mSw);
		
		request.setAttribute("vos", vos);
		request.setAttribute("mSw", mSw);
		request.setAttribute("mFlag", mFlag);
	}

}

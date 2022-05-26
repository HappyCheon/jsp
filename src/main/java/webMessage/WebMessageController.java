package webMessage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pds.PdsContentCommand;
import pds.PdsDeleteCommand;
import pds.PdsDownNumCommand;
import pds.PdsInputOkCommand;
import pds.PdsInterface;
import pds.PdsListCommand;
import pds.PdsPwdCheckCommand;
import pds.PdsTotalDownCommand;

@WebServlet("*.wm")
public class WebMessageController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WebMessageInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		// 세션이 끈겼으면 작업의 진행을 홈창으로 보낸다.
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		if(level > 4 || level == 1) {   // 세션이 끈겼으면 작업의 진행을 홈창으로 보낸다.
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}
		else if(com.equals("wmMessage")) {
			command = new WmMessageCommand();
			command.execute(request, response);
			viewPaged += "/webMessage/wmMessage.jsp";
		}
		else if(com.equals("wmInputOk")) {
			command = new WmInputOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("wmDeleteCheck")) {
			command = new WmDeleteCheckCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}

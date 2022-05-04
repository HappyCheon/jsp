package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if(com.equals("memLogin")) {
			command = new MemLoginCommand();
			command.execute(request, response);
			viewPaged += "/member/memLogin.jsp";
		}
		else if(com.equals("memLoginOk")) {
			command = new MemLoginOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		else if(com.equals("memJoin")) {
			viewPaged += "/member/memJoin.jsp";
		}
		else if(com.equals("memIdCheck")) {
			command = new MemIdCheckCommand();
			command.execute(request, response);
			viewPaged += "/member/memIdCheck.jsp";
		}
		else if(com.equals("memNickCheck")) {
			command = new MemNickCheckCommand();
			command.execute(request, response);
			viewPaged += "/member/memNickCheck.jsp";
		}
		else if(com.equals("memJoinOk")) {
			command = new MemJoinOkCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}

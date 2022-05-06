package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPaged = "/WEB-INF";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if(com.equals("adMenu")) {
			viewPaged += "/admin/adMenu.jsp";
		}
		else if(com.equals("adLeft")) {
			viewPaged += "/admin/adLeft.jsp";
		}
		else if(com.equals("adContent")) {
			viewPaged += "/admin/adContent.jsp";
		}
		else if(com.equals("adGuestList")) {
			command = new AdGuestListCommand();
			command.execute(request, response);
			viewPaged += "/admin/guest/adGuestList.jsp";
		}
		else if(com.equals("adMemList")) {
			command = new AdMemListCommand();
			command.execute(request, response);
			viewPaged += "/admin/member/adMemList.jsp";
		}
		else if(com.equals("adMemLevelChange")) {
			command = new AdMemLevelChangeCommand();
			command.execute(request, response);
			viewPaged = "/message/message.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPaged);
		dispatcher.forward(request, response);
	}
}

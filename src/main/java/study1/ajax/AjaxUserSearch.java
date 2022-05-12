package study1.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajaxUserSearch")
public class AjaxUserSearch extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		
		UserDAO dao = new UserDAO();
		
		ArrayList<UserVO> vos = dao.getUserSearch(mid);
		
//		String name = "";
//		int age = 0;
//		String address = "";
//		if(vo.getName()==null) {
//			name = "찾는 자료가 없습니다.";
//			return;
//		}
//		else {
//			name = vo.getName();
//			age = vo.getAge();
//			address = vo.getAddress();
//		}
//		String str = mid + "/" + name + "/" + age + "/" + address;
		response.getWriter().write("0");
		
		request.setAttribute("vos", vos);
		System.out.println("vos : " + vos);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/study1/ajax/ajax1.jsp");
		dispatcher.forward(request, response);
	}
}

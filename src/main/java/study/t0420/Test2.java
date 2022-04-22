package study.t0420;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/tt02Ok")
public class Test2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		int su = request.getParameter("su")==null ? 0 : Integer.parseInt(request.getParameter("su"));
		
		out.println("<p>입력받은수 ? "+su+"</p>");
		out.println("<p>거듭제곱 ? "+(su * su)+"</p>");
		out.println("<p><a href='"+request.getContextPath()+"/0420/test2.jsp'>돌아가기</a></p>");
	}
}

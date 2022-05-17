package study1.pdsTest;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/fileDelete")
public class FileDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realpath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		String fName = request.getParameter("file");
		
		File file = new File(realpath + fName);
		
		if(file.exists()) {
			file.delete();	// 서버 파일시스템에서 생성된 객체파일을 삭제처리한다.
			request.setAttribute("msg", "fileDeleteOk");
		}
		else {
			request.setAttribute("msg", "fileDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/downLoad1.st");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/message/message.jsp");
		dispatcher.forward(request, response);
	}
}

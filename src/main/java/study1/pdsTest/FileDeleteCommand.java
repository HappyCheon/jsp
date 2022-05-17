package study1.pdsTest;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study1.StudyInterface;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realpath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		String fName = request.getParameter("file");
		
		File file = new File(realpath + fName);
		
		if(file.exists()) {
			file.delete();	// 서버 파일시스템에서 생성된 객체파일을 삭제처리한다.
			response.getWriter().write("fileDeleteOk");
		}
		else {
			response.getWriter().write("fileDeleteNo");
		}
	}

}

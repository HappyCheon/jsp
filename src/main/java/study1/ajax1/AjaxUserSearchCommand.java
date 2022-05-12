package study1.ajax1;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study1.StudyInterface;
import study1.ajax.UserDAO;
import study1.ajax.UserVO;

public class AjaxUserSearchCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchStr = request.getParameter("searchStr")==null? "" : request.getParameter("searchStr");
		
		UserDAO dao = new UserDAO();
		
		ArrayList<UserVO> vos = dao.getUserSearch(searchStr);
		
		request.setAttribute("vos", vos);
		request.setAttribute("searchStr", searchStr);			// 검색기를 통해서 검색한경우 searchStr변수에 searchStr를 담아서 넘긴다.
		request.setAttribute("searchStrCnt", vos.size());
	}

}

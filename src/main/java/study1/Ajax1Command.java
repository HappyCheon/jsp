package study1;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study1.ajax.UserDAO;
import study1.ajax.UserVO;

public class Ajax1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		
		ArrayList<UserVO> vos = dao.getList();
		
		request.setAttribute("vos", vos);
	}

}

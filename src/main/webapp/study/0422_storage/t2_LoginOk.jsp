<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t2_LoginOk.jsp -->
<%
  // request.setCharacterEncoding("utf-8");

  String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
  String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
  
  if(mid.equals("admin") && pwd.equals("1234")) {
  	Cookie cookie = new Cookie("cMid", mid);
  	cookie.setMaxAge(5*60);
  	response.addCookie(cookie);
  	
  	out.println("<script>");
  	out.println("alert('"+mid+"님 로그인 되셨습니다.');");
  	out.println("location.href='t2_LoginMember.jsp';");
  	out.println("</script>");
  }
  else {
  	out.println("<script>");
  	out.println("alert('아이디/비밀번호를 확인하세요.');");
  	out.println("history.back();");
  	out.println("</script>");
  }
%>
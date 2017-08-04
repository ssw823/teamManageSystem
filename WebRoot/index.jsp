<%@ page language="java" import="java.util.*,model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User user = (User)session.getAttribute("user");
if(user==null){
	response.sendRedirect("index");
	return;
}
	
%>

<!DOCTYPE html>
  <head>
<!--[if IE]> 
<meta http-equiv="X-UA-Compatible" content="IE=8" /> 
<![endif]--> 
<!--[if IE 7]> 
<meta http-equiv="X-UA-Compatible" content="IE=7" /> 
<![endif]--> 
<!--[if IE 6]> 
<meta http-equiv="X-UA-Compatible" content="IE=6" /> 
<![endif]--> 
<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>

<frameset rows="60,*" bordercolor="#FFFFFF" framespacing="0" border="0" frameborder="no">

<frame src="logo.jsp" name="navegator" scrolling="no">

<frameset cols="175,*" bordercolor="#FFFFFF" framespacing="0" border="0" >
<frame src="menu" name="content" scrolling="no">
<frame src="main" name="target" >

</frameset>
</frameset><noframes></noframes>


</html>
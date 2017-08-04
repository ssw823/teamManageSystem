<%@ page language="java" import="java.util.*,model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>target</title>
<style type="text/css">
<!--
.STYLE1 {font-size: x-large}
-->
</style>
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" scroll="no"  style="background-color: #EFFAFE;">


<P style="TEXT-INDENT: 2em">&nbsp;</P></TD></TR></TABLE></P>
<div>
<div style="width: 500px;border: 1px solid;float: left;">
  <div align="center">球队事物公告</div>
	   <div style="padding: 10px 10px 10px 10px">
	   <div align="center" style="font-size: 22px;font-weight: bold;">${news1.title}</div>
	   <div align="center" style="margin-top: 10px">日期:<fmt:formatDate value="${news1.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
	   <div align="left" style="margin-top: 10px;line-height: 1.5;font-size: 15px">${news1.content}</div>
	   </div>  
</div>

<c:if test="${user.role.dicscode eq 'D0103'}">
<div style="width: 500px;border: 1px solid;float: left;margin-left: 20px">
	<div align="center">经理人公告</div>
	<div style="padding: 10px 10px 10px 10px">
	   <div align="center" style="font-size: 22px;font-weight: bold;">${news2.title}</div>
	   <div align="center" style="margin-top: 10px">日期:<fmt:formatDate value="${news2.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
	   <div align="left" style="margin-top: 10px;line-height: 1.5;font-size: 15px">${news2.content}</div>
	   </div>  
</div>
</c:if>
</div>
</body>
</html>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
	

</head>

<body style="background-color: #EFFAFE;">

    <table width="400" border="1"   bordercolor="#3399FF" id="customers">
	 
      <tr>
	   <td>
	   <div style="padding: 10px 10px 10px 10px">
	   <div align="center" style="font-size: 22px;font-weight: bold;">${bean.title}</div>
	   <div align="center" style="margin-top: 10px">日期:<fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
	   <div align="left" style="margin-top: 10px;line-height: 1.5;font-size: 15px">${bean.content}</div>
	   </div>
       </td>
	  </tr>
	  
	  
	  </table>
     


</body>
</html>

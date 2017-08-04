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
	
    <link href="css/validate.css" type="text/css" rel="stylesheet">

    <script src="js/jquery-1.6.2.min.js"></script>
    <script src="js/Validform_v5.3.1_min.js"></script>
</head>

<body style="background-color: #EFFAFE;">
<span class="title">
<c:if test="${status==0}">增加球队事物公告</c:if>
<c:if test="${status==1}">增加经理人公告</c:if>
<c:if test="${status==2}">增加规则知识</c:if>
<c:if test="${status==3}">增加球队赛事记录</c:if>	
</span>
<hr />
 <form  method="post" action="act_News_addNews?status=${status}" class="demoform">
  <p style="color: red;font-size: 16px;">${message}</p>
    <table width="400" border="1"   bordercolor="#3399FF" id="customers">
	 
      <tr>
	   <th width="50%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>标题:</th>
	   <td>
	   <div><input type="text" name="title" class="inputxt" datatype="*" errormsg="请输入标题！" /></div>
       </td>
	  </tr>
	  
	  
		<tr>
      <th width="50%" height="30" align="center" bgcolor="#3399FF">内容:</th>
        <td>
          		<textarea id="content1" name="content1" style="display: none;"></textarea>
				<iframe ID="eWebEditor" src="editor/ewebeditor.htm?id=content1" frameborder="0" scrolling="no" width="700" height="350"></iframe>					
       </td>
      </tr>      
	  </table>
     
 		<table align="center"  class="boc3">
      <tr>
      <td> 
	        <input name="add" type="submit" value="增加"/>
     </td>
      </tr>
   </table>
</form>
<script type="text/javascript">

$(function(){

	var demo=$(".demoform").Validform({
		tiptype:3,
		label:".label",
		showAllError:true,
		ajaxPost:false
	});

	demo.addRule([{
		ele:".inputxt:eq(0)",
		datatype:"*"
	}]);

})

</script>

</body>
</html>

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
添加账号	
</span>
<hr />
 <form  method="post" action="act_User_addUser" class="demoform">
  <p style="color: red;font-size: 16px;">${message}</p>
    <table width="400" border="1"   bordercolor="#3399FF" id="customers">
	 
      <tr>
	   <th width="50%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>用户名:</th>
	   <td>
	   <div><input type="text" name="username" class="inputxt" datatype="*" errormsg="请输入！" /></div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="50%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>权限:</th>
	   <td>
	   <div>
	      <select name="role" class="inputxt" datatype="*">
	      <option value="">&nbsp;</option>
	      <c:forEach items="${roleList}" var="bean2">
	      	<option value="${bean2.dicscode}">${bean2.dicname}</option>
	      </c:forEach>
	      </select>
		</div>
       </td>
	  </tr>	  
	  
      <tr>
	   <th width="50%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>密码:</th>
	   <td>
	   <div><input type="password" name="userpassword" class="inputxt" datatype="*6-16" nullmsg="请设置密码！" errormsg="密码范围在6~16位之间！"/></div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="50%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>确认密码:</th>
	   <td>
	   <div><input type="password" name="userpassword2"  class="inputxt" datatype="*" recheck="userpassword" nullmsg="请再输入一次密码！" errormsg="您两次输入的账号密码不一致！"/></div>
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

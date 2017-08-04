<%@ page language="java" import="java.util.*,model.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学员入学注册</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/main.css">



<script>

function checkpassword(){

var password1 = document.getElementById("password1id").value;	
var password2 = document.getElementById("password2id").value;	
var password3 = document.getElementById("password3id").value;

if(password1==''){
	alert("原密码不能为空");
	return false;
}
if(password2==''){
	alert("新密码不能为空");
	return false;
}
if(password2.length<6){
	alert("新密码的长度必须大于6位");
	return false;
}


if(password2!=password3){

	alert("新密码和确认新密码不一致，提交失败！！");
	return false;
}
return true;

}


</script>


</head>

<body style="background-color: #EFFAFE;">
	<form action="usermethod!changepwd2" method="post" onsubmit="return checkpassword()" >
		<span class="title">修改密码</span>
		<hr>
		<h6></h6>
		<table width="504" border="1" align="center" bordercolor="#3399FF"
			id="customers">
			
			
			<tr>
				<th width="98" bordercolor="#3399FF" bgcolor="#3399FF"><label
					class="nameid">旧密码</label></th>
				<td>
						<input name="password1" type="password" id="password1id" />
					</td>
			</tr>
			
			<tr>
				<th width="98" bordercolor="#3399FF" bgcolor="#3399FF"><label
					class="nameid">新密码</label></th>
				<td>
						<input name="password2" type="password" id="password2id" />
					</td>
			</tr>
			
			<tr>
				<th width="98" bordercolor="#3399FF" bgcolor="#3399FF"><label
					class="nameid">确认密码</label></th>
				<td>
						<input name="password3" type="password" id="password3id" />
					</td>
			</tr>

			
			



            </table>
            <table width="600" align="center"class="boc3">
			<tr>
				<td colspan="2" align="center" valign="middle" bordercolor="#3399FF"><input
					type="submit" name="Submit10" value="提交"  />
					&nbsp; &nbsp; &nbsp; &nbsp;<input type="reset" name="button"
					id="button" value="重置" /></td>
			</tr>
		</table>
	</form>
	
</body>
</html>


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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
a:link {
	color: #3399FF;
}
a:visited {
	color: #3399FF;
}
-->
</style>



</head>
<script type="text/javascript">
function $(objId){
return document.getElementById(objId);
}


function del_tbl(tblN,ckN,url){
var ck = document.getElementsByName(ckN);
var tab = $(tblN);

var rowIndex;
var id='';

for(var i=0;i<ck.length;i++){
    if(ck[i].checked){
    	id = ck[i].value;
	}
}
if(id==''){
	alert("请选择一条记录");
	return false;
}
if(confirm("球队管理系统提示：你确认要删除吗?")){
	window.location.href=url+'?id='+id;
}
}



function update_tbl(tblN,ckN,url){
var ck = document.getElementsByName(ckN);
var tab = $(tblN);

var rowIndex;
var id='';
for(var i=0;i<ck.length;i++){
    if(ck[i].checked){
		id = ck[i].value;
	}
}
if(id==''){
	alert("请选择一条记录");
	return false;
}else{
	window.location.href=url+'?id='+id;
}

}


function update3_tbl(tblN,ckN,url){
var ck = document.getElementsByName(ckN);
var tab = $(tblN);

var rowIndex;
var id='';
for(var i=0;i<ck.length;i++){
    if(ck[i].checked){
    	id = ck[i].value;
	}
}
if(id==''){
	alert("请选择一条记录");
	return false;
}else{
	window.location.href=url+'?id='+id;
}



}





</script>

<body style="background-color: #EFFAFE;">
<span class="title">
球队人员管理
</span>
<hr />
<table align="center" >
<form action="act_User_queryPersonInfo" method="post" name="form1" > 
    <tr>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人员名称：</td>
      <td>
         <input type="text" name="key" id="textfield3" value="${key}" />
      </td>
      <th>&nbsp;&nbsp;&nbsp;<input type="submit" name="button3" id="button3" value="查询" /></th>
  </tr>
  </form>
   </table>
   
   
  <form  action="">
    <table border="1" align="center"  bordercolor="#3399FF" id="customers">
      <tr>
        <th  bgcolor="#3399FF">选中</th>
        <th bgcolor="#3399FF" >姓名</th>
        <th bgcolor="#3399FF" >职责</th>
        <th bgcolor="#3399FF" >年龄</th>
        <th bgcolor="#3399FF" >生日</th>
        <th bgcolor="#3399FF" >性别</th>
        <th bgcolor="#3399FF" >是否单身</th>
	  </tr>
	  <c:forEach items="${list}"  var="bean">
	  <tr>
        <td><input name="del" id="del"  type="radio" value="${bean.id }" /></td>
        <td >
        <a href="act_User_showPersonInfo?id=${bean.id}">${bean.truename}</a>
        </td>
        <td >
        ${bean.role.dicname}
        </td>
        <td >
        ${bean.age}
        </td>
        <td >
        ${bean.birthday}
        </td>
        <td >
        ${bean.sex.dicname}
        </td> 
        <td >
        ${bean.danshen.dicname}
        </td>                                       
	  </tr>
	  
	  
	  </c:forEach>
	  
      
      
    </table>
	
<table width="600" align="center" class="boc3">
    <tr class="boc3" align="center">
      <td width="499" align="center">
		<a href="#" onclick="update_tbl('customers','del','act_User_findPersonInfo')">修改</a>
	   &nbsp;&nbsp;<a href="#" onclick="del_tbl('customers','del','act_User_deletePersonInfo')">删除</a> &nbsp;&nbsp;
	   <a href="####" onclick="update3_tbl('customers','del','act_User_showPersonInfo')">查看</a></td>
    </tr>
	<tr align="center"><td>${pagerinfo }</td></tr>
	
  </table>
</form>
</body>
</html>

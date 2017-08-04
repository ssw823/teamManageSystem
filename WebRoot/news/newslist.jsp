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
<c:if test="${status==0}">球队事物公告管理</c:if>
<c:if test="${status==1}">经理人公告管理</c:if>
<c:if test="${status==2}">规则知识管理</c:if>
<c:if test="${status==3}">球队赛事记录管理</c:if>	
</span>
<hr />
<!-- 
<table align="center" >
<form action="banjimethod!banjilist2" method="post" name="form1" > 
    <tr>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班级编号：</td>
      <td>
         <input type="text" name="banjibianhao" id="textfield3" value="${banjibianhao }" />
      </td>
      <td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班级名称：</td>
      <th> <label for="textfield2"></label>
        <input type="text" name="banjimingchen" id="textfield2" value="${banjimingchen }" />
      </th>
      <th>&nbsp;&nbsp;&nbsp;<input type="submit" name="button3" id="button3" value="查询" /></th>
  </tr>
  </form>
   </table>
    -->
   
   
  <form  action="">
    <table border="1" align="center"  bordercolor="#3399FF" id="customers">
      <tr>
        <th  bgcolor="#3399FF">选中</th>
        <th bgcolor="#3399FF" >标题</th>
        <th bgcolor="#3399FF" >添加日期</th>
	  </tr>
	  <c:forEach items="${list}"  var="bean">
	  <tr>
        <td><input name="del" id="del"  type="radio" value="${bean.id }" /></td>
        <td >
        <a href="act_News_showNews?id=${bean.id}">${bean.title}</a>
        </td>
        <td><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
	  </tr>
	  
	  
	  </c:forEach>
	  
      
      
    </table>
	
<table width="600" align="center" class="boc3">
    <tr class="boc3" align="center">
      <td width="499" align="center">
      	
		<a href="#" onclick="update_tbl('customers','del','act_News_findNews')">修改</a>
	   &nbsp;&nbsp;<a href="#" onclick="del_tbl('customers','del','act_News_deleteNews')">删除</a> &nbsp;&nbsp;
	   
	   <a href="####" onclick="update3_tbl('customers','del','act_News_showNews')">查看</a></td>
    </tr>
	<tr align="center"><td>${pagerinfo }</td></tr>
	
  </table>
</form>
</body>
</html>

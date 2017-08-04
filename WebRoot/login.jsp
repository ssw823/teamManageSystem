<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<html>
<HEAD><title></title>

</HEAD>
<body  marginheight="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#666666" bgcolor="5f97b2">
  <table align="center">
    <tr>
      <td align="center" height="400" valign="middle">
      <form  action="usermethod!login" method="post">
      <table  background="css/login.jpg" width="500" height="300" border="0" cellspacing="0" cellpadding="0" style="margin-top:90" align="center">
          <tr>
            <th height="130" colspan="2" class="" scope="col"></th>
		  </tr>
          <tr>
            <th width="45%" height="30" align="right" scope="row" class="">用户名:</th>
            <td width="55%" height="30" align="left">&nbsp;<input name="username" type="text" /></td>
          </tr>
          <tr>
            <th width="40%" height="30" align="right" scope="row" class="">密&nbsp;&nbsp;码:</th>
            <td height="30" align="left">&nbsp;<input name="password" type="password" size="22" ></td>
          </tr>
          <tr>
            <th width="40%" height="30" align="right" scope="row" class="">用户角色:</th>
            <td height="30" align="left">&nbsp;
				<select name="role" >
			      <option value="D0105">游客</option>
			      <option value="D0104">球员</option>
			      <option value="D0102">球队队长</option>
			      <option value="D0103">经理人</option>
			      <option value="D0101">系统管理员</option>
				</select>            
            
            </td>
          </tr>          
          <tr>
            <th height="35" colspan="2" scope="row" class=""><input type="submit" value="提交" />&nbsp;&nbsp;&nbsp;<input type="reset" value="重置" /></th>
		</tr>
        </table>
      </form>
      </td>
    </tr>
  </table>
</body>
</html>

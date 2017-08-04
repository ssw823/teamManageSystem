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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="pragma" content="no-cache">
   
<meta http-equiv="cache-control" content="no-cache">
    <style type="text/css">
      body {
        margin: 0px;
        padding: 0px;
      }
      #container {
        width : 600px;
        height: 384px;
        margin: 8px auto;
      }
    </style>	
</head>

<body style="background-color: #EFFAFE;">
<span class="title">
球队人员信息
</span>
<hr />
  <p style="color: red;font-size: 16px;">${message}</p>
    <table width="300" border="1"   bordercolor="#3399FF" id="customers">
	 
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">头像:</th>
	   <td>
	   <div>
	   <c:if test="${not empty bean.pic}"><img src="uploadfile/${bean.pic}" id="touxiang" width="200px" height="200px"/></c:if>
	   <c:if test="${empty bean.pic}"><img src="images/touxiang.jpg" id="touxiang" width="200px" height="200px"/></c:if>
		</div>
       </td>
	  </tr>


      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">职责:</th>
	   <td>
	   <div align="left">
		${bean.role.dicname}
		</div>
       </td>
	  </tr>
	  
	  
	  
	  <c:if test="${bean.role.dicscode eq 'D0104'}">
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">是否退役:</th>
	   <td>
	   <div align="left">
			<c:if test="${bean.tuiyi eq 'true'}">是</c:if>
			<c:if test="${bean.tuiyi eq 'false'}">否</c:if>
			&nbsp;
		</div>
       </td>
	  </tr>	
	  </c:if>  	  	  	  

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">姓名:</th>
	   <td>
	   <div align="left">
	   	${bean.truename}&nbsp;&nbsp;
	      </div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">年龄:</th>
	   <td>
	   <div align="left">${bean.age}岁</div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">生日:</th>
	   <td>
	   <div align="left">
	   ${bean.birthday}
	   </div>
       </td>
	  </tr>
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">性别:</th>
	   <td>
	   <div align="left">
	      ${bean.sex.dicname}
		</div>
       </td>
	  </tr>	

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">是否单身:</th>
	   <td>
	   <div align="left">
	      ${bean.danshen.dicname}
		</div>
       </td>
	  </tr>
	  	    
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">身高:</th>
	   <td>
	   <div align="left">${bean.height}cm</div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">体重:</th>
	   <td>
	   <div align="left">${bean.weight}kg</div>
       </td>
	  </tr>	  	  	  

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">爱好:</th>
	   <td>
	   	<div align="left">&nbsp;${bean.hobby}</div>
	   </div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">评价:</th>
	   <td>
	   <div align="left">&nbsp;${bean.special}</div>
       </td>
	  </tr>	
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">QQ:</th>
	   <td>
	   <div align="left">&nbsp;${bean.qq}</div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">长号:</th>
	   <td>
	   <div align="left">&nbsp;${bean.longmobile}</div>
       </td>
	  </tr>		  	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">短号:</th>
	   <td>
	   <div align="left">&nbsp;${bean.shortmobile}</div>
       </td>
	  </tr>		     
	  </table>

<c:if test="${bean.role.dicscode eq 'D0104'}">
<br/>
<br/>
<span class="title">
个人能力表
</span>
<hr />

   <div id="container">
  <table width="600px" border="1">
    <tr style="font-size: 16px;font-weight: bold;"  >
    <td>进攻</td>
    <td>${pa.attack }</td>
    </tr>
       <tr style="font-size: 16px;font-weight: bold;"  >
    <td>防守</td>
    <td>${pa.defend }</td>
    </tr>
      <tr style="font-size: 16px;font-weight: bold;"  >
    <td>速度</td>
    <td>${pa.speed }</td>
    </tr>
      <tr style="font-size: 16px;font-weight: bold;"  >
    <td>技术</td>
    <td>${pa.skill }</td>
    </tr>
      <tr style="font-size: 16px;font-weight: bold;"  >
    <td>体能</td>
    <td>${pa.power }</td>
    </tr>
      <tr style="font-size: 16px;font-weight: bold;"  >
    <td>意识</td>
    <td>${pa.cons }</td>
    </tr>
    
    </table>
    
    </div>
</c:if>
<span class="title">
个人能力详细
</span>
<hr />
<table width="600px" border="1">
	<tr style="font-size: 20px">
		<th colspan="2">进攻</th>
		<th colspan="2">防守</th>
	</tr>
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">短传：</th>
		<td width="30%">${dtl.attack1}</td>
		<th width="20%" align="left">防短</th>
		<td width="30%">${dtl.defend1}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">中传：</th>
		<td width="30%">${dtl.attack2}</td>
		<th width="20%" align="left">防中：</th>
		<td width="30%">${dtl.defend2}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">长传：</th>
		<td width="30%">${dtl.attack3}</td>
		<th width="20%" align="left">防长：</th>
		<td width="30%">${dtl.defend3}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">短接：</th>
		<td width="30%">${dtl.attack4}</td>
		<th width="20%" align="left">防跑：</th>
		<td width="30%">${dtl.defend4}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">中接：</th>
		<td width="30%">${dtl.attack5}</td>
		<th width="20%" align="left">区域：</th>
		<td width="30%">${dtl.defend5}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">长接：</th>
		<td width="30%">${dtl.attack6}</td>
		<th width="20%" align="left">单挑：</th>
		<td width="30%">${dtl.defend6}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">跑动：</th>
		<td width="30%">${dtl.attack7}</td>
		<th width="20%" align="left">联防：</th>
		<td width="30%">${dtl.defend7}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">路线：</th>
		<td width="30%">${dtl.attack8}</td>
		<th width="20%" align="left">意识：</th>
		<td width="30%">${dtl.defend8}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">加速：</th>
		<td width="30%">${dtl.attack9}</td>
		<th width="20%" align="left">团队合作：</th>
		<td width="30%">${dtl.defend9}</td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">弹跳：</th>
		<td width="30%">${dtl.attack10}</td>
		<th width="20%" align="left"></th>
		<td width="30%"></td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">意识：</th>
		<td width="30%">${dtl.attack11}</td>
		<th width="20%" align="left"></th>
		<td width="30%"></td>
	</tr>
	
	<tr style="font-size: 16px"  align="left">
		<th width="20%" align="left">团队合作：</th>
		<td width="30%">${dtl.attack12}</td>
		<th width="20%" align="left"></th>
		<td width="30%"></td>
	</tr>											
</table>
  
</body>
</html>

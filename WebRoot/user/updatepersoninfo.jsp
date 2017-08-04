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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<%=basePath %>css/main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
	
    <link href="css/validate.css" type="text/css" rel="stylesheet">

	<link rel="stylesheet" href="css/jquery.slider.min.css" type="text/css">
		<link rel="stylesheet" href="css/ajaxfileupload.css" type="text/css">
		
    <script src="js/jquery-1.6.2.min.js"></script>
    <script src="js/jquery.slider.min.js"></script>
    <script src="js/ajaxfileupload.js"></script>
    
    <script src="js/Validform_v5.3.1_min.js"></script>
    <script src="datepicker/WdatePicker.js"></script>
    <script type="text/javascript">
    function selectCheck(obj){
    	var val = obj.value;
    	if(val=='D0104'){
    		$("#postion").attr("datatype", "*");
    		$("#tuiyi").attr("datatype", "*");
			$("#postionTR").show();
			$("#tuiyiTR").show();
    	}else{
    		$("#postion").removeAttr("datatype");
    		$("#tuiyi").removeAttr("datatype");
			$("#postionTR").hide();
			$("#tuiyiTR").hide();
    	}
    }
	function ajaxFileUpload()
	{
		$("#loading")
		.ajaxStart(function(){
			$(this).show();
		})
		.ajaxComplete(function(){
			$(this).hide();
		});

		$.ajaxFileUpload
		(
			{
				url:'act_Upload_uploadpic',
				secureuri:false,
				fileElementId:'fileToUpload',
				dataType: 'json',
				//data:{name:'logan', id:'id'},
				success: function (data, status)
				{
					if(typeof(data.error) != 'undefined')
					{
						if(data.error != '')
						{
							alert(data.error);
						}else
						{
							alert(data.msg);
						}
					}
					$("#touxiang").attr("src","uploadfile/"+data.filename);
					$("#pic").val(data.filename);
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		)
		return false;
	}
    </script>
</head>

<body style="background-color: #EFFAFE;">
<br/>
<span class="title">
球队人员管理
</span>
<hr />
 <form  method="post" action="act_User_updatePersonInfo?id=${bean.id}" class="demoform">
  <p style="color: red;font-size: 16px;">${message}</p>
    <table width="400" border="1"   bordercolor="#3399FF" id="customers">
	 
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">头像:</th>
	   <td>
	   	<div>
	   <c:if test="${not empty bean.pic}"><img src="uploadfile/${bean.pic}" id="touxiang" width="200px" height="200px"/></c:if>
	   <c:if test="${empty bean.pic}"><img src="images/touxiang.jpg" id="touxiang" width="200px" height="200px"/></c:if>
	   
		<input id="fileToUpload" type="file" size="45" name="Filedata" >
		<button class="button" id="buttonUpload" onclick="return ajaxFileUpload();">上传</button>	  
		<img id="loading" src="images/loading.gif" style="display:none;"> 
	   <input type="hidden" id="pic" value="${bean.pic}" name="pic"/>
	   </div>
       </td>
	  </tr>


      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>职责:</th>
	   <td>
	   <div>
		${bean.role.dicname}
		</div>
       </td>
	  </tr>
	  
	  
	  
	  <c:if test="${bean.role.dicscode eq 'D0104'}">
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>是否退役:</th>
	   <td>
	   <div>
		<select name="tuiyi" class="inputxt" id="tuiyi">
			<option value="">&nbsp;</option>
			<option value="false" <c:if test="${bean.tuiyi eq 'false'}">selected="selected"</c:if>>否</option>
			<option value="true" <c:if test="${bean.tuiyi eq 'true'}">selected="selected"</c:if>>是</option>
		</select>
		</div>
       </td>
	  </tr>	  	
	  </c:if> 
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>姓名:</th>
	   <td>
	   <div><input type="text" name="truename" value="${bean.truename}" class="inputxt" datatype="*" errormsg="请输入姓名！" /></div>
       </td>
	  </tr>	   	  	  

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>年龄:</th>
	   <td>
	   <div><input type="text" name="age" value="${bean.age}" class="inputxt" datatype="n" />岁</div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">生日:</th>
	   <td>
	   <div>
	   <input id="d11" type="text" name="birthday" value="${bean.birthday}" onClick="WdatePicker()"/>
	   </div>
       </td>
	  </tr>
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>性别:</th>
	   <td>
	   <div>
	      <select name="sex" class="inputxt" datatype="*">
	      <option value="">&nbsp;</option>
	      <c:forEach items="${sexList}" var="bean2">
	      	<option value="${bean2.dicscode}" <c:if test="${bean.sex.dicscode eq bean2.dicscode}">selected="selected"</c:if>>${bean2.dicname}</option>
	      </c:forEach>
	      </select>
		</div>
       </td>
	  </tr>	

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff"><span class="need" style="width:10px;">*</span>是否单身:</th>
	   <td>
	   <div>
	      <select name="danshen" class="inputxt" datatype="*">
	      <option value="">&nbsp;</option>
	      <c:forEach items="${danshenList}" var="bean2">
	      	<option value="${bean2.dicscode}" <c:if test="${bean.danshen.dicscode eq bean2.dicscode}">selected="selected"</c:if>>${bean2.dicname}</option>
	      </c:forEach>
	      </select>
		</div>
       </td>
	  </tr>
	  	    
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">身高:</th>
	   <td>
	   <div><input type="text" name="height" value="${bean.height}" class="inputxt" datatype="n" />cm</div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">体重:</th>
	   <td>
	   <div><input type="text" name="weight" value="${bean.weight}" class="inputxt" datatype="n"/>kg</div>
       </td>
	  </tr>	  	  	  

      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">爱好:</th>
	   <td>
	   	<div><textarea rows="4" cols="230" name="hobby">${bean.hobby}</textarea></div>
	   </div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">评价:</th>
	   <td>
	   <div><textarea rows="4" cols="230" name="special">${bean.special}</textarea></div>
       </td>
	  </tr>	
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">QQ:</th>
	   <td>
	   <div><input type="text" name="qq" value="${bean.qq}"/></div>
       </td>
	  </tr>
	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">长号:</th>
	   <td>
	   <div><input type="text" name="longmobile" value="${bean.longmobile}"/></div>
       </td>
	  </tr>		  	  
      <tr>
	   <th width="10%" height="30" align="center" bgcolor="#3399ff">短号:</th>
	   <td>
	   <div><input type="text" name="shortmobile" value="${bean.shortmobile}"/></div>
       </td>
	  </tr>		     
	  </table>
	  
	  
<c:if test="${bean.role.dicscode eq 'D0104'}">
<br/>
<br/>
<span class="title">
个人能力信息
</span>
<hr />
	<div style=";margin-left: 350px">
		<div style="width: 600px;margin-top: 30px;">
				   <div style="float: left;font-weight: bold;">进攻：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attackSliderSingle" type="slider" name="attack" value="${pa.attack}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attackSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
		
		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">防守：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defendSliderSingle" type="slider" name="defend" value="${pa.defend}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defendSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
     	
     			
		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">速度：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="speedSliderSingle" type="slider" name="speed" value="${pa.speed}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#speedSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
     	
		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">技术：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="skillSliderSingle" type="slider" name="skill" value="${pa.skill}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#skillSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>

		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">体能：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="powerSliderSingle" type="slider" name="power" value="${pa.power}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#powerSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
     	
		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">意识：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="consSliderSingle" type="slider" name="cons" value="${pa.cons}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#consSliderSingle").slider({ from: 0, to: 7, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>  
  
	</div>
	
	
<br/>
<br/>
<span class="title">
个人能力详细-进攻
</span>
<hr />
 	<div style=";margin-left: 350px">
  		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">短传：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack1SliderSingle" type="slider" name="attack1" value="${dtl.attack1}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack1SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">中传：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack2SliderSingle" type="slider" name="attack2" value="${dtl.attack2}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack2SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">长传：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack3SliderSingle" type="slider" name="attack3" value="${dtl.attack3}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack3SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">短接：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack4SliderSingle" type="slider" name="attack4" value="${dtl.attack4}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack4SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>  
  		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">中接：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack5SliderSingle" type="slider" name="attack5" value="${dtl.attack5}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack5SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">长接：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack6SliderSingle" type="slider" name="attack6" value="${dtl.attack6}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack6SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">跑动：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack7SliderSingle" type="slider" name="attack7" value="${dtl.attack7}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack7SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">路线：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack8SliderSingle" type="slider" name="attack8" value="${dtl.attack8}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack8SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
  		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">加速：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack9SliderSingle" type="slider" name="attack9" value="${dtl.attack9}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack9SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">弹跳：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack10SliderSingle" type="slider" name="attack10" value="${dtl.attack10}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack10SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">意识：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack11SliderSingle" type="slider" name="attack11" value="${dtl.attack11}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack11SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">团队合作：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="attack12SliderSingle" type="slider" name="attack12" value="${dtl.attack12}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#attack12SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>  
     </div>
     
<br/>
<span class="title">
个人能力详细-防守
</span>
<hr />   
	<div style=";margin-left: 350px">
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">防短：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend1SliderSingle" type="slider" name="defend1" value="${dtl.defend1}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend1SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">防中：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend2SliderSingle" type="slider" name="defend2" value="${dtl.defend2}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend2SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">防长：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend3SliderSingle" type="slider" name="defend3" value="${dtl.defend3}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend3SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">防跑：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend4SliderSingle" type="slider" name="defend4" value="${dtl.defend4}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend4SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">区域：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend5SliderSingle" type="slider" name="defend5" value="${dtl.defend5}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend5SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">单挑：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend6SliderSingle" type="slider" name="defend6" value="${dtl.defend6}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend6SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div>  
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">联防：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend7SliderSingle" type="slider" name="defend7" value="${dtl.defend7}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend7SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">意识：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend8SliderSingle" type="slider" name="defend8" value="${dtl.defend8}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend8SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
   		<div style="width: 600px;margin-top: 30px">
				   <div style="float: left;font-weight: bold;">团队合作：</div>
				
		  			<div class="layout-slider" style="width: 400px;float: left;margin-left: 20px">
				      <input id="defend9SliderSingle" type="slider" name="defend9" value="${dtl.defend9}" />
				    </div>
				    <script type="text/javascript" charset="utf-8">
				      jQuery("#defend9SliderSingle").slider({ from: 0, to: 100, step: 1, round: 1, dimension: '', skin: "round" });
				    </script>
     	</div> 
		</div>     	
</c:if>  
 


     
 		<table align="center"  class="boc3">
      <tr>
      <td> 
	        <input name="add" type="submit" value="修改"/>
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

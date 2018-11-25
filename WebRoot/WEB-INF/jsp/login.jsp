<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-CN" /><title>后置需求管理系统</title>
<meta name="description" content="后置需求管理系统" />
<link rel="shortcut icon" href="favicon.gif" type="image/x-icon" />
<link rel="icon" href="favicon.gif" type="image/x-icon" />
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
<!--[if lt IE 7]>
<link rel='stylesheet' href='themes/bluetheme/ie6fix.css' type='text/css' />
<![endif]-->


<script type="text/javascript">

  //var pWindow=window.opener;
  //if(pWindow == undefined)
  //   location.href = '<%=basePath%>/app/index.jsp';
$(function() {

//只有首页使用的登录效果
$("input:text,input:password").hover(function(){$(this).addClass("hover");},function(){  $(this).removeClass("hover");});
$("input:text").focus(function(){$(this).addClass("focus");}).blur(function(){$(this).removeClass("focus");});
$("input:password").focus(function(){$(this).addClass("focus");}).blur(function(){$(this).removeClass("focus");});

$("#submitBtn").click(function(){
	$("#Button1").attr("disabled",true); 
	var userCode = $("#userCode").val();
	var password = $("#password").val();
	if(userCode==""){
		alert('请输入用户编号!');
		$("#userCode").focus();
		$("#Button1").attr("disabled",false); 
		return false;
	}
	if(password==""){
		alert('请输入用户密码!');
		$("#password").focus();
		$("#Button1").attr("disabled",false); 
		return false;
	}
	return true;
})
 
});

</script>
<style>
* {font: 12px/140% tahoma;}
body {background:#7FADD1 url(<%=basePath%>LigerUI/lib/images/login-bk.jpg) repeat-x}
#container {position:absolute;height:100%;width:100%;left:0;top:0;background: url(<%=basePath%>LigerUI/lib/images/login-bk-lt.jpg) no-repeat;}


#ologin {position:absolute;left:50%;top:192px;margin-left: -288px;background: url(<%=basePath%>LigerUI/lib/images/login-form-bk.jpg) no-repeat;width:577px; height:360px;}
#ologin label {display:block;color: #15428B;}


#loginForm {margin-left:187px;margin-top: 101px;}
#loginForm input.text {width: 180px;border:solid 1px #93B7E6;line-height:23px;height:23px;padding:0 4px;}
#loginForm input.focus {border:solid 1px #c00}
#loginForm input.submit {width: 137px;height:24px;background:url(<%=basePath%>LigerUI/lib/images/login-submit.jpg);border:none;padding:0;color:#fff;font-weight:700;}

#copyright {position:absolute;bottom:0;left:200px;top:245px;color:#B6CBDD;}

#errorInfo{display:none; color:red;}

div {border:0px solid;}
</style>
</head>
<body >
<c:if test="${loginFail!=null }">
<script type="text/javascript">
	alert('登陆出错:<c:out value="${loginFail}"/>');
</script>
</c:if>
<div id="container">

	<div id="ologin">

	<form method="post" action="<%=path%>/doLogin.do" >
		<div id="loginForm">
			<label for="username">用户编号：<input class="text" type="text" value="<c:out value="${userCode}"/>" name="userCode" id="userCode" /></label>
			<label for="password">&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;码：<input class="text" type="password" name="password" id="password"  /></label>
			<label style="margin-top:8px;margin-left:100px"><input id="submitBtn" class="submit" type="submit" value="登录"  /></label>
					<div id="errorInfo">请输入密码！</div>
		</div>
		<div id="copyright" >Copyright<sup>&copy;</sup>2014- 深圳农村商业银行</div>
	</form>	
	</div>
</div>
</body>
</html>

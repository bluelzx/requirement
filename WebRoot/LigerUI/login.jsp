<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="include.jsp"%>
<head>
	<title>后置需求管理系统--登陆</title>
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" />
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>  

    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    

    <style>
        .liger-button {
            margin-bottom: 2px;
        }
    </style>

</head>

<body style="padding: 10px;">
   <form id="form1" class="liger-form" data-validate="{}" action="">
        <div class="fields">
            <input data-type="text" data-label="用户名" data-name="username" validate="{required:true}" />
            <input data-type="password" data-label="密码" data-name="password" validate="{required:true}" />
        </div>
        </form>   
    <div class="liger-button" data-click="f_validate" data-width="100">登陆</div> 
    
    <script>
        
        function f_validate() {
            var form = liger.get('form1');
            if (form.valid()) {
                document.getElementById('form1').submit();
            }
            else {
                form.showInvalid();
            }
        } 

    </script>
</body>
</html>

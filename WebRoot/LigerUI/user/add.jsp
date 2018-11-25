<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" /> 
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="<%=path%>/LigerUI/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerButton.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>

    <script type="text/javascript">
        var eee;
        $(function () {
            $.metadata.setType("attr", "validate");
            var v = $("form").validate({
                //调试状态，不会提交数据的
                debug: false,
                errorPlacement: function (lable, element) {

                    if (element.hasClass("l-textarea")) {
                        element.addClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field")) {
                        element.parent().addClass("l-text-invalid");
                    }

                    var nextCell = element.parents("td:first").next("td");
                    nextCell.find("div.l-exclamation").remove(); 
                    $('<div class="l-exclamation" title="' + lable.html() + '"></div>').appendTo(nextCell).ligerTip(); 
                },
                success: function (lable) {
                    var element = $("#" + lable.attr("for"));
                    var nextCell = element.parents("td:first").next("td");
                    if (element.hasClass("l-textarea")) {
                        element.removeClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field")) {
                        element.parent().removeClass("l-text-invalid");
                    }
                    nextCell.find("div.l-exclamation").remove();
                },
                submitHandler: function () {
                   $("form").submit();
                }
            });
            $("form").ligerForm();
        });  
    </script>
    <style type="text/css">
           body{ font-size:12px;}
        .l-table-edit {}
        .l-table-edit-td{ padding:4px;}
        .l-button-submit,.l-button-test{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
        .l-verify-tip{ left:230px; top:120px;}
    </style>

</head>

<body style="padding:10px">

    <form name="form1" method="post" action="<%=path%>/LigerUI/user/saveUser.do"  id="form1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">用户编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="userCode" type="text" id="userCode" ltype="text" validate="{required:true,minlength:3,maxlength:10}" /></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">用户名称:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="userName" type="text" id="userName" ltype="text" validate="{required:true,minlength:3,maxlength:10}" /></td>
            <td align="left"></td>
            </tr>
            <tr>
            <td align="right" class="l-table-edit-td">用户密码:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="password" type="text" id="password" ltype="text" validate="{required:true,minlength:3,maxlength:10}" /></td>
            <td align="left"></td>
            </tr>
           
           
            <tr>
                <td align="right" class="l-table-edit-td">用户类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                <select name="userType" id="userType" ltype="select">
					<option value="1">项目管理人员</option>
					<option value="2">开发人员</option>
					<option value="3">测试人员</option>
				</select>
                </td>
                <td align="left"></td>
            </tr>
        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
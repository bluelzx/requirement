<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>修改用户密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%@ include file="include.meta.jsp"%>

    <script type="text/javascript">
       
        $(function () {
        	
        	
        	
            $.metadata.setType("attr", "validate");
            var v = $("form").validate({
                //调试状态，不会提交数据的
                debug: true,
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
                	var password1 = $("#password1").val();
                	var password2 = $("#password2").val();
                	if(password1!=password2){
                		$.ligerDialog.error('输入新密码不一致!')
                		return;
                	}
                	$.ajax({
								                type: 'POST',
								                url: '<%=path%>/modifyUserPass.do',
								                data: $("#form1").serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#Button1").attr("disabled",true);
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=='success'){
								                    	$("#Button1").attr("disabled",false);
								                    	$.ligerDialog.success('修改密码成功!')
								                     }else{
								                     	$("#Button1").attr("disabled",true);
								                     	$.ligerDialog.error('修改密码不成功!')
								                     	return;
								                     }
								                   
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                        $("#Button1").attr("disabled",false);
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
                }
            });
            $("form").ligerForm();
            
            $("#pageloading").hide();
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
<div class="l-loading" style="display:block" id="pageloading"></div> 
    <form name="form1" method="post" action="<%=path%>/modifyUserPass.do"   id="form1">
    	<input name="userCode" id="userCode" value="<c:out value="${userCode}"/>" type="hidden"/>
    	<input name="oldPass" id="oldPass" value="<c:out value="${oldPass}"/>" type="hidden"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">旧密码:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="inputOldPass" type="password" id="inputOldPass" ltype="text" validate="{required:true}" /></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">新密码:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="password1" type="password" id="password1" ltype="text" validate="{required:true,minlength:5}" /></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">再一次输入新密码:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="password" type="password" id="password2" ltype="text" validate="{required:true,minlength:5}" /></td>
            <td align="left"></td>
            </tr>
           
        </table>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>
<br>
<br>
    
</body>
</html>
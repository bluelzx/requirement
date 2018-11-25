<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="include.meta.jsp"%>
       <script type="text/javascript">
        var eee;
        
        $(function () {
             $.validator.addMethod("myUnit",function(value,element){
            	var myUnitValue = parseFloat(value);
            	if(isNaN(myUnitValue)){
            		return false;
            	}
            	var myUnitLeft = myUnitValue%0.5;
            	if(myUnitLeft>0){
            	return false;
            	}
            	return true;
            },"最小单位为0.5小时");
            
           $("#createTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
           
           $("#taskCodeText").ligerComboBox({
                onBeforeOpen: f_selectTask,slide :false, valueFieldID: 'taskCode',width:300
            });
            
            $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectUser,slide :false, valueFieldID: 'userCode',width:300
            });
            
           $("#isOT").change(function () { 
              	
              	if(this.checked){
              		$("#otHour").ligerGetTextBoxManager().setEnabled();
              		//$("#otHour").attr("disabled",false);
              	}else{
              		//$("#otHour").val("");
              		//$("#otHour").attr("disabled",true);
              		$("#otHour").ligerGetTextBoxManager().setValue('0');
              		$("#otHour").ligerGetTextBoxManager().setDisabled();
              	} 
              	
              	}
              );
            
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
                   $("#Button1").attr("disabled",true);
					form1.submit();
                }
            });
            $("form").ligerForm();
            
			$("#otHour").ligerGetTextBoxManager().setDisabled();
            
        });
        
        function f_selectTask()
        {
            $.ligerDialog.open({ title: '选择任务', name:'winselector2',width: 1000, height: 500, url: '<%=path%>/toListAllTask.do', buttons: [
                { text: '确定', onclick: f_selectTaskOK },
                { text: '取消', onclick: f_selectCancel }
            ]
            });
            return false;
        }
        
        function f_selectTaskOK(item, dialog)
        {
			var fn1 = dialog.frame.f_select || dialog.frame.window.f_select; 
            var data = fn1(); 
            if (!data)
            {
                alert('请选择行!');
                return;
            }
            var tempText = "";
            var tempIds = "";
            tempText = data[0].taskName;
            tempIds = data[0].taskCode;
            $("#taskCodeText").val(tempText);
            $("#taskCode").val(tempIds);
            dialog.close();
        }
        function f_selectCancel(item, dialog)
        {
            dialog.close();
        }
        
        function f_selectUser()
        {
            $.ligerDialog.open({ title: '选择任务执行者', name:'winselector1',width: 500, height: 400, url: '<%=path%>/toUserWorks.do', buttons: [
                { text: '确定', onclick: f_selectUserOK },
                { text: '取消', onclick: f_selectUserCancel }
            ]
            });
            return false;
        }
        
        function f_selectUserOK(item, dialog)
        {
			var fn = dialog.frame.f_select || dialog.frame.window.f_select; 
            var data1 = fn(); 
            if (!data1)
            {
                alert('请选择行!');
                return;
            }
            $("#userCodeText").val(data1.userName);
            $("#userCode").val(data1.userCode);
            dialog.close();
        }
        
        function f_selectUserCancel(item, dialog)
        {
            dialog.close();
        }
        
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

    <form name="form1" method="post" action="<%=path%>/doBackTaskSignIn.do"   id="form1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">任务编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="taskCodeText" type="text" id="taskCodeText" ltype="text" validate="{required:true}" />
                <input type="hidden" name="taskCode" id="taskCode"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">用户编号:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="userCodeText" id="userCodeText" validate="{required:true}"  />
            <input type="hidden" name="userCode" id="userCode"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">补签时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="createTime" type="text" id="createTime" ltype="text" validate="{required:true}"   />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">当天正常工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
           <input type="text" name="manHour" id="manHour" value="7" validate="{required:true,number:true,min:0,max:7,myUnit:true}"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td"><input type="checkbox" id="isOT" />加班工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
           <input type="text" name="otHour" id="otHour" value="0" validate="{number:true,myUnit:true}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>

			<tr>
            <td align="right" class="l-table-edit-td">备注:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:300px"></textarea>
            </td>
            <td align="left"></td>
            </tr>
        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
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
        var myValidate = null;
       
        $(function () {
           
           $("#startTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 0, labelAlign: 'left' });
           
           $("#endTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 0, labelAlign: 'left' });
           
           var dayData = [
                    { text: '上午', id: '1' },
                    { text: '下午', id: '2' }
                ];
           
            $("#startTimeText").ligerComboBox({  
                data: dayData, valueFieldID: 'startTimeD',initValue :1,width:100
            }); 
            
            $("#endTimeText").ligerComboBox({  
                data: dayData, valueFieldID: 'endTimeD',initValue :1,width:100
            }); 
           
           $("#proposerText").ligerComboBox({
                onBeforeOpen: f_selectUser,slide :false, valueFieldID: 'proposer',width:300
            });
           
            $.metadata.setType("attr", "validate");
            
            myValidate = $("form").validate({
                //调试状态，不会提交数据的
                debug: false,
                errorPlacement: function (lable, element) {
					
                   if (element.hasClass("l-textarea"))
                    {
                        element.addClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field"))
                    {
                        element.parent().addClass("l-text-invalid");
                    }
                    $(element).removeAttr("title").ligerHideTip();
                    $(element).attr("title", lable.html()).ligerTip();
                },
                success: function (lable) {
                   var element = $("#" + lable.attr("for"));
                    if (element.hasClass("l-textarea"))
                    {
                        element.removeClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field"))
                    {
                        element.parent().removeClass("l-text-invalid");
                    }
                    $(element).removeAttr("title").ligerHideTip();
                },
                submitHandler: function () {
                   $("#Button1").attr("disabled",true);
					form1.submit();
                }
            });
            $("form").ligerForm();
            

            
        });
        
       function checkForm(){
        	return myValidate.form();
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
            $("#proposerText").val(data1.userName);
            $("#proposer").val(data1.userCode);
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
	
    <form name="form1"  method="post" action="<%=path%>/saveVacation.do"   id="form1">
    	<input type="hidden" name="taskCode" id="taskCode" value="<c:out value="${taskCode}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >

			<tr>
            <td align="right" class="l-table-edit-td">申请人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input type="text" name="proposerText" id="proposerText" validate="{required:true}"  />
             <input type="hidden" name="proposer" id="proposer"/>
            </td>
            <td></td>
            </tr>
            
			<tr>
            <td align="right" class="l-table-edit-td">开始日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input name="startTime" type="text" id="startTime" ltype="text" validate="{required:true}" />
            </td>
            <td class="l-table-edit-td" align="left" ><input style="width:60px;" type="text" name="startTimeText" id="startTimeText" validate="{required:true}"  /><input type="hidden" name="startTimeD" id="startTimeD" value="1"/>
            </td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">结束日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input name="endTime" type="text" id="endTime" ltype="text" validate="{required:true}"   />
            </td>
            <td align="left" class="l-table-edit-td" ><input style="width:60px;" type="text" name="endTimeText" id="endTimeText" validate="{required:true}"  /><input type="hidden" name="endTimeD" id="endTimeD" value="1"/>
            </td>
            </tr>
			
            
            <tr>
            <td align="right" class="l-table-edit-td">备注:</td>
            <td colspan="2" align="left" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:300px"></textarea>
            </td>
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
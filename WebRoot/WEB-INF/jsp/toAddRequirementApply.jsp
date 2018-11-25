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
            
            $("#applyTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            $("#applyFinishTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            
             $("#taskCodeText").ligerComboBox({
                onBeforeOpen: f_selectTask,slide :false, valueFieldID: 'taskCode',width:300
            });
            
            $("#reportSelfText").ligerComboBox({  
			                data: [
			                    { text: '附带', id: '1' },
			                    { text: '不附带', id: '2' }
			                ], valueFieldID: 'reportSelf',initValue :'2'
			            });
            
            $.metadata.setType("attr", "validate");
            
            
            myValidate  = $("form").validate({
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
            
			$("#pageloading").hide();
            
           
        });
        
        function checkForm(){
        	return myValidate.form();
        }
        
        function f_selectTask()
        {
            $.ligerDialog.open({ title: '选择任务', name:'winselector2',width: 600, height: 300, url: '<%=path%>/toListTaskReportDevTask.do?requirementId=<c:out value="${requirementId}"/>', buttons: [
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
            if(data.length==0){
            	 alert('请选择行!');
                return;
            }
            var tempText = "";
            var tempIds = "";
            var taskNames = "";
            for(var i=0;i<data.length;i++){
            	taskNames = taskNames+data[i].taskName+"\r\n"
            	if(i==0){
            		tempText = data[i].taskName;
            		tempIds = data[i].taskCode;
            	}else{
            		tempText = tempText+","+data[i].taskName;
            		tempIds = tempIds+","+data[i].taskCode;
            	}
            }
            $("#taskCodeText").val(tempText);
            $("#applyName").val(taskNames);
            $("#taskCode").val(tempIds);
            dialog.close();
        }
        function f_selectCancel(item, dialog)
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
<div class="l-loading" style="display:block" id="pageloading"></div>
    <form name="form1" method="post" action="<%=path%>/doAddApplyFromRequirement.do"   id="form1">
    	<input type="hidden" id="requirementId" name="requirementId" value="<c:out value="${requirementId}"/>"/>
    	<input type="hidden" id="requirementCode" name="requirementCode" value="<c:out value="${requirementCode}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
             <tr>
                <td align="right" class="l-table-edit-td">清单编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="applyCode" type="text" id="applyCode" value="<c:out value="${applyCode}"/>" ltype="text" validate="{required:true,minlength:1,maxlength:30}" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">任务:</td>
            <td align="left"  class="l-table-edit-td" style="width:160px">
            <input type="text" name="taskCodeText" id="taskCodeText" />
			<input type="hidden" name="taskCode" id="taskCode" validate="{required:true}"/>
            </td>
            <td align="left">按住Ctrl可选择多个任务</td>
            <td align="left"></td>
            </tr>
            
            
            <tr>
            <td align="right" class="l-table-edit-td">项目名称:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="applyName" id="applyName" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1,maxlength:250}"></textarea>
            </td>
            <td align="left"></td>
            </tr>
            
           
            <tr>
            <td align="right" class="l-table-edit-td">技术负责人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="hidden" name="devPrincipal" id="devPrincipal" value="<c:out value="${devPrincipal}"/>"/>
            <input name="devPrincipalName" type="text" id="devPrincipalName"   value="<c:out value="${devPrincipalName}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">自测报告:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input name="reportSelfText" type="text" id="reportSelfText" ltype="text"  />
                	<input name="reportSelf" type="hidden" id="reportSelf" ltype="text" value="2"  />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <!-- 
            <tr>
                <td align="right" class="l-table-edit-td">送测时间:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input name="applyTime" type="text" id="applyTime" ltype="text" validate="{required:true}" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
             -->
             
            <tr>
            <td align="right" class="l-table-edit-td">测试部门:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="applyDept" type="text" id="applyDept" ltype="text" validate="{required:true}" value="<c:out value="${applyDept}"/>" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">测试人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="conner" type="text" id="conner" ltype="text" validate="{required:true}" value="<c:out value="${conner}"/>" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">完成时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="applyFinishTime" type="text" id="applyFinishTime" ltype="text"  /></td>
            <td align="left">如无特殊要求,可为空</td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">测试指引:</td>
            <td align="left"  colspan="2" class="l-table-edit-td" style="width:160px"><textarea name="howToTest" id="howToTest" cols="100" rows="5" class="l-textarea" style="width:400px" validate="{required:true,minlength:1}"></textarea></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">其他说明:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px"><textarea name="info" id="info" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1}"></textarea></td>
            <td align="left"></td>
            </tr>
            

        </table>
 <br />
   
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
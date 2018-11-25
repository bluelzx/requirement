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
            
            $.validator.addMethod("validReq",function(value,element){
            	var reqId  = $("#requirementId").val();
            	if(reqId==''){
            		return false;
            	}
            	return true;
            },"请选择有效需求");
            
            $.validator.addMethod("myUnit",function(value,element){
            	var myUnitValue = parseFloat(value);
            	if(isNaN(myUnitValue)){
            		return false;
            	}
            	var myUnitLeft = myUnitValue%0.1;
            	if(myUnitLeft>0){
            	return false;
            	}
            	return true;
            },"最小单位为0.1天");
            
            $.validator.addMethod("afterToday",function(value,element){
            	var currentDate =  getNowFormatDate();
            	var selectDate = value;
            	var day1 = new Date(currentDate.substr(0,4),currentDate.substr(4,6),currentDate.substr(6,8));
            	var day2 = new Date(selectDate.substr(0,4),selectDate.substr(4,6),selectDate.substr(6,8));
            	if(day1>day2){
            		return false;
            	}else{
            	return true;
            	}
            },"完成日期从今天开始");
            
            $.validator.addMethod("beforeDays",function(value,element){
            	var currentDate =  getNowFormatDate();
            	var selectDate = $("#planFinishTime").val();
            	var day1 = new Date(currentDate.substr(0,4),currentDate.substr(4,2),currentDate.substr(6,2));
            	var day2 = new Date(selectDate.substr(0,4),selectDate.substr(4,2),selectDate.substr(6,2));
            	var dayDiff = value-((day2-day1)/(1000*3600*24))-1;
            	if(dayDiff>0){
            		return false;
            	}
            	
            	return true;
            },"工时超过最大值");
            
            $("#planFinishTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left',readonly:true });
            
             $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectUser,
                slide :false,
                valueFieldID: 'userCode',
                width:300,
                initValue :'<c:out value="${task.userCode}"/>'
            });
            
             $("#dependableTaskText").ligerComboBox({
                onBeforeOpen: f_selectDependableTask,
                slide :false,
                valueFieldID: 'dependableTask',
                width:300,
                initValue :'<c:out value="${dependableTask}"/>'
            });
            
             $("#requirementCode").ligerComboBox(
                {
                    url: '<%=path%>/getUnCloseSelectRequirements.do',
                    valueField: 'requirementId',
                    valueFieldID : 'requirementId',
                    textField: 'requirementCode',
                    selectBoxWidth: 200,
                    width: 200 ,
                    autocomplete: true,
                    initValue :'<c:out value="${task.requirementId}"/>'
                }
            ); 
            
            //$("#taskGroupText").ligerComboBox({  
            //    data: [
            //        { text: '应用组', id: '1' },
            //        { text: '数据组', id: '2' }
            //    ], valueFieldID: 'taskGroup',initValue :'<c:out value="${task.taskGroup}"/>'
            //}); 
            
            $("#taskTypeText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=1',
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'taskType',
                initValue :'<c:out value="${task.taskType}"/>'
            }); 
            
            $("#statusText").ligerComboBox({  
                data: [
                    { text: '未开始', id: '1' },
                    { text: '进行中', id: '2' },
                    { text: '完成', id: '3' },
                    { text: '挂起', id: '4' },
                    { text: '逾期未完成', id: '5' },
                    { text: '逾期完成', id: '6' }
                ], valueFieldID: 'status',initValue :'<c:out value="${task.status}"/>',readonly :true
            }); 
            
            $("#urgentText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_4%>',
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'urgent',
                initValue :'<c:out value="${task.urgent}"/>'
            });
            
            $("#isLongTermText").ligerComboBox({  
                data: [
                    { text: '否', id: '0' },
                    { text: '是', id: '1' }
                ], valueFieldID: 'isLongTerm',
                initValue :'<c:out value="${task.isLongTerm}"/>',
                onSelected:function (newvalue){
                	if(newvalue=='1'){
                		planFinishTime.setValue('20991231');
                	}else{
                		planFinishTime.setValue('');
                	}
                }
            }); 
            
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
            

            
        });
        
        function getNowFormatDate(){
        	var bDate = new Date();
            	var year = bDate.getFullYear();
            	var month = bDate.getMonth()+1;
            	var mday = bDate.getDate();
            	var currentDate = year; 
            	if(month>=10){
            		currentDate = currentDate+month;
            	}else{
            		currentDate = currentDate+"0"+month;
            	}
            	if(mday>=10){
            		currentDate = currentDate+mday;
            	}else{
            		currentDate = currentDate+"0"+mday;
            	}
            	return currentDate;
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
        
        function f_selectDependableTask()
        {
            $.ligerDialog.open({ title: '选择前置任务', name:'winselector2',width: 1000, height: 500, url: '<%=path%>/toListAllTask.do', buttons: [
                { text: '确定', onclick: f_selectDependableTaskOK },
                { text: '取消', onclick: f_selectDependableTaskCancel }
            ]
            });
            return false;
        }
        function f_selectUserOK(item, dialog)
        {
			var fn = dialog.frame.f_select || dialog.frame.window.f_select; 
            var data = fn(); 
            if (!data)
            {
                alert('请选择行!');
                return;
            }
            $("#userCodeText").val(data.userName);
            $("#userCode").val(data.userCode);
            dialog.close();
        }
        function f_selectDependableTaskOK(item, dialog)
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
            for(var i=0;i<data.length;i++){
            	if(tempText==""){
            		tempText = data[i].taskName;
            		tempIds = data[i].taskCode;
            	}else{
            		tempText = tempText+","+data[i].taskName;
            		tempIds = tempIds+","+data[i].taskCode;
            	}
            }
            $("#dependableTaskText").val(tempText);
            $("#dependableTask").val(tempIds);
            dialog.close();
        }
        function f_selectUserCancel(item, dialog)
        {
            dialog.close();
        }
        function f_selectDependableTaskCancel(item, dialog)
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

    <form name="form1" method="post" action="<%=path%>/doModifyTask.do"   id="form1">
    	<input name="taskCode"  type="hidden" value="<c:out value="${task.taskCode}"/>"/>
    	<input name="fromRtree"  type="hidden" value="<c:out value="${fromRtree}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">任务名称:</td>
                <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
                <textarea name="taskName" id="taskName" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1,maxlength:50}"><c:out value="${task.taskName}"/></textarea>
                </td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求编号:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="requirementCode"  id="requirementCode" value="<c:out value="${requirementCode}"/>" validate="{required:true,validReq:true}"  />
            <input type="hidden" name="requirementId"  id="requirementId" value="<c:out value="${task.requirementId}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">前置任务:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="dependableTaskText" id="dependableTaskText" value="<c:out value="${dependableTaskText}"/>"/>
            <input type="hidden" name="dependableTask" value="<c:out value="${dependableTask}"/>" id="dependableTask"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            <!-- 
             <tr>
                <td align="right" class="l-table-edit-td">所属组:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="taskGroupText" type="text" validate="{required:true}"/>
                	<input id="taskGroup" type="hidden" name="taskGroup" validate="{required:true}" value="<c:out value="${task.taskGroup}"/>" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
             -->
            <tr>
                <td align="right" class="l-table-edit-td">任务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                	<input id="taskTypeText" type="text" validate="{required:true}"/>
                	<input id="taskType" type="hidden" name="taskType" validate="{required:true}" value="<c:out value="${task.taskType}"/>" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
           
            <tr>
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="urgentText" type="text" id="urgentText" ltype="text" validate="{required:true}" />
            <input name="urgent" type="hidden" id="urgent" ltype="text" validate="{required:true}" value="<c:out value="${task.urgent}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">是否持续性:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="isLongTermText" type="text" id="isLongTermText" ltype="text" validate="{required:true}" />
            <input name="isLongTerm" type="hidden" id="isLongTerm" ltype="text" value="0" validate="{required:true}" value="<c:out value="${task.isLongTerm}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">开发者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="userCodeText" type="text" id="userCodeText" value="<c:out value="${userCodeText}"/>"/>
             <input type="hidden" id="userCode" name="userCode" value="<c:out value="${task.userCode}"/>"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
           
            <tr>
            <td align="right" class="l-table-edit-td">计划完成日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="planFinishTime"  type="text" id="planFinishTime" value="<c:out value="${task.planFinishTime}"/>"  ltype="text"  validate="{required:true}" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
              
            <tr>
            <td align="right" class="l-table-edit-td">预计所需工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.planManHaur}"/>
            <input type="hidden" id="planManHaur" name="planManHaur" value="<c:out value="${task.planManHaur}"/>"/>
            </td>
            <td align="left">预计该任务完成的实际所需工时。最小单位0.1天。</td>
            <td align="left"></td>
            </tr>
             
             <tr>
            <td align="right" class="l-table-edit-td">状态:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
           		<input id="statusText" type="text" validate="{required:true}"/>
                <input name="status"  id="status" type="hidden" validate="{required:true}" value="<c:out value="${task.status}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">描述:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:400px"><c:out value="${task.remark}"/></textarea>
            </td>
            <td align="left"></td>
            </tr>

        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button1" class="l-button" style="width: 80px;" onclick="javascript:window.history.go(-1);"/>
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
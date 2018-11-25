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
            	var myUnitLeft = (myUnitValue*10)%1;
            	if(myUnitLeft>0){
            	return false;
            	}
            	return true;
            },"最小单位为0.1天");
            
             $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectUser,slide :false, valueFieldID: 'userCode',width:300
            });
            
             $("#dependableTaskText").ligerComboBox({
                onBeforeOpen: f_selectDependableTask,slide :false, valueFieldID: 'dependableTask',width:300
            });
            
            var planFinishTime =$("#planFinishTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            
            $("#requirementCode").ligerComboBox(
                {
                    url: '<%=path%>/getUnCloseSelectRequirements.do',
                    valueField: 'requirementId',
                    valueFieldID : 'requirementId',
                    textField: 'requirementCode',
                    selectBoxWidth: 200,
                    width: 200 ,
                    autocomplete: true,
                    initValue :'<c:out value="${requirementId}"/>'
                }
            ); 
            
            //$("#taskGroupText").ligerComboBox({  
            //    data: [
            //        { text: '应用组', id: '1' },
            //       { text: '数据组', id: '2' }
            //    ], valueFieldID: 'taskGroup'
            //}); 
            
            $("#taskTypeText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=1',
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'taskType'
            }); 
            
            $("#urgentText").ligerComboBox({  
                 url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_4%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'urgent'
            });
            
            $("#isLongTermText").ligerComboBox({  
                data: [
                    { text: '否', id: '0' },
                    { text: '是', id: '1' }
                ], valueFieldID: 'isLongTerm',initValue :'0',
                onSelected:function (newvalue){
                	if(newvalue=='1'){
                		planFinishTime.setValue('20991231');
                	}else{
                		planFinishTime.setValue('');
                	}
                }
            }); 
            
            $("#demo1").bind("input propertychange",
            	function(event1){
            		if($.browser.msie){//IE
            			if(event1.originalEvent.propertyName==="value"){
            				alert($(this).val());
            			};
            			
            		}else{//非IE
            			alert($(this).val());
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
            
        });
        
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

    <form name="form1" method="post" action="<%=path%>/saveTask.do"   id="form1">
    	<input name="fromRtree"  type="hidden" value="<c:out value="${requirementId!=null}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">任务名称:</td>
                <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
                <textarea name="taskName" id="taskName" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1,maxlength:50}"></textarea>
                </td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求编号:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="requirementCode" id="requirementCode" value="<c:out value="${requirementCode}"/>" validate="{required:true,validReq:true}" />
            <input type="hidden" name="requirementId" id="requirementId" value="<c:out value="${requirementId}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">前置任务:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text"  id="dependableTaskText"/>
            <input type="hidden" name="dependableTask" id="dependableTask"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            <!-- 
             <tr>
                <td align="right" class="l-table-edit-td">所属组:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="taskGroupText" type="text" validate="{required:true}"/>
                	<input id="taskGroup" type="hidden" name="taskGroup" value="" validate="{required:true}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
             -->
            <tr>
                <td align="right" class="l-table-edit-td">任务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="taskTypeText" type="text" validate="{required:true}"/>
                	<input id="taskType" type="hidden" name="taskType" value="" validate="{required:true}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="urgentText" type="text" id="urgentText" ltype="text" validate="{required:true}" />
            <input name="urgent" type="hidden" id="urgent" ltype="text" validate="{required:true}"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">是否持续性:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="isLongTermText" type="text" id="isLongTermText" ltype="text" validate="{required:true}" />
            <input name="isLongTerm" type="hidden" id="isLongTerm" ltype="text" value="0" validate="{required:true}"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">开发者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="userCodeText" type="text" id="userCodeText" />
             <input type="hidden" id="userCode" name="userCode"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             
            <tr>
            <td align="right" class="l-table-edit-td">预计所需工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="planManHaur" type="text" id="planManHaur" ltype="text" validate="{required:true,myUnit:true,number:true,min:0}" />
            </td>
            <td align="left">(按天计算,最小单位为0.1天)</td>
            <td align="left"></td>
            </tr>
             
             <tr>
            <td align="right" class="l-table-edit-td">计划完成日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="planFinishTime" type="text" id="planFinishTime" value="" ltype="text"  validate="{required:true}" />
            </td>
            <td align="left">任务开发自测完成的最后截止日期，不包括UAT业务测试时间</td>
            <td align="left"></td>
            </tr>
            <tr>
            <td align="right" class="l-table-edit-td">描述:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:400px"></textarea>
            </td>
            <td align="left"></td>
            </tr>
            

        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button2" class="l-button" style="width: 80px;" onclick="javascript:window.history.go(-1);"/>
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
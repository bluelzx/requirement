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
            
            $("#startDate").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
            $("#endDate").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
            
            $.ligerui.get('startDate').setValue('<c:out value="${requirement.startDate}"/>');
            $.ligerui.get('endDate').setValue('<c:out value="${requirement.endDate}"/>');
            
           
            
            $("#parentCodeText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectRequirements.do',
                    valueField: 'requirementId',
                    valueFieldID: 'parentCode',
                    textField: 'requirementCode', 
	                initValue :'<c:out value="${requirement.parentCode}"/>',
                    selectBoxWidth: 200,
                    autocomplete: true,
                    width: 200 
                }
            ); 
            
            $("#rTypeText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=2',
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'requirementType',
                initValue :'<c:out value="${requirement.requirementType}"/>'
            }); 
            
             
             $("#ownerText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectManagerUsers.do',
                    valueField: 'userCode',
                    textField: 'userName', 
                    selectBoxWidth: 200,
                    
                    valueFieldID: 'owner',
                    width: 200 ,initValue :'<c:out value="${requirement.owner}"/>'
                }
            );
            
            $("#watcherText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectManagerUsers.do',
                    valueField: 'userCode',
                    textField: 'userName', 
                    selectBoxWidth: 200,
                    
                    valueFieldID: 'watcher',
                    width: 200 ,initValue :'<c:out value="${requirement.watcher}"/>'
                }
            );
            
            
            $("#projectText").ligerComboBox(
                {
                    url: '<%=path%>/getAllProjects.do',
                    valueField: 'projectCode',
                    textField: 'projectName', 
                    selectBoxWidth: 200,
                    valueFieldID: 'projectCode',
                    width: 200,initValue :'<c:out value="${requirement.projectCode}"/>' 
                }
            );
            $("#importantText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_3%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'important',
                initValue :'<c:out value="${requirement.important}"/>'
            });
            
            $("#urgentText").ligerComboBox({  
                 url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_4%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                 valueFieldID: 'urgent',
                 initValue :'<c:out value="${requirement.urgent}"/>'
            }); 
            
            $("#businessTypeText").ligerComboBox({  
                 url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_5%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                 valueFieldID: 'businessType',
                 initValue :'<c:out value="${requirement.businessType}"/>'
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

    <form name="form1" method="post" action="<%=path%>/doModifyRequirement.do"   id="form1">
    	<input name="requirementId" type="hidden" id="requirementId" value="<c:out value="${requirement.requirementId}"/>" />
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">需求编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                 <input name="requirementCode" type="text" id="requirementCode" value="<c:out value="${requirement.requirementCode}"/>" ltype="text" validate="{required:true,maxlength:50}" />
                </td>
                <td align="left">无A项目需求编号时，可默认选择T需求编号</td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求名称:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="requirementName" id="requirementName" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1,maxlength:50}"><c:out value="${requirement.requirementName}"/></textarea>
            </td>
            <td align="left"></td>
            </tr>
            <tr>
                <td align="right" class="l-table-edit-td">上级需求:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
           			<input type="text" name="parentCodeText" id="parentCodeText"  ltype="text"/>
           			<input type="hidden" name="parentCode" id="parentCode" value="<c:out value="${requirement.parentCode}"/>" ltype="text"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">需求类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                	<input id="rTypeText" name="rTypeText" type="text" validate="{required:true}"/>
                	<input id="requirementType" name="requirementType" value="<c:out value="${requirement.requirementType}"/>" type="hidden" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">业务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                	<input id="businessTypeText" name="businessTypeText" type="text" validate="{required:true}"/>
                	<input id="businessType" name="businessType" value="<c:out value="${requirement.businessType}"/>" type="hidden" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="planManHaur" type="text" id="planManHaur" value="<c:out value="${requirement.planManHaur}"/>" ltype="text" validate="{required:true}" /></td>
            <td align="left">单位(人日)</td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计开始时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="startDate" type="text" id="startDate" ltype="text"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计结束时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="endDate" type="text" id="endDate" ltype="text"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">责任人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="ownerText" type="text" id="ownerText" ltype="text" validate="{required:true}"/></td>
            <input name="owner" type="hidden" id="owner" ltype="text" value="<c:out value="${requirement.owner}"/>" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">监理:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="watcherText" type="text" id="watcherText" ltype="text" validate="{required:true}"/></td>
            <input name="watcher" type="hidden" id="watcher" ltype="text" value="<c:out value="${requirement.watcher}"/>" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">项目:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="projectText" type="text" id="projectText" ltype="text" validate="{required:true}"/></td>
            <input name="projectCode" type="hidden" id="projectCode" ltype="text" value="<c:out value="${requirement.projectCode}"/>" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求部门:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="dept" type="text" id="dept" value="<c:out value="${requirement.dept}"/>" ltype="text" validate="{required:true}" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求提出者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="presenter" type="text" id="presenter" value="<c:out value="${requirement.presenter}"/>" ltype="text" validate="{required:true}" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">重要程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="importantText" type="text" id="importantText" ltype="text" validate="{required:true}" />
            <input name="important" type="hidden" id="important" ltype="text" validate="{required:true}" value="<c:out value="${requirement.important}"/>"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="urgentText" type="text" id="urgentText" ltype="text" validate="{required:true}" />
            <input name="urgent" type="hidden" id="urgent" ltype="text" validate="{required:true}" value="<c:out value="${requirement.urgent}"/>" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求描述:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:400px"><c:out value="${requirement.remark}"/></textarea>
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
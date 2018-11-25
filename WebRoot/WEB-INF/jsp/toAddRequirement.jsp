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
        var myFileUpload;
        $(function () {
            
            $("#startDate").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            $("#endDate").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
            
            $("#parentCodeText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectRequirements.do',
                    valueField: 'requirementId',
                    valueFieldID: 'parentCode',
                    textField: 'requirementCode',
                    selectBoxWidth: 200,
                    autocomplete: true,
                    width: 200 
                }
            ); 
            
            
            $("#rTypeText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=2',
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'requirementType'
            }); 
            
            $("#ownerText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectManagerUsers.do',
                    valueField: 'userCode',
                    textField: 'userName', 
                    selectBoxWidth: 200,
                    valueFieldID: 'owner',
                    width: 200 
                }
            );
            
            $("#watcherText").ligerComboBox(
                {
                    url: '<%=path%>/getSelectManagerUsers.do',
                    valueField: 'userCode',
                    textField: 'userName', 
                    selectBoxWidth: 200,
                    valueFieldID: 'watcher',
                    width: 200 
                }
            );
            
            $("#projectText").ligerComboBox(
                {
                    url: '<%=path%>/getAllProjects.do',
                    valueField: 'projectCode',
                    textField: 'projectName', 
                    selectBoxWidth: 200,
                    valueFieldID: 'projectCode',
                    width: 200 
                }
            );
            
            $("#importantText").ligerComboBox({  
                url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_3%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'important'
            });
            
            $("#urgentText").ligerComboBox({  
                 url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_4%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'urgent'
            }); 
            
            $("#businessTypeText").ligerComboBox({  
                 url:'<%=path%>/getAllParas.do?paraType=<%=Constants.PARA_TYPE_5%>',
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'businessType'
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
                if(myFileUpload.data('uploadify').queueData.queueLength){
			       		$.ligerDialog.error('亲,你选择了文件但是还没有上传!');
			       		return;
			    }else{
			    		var myFile = "";
			    		$("input[name='uploadFiles']").each(function(){
			    			if(myFile==""){
			    				myFile = $(this).val();
			    			}else{
			    				myFile = myFile+","+$(this).val();
			    			}
			    		});
			    		
			    		$("#form1").append("<input type='hidden' value='"+myFile+"' name='allFiles' />");
			    }
                   $.ajax({
								                type: 'POST',
								                url: '<%=path%>/checkRequirementCode.do',
								                data: 'requirementCode='+$("#requirementCode").val(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#Button1").attr("disabled",true);
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=='true'){
								                    	$("#Button1").attr("disabled",false);
								                    	$.ligerDialog.error('亲,需求'+$("#requirementCode").val()+'已经存在,请选择其他需求编号!');
								                    	$("#requirementCode").val("");
								                    	$("#requirementCode").focus();
								                     	return;
								                     }else{
										                $("#Button1").attr("disabled",true);
									                   form1.submit();
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
            
           myFileUpload = $("#file_upload").uploadify({
            'swf':'<%=path%>/js/uploadify/uploadify.swf',
            'uploader':'<%=path%>/doTmpUploadFile.do;jsessionid=<%=session.getId()%>',
            auto:false,
            buttonText : '选择要上传文件',
            debug : false,
            buttonClass : 'l-button',
            removeCompleted : false,
			onUploadSuccess : function(file,data,response){
				var myData = eval('('+data+')');
				$("#form1").append("<input type='hidden' value='"+data+"' id='"+file.id+"' name='uploadFiles' />");
				var myCancel = $("#"+file.id+" .cancel a");
				if(myCancel){
					myCancel.on("click",function(){
						$(this).hide();
						$("#"+file.id).remove();
					});
				}
			}
            });
        });
        function mytest(){
        
       	if(myFileUpload.data('uploadify').queueData.queueLength){
       		alert("你选择了文件但是还没有上传!");
       	};
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
    <form name="form1" method="post" action="<%=path%>/saveRequirement.do"   id="form1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">需求编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="requirementCode" type="text" id="requirementCode" value="<c:out value="${requirementCode}"/>" ltype="text" validate="{required:true,minlength:1,maxlength:30}" />
                </td>
                <td align="left">无A项目需求编号时，可默认选择T需求编号</td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求名称:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="requirementName" id="requirementName" cols="100" rows="1" class="l-textarea" style="width:400px" validate="{required:true,minlength:1,maxlength:50}"></textarea>
            </td>
            <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">上级需求:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input type="text" name="parentCodeText" id="parentCodeText"  ltype="text"/>
                	<input type="hidden" name="parentCode" id="parentCode"  ltype="text"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            
            <tr>
                <td align="right" class="l-table-edit-td">需求类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="rTypeText" type="text" ltype="text" validate="{required:true}" />
                	<input id="requirementType" name="requirementType" type="hidden" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">业务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="businessTypeText" type="text" ltype="text" validate="{required:true}" />
                	<input id="businessType" name="businessType" type="hidden" />
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="planManHaur" type="text" id="planManHaur" ltype="text" validate="{required:true}" /></td>
            <td align="left">单位(人日)</td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计开始时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="startDate" type="text" id="startDate" ltype="text"  /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计结束时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="endDate" type="text" id="endDate" ltype="text"  /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">责任人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="ownerText" type="text" id="ownerText" validate="{required:true}" ltype="text" /></td>
            <input name="owner" type="hidden" id="owner" ltype="text" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">监理:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="watcherText" type="text" id="watcherText" validate="{required:true}" ltype="text" /></td>
            <input name="watcher" type="hidden" id="watcher" ltype="text" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">项目:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="projectText" type="text" id="projectText" validate="{required:true}" ltype="text" /></td>
            <input name="projectCode" type="hidden" id="projectCode" ltype="text" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求部门:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="dept" type="text" id="dept" ltype="text" validate="{required:true}" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求提出者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="presenter" type="text" id="presenter" ltype="text" validate="{required:true}" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">重要程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="importantText" type="text" id="importantText" ltype="text" validate="{required:true}" />
            <input name="important" type="hidden" id="important" ltype="text" validate="{required:true}" />
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
            <td align="right" class="l-table-edit-td">需求描述:</td>
            <td align="left" colspan="2" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:400px"></textarea>
            </td>
            <td align="left"></td>
            </tr>

        </table>
 <br />

   <div style="height:20px;border-bottom: 1px solid #ccc;margin-top: 1px;">
    <p><img src="<%=path%>/LigerUI/lib/ligerUI/skins/icons/communication.gif" />  附件上传：</p>
   </div>  
   <div style="margin-bottom: 50px;">
   <p><input type="file" name="file_upload" id="file_upload"/></p>
   <p><a href="javascript:$('#file_upload').uploadify('upload','*')">开始上传</a></p>
   </div>
   <input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button1" class="l-button" style="width: 80px;" onclick="javascript:mytest();"/>
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
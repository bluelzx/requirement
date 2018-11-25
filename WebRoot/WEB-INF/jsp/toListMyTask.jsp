<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%@ include file="include.meta.jsp"%>
		<script type="text/javascript">
        var grid = null;
        var myTaskTyps = [];
         var urgentData = [];//紧急程度
          function f_selectContact()
        {
            $.ligerDialog.open({ title: '选择任务执行者', name:'winselector1',width: 500, height: 400, url: '<%=path%>/toUserWorks.do', buttons: [
                { text: '确定', onclick: f_selectContactOK },
                { text: '取消', onclick: f_selectContactCancel }
            ]
            });
            return false;
        }
        function f_selectContactOK(item, dialog)
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
        function f_selectContactCancel(item, dialog)
        {
            dialog.close();
        }

        
        function itemclick(item)
        {
            alert(item.text);
        }
        
        function toAdd(item)
        {
            window.location.href="<%=path%>/toAddTask.do";
        }
        
         function toAddRemark(){
        	var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('请选择要添加备注的需求!');
        		return;
        	}
        	$.ligerDialog.open({ title: '添加备注', name:'winselector2',width: 500, height: 400, 
        	url: '<%=path%>/toAddRemark.do?requirementCode='+toSelectRow.requirementCode+'&taskCode='+toSelectRow.taskCode
            });
        }
        
        
        $(function () {
        
        var taskType = $("#taskTypeText").ligerComboBox({  
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'taskType'
            }); 
        	
        	var urgentType =  $("#urgentText").ligerComboBox({  
                data : urgentData,
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'urgent'
            }); 
        	
        	 $.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_1%>',
						dataType: 'json',
						async: false,
						success: function (data){
							myTaskTyps = data;
        	 				taskType.setData(myTaskTyps);
						}
			});
			
			$.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_4%>',
						dataType: 'json',
						async: false,
						success: function (data){
							urgentData = data;
        	 				urgentType.setData(urgentData);
						}
			});
        
        $("#statusText").ligerComboBox({  
                data: [
                    { text: '未开始', id: '1' },
                    { text: '进行中', id: '2' },
                    { text: '正常完成', id: '3' },
                    { text: '逾期完成', id: '6' },
                    { text: '挂起', id: '4' },
                    { text: '等待前置任务', id: '-1' }
                ], valueFieldID : 'status'
            }); 
        	
        	$("#taskGroupText").ligerComboBox({  
                data: [
                    { text: '应用组', id: '1' },
                    { text: '数据组', id: '2' }
                ], valueFieldID: 'taskGroup'
            }); 
            
        	$("#isSignInText").ligerComboBox({  
                data: [
                    { text: '否', id: '0' },
                    { text: '是', id: '1' }
                ], valueFieldID: 'isSignIn'
            }); 
            
        	 $("#isLongTermText").ligerComboBox({  
                data: [
                    { text: '否', id: '0' },
                    { text: '是', id: '1' }
                ], valueFieldID: 'isLongTerm'
            }); 
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '操作', isSort: false, width: 120, render: function (rowdata, rowindex, value){
                
                			var h = "";
                			
                			if(rowdata.status==1){
                				h += "<a style='display:inline;' id='toSignForTask"+rowindex+"' href='javascript:toSignForTask(" +rowindex + ")'>签收</a> ";
                				h += "<a style='display:none;' id='finshTask"+rowindex+"' href='javascript:finshTask(" + rowindex + ")'>完成</a> ";
                				//h += "<a style='display:none;' id='doCloseTask"+rowindex+"' href='javascript:doCloseTask(" +rowindex + ")'>关闭</a> ";
                			}
                			
                			if(rowdata.status==2 || rowdata.status==5){
                				h += "<a style='display:inline;' id='finshTask"+rowindex+"' href='javascript:finshTask(" + rowindex + ")'>完成</a> ";
                				//h += "<a style='display:none;' id='doCloseTask"+rowindex+"' href='javascript:doCloseTask(" +rowindex + ")'>关闭</a> ";
                			}
                        	
                        	//if(rowdata.status==3 || rowdata.status==6){//完成的任务才能关闭
                			//	h += "<a style='display:inline;' id='doCloseTask"+rowindex+"' href='javascript:doCloseTask(" +rowindex + ")'>关闭</a> ";
                			//}
                        	
                        	if(rowdata.taskType==99 && rowdata.status != 3 && rowdata.status != 6 ){//自动派生任务可退回
                        		h += "<a style='display:inline;' id='toRevokeTask"+rowindex+"' href='javascript:toRevokeTask(" +rowindex + ")'>退回</a> "
                        	}
                        	
                        	//h += "<a id='vaiwTask"+rowindex+"' href='javascript:viewTask(" +rowindex + ")'>查看</a> ";
                        	return h; 
                			} 
                },{ display: '需求编号', name: 'requirementCode',align: 'center', width: 150,
                render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewRequirement("+rowindex+")' >"+value+"</a>";
                	}
                 },
                { display: '需求名称', name: 'requirementName', align: 'left', width: 200 },
                { display: '任务名称', name: 'taskName', align: 'left', width: 200,
                render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewTask("+rowindex+")' >"+value+"</a>";
                	}  },
                { display: '开发者', name: 'userCode', width: 100,align:'center' },
                { display: '计划完成日期', name: 'planFinishTime', width: 100,align:'center' },
                { display: '状态', name: 'status', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "未开始";
                					if(value==2)
                						return "进行中";
                					if(value==3)
                						return "完成";
                					if(value==4)
                						return "挂起";
                					if(value==5)
                						return "逾期未完成";
                					if(value==6)
                						return "逾期完成";
                					if(value==-1)
                						return "等待前置任务";
                							
                			}
                 },	
                 { display: '紧急程度', name: 'urgent', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(urgentData,value);
                } },
                { display: '任务类型', name: 'taskType', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					return returnParaValue(myTaskTyps,value);
                			} },
                { display: '是否签到', name: 'isSignIn', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==0)
                						return "未签到";
                					if(value==1)
                						return "已签到";
                } },
                { display: '录入者', name: 'creator', width: 100,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listMyTask.do?status='+$("#status").val(),
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                 { text: '添加备注', click: toAddRemark, icon: 'comment' },
                 { line: true },
                 { text: '日志登记', click: toSignIn, icon: 'ok' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        var doSignForTask = false;
        function toSignForTask(rowindex){
        var gData = mygrid.data.rows;
        $.ligerDialog.confirm('确认签收任务:'+gData[rowindex].taskName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
//								                url: '<%=path%>/doFinishTask.do',
								                url: '<%=path%>/doSignFor.do?taskCode='+gData[rowindex].taskCode,
								                //data: $(myform).serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                	doSignForTask = false;
								                    if (data == 'success'){
								                    	
								                    	$("#finshTask"+rowindex).show();
								                    	$("#toSignForTask"+rowindex).hide();
								                    	$.ligerDialog.success('签收成功!');
								                    	f_search();
								                     }
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                        doSignForTask = false;
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
			                		}
			                	
			                	});
        }

	   var finishTaskSubmit = false;
       function finshTask(rowindex){
       		finishTaskSubmit = false;
       		var gData = mygrid.data.rows;
       		 $.ligerDialog.confirm('确认完成任务:'+gData[rowindex].taskName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
//								                url: '<%=path%>/doFinishTask.do',
								                url: '<%=path%>/doFinishTaskProc.do?taskCode='+gData[rowindex].taskCode,
								                //data: $(myform).serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data == 'success'){
								                    
								                    	//dialog.close(); 
								                    	//$("#finshTask"+rowindex).hide();
								                    	//$("#doCloseTask"+rowindex).show();
								                    	f_search();
								                    	$.ligerDialog.success('填单成功!')
								                     	return;
								                     }
								                   finishTaskSubmit = true;
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
       								}
			                	
			                	});
       }
       function toRevokeTask(rowindex){
       		var gData = mygrid.data.rows;
       		$.ligerDialog.open({text:"退回任务", 
       		url: '<%=path%>/toRevokeTask.do?taskCode='+gData[rowindex].taskCode, height: 350,width: 400, 
       		buttons: [ { text: '确定', onclick: function (item, dialog) {
       		                var myform =  dialog.frame.form1 || dialog.frame.window.form1; 
       		                var fn = dialog.frame.checkForm || dialog.frame.window.checkForm; 
				            var data1 = fn(); 
				            
				            if (data1)
				            {
				            	
				                $.ajax({
								                type: 'POST',
								                url: '<%=path%>/revokeTask.do',
								                data: $(myform).serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data == 'success'){
								                    
								                    	dialog.close(); 
								                    	//$("#finshTask"+rowindex).hide();
								                    	//$("#doCloseTask"+rowindex).show();
								                    	f_search();
								                    	$.ligerDialog.success('退回成功!')
								                     	return;
								                     }
								                   
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
				            }
       				 		
       				 } }, 
       		{ text: '取消', onclick: function (item, dialog) { 
       						dialog.close(); 
       		} } ] 
       		});
       }
       
       function toLaunch(){
       		var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('请选择要申请上线的任务!');
        		return;
        	}
        	
       		$.ligerDialog.open({text:"申请上线", 
       		url: '<%=path%>/toTaskLaunch.do?taskCode='+toSelectRow.taskCode, height: 300,width: 400, 
       		buttons: [ { text: '确定', onclick: function (item, dialog) {
       		                var myform =  dialog.frame.form1 || dialog.frame.window.form1; 
       		                var fn = dialog.frame.checkForm || dialog.frame.window.checkForm; 
				            var data1 = fn(); 
				            
				            if (data1)
				            {
				            	
				                $.ajax({
								                type: 'POST',
								                url: '<%=path%>/doTaskLaunch.do',
								                data: $(myform).serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data == 'success'){
								                    
								                    	dialog.close(); 
								                    	//$("#finshTask"+rowindex).hide();
								                    	//$("#doCloseTask"+rowindex).show();
								                    	f_search();
								                    	$.ligerDialog.success('申请上线成功!')
								                     	return;
								                     }
								                   
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
				            }
       				 		
       				 } }, 
       		{ text: '取消', onclick: function (item, dialog) { 
       						dialog.close(); 
       		} } ] 
       		});
        }
        
        var taskSignInSubmit=false;
        function toSignIn(){
        	taskSignInSubmit=false;
       		var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('请选择要签到的任务!');
        		return;
        	}
        	if(toSelectRow.taskType=='99'){
        		$.ligerDialog.error('99测试/验证任务不用签到!');
        		return;
        	}
        	if(toSelectRow.isSignIn=='1'){
        		$.ligerDialog.error('此任务已签到!');
        		return;
        	}
        	//if(toSelectRow.status=='3'||toSelectRow.status=='6'){
        	//	if(toSelectRow.endTime!='<c:out value="${currentDate}"/>'){
	        //		$.ligerDialog.error('已完成的任务不能签到!');
	        //		return;
        	//	}
        	//}
        	
       	$.ligerDialog.open({text:"签到任务", 
       		url: '<%=path%>/toTaskSignIn.do?taskCode='+toSelectRow.taskCode, height: 350,width: 500, 
       		buttons: [ { text: '确定', onclick: function (item, dialog) {
       						
       						if(taskSignInSubmit==true){
       							$.ligerDialog.error("亲,请稍等,系统正在努力提交中......");
       							return;
       						}
       						taskSignInSubmit=true;
       		                var myform =  dialog.frame.form1 || dialog.frame.window.form1; 
       		                var fn = dialog.frame.checkForm || dialog.frame.window.checkForm; 
				            var data1 = fn(); 
				            
				            if (data1)
				            {
				            	
				                $.ajax({
								                type: 'POST',
								                url: '<%=path%>/doTaskSignIn.do',
								                data: $(myform).serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                    taskSignInSubmit=true;
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data){
								                    	taskSignInSubmit=false;
								                    	dialog.close(); 
								                    	//$("#finshTask"+rowindex).hide();
								                    	//$("#doCloseTask"+rowindex).show();
								                    	f_search();
								                    	
								                    	$.ligerDialog.success('签到任务成功!')
								                     	return;
								                     }
								                   taskSignInSubmit=false;
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                        taskSignInSubmit=false;
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
				            }
       				 		
       				 } }, 
       		{ text: '取消', onclick: function (item, dialog) { 
       						dialog.close(); 
       		} } ] 
       		});	
        }
        
       
       function doCloseTask(rowindex){
       		 var gData = mygrid.data.rows;
        $.ligerDialog.confirm('确认关闭任务:'+gData[rowindex].taskName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doCloseTask.do',
								                data: 'taskCode='+gData[rowindex].taskCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data){
								                    	$("#doCloseTask"+rowindex).hide();
								                    	$.ligerDialog.success('成功关闭任务!')
								                     	return;
								                     }
								                   
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
			                		}
			                	
			                	});
       }
       
       function viewTask(rowindex){
       		var gData = mygrid.data.rows;
       		$.ligerDialog.open({title:"查看任务", 
       		url: '<%=path%>/viewTask.do?taskCode='+gData[rowindex].taskCode, height: 350,width: 400});
       }
       
       function viewRequirement(rowindex){
       	var gData = mygrid.data.rows;
       	$.ligerDialog.open({title:"查看需求", 
       		url: '<%=path%>/toViewRequirement.do?requirementId='+gData[rowindex].requirementId, height: 400,width: 600});
       }
       
        function f_search()
        {
        	mygrid.options.url='<%=path%>/listMyTask.do';
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
        function returnParaValue(paraData,value){
				var returTemp = null;
                for(var i=0;i<paraData.length;i++){
                	if(value==paraData[i].paraCode){
                		returTemp =  paraData[i].paraValue;
                		}
                	}
               return returTemp;       	
       }
    </script>
		<style type="text/css">
           body{ font-size:12px;}
        .l-table-edit {}
        .l-table-edit-td{ padding:4px;}
        .l-button-submit,.l-button-test{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
        .l-verify-tip{ left:230px; top:120px;}
        #errorLabelContainer{ padding:10px; width:300px; border:1px solid #FF4466; display:none; background:#FFEEEE; color:Red;}
    </style>
	</head>
	<body style="padding:6px; overflow:hidden;">
		<form id="searchForm" name="" action="" method="post">

			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="right" class="l-table-edit-td">
						需求:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input type="text" name="requirementCode" id="requirementCode" />
					</td>

					<td align="right" class="l-table-edit-td">
						状态:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input id="statusText" type="text" />
               			<input name="status"  id="status" type="hidden" />
					</td>

			
					<td align="right" class="l-table-edit-td">所属组:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input type="text" name="taskGroupText" id="taskGroupText" />
                <input type="hidden" name="taskGroup" id="taskGroup" />
                </td>
                
                 <td align="right" class="l-table-edit-td">是否持续性:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input type="text" name="isLongTermText" id="isLongTermText" />
                <input id="isLongTerm" type="hidden" name="isLongTerm" value="" />
                </td>
                	
                </tr>
                <tr>
                <td align="right" class="l-table-edit-td">任务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input type="text" name="taskTypeText" id="taskTypeText" />
                <input id="taskType" type="hidden" name="taskType" value="" />
                </td>
                
                <td align="right" class="l-table-edit-td">紧急程度:</td>
	            <td align="left" class="l-table-edit-td" style="width:160px">
	            <input name="urgentText" type="text" id="urgentText" ltype="text"  />
	            <input name="urgent" type="hidden" id="urgent" ltype="text"  />
	            </td>
                
                <td align="right" class="l-table-edit-td">是否签到:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input type="text" name="isSignInText" id="isSignInText" />
                <input type="hidden" name="isSignIn" id="isSignIn" />
                </td>
                
                 <td align="right" class="l-table-edit-td"></td>
                <td align="left" class="l-table-edit-td " style="width:160px">
                <input id="btnOK" type="button" class="l-button" style="width:100px" value="查询" onclick="f_search()" />
                </td>

				</tr>
			</table>
		</form>
		<b />
			<div id="maingrid4" style="margin:0; padding:0"></div>


			<div style="display:none;">
				<!-- g data total ttt -->
			</div>
	</body>
</html>


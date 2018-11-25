<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="include.meta.jsp"%>
    <script type="text/javascript">
        var mygrid = null;
        
          function f_selectContact()
        {
            $.ligerDialog.open({ title: '选择任务执行者', name:'winselector',width: 500, height: 400, url: '<%=path%>/toUserWorks.do', buttons: [
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

        function clickee()
        {
            alert($("#userCode").val());
        }
        
        function toAdd()
        {
            window.location.href="<%=path%>/toAddTask.do?requirementId=<c:out value="${requirementId}"/>";
        }
        
        function toModifyTask(){
        	var toUpdate = mygrid.getSelectedRow();
        	if(!toUpdate){
        		$.ligerDialog.error('请选择要修改的任务!');
        		return;
        	}
        	window.location.href="<%=path%>/toModifyTask.do?taskCode="+toUpdate.taskCode+"&requirementId=<c:out value="${requirementId}"/>";
        }
        
        function disableByTaskCode(){
        	var toDisable = mygrid.getSelectedRow();
        	if(!toDisable){
        		$.ligerDialog.error('请选择要删除的任务!');
        		return;
        	}
        	//var taskStatus = toDisable.status;
        	//var toDisableCode = toDisable.taskCode;
        	//var toDisableName = toDisable.taskName;
        	$.ligerDialog.confirm('确认要删除任务：'+toDisable.taskName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/disableByTaskCode.do',
								                data: 'taskCode='+toDisable.taskCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=="success"){
								                    	f_search();
								                    	$.ligerDialog.success('删除成功!');
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
        
        function toLock(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择要挂起的任务!');
        		return;
        		}
        	var taskStatus = toDelete.status;
        	var toDisableCode = toDelete.taskCode;
        	var toDisableName = toDelete.taskName;
        	if( taskStatus==3 || taskStatus==6 ){
        		$.ligerDialog.error('任务：'+toDisableName+",已经完成不能挂起！");
        		return;
        	}
        	if( taskStatus==4){
        		$.ligerDialog.error('任务：'+toDisableName+",已经挂起,不用再挂起！");
        		return;
        	}		
        	$.ligerDialog.confirm('确认要挂起任务：'+toDisableName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doLockTask.do',
								                data: 'taskCode='+toDisableCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=="success"){
								                    	f_search();
								                    	$.ligerDialog.success('挂起成功!');
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
        
        $(function () {
        
        	$("#statusText").ligerComboBox({  
                data: [
                    { text: '未开始', id: '1' },
                    { text: '进行中', id: '2' },
                    { text: '完成', id: '3' },
                    { text: '挂起', id: '4' },
                    { text: '逾期未完成', id: '5' },
                    { text: '完成', id: '6' }
                ], valueFieldID: 'status'
            }); 
        
        	
            
           $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectContact, valueFieldID: 'userCode',width:300
            });
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '任务名称', name: 'taskName',id:'id1', align: 'left', width: 200 },
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 200 },
                { display: '所属组', name: 'taskGroup', width: 100,align:'center',render: function (rowdata, rowindex, value){
                	if(value==1)
                		return "应用组";
                	if(value==2)
                		return "数据组";
                } },
                { display: '任务类型', name: 'taskType', width: 100,align:'center',render: function (rowdata, rowindex, value){
                	if(value==1)
                		return "数据模型ETL开发";
                	if(value==2)
                		return "汇总层开发";
                	if(value==3)
                		return "报表开发";
                	if(value==4)
                		return "临时提取数据";
                	if(value==5)
                		return "测试";
                	if(value==6)
                		return "日常琐事";
                } },
                { display: '预计所需工时', name: 'planManHaur', width: 200,align:'center' },
                { display: '实际工时', name: 'creator', width: 100,align:'center' },
                { display: '开发者', name: 'userCode', width: 200,align:'center' },
                { display: '状态', name: 'status', width: 200,align:'center',
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
                 }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listAllTask.do?requirementId=<c:out value="${requirementId}"/>',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '增加', click: toAdd, icon: 'add' },
                { line: true },
                { text: '修改', click: toModifyTask, icon: 'modify' },
                { line: true },
                { text: '删除', click: disableByTaskCode, icon: 'delete' },
                  { line: true },
                { text: '挂起', click: toLock, icon: 'lock' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
        

       
        function f_search()
        {
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
       
       function f_select()
        {
            return mygrid.getSelectedRows();
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
<input type="hidden" name="requirementId" value="<c:out value="${requirementId}"/>"/>
 <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                
                <td align="right" class="l-table-edit-td">开发者:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="userCodeText" type="text" id="userCodeText"  />
             	<input type="hidden" id="userCode" name="userCode"/>
                </td>
                
                <td align="right" class="l-table-edit-td">状态:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input id="statusText" type="text" />
                <input name="status"  id="status" type="hidden" />
                <!-- 
                <select name="status" style="width:160px">
                	<option value="">所有</option>
                	<option value="1">未开始</option>
                	<option value="2">进行中</option>
                	<option value="3">完成</option>
                </select>
                 -->
                </td>
                
                 <td align="right" class="l-table-edit-td"></td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input id="btnOK" type="button" class="l-button" style="width:100px" value=" 查   询" onclick="f_search()" /></td>
                
            </tr>
 </table>
</form>
<b/>
    <div id="maingrid4" style="margin:0; padding:0"></div>
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</html>


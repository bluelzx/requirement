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
         var loginUser = '<%=SystemUtil.getLoginUser(request).getUserCode()%>';
        
        $(function () {
        	$("#startDate").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            $("#endDate").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
            
             $("#taskCodeText").ligerComboBox({
                onBeforeOpen: f_selectTask,slide :false, valueFieldID: 'taskCode',width:300
            });
            
            $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectUser,slide :false, valueFieldID: 'userCode',width:300
            });
            
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '任务名称', name: 'taskName',id:'id1', align: 'left', width: 300,
                	render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewTask("+rowindex+")' >"+value+"</a>";
                	} },
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 150 ,
                	render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewRequirement("+rowindex+")' >"+value+"</a>";
                	}
                },
                { display: '需求名称', name: 'requirenmentName', align: 'left', width: 300 },
                { display: '签到者', name: 'userCode', width: 80,align:'center' },
                { display: '签到时间', name: 'createTime', width: 200,align:'center' },
                { display: '当日花费工时(小时)', name: 'manHour', width: 120,align:'center' },
                { display: '当日加班工时(小时)', name: 'otHour', width: 120,align:'center' },	
                { display: '备注', name: 'remark', width: 200,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listTaskSignIn.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '删除', click: toDelete, icon: 'delete' }
                 ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        function f_search()
        {
        	mygrid.options.url='<%=path%>/listTaskSignIn.do';
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
       function toDelete(rowindex){
       		 var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('请选择要删除任务签到!');
        		return;
        	}
        	
        	if(toSelectRow.userCode!=loginUser&&loginUser!="admin"){
        			$.ligerDialog.error('亲,你没有权限删除任务签到：'+toSelectRow.requirenmentName);
        			return;
        		}
        $.ligerDialog.confirm('确认删除任务签到?', function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/deleteTaskSignIn.do',
								                data: 'signInCode='+toSelectRow.signInCode,
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
								                    	f_search();
								                    	$.ligerDialog.success('成功删除任务签到!')
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
        	mygrid.options.url='<%=path%>/listTaskSignIn.do';
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
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
						任务:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input type="text" name="taskCodeText" id="taskCodeText" />
						<input type="hidden" name="taskCode" id="taskCode"/>
					</td>
					
					<td align="right" class="l-table-edit-td">
						用户:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input type="text" name="userCodeText" id="userCodeText" />
						<input type="hidden" name="userCode" id="userCode"/>
					</td>
			</tr>
			<tr>
					<td align="right" class="l-table-edit-td">
						开始时间:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="startDate" type="text" id="startDate" ltype="text" />
					</td>

					<td align="right" class="l-table-edit-td">
						结束时间:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="endDate" type="text" id="endDate" ltype="text" />
					</td>

					<td align="right" class="l-table-edit-td"></td>
					<td align="left" class="l-table-edit-td " style="width:160px">
						<input id="btnOK" type="button" class="l-button"
							style="width:100px" value="查询" onclick="f_search()" />
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


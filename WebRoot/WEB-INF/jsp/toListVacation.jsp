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
        
        
        $(function () {
        	$("#startTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            $("#endTime").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
            
            $("#proposerText").ligerComboBox({
                onBeforeOpen: f_selectUser,slide :false, valueFieldID: 'proposer',width:300
            });
            
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '申请人', name: 'proposer',id:'id1', align: 'center', width: 100},
                { display: '开始时间', name: 'startTime',align: 'center', width: 150 },
                { display: '结束时间', name: 'endTime', align: 'center', width: 150 },
                { display: '录入人', name: 'creator', width: 80,align:'center' },
                { display: '录入时间', name: 'createTime', width: 200,align:'center' },
                { display: '备注', name: 'remark', width: 300,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/doListVacation.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%'
            });
			

            $("#pageloading").hide();
            
        });
      
       
        function f_search()
        {
        	mygrid.options.url='<%=path%>/doListVacation.do';
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
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
        #errorLabelContainer{ padding:10px; width:300px; border:1px solid #FF4466; display:none; background:#FFEEEE; color:Red;}
    </style>
	</head>
	<body style="padding:6px; overflow:hidden;">
		<form id="searchForm" name="" action="" method="post">

			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				
			<tr>
					<td align="right" class="l-table-edit-td">
						开始时间:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="startTime" type="text" id="startTime" ltype="text" />
					</td>

					<td align="right" class="l-table-edit-td">
						结束时间:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="endTime" type="text" id="endTime" ltype="text" />
					</td>

					<td align="right" class="l-table-edit-td">
						申请人:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input type="text" name="proposerText" id="proposerText" />
						<input type="hidden" name="proposer" id="proposer"/>
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


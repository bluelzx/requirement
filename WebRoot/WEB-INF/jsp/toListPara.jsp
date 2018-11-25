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
        
        function toAddPara()
        {
        	window.location.href='<%=path%>/toAddPara.do';
        }
        
        function toUpdatePara()
        {
            var toUpate = mygrid.getSelectedRow();
        	if(!toUpate){
        		$.ligerDialog.error('请选择更新的参数!');
        		return;
        	}
        	window.location.href='<%=path%>/toUpdatePara.do?paraType='+toUpate.paraType+'&paraCode='+toUpate.paraCode;
        	
        }
        
        
        function toDeletePara(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择删除的参数!');
        		return;
        	}
        	$.ligerDialog.confirm('确认要删除参数：'+toDelete.paraCode, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doDeletePara.do',
								                data: 'paraCode='+toDelete.paraCode+'&paraType='+toDelete.paraType,
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
        
        $(function () {
        
        	$("#paraTypeText").ligerComboBox({  
                data: [
                	{ text: '任务类型', id: '1' },
                    { text: '需求类型', id: '2' },
                    { text: '重要程度', id: '3' },
                    { text: '紧急程度', id: '4' },
                    { text: '业务分类', id: '5' }
                ], valueFieldID: 'paraType'
            }); 
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '参数类型', name: 'paraType',id:'id1', align: 'center', width: 100,
                	render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "任务类型";
                					if(value==2)
                						return "需求类型";
                					if(value==3)
                						return "重要程度";
                					if(value==4)
                						return "紧急程度";
                					if(value==5)
                						return "业务分类";
                	} 
                },
                { display: '参数代码', name: 'paraCode',align: 'center', width: 100 },
                { display: '参数值', name: 'paraValue', width: 300,align:'center' },
                { display: '参数说明', name: 'paraRemark', width: 300,align:'center' }
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false, width: '99%',height:'99%',
                url: '<%=path%>/listAllPara.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '增加', click: toAddPara, icon: 'add' },
                { line: true },
                { text: '修改', click: toUpdatePara, icon: 'modify' },
                { line: true },
                { text: '删除', click: toDeletePara, icon: 'delete' }
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
 <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">参数类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
           		<input type="text" name="paraTypeText" id="paraTypeText" />
           		<input type="hidden" name="paraType" id="paraType" />
                </td>
                
                 <td align="right" class="l-table-edit-td">参数代码:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
           		<input type="text" name="paraCode" id="paraCode" />
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


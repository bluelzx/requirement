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
        
        
        function toAdd()
        {
            window.location.href="<%=path%>/toAddProject.do";
        }
        function toModifyProject(){
        	var toSelectProject = mygrid.getSelectedRow();
        	if(!toSelectProject){
        		$.ligerDialog.error('请选择要修改的项目!');
        		return;
        	}
        	window.location.href="<%=path%>/toUpdateProject.do?projectCode="+toSelectProject.projectCode;
        }
        
        function deleteProject(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择删除的项目!');
        		return;
        	}
        	$.ligerDialog.confirm('确认要删除项目：'+toDelete.projectName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/deleteProject.do',
								                data: 'projectCode='+toDelete.projectCode,
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
        
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '项目代码', name: 'projectCode', width: 150,align:'center' },
                { display: '项目名称', name: 'projectName',id:'id1', align: 'left', width: 300 }
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false, 
                url: '<%=path%>/listAllProject.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '增加', click: toAdd, icon: 'add' },
                 { line: true },
                { text: '修改', click: toModifyProject, icon: 'modify' },
                { line: true },
                { text: '删除', click: deleteProject, icon: 'delete' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
        

       
        function f_search()
        {
            mygrid.options.url='<%=path%>/listAllProject.do';
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
                <td align="right" class="l-table-edit-td">项目代码:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
           		<input type="text" name="projectCode" id="projectCode" />
                </td>
                
                <td align="right" class="l-table-edit-td">项目名称:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="projectName"  id="projectName" type="text"  />
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


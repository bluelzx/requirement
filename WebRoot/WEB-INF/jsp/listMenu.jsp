<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="include.meta.jsp"%>    <script type="text/javascript">
        var mygrid = null;
        function itemclick(item)
        {
            alert(item.text);
        }
        
        function toAdd()
        {
            window.location.href="<%=path%>/toAddMenu.do";
        }
        
        function toModifyMenu(){
        	var toUpdate = mygrid.getSelectedRow();
        	if(!toUpdate){
        		$.ligerDialog.error('请选择要修改的菜单!');
        		return;
        	}
        	window.location.href="<%=path%>/toModifyMenu.do?menuCode="+toUpdate.menuCode;
        }
        
         function disable(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择要删除的菜单!');
        		return;
        		}
        	var toDisableCode = toDelete.menuCode;
        	var toDisableName = toDelete.text;
        	$.ligerDialog.confirm('确认要删除菜单：'+toDisableName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/disableByMenuCode.do',
								                data: 'menuCode='+toDisableCode,
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
                { display: '菜单名称', name: 'text',id:'id1',  width: 250 },
                { display: '菜单编号', name: 'menuCode',align: 'center', width: 150 },
                { display: 'URL', name: 'url', width: 250,align:'center' },
                { display: '上级菜单', name: 'parentMenu', width: 220,align:'center' },
                { display: '排序号', name: 'menuOrder', width: 120,align:'center' },
                { display: '创建者', name: 'creater', width: 120,align:'center' }
                ],  pageSize:10000,pageSizeOptions:[100,500,1000,10000],rownumbers:true,enabledSort:false,
                onAfterShowData :f_onAfterShowData,
                tree: { 
	                columnId: 'id1', 
	                idField: 'menuCode',
                    parentIDField: 'parentMenu'
                    },
                url: '<%=path%>/listAllSysMenu.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '增加', click: toAdd, icon: 'add' },
                { line: true },
                { text: '修改', click: toModifyMenu, icon: 'modify' },
                { line: true },
                { text: '删除', click: disable, icon: 'delete' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
        function f_onAfterShowData(currentData){
        	
            for (var myrowIndex in mygrid.rows)
            { 
            	 var tempMyRow = mygrid.rows[myrowIndex];
            	 if(mygrid.hasChildren(tempMyRow)&&tempMyRow["__level"]==1)
            	 {
            	 	   mygrid.toggle(tempMyRow);
            	 }
            }
        }
       
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
                <td align="right" class="l-table-edit-td">菜单编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="menuCode" type="text" id="menuCode" ltype="text"  /></td>
                
                <td align="right" class="l-table-edit-td">菜单名称:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="text" type="text" id="text" ltype="text"  /></td>
                
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


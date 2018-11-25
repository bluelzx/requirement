<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script type="text/javascript">
        var grid = null;
        function toSaveUser()
        {
            window.location.href="<%=path%>/toSaveUser.do";
        }
        
        function toModifyUser(){
        	var toSelectUser = grid.getSelectedRow();
        	if(!toSelectUser){
        		$.ligerDialog.error('请选择要修改的用户!');
        		return;
        	}
        	window.location.href="<%=path%>/toModifyUser.do?userCode="+toSelectUser.userCode;
        }
        
        function disableUser(){
        	var toDeleteUser = grid.getSelectedRow();
        	if(!toDeleteUser){
        		$.ligerDialog.error('请选择要删除的用户!');
        		return;
        		}
        	var toDisableCode = toDeleteUser.userCode;
        	var toDisableName = toDeleteUser.userName;
        	$.ligerDialog.confirm('确认要删除用户：'+toDisableName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/disableByUserCode.do',
								                data: 'userCode='+toDisableCode,
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
        	$("#userTypeText").ligerComboBox({  
			                data: [
			                    { text: 'admin', id: '0' },
			                    { text: '项目管理人员', id: '1' },
			                    { text: '开发人员', id: '2' },
			                    { text: '测试人员', id: '3' }
			                ], valueFieldID: 'userType'
			            }); 
        	$("#myTeamText").ligerComboBox({  
			                data: [
			                    { text: '本行', id: '1' },
			                    { text: '外包', id: '2' },
			                    { text: '项目', id: '3' }
			                ], valueFieldID: 'myTeam'
			            }); 
            grid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '用户编号', name: 'userCode', align: 'center', width: 150 },
                { display: '用户名', name: 'userName', width: 250 },
                { display: '用户类型', name: 'userType', width: 120,align:'center',
                  render: function (item)
                  {
                  	if (parseInt(item.userType) == 0) return 'admin';
                  	if (parseInt(item.userType) == 1) return '项目管理人员';
                  	if (parseInt(item.userType) == 2) return '开发人员';
                  	if (parseInt(item.userType) == 3) return '测试人员';
                  }
                 },
                 { display: '归属团队', name: 'myTeam', width: 120,align:'center',
                  render: function (item)
                  {
                  	if (parseInt(item.myTeam) == 1) return '本行';
                  	if (parseInt(item.myTeam) == 2) return '外包';
                  	if (parseInt(item.myTeam) == 3) return '项目';
                  }
                 },
                { display: '创建者', name: 'creater', width: 150,align:'center' },
                { display: '创建时间', name: 'createTime', width: 220,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listAllSysUser.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '增加', click: toSaveUser, icon: 'add' },
                { line: true },
                { text: '修改', click: toModifyUser, icon: 'modify' },
                { line: true },
                { text: '删除', click: disableUser, icon: 'delete' }
                ]
                }
            });
			

            $("#pageloading").hide();
        });
        function f_search()
        {
            grid.options.parms=$("#searchForm").serializeArray();
            grid.loadData();
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
<input name="tabid" type="hidden" value="<c:out value="${tabid}"/>" id="tabid"/>
 <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">用户编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="userCode" type="text" id="userCode" ltype="text"  /></td>
                
                <td align="right" class="l-table-edit-td">用户名称:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="userName" type="text" id="userName" ltype="text"  /></td>
                <td align="right" class="l-table-edit-td">用户类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="userTypeText" type="text" id="userTypeText" ltype="text"  />
                <input type="hidden" id="userType" name="userType" value=""/>
                </td>
                <td align="right" class="l-table-edit-td">归属团队:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="myTeamText" type="text" id="myTeamText" ltype="text"  />
                <input type="hidden" id="myTeam" name="myTeam" value=""/>
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


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
            $.ligerDialog.open({ title: '选择文件上传者', name:'winselector',width: 900, height: 500, url: '<%=path%>/selectUserWin.do', buttons: [
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
            window.location.href="<%=path%>/toUpoadFile.do?requirementCode=<c:out value="${requirementCode}"/>";
        }
        
        function toDownLoad(){
        	var toDownLoad = mygrid.getSelectedRow();
        	if(!toDownLoad){
        		$.ligerDialog.error('请选择要下载的文件!');
        		return;
        	}
        	 window.location.href="<%=path%>/downLoadFile.do?fileCode="+toDownLoad.fileCode;
        }
        
        function deleteFile(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择删除的文件!');
        		return;
        	}
        	$.ligerDialog.confirm('确认要删除文件：'+toDelete.fileName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/deleteFile.do',
								                data: 'fileCode='+toDelete.fileCode,
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
            
           $("#userCodeText").ligerComboBox({
                onBeforeOpen: f_selectContact, valueFieldID: 'userCode',width:300
            });
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '需求', name: 'requirementId', width: 150,align:'center' },
                { display: '名称', name: 'fileName',id:'id1', align: 'left', width: 300 },
                { display: '上传时间', name: 'uploadTime',align: 'center', width: 150 },
                { display: '上传者', name: 'userCode', width: 100,align:'center' },
                { display: '文件大小', name: 'fileSize', width: 100,align:'center' }
                
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false, 
                url: '<%=path%>/listAllFile.do?requirementId=<c:out value="${requirementId}"/>',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '上传', click: toAdd, icon: 'up' },
                 { line: true },
                { text: '下载', click: toDownLoad, icon: 'down' },
                { line: true },
                { text: '删除', click: deleteFile, icon: 'delete' }
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
<input type="hidden" name="requirementId" id="requirementId" value="<c:out value="${requirementId}"/>" />
 <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                
                <td align="right" class="l-table-edit-td">上传者:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="userCodeText" type="text" id="userCodeText"  />
             	<input type="hidden" id="userCode" name="userCode"/>
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


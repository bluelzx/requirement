<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <%@ include file="include.meta.1.3.jsp"%>
    <script type="text/javascript">
        var mygrid = null;
        var loginUser = '<%=SystemUtil.getLoginUser(request).getUserCode()%>';
        function itemclick(item)
        {
            alert(item.text);
        }
        
        function toDownLoad(){
         	 var toSelectRow = mygrid.getSelectedRow();
         	 if(!toSelectRow){
        		$.ligerDialog.error('亲,请选择要导出的送测!');
        		return;
        	}
        	 window.location.href = "<%=path%>/downApplyAsWord.do?applyCode="+toSelectRow.applyCode;
        }
        
        $(function () {
        	 
        	
        	$("#statusText").ligerComboBox({  
			                data: [
			                    { text: '待送测', id: '1' },
			                    { text: '已送测', id: '2' },
			                    { text: '待上线', id: '3' },
			                    { text: '已上线', id: '4' }
			                ], valueFieldID: 'status'
			            }); 
        	
        	
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '清单编号', name: 'applyCode',align: 'center', width: 130 },
                { display: '版本号', name: 'applyVersion',align: 'center', width: 130 },
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 130,
                render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewRequirement("+rowindex+")' >"+value+"</a>";
                	}
                 },
                { display: '需求名称', name: 'requirementName',align: 'center', width: 130 },
                { display: '项目名称', name: 'applyName', align: 'center', width: 250 },
                { display: '状态', name: 'status', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "待送测";
                					if(value==2)
                						return "已送测";
                					if(value==3)
                						return "待上线";
                					if(value==4)
                						return "已上线";
                			}
                 },
                { display: '技术负责人', name: 'devPrincipal', align: 'center', width: 100 },
                { display: '自测报告', name: 'reportSelf', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "附带";
                					if(value==2)
                						return "不附带";
                } },
                { display: '送测时间', name: 'applyTime', width: 80,align:'center' },
                { display: '测试部门', name: 'applyDept', width: 80,align:'center' },
                { display: '完成时间', name: 'important', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value)
                						return value;
                					else
                						return "无特殊要求";
                } },
                { display: '测试指引', name: 'howToTest', width: 380,align:'center' },
                { display: '其他说明', name: 'info', width: 100,align:'center' },
                { display: '测试人', name: 'conner', width: 100,align:'center' },
                { display: '授权人', name: 'charge', width: 80,align:'center' },
                { display: '录入者', name: 'creator', width: 70,align:'center' },
                { display: '录入时间', name: 'createTime', width: 70,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listAllRequirementApply.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                 { text: '送测', click: toFinishApply, icon: 'role' },
                 { line: true },
                 { text: '导出送测单', click: toDownLoad, icon: 'down' },
                 { line: true },
                 { text: '申请上线', click: toOnLine, icon: 'add' },
                 { line: true },
                 { text: '上线完成', click: toFinishOnLine, icon: 'add' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
        
        
        
       
        function f_search()
        {	
        	mygrid.options.url = "<%=path%>/listAllRequirementApply.do";
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
       
      function viewRequirement(rowindex){
       	var gData = mygrid.data.rows;
       	$.ligerDialog.open({title:"查看需求", 
       		url: '<%=path%>/toViewRequirement.do?requirementId='+gData[rowindex].requirementId, height: 350,width: 600});
       }
       
       /**
       * 申请上线
       */
       function toOnLine(){
       		var toSelectRow = mygrid.getSelectedRow();
	       	if(!toSelectRow){
	        		$.ligerDialog.error('请选择要申请上线的送测!');
	        		return;
	        }
	        if(toSelectRow.status!=2){
	        		$.ligerDialog.error('请选择已完成的送测!');
	        		return;
	        }
	        $.ligerDialog.confirm('确认送测要申请上线:'+toSelectRow.applyName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doOnLine.do',
								                data: 'applyCode='+toSelectRow.applyCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data){
								                    	$.ligerDialog.success('操作成功!')
								                    	f_search();
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
       
       /**
       * 上线完成
       */
       function toFinishOnLine(){
       		var toSelectRow = mygrid.getSelectedRow();
	       	if(!toSelectRow){
	        		$.ligerDialog.error('请选择要上线的送测!');
	        		return;
	        }
	        if(toSelectRow.status!=3){
	        		$.ligerDialog.error('请选择已申请上线的送测!');
	        		return;
	        }
	        $.ligerDialog.confirm('确认此送测已经上线:'+toSelectRow.applyName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doFinishOnLine.do',
								                data: 'applyCode='+toSelectRow.applyCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data){
								                    	$.ligerDialog.success('操作成功!')
								                    	f_search();
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
       
       function toFinishApply(){
       	var toSelectRow = mygrid.getSelectedRow();
       	if(!toSelectRow){
        		$.ligerDialog.error('请选择要完成的送测!');
        		return;
        }
        if(toSelectRow.status!=1){
        		$.ligerDialog.error('请选择待送测!');
        		return;
        }
        $.ligerDialog.confirm('确认送测已完成:'+toSelectRow.applyName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/finishApply.do',
								                data: 'applyCode='+toSelectRow.applyCode,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data){
								                    	$.ligerDialog.success('操作成功!')
								                    	f_search();
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
                <td align="right" class="l-table-edit-td">需求编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="requirementCode" type="text" id="requirementCode" ltype="text"  /></td>
                
                <td align="right" class="l-table-edit-td">需求名称:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="requirementName" type="text" id="requirementName" ltype="text"  /></td>
                 <td align="right" class="l-table-edit-td">状态:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="statusText" type="text" id="statusText" ltype="text"  />
                <input name="status" type="hidden" id="status" ltype="text"  />
                </td>
            
            </tr>
            <tr>
             <td align="right" class="l-table-edit-td">测试人:</td>
               <td align="left" class="l-table-edit-td" style="width:160px"><input name="conner" type="text" id="conner" ltype="text"  /></td>  
           <td align="right" class="l-table-edit-td">技术负责人:</td>
               <td align="left" class="l-table-edit-td" style="width:160px"><input name="devPrincipal" type="text" id="devPrincipal" ltype="text"  /></td>
             <td align="right" class="l-table-edit-td"></td>
             <td align="left" class="l-table-edit-td" style="width:160px">
             <input id="btnOK" type="button" class="l-button" style="width:100px" value=" 查   询" onclick="f_search()" />
             </td>
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


<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="include.meta.1.3.jsp"%>
    <script type="text/javascript">
        var mygrid = null;
        var myTaskTyps = [];//任务类型
        var myReTyps =[];//需求类型
        var importantData = [];//重要程度
        var urgentData = [];//紧急程度
        function itemclick(item)
        {
            alert(item.text);
        }
        
        function toModifyRequirement(){
        	var toUpdate = mygrid.getSelectedRow();
        	if(!toUpdate){
        		$.ligerDialog.error('请选择要更新的需求!');
        		return;
        	}
        	window.location.href="<%=path%>/toModifyRequirement.do?requirementId="+toUpdate.requirementId;
        }
        
         function toDownLoad(){
        	 window.location.href = "<%=path%>/downLoadRequirements.do?"+$("#searchForm").serialize();
        }
        
        function toAddRemark(){
        	var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('请选择要添加备注的需求!');
        		return;
        	}
        	$.ligerDialog.open({ title: '添加备注', name:'winselector',width: 500, height: 400, url: '<%=path%>/toAddRemark.do?requirementId='+toSelectRow.requirementId
            });
        }
        
        function toFiles(){
        	var toSelectRow = mygrid.getSelectedRow();
        	if(!toSelectRow){
        		$.ligerDialog.error('亲,请选择需求!');
        		return;
        	}
        	$.ligerDialog.open({ title: '需求附件', name:'winselector',width: 800, height: 500, url: '<%=path%>/toListFile.do?requirementCode='+toSelectRow.requirementCode
            });
        }
        
        function f_toAddRemarkCancel(item, dialog)
        {
            dialog.close();
        }
        
        function disable(){
        	var toDelete = mygrid.getSelectedRow();
        	if(!toDelete){
        		$.ligerDialog.error('请选择要删除的需求!');
        		return;
        		}
        	var toDisableId = toDelete.requirementId;
        	var toDisableCode = toDelete.requirementCode;
        	var toDisableName = toDelete.requirementName;
        	$.ligerDialog.confirm('确认要删除需求：'+toDisableName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/disableByRCode.do',
								                data: 'requirementId='+toDisableId,
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
        
        function toCloseRequirement(){
        	var toClose = mygrid.getSelectedRow();
        	
        	if(!toClose){
        		$.ligerDialog.error('请选择要关闭的需求!');
        		return;
        	}else{
        		
        		if(toClose.status==4){
        			$.ligerDialog.error('需求：'+toClose.requirementName+',已经关闭,不用再次关闭!');
        			return;
        		}
        		if(toClose.status!=3){
        			$.ligerDialog.error('需求：'+toClose.requirementName+',有未完成的任务,不能关闭!');
        			return;
        		}
        	}
        	var toCloseId = toClose.requirementId;
        	var toCloseCode = toClose.requirementCode;
        	var toCloseName = toClose.requirementName;
        	$.ligerDialog.confirm('确认要关闭需求：'+toCloseName, function (yes) { 
			                		 
			                		if(yes){
			                			$.ajax({
								                type: 'POST',
								                url: '<%=path%>/closeByRequirementId.do',
								                data: 'requirementId='+toCloseId,
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=="true"){
								                    	f_search();
								                    	$.ligerDialog.success('关闭成功!');
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
        
        function toAdd(item)
        {
            window.location.href="<%=path%>/toAddRequirement.do";
        }
        
        $(function () {
        	 
        	var rType= $("#rTypeText").ligerComboBox({  
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'requirementType'
            }); 
            
            var importType = $("#importantText").ligerComboBox({  
                data:importantData,
                valueField : 'paraCode',
                textField : 'paraValue',
                valueFieldID: 'important'
            });
            
           var urgentType =  $("#urgentText").ligerComboBox({  
                data : urgentData,
                valueField : 'paraCode',
                textField : 'paraValue', 
                valueFieldID: 'urgent'
            }); 
            
        	$.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_2%>',
						dataType: 'json',
						async: false,
						success: function (data){
							myReTyps = data ; 
        	 				rType.setData(myReTyps);	                	
						}
			});
			
			$.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_1%>',
						dataType: 'json',
						async: false,
						success: function (data){
							myTaskTyps = data;
						}
			});
			
			$.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_3%>',
						dataType: 'json',
						async: false,
						success: function (data){
							importantData = data;
        	 				importType.setData(importantData);    	
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
			                    { text: '完成', id: '3' },
			                    { text: '关闭', id: '4' },
			                    { text: '已送测', id: '5' }
			                ], valueFieldID: 'status'
			            }); 
        	
        	
        	
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 130 },
                { display: '需求名称', name: 'requirementName',id:'id1', align: 'left', width: 250 },
                { display: '需求类型', name: 'requirementType', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(myReTyps,value);
                } },
                { display: '业务类型', name: 'businessType', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(businessTypes,value);
                } },
                { display: '责任人', name: 'owner', width: 80,align:'center' },
                { display: '重要程度', name: 'important', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(importantData,value);
                } },
                { display: '紧急程度', name: 'urgent', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(urgentData,value);
                } },
                { display: '项目', name: 'projectCode', width: 100,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnProjectValue(projectCodes,value);
                } },
                { display: '需求部门', name: 'dept', width: 100,align:'center' },
                { display: '需求提出者', name: 'presenter', width: 80,align:'center' },
                { display: '需求状态', name: 'status', width: 80,align:'center',render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "未开始";
                					if(value==2)
                						return "进行中";
                					if(value==3)
                						return "完成";
                					if(value==4)
                						return "关闭";	
                					if(value==5)
                						return "已送测";	
                } },
                
                { display: '录入者', name: 'creator', width: 70,align:'center' },
                { display: '录入时间', name: 'createTime', width: 100,align:'center' },
                { display: '预计开始时间', name: 'startDate', width: 100,align:'center' },
                { display: '预计结束时间', name: 'endDate', width: 100,align:'center' },
                { display: '预计工时', name: 'planManHaur', width: 100,align:'center' },
                { display: '关闭时间', name: 'confirmCloseTime', width: 100,align:'center' },
                { display: '实际完成时间', name: 'closeTime', width: 100,align:'center' }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                 detail: { onShowDetail: f_showTasks,height:'auto' },
                url: '<%=path%>/listLaunchRequirement.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                <c:if test="${userInfo.userType==0 || userInfo.userType==1}">
                { text: '增加', click: toAdd, icon: 'add' },
                { line: true },
                { text: '修改', click: toModifyRequirement, icon: 'modify' },
                { line: true },
                { text: '删除', click: disable, icon: 'delete' },
                 { line: true },
                { text: '关闭', click: toCloseRequirement, icon: 'busy' },
                </c:if>
                { line: true },
                 { text: '添加备注', click: toAddRemark, icon: 'comment' },
                 { line: true },
                 { text: '附件', click: toFiles, icon: 'archives' },
                 { line: true },
                 { text: '导出', click: toDownLoad, icon: 'down' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
        function f_showTasks(row, detailPanel,callback)
        {
            var grid = document.createElement('div'); 
            $(detailPanel).append(grid);
            $(grid).css({'margin':10,'border-color':'orange','border-width':5}).ligerGrid({
                columns: [
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 150 },
                { display: '任务名称', name: 'taskName',id:'id1', align: 'left', width: 300 },
                 { display: '开发者', name: 'userCode', width: 100,align:'center' },
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
                 { display: '所属组', name: 'taskGroup', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "应用组";
                					if(value==2)
                						return "数据组";
                			} },
                { display: '任务类型', name: 'taskType', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					return returnParaValue(myTaskTyps,value);
                			} },
                { display: '预计所需工时', name: 'planManHaur', width: 100,align:'center' },
                { display: '实际工时', name: 'creator', width: 100,align:'center' }
                ],  pageSize:10,pageSizeOptions:[10,20,50,100],rownumbers:true,enabledSort:false,isScroll: false,
                url: '<%=path%>/listAllTask.do?requirementId='+row.requirementId,
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '90%',height:'90%'
            });
        }
        
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
        	mygrid.options.url = "<%=path%>/listLaunchRequirement.do";
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
<form id="searchForm" name="searchForm" action="" method="post">
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
            
            <td align="right" class="l-table-edit-td">重要程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="importantText" type="text" id="importantText" ltype="text"  />
            <input name="important" type="hidden" id="important" ltype="text"  />
            </td>
             
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="urgentText" type="text" id="urgentText" ltype="text"  />
            <input name="urgent" type="hidden" id="urgent" ltype="text"  />
            </td>
            
             <td align="right" class="l-table-edit-td">需求类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	<input id="rTypeText" type="text" ltype="text"  />
                	<input id="requirementType" name="requirementType" type="hidden" />
                </td>
            
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


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
        
        var myTaskTyps = [];
        var urgentData = [];//紧急程度
        
        $(function () {
        	
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
						data: 'paraType=<%=Constants.PARA_TYPE_4%>',
						dataType: 'json',
						async: false,
						success: function (data){
							urgentData = data;
						}
			});
        	
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '任务名称', name: 'taskName', align: 'left', width: 200  },
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
                { display: '预计所需工时', name: 'planManHaur', width: 80,align:'center' },
                { display: '实际工时', name: 'creator', width: 80,align:'center' }
                
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/doListTaskReportDevTask.do?requirementId=<c:out value="${requirementId}"/>',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%'
            });
			

            $("#pageloading").hide();
            
        });
        
       
       function viewTask(rowindex){
       		var gData = mygrid.data.rows;
       		$.ligerDialog.open({title:"查看任务", 
       		url: '<%=path%>/viewTask.do?taskCode='+gData[rowindex].taskCode, height: 350,width: 400});
       }
       
       function f_select()
        {
            return mygrid.getSelectedRows();
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
<form id="searchForm" name="" action="" method="post">
</form>
<b/>
    <div id="maingrid4" style="margin:0; padding:0"></div>
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</html>


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
         var importantData = [];//重要程度
        var urgentData = [];//紧急程度
         
        
        $(function () {
        
        $.ajax({	type: 'POST',
						url: '<%=path%>/getAllParas.do',
						data: 'paraType=<%=Constants.PARA_TYPE_3%>',
						dataType: 'json',
						async: false,
						success: function (data){
							importantData = data;
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
                
                { display: '任务名称', name: 'taskName', align: 'center', width: 200,
                	render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewTask("+rowindex+")' >"+value+"</a>";
                	} },
                { display: '任务状态', name: 'status', width: 60,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "未签收";
                					if(value==2)
                						return "进行中";
                } },	
                { display: '需求编号', name: 'requirementCode',align: 'center', width: 120 ,
                	render: function (rowdata, rowindex, value){
                			return "<a href='javascript:viewRequirement("+rowindex+")' >"+value+"</a>";
                	}
                },	
                { display: '签收日期', name: 'signTime', width: 100,align:'center' },
                { display: '预计完成日期', name: 'planFinishTime', width: 100,align:'center' },
                { display: '预计工时（天）', name: 'planManHaur', width: 100,align:'center' },		
                { display: '累计工时（时）', name: 'allHaur', width: 100,align:'center' },		
                { display: '任务完成百分比(%)', name: 'finishPercent', width: 90,align:'center' },		
                { display: '重要程度', name: 'urgent', width: 80,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(urgentData,value);
                } },
                { display: '紧急程度', name: 'important', width: 80,align:'center',
                			render: function (rowdata, rowindex, value){
                					return returnParaValue(urgentData,value);
                } },
                { display: '预警类型', name: 'alarmType', width: 60,align:'center',
                			render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "即将延迟";
                					if(value==2)
                						return "已延迟";
                } }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/myTaskAlarm.do',
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
       
       function viewRequirement(rowindex){
       	var gData = mygrid.data.rows;
       	$.ligerDialog.open({title:"查看需求", 
       		url: '<%=path%>/toViewRequirement.do?requirementId='+gData[rowindex].requirementId, height: 400,width: 600});
       }
       
        function f_search()
        {
        	mygrid.options.url='<%=path%>/listMyTask.do';
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
		
			<div id="maingrid4" style="margin:0; padding:0"></div>


			<div style="display:none;">
				<!-- g data total ttt -->
			</div>
	</body>
</html>


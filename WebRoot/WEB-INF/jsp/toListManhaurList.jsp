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
        
        
        
         function toDownLoad(){
        	 window.location.href="<%=path%>/downLoadManhaurList.do";
        }
        
       
        
        $(function () {
        
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '类型', name: 'mtype',id:'id1', align: 'left', width: 100 },
                { display: '人员', name: 'personName',align: 'center', width: 100 },
                { display: '需求编号', name: 'requirementCode', width: 100,align:'center' },
                { display: '需求描述', name: 'requirementName', align: 'left', width: 200 },
                { display: '任务描述', name: 'taskName',align: 'center', width: 200 },
                { display: '工时(已确认)', name: 'doneTime', width: 200,align:'center' },
                { display: '工时(待确认)', name: 'todoTime',align: 'center', width: 200 },
                { display: '工时(合计)', name: 'sumTime', width: 200,align:'center' },
                { display: '完成日期', name: 'endTime', width: 300,align:'center' }
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[20,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listManhaurList.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '下载', click: toDownLoad, icon: 'down' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
       
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

<b/>
    <div id="maingrid4" style="margin:0; padding:0"></div>
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</html>


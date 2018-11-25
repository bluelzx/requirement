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
        
        
        $(function () {
        	
            
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '开发人员', name: 'userName', align: 'center', width: 200 },
                { display: '非确认任务签到', name: 'taskC1',id:'id1', align: 'center', width: 150,
                	render: function (rowdata, rowindex, value){
                			if(value==0)
                				return "<span style='color:Red' >"+value+"</span>";
                			else
                			return value;
                	} },
                { display: '确认任务签到', name: 'taskC2',align: 'center', width: 150 }
                ],  pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/doListTodayTaskSignIn.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%'
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
		
		<b />
			<div id="maingrid4" style="margin:0; padding:0"></div>


			<div style="display:none;">
				<!-- g data total ttt -->
			</div>
	</body>
</html>


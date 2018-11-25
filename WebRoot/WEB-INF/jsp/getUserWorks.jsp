<%@ page pageEncoding="UTF-8"%>
<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script type="text/javascript">
        var g = null;
        $(function () {
           g = $("#getUserWorkId").ligerGrid({
                columns: [
                { display: '用户', name: 'userName', align: 'center'  },
                { display: '工作量', name: 'works', align: 'center' }
                ],  pageSize:10,rownumbers:true,enabledSort:false,
                url: '<%=path%>/getUserWorks.do',
                root: 'rows',
                record: 'total',
                 dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],
                width: '99%',height:'99%'
            }); 
            $("#pageloading").hide();
        });
        function f_select()
        {
            return g.getSelectedRow();
        }
    </script>
</head>
<body style="padding:6px; overflow:hidden;">
 
    <div id="getUserWorkId" style="margin:0; padding:0"></div>
 


  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</html>

<!DOCTYPE html>
<%@ include file="include.jsp"%>
<%@ page pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>ECharts</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 

<link href="<%=path%>/LigerUI-1.2.5/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <script src="<%=path%>/LigerUI-1.2.5/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>   
    <script src="<%=path%>/LigerUI-1.2.5/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI-1.2.5/lib/ligerUI/js/plugins/ligerPanel.js" type="text/javascript"></script>
     <script src="<%=path%>/LigerUI-1.2.5/lib/ligerUI/js/plugins/ligerPortal.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI-1.2.5/lib/ligerUI/js/plugins/ligerDrag.js"></script>
    <script type="text/javascript">
        var manager;
        $(function ()
        {
            $("#portalMain").ligerPortal({
                draggable : true,
                rows: [ 
                    {
                        columns: [{
                            width: '100%',
                            panels: [{
                                title: '任务预警清单',
                                width: '99%',
                                height: 400,
                                url: '<%=path%>/toAllTaskAlarm.do'
                            },
                            {
                                title: '我的任务清单',
                                width: '99%',
                                height: 400,
                                url: '<%=path%>/toMyTaskAlarm.do'
                            },
                            {
                                title: '签到情况表(<%=request.getAttribute("workDate") %>)',
                                width: '99%',
                                height: 800,
                                url: '<%=path%>/allWorkDetail.do'
                            }
                            ]
                        }]
                    }
                ]
            }); 
        }); 
    </script>


</head>
<body>
	 <div  id="portalMain"> </div> 
</body>
</html>
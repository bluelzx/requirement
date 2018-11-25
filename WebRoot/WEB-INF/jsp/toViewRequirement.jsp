<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
     <%@ include file="include.meta.jsp"%>

    <script type="text/javascript">
        
        var mygrid = null;
        
        function toDownLoad(){
        	var toDownLoad = mygrid.getSelectedRow();
        	if(!toDownLoad){
        		$.ligerDialog.error('请选择要下载的文件!');
        		return;
        	}
        	 window.location.href="<%=path%>/downLoadFile.do?fileCode="+toDownLoad.fileCode;
        }
        
        $(function () {
        
          mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '名称', name: 'fileName',id:'id1', align: 'left', width: 250 },
                { display: '上传时间', name: 'uploadTime',align: 'center', width: 120 },
                { display: '上传者', name: 'userCode', width: 80,align:'center' }
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[18,30,50,100],rownumbers:true,enabledSort:false, 
                url: '<%=path%>/listAllFile.do?requirementId=<c:out value="${requirement.requirementCode}"/>',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                 { line: true },
                { text: '附件下载', click: toDownLoad, icon: 'down' }
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
    </style>

</head>

<body style="padding:10px">
<div class="l-loading" style="display:block" id="pageloading"></div> 
    <form name="form1" method="post" action=""   id="form1">
    	<input name="requirementId" type="hidden" id="requirementId" value="<c:out value="${requirement.requirementId}"/>" />
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">需求编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <c:out value="${requirement.requirementCode}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求名称:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.requirementName}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            <tr>
                <td align="right" class="l-table-edit-td">上级需求:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
           			<c:out value="${requirement.parentCode}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">预计工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.planManHaur}"/>(人日)
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计开始时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.startDate}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计结束时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.endDate}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">责任人:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.owner}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求部门:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.dept}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求提出者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.presenter}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">重要程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:if test="${requirement.important==1}">普通</c:if>
            <c:if test="${requirement.important==2}">重要</c:if>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:if test="${requirement.urgent==1}">一般</c:if>
            <c:if test="${requirement.urgent==2}">紧急</c:if>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">需求描述:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${requirement.remark}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
           
        </table>
 <br />
    </form>
    
    <div id="maingrid4" style="margin:0; padding:0"></div>
    
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
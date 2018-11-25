<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%@ include file="include.meta.jsp"%>
    <script type="text/javascript">
        var eee;
       
        $(function () {
            
           
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
    <form name="form1" method="post" action="<%=path%>/viewTask.do"   id="form1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <!-- 
            <tr>
            <td align="right" class="l-table-edit-td">需求编号:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.requirementCode}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
             -->
             
            <tr>
                <td align="right" class="l-table-edit-td">任务名称:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <c:out value="${task.taskName}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">前置任务:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${dependableTaskText}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
             <tr>
                <td align="right" class="l-table-edit-td">所属组:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                <c:if test="${task.taskGroup==1 }">应用组
                </c:if>
                <c:if test="${task.taskGroup==2 }">数据组
                </c:if>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
             <tr>
            <td align="right" class="l-table-edit-td">紧急程度:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:if test="${task.urgent==1}">一般</c:if>
            <c:if test="${task.urgent==2}">紧急</c:if>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">任务类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                <c:forEach items="${paras}" var="para">
                	<c:if test="${task.taskType==para.paraCode }">
                	<c:out value="${para.paraValue}"/>
                	</c:if>
                </c:forEach>	 
                	 
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
             <tr>
                <td align="right" class="l-table-edit-td">任务状态:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                	 <c:if test="${task.status==1 }">未开始
                </c:if>
                <c:if test="${task.status==2 }">进行中
                </c:if>
                 <c:if test="${task.status==3 }">完成
                </c:if>
                <c:if test="${task.status==4 }">挂起
                </c:if>
                 <c:if test="${task.status==5 }">逾期未完成
                </c:if>
                <c:if test="${task.status==6 }">逾期完成
                </c:if>
                <c:if test="${task.status==-1 }">等待前置任务
                </c:if>
                <c:if test="${task.status==7 }">关闭
                </c:if>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计所需工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.planManHaur}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">实际工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.manHaur}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">开发者:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <c:out value="${userCodeText}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">描述:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.remark}"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
			
        </table>
 <br />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

</body>
</html>



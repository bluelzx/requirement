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
        var validator;
        $(function () {
        	 <c:if test="${task.isLongTerm=='0'}">
        	$("#planFinishTime").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
        	</c:if>
        	
        	$.validator.addMethod("myUnit",function(value,element){
            	var myUnitValue = parseFloat(value);
            	if(isNaN(myUnitValue)){
            		return false;
            	}
            	var myUnitLeft = myUnitValue%0.5;
            	if(myUnitLeft>0){
            	return false;
            	}
            	return true;
            },"最小单位为0.5天");
            
            $.validator.addMethod("afterToday",function(value,element){
            	var currentDate =  getNowFormatDate();
            	var selectDate = value;
            	var day1 = new Date(currentDate.substr(0,4),currentDate.substr(4,2),currentDate.substr(6,2));
            	var day2 = new Date(selectDate.substr(0,4),selectDate.substr(4,2),selectDate.substr(6,2));
            	if(day1>day2){
            		return false;
            	}else{
            	return true;
            	}
            },"完成日期从今天开始");
            
            $.validator.addMethod("beforeDays",function(value,element){
            	var currentDate =  getNowFormatDate();
            	var selectDate = $("#planFinishTime").val();
            	var day1 = new Date(currentDate.substr(0,4),currentDate.substr(4,2),currentDate.substr(6,2));
            	var day2 = new Date(selectDate.substr(0,4),selectDate.substr(4,2),selectDate.substr(6,2));
            	var dayDiff = value-((day2-day1)/(1000*3600*24))-1;
            	if(dayDiff>0){
            		return false;
            	}
            	
            	return true;
            },"工时超过最大值");
        	        
            $.metadata.setType("attr", "validate");
            
            validator = $("form").validate({
                //调试状态，不会提交数据的
                debug: false,
                errorPlacement: function (lable, element) {
					
                    if (element.hasClass("l-textarea")) {
                        element.addClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field")) {
                        element.parent().addClass("l-text-invalid");
                    }

                    var nextCell = element.parents("td:first").next("td");
                    nextCell.find("div.l-exclamation").remove(); 
                    $('<div class="l-exclamation" title="' + lable.html() + '"></div>').appendTo(nextCell).ligerTip(); 
                },
                success: function (lable) {
                    var element = $("#" + lable.attr("for"));
                    var nextCell = element.parents("td:first").next("td");
                    if (element.hasClass("l-textarea")) {
                        element.removeClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field")) {
                        element.parent().removeClass("l-text-invalid");
                    }
                    nextCell.find("div.l-exclamation").remove();
                },
                submitHandler: function () {
                   
					
                }
            });
            $("form").ligerForm();
            

            
        });
        
        function getNowFormatDate(){
        	var bDate = new Date();
            	var year = bDate.getFullYear();
            	var month = bDate.getMonth()+1;
            	var mday = bDate.getDate();
            	var currentDate = year; 
            	if(month>=10){
            		currentDate = currentDate+""+month;
            	}else{
            		currentDate = currentDate+"0"+month;
            	}
            	if(mday>=10){
            		currentDate = currentDate+""+mday;
            	}else{
            		currentDate = currentDate+"0"+mday;
            	}
            	return currentDate;
        }
        
        function checkForm(){
        	return validator.form();
        }
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
    <form name="form1" method="post" action="<%=path%>/doSignFor.do"   id="form1">
    	<input name="taskCode"  id="taskCode" type="hidden" value="<c:out value="${task.taskCode}"/>"/>
    	
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">任务:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <c:out value="${task.taskName}"/>
                </td>
                <td align="left"></td>
            </tr>
            
            <c:if test="${task.isLongTerm=='1'}">
           	</c:if>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计完成时间:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <c:if test="${task.isLongTerm=='0'}">
            <input name="planFinishTime" type="text" id="planFinishTime" value="<c:out value="${task.planFinishTime}"/>" ltype="text"  validate="{required:true,afterToday:true}" />
             </c:if>
             <c:if test="${task.isLongTerm=='1'}">
             <input name="planFinishTime" type="text" readonly="true" id="planFinishTime" value="20991231" />
           	</c:if>
            </td>
            <td align="left">任务开发自测完成的最后截止日期，不包括UAT业务测试时间，和预计花费工时无直接联系</td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">预计花费工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:if test="${task.isLongTerm=='0'}">
            <input name="planManHaur"  type="text" id="planManHaur"  value="<c:out value="${task.planManHaur}"/>" ltype='text'  class="required"  validate="{required:true,myUnit:true,beforeDays:true,number:true,min:0}" />
            </c:if>
             <c:if test="${task.isLongTerm=='1'}">
             <input name="planManHaur"  type="text" readonly="true" id="planManHaur"  value="99999"  />
            </c:if>
            </td>
            <td align="left">预计该任务完成的实际所需工时。最小单位0.5天。</td>
            </tr>
             
        </table>
 <br />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
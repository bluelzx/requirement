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
        var myValidate = null;
        $(function () {
        	
        	$("#launchDate").ligerDateEditor({ absolute:false,showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left'});
        
            $.metadata.setType("attr", "validate");
            
            myValidate = $("form").validate({
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
        
        function checkForm(){
        	return myValidate.form();
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
    <form name="form1" method="post" action="<%=path%>/doLaunch.do"   id="form1">
    	<input name="taskCode"  id="taskCode" type="hidden" value="<c:out value="${task.taskCode}"/>"/>
    	 
        <table cellpadding="0" cellspacing="0"  >
            <tr>
                <td align="right" class="l-table-edit-td">任务:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <c:out value="${task.taskName}"/>
                </td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">上线日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="launchDate" type="text" id="launchDate"  ltype="text"  validate="{required:true}" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
           
      </table>  
 <br />
    </form>

    
</body>
</html>
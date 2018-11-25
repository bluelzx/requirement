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
           
           $("#startDate").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 0, labelAlign: 'left' });
           
           $("#endDate").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 0, labelAlign: 'left' });
           
           
            $.metadata.setType("attr", "validate");
            
            myValidate = $("form").validate({
                //调试状态，不会提交数据的
                debug: false,
                errorPlacement: function (lable, element) {
					
                   if (element.hasClass("l-textarea"))
                    {
                        element.addClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field"))
                    {
                        element.parent().addClass("l-text-invalid");
                    }
                    $(element).removeAttr("title").ligerHideTip();
                    $(element).attr("title", lable.html()).ligerTip();
                },
                success: function (lable) {
                   var element = $("#" + lable.attr("for"));
                    if (element.hasClass("l-textarea"))
                    {
                        element.removeClass("l-textarea-invalid");
                    }
                    else if (element.hasClass("l-text-field"))
                    {
                        element.parent().removeClass("l-text-invalid");
                    }
                    $(element).removeAttr("title").ligerHideTip();
                },
                submitHandler: function () {
                   
					form1.submit();
                }
            });
            $("form").ligerForm();
            

            
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
	
    <form name="form1"  method="post" action="<%=path%>/downLoadReportWeek.do"   id="form1">
    	
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >

            
			<tr>
            <td align="right" class="l-table-edit-td">开始日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input name="startDate" type="text" id="startDate" ltype="text" validate="{required:true}" />
            </td>
            <td class="l-table-edit-td" align="left" >
            </td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">结束日期:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input name="endDate" type="text" id="endDate" ltype="text" validate="{required:true}"   />
            </td>
            <td align="left" class="l-table-edit-td" >
            </td>
            </tr>
			
        </table>
 <br />
 <input type="submit" value="生成统计表" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
    </form>
    
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
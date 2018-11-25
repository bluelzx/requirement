<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link href="<%=path%>/js/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
 <link href="<%=path%>/LigerUI/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />   
<link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/js/uploadify/swfobject.js" type="text/javascript"></script>
<script src="<%=path%>/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>

<script src="<%=path%>/LigerUI/lib/ligerUI/draggable.js" type="text/javascript"></script>
<script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
<script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
<script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>

       <script type="text/javascript">
        var eee;
        var myValidate = null;
        $(function () {
            
            $("#weightRatioText").ligerComboBox({  
                data: [
                    { text: '较多', id: '1' },
                    { text: '一般', id: '2' },
                    { text: '较少', id: '3' }
                ], valueFieldID: 'weightRatio',initValue :'2'
            }); 
            
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
            },"最小单位为0.5小时");
            
            $.metadata.setType("attr", "validate");
            
              $("#isOT").change(function () { 
              	
              	if(this.checked){
              		$("#otHour").ligerGetTextBoxManager().setEnabled();
              		//$("#otHour").attr("disabled",false);
              	}else{
              		//$("#otHour").val("");
              		//$("#otHour").attr("disabled",true);
              		$("#otHour").ligerGetTextBoxManager().setValue('0');
              		$("#otHour").ligerGetTextBoxManager().setDisabled();
              	} 
              	
              	}
              );
            
            
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
                   $("#Button1").attr("disabled",true);
					form1.submit();
                }
            });
            $("form").ligerForm();
            

            $("#otHour").ligerGetTextBoxManager().setDisabled();
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
	
    <form name="form1"  method="post" action="<%=path%>/doTaskSignIn.do"   id="form1">
    	<input type="hidden" name="taskCode" id="taskCode" value="<c:out value="${taskCode}"/>"/>
    	<input type="hidden" name="finishPercent" id="finishPercent" value="<c:out value="0"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >

			<tr>
            <td align="right" class="l-table-edit-td">任务:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <c:out value="${task.taskName}"/>
            </td>
            </tr>

			<!-- 
			<tr>
            <td align="right" class="l-table-edit-td">任务完成百分比(%):</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
             <input type="text" name="finishPercent" id="finishPercent" value="0"  validate="{number:true,required:true}"/>
            </td>
            </tr>
			 -->
			 <!--
			<tr>
            <td align="right" class="l-table-edit-td">正常工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="manHour" id="manHour" value="<c:out value="${todayInputHour}"/>" validate="{required:true,number:true,min:0,max:<c:out value="${todayInputHour}"/>,myUnit:true}"  />
            </td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td"><input type="checkbox" id="isOT" />加班工时:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="otHour" id="otHour" value="0"  validate="{number:true,myUnit:true}"/>
            </td>
            </tr>
            -->
            
            <tr>
            <td align="right" class="l-table-edit-td">当日投入比重:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="weightRatioText" type="text" id="weightRatioText" ltype="text" validate="{required:true}" />
            <input name="weightRatio" type="hidden" id="weightRatio" ltype="text" value="2" validate="{required:true}"  />
            </td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">备注:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:300px"validate="{required:true}"></textarea>
            </td>
            </tr>
        </table>
 <br />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
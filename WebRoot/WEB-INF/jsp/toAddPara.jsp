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
            
            $("#paraTypeText").ligerComboBox({  
                data: [
                	{ text: '任务类型', id: '1' },
                    { text: '需求类型', id: '2' },
                    { text: '重要程度', id: '3' },
                    { text: '紧急程度', id: '4' },
                    { text: '业务分类', id: '5' }
                ], valueFieldID: 'paraType'
            }); 
            
            $.metadata.setType("attr", "validate");
            
            
            var v = $("form").validate({
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
                  $.ajax({
								                type: 'POST',
								                url: '<%=path%>/checkParaExist.do',
								                data: $("#form1").serialize(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#Button1").attr("disabled",true);
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=='false'){
								                    	$("#Button1").attr("disabled",false);
								                    	$.ligerDialog.error('亲,参数'+$("#paraCode").val()+'已经存在,请选择其他参数编号!')
								                    	$("#requirementCode").val("");
								                    	$("#requirementCode").focus();
								                     	return;
								                     }else{
										                $("#Button1").attr("disabled",true);
									                   form1.submit();
								                     }
								                   
								                },
								                error: function (XMLHttpRequest, textStatus, errorThrown)
								                {
								                    try
								                    {
								                        $("#pageloading").hide();
								                        $("#Button1").attr("disabled",false);
								                    }
								                    catch (e)
								                    {
								
								                    }
								                }
								            });
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

    <form name="form1" method="post" action="<%=path%>/doAddPara.do"   id="form1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">参数类型:</td>
                <td align="left" class="l-table-edit-td" style="width:160px">
                <input name="paraTypeText" type="text" id="paraTypeText" ltype="text" validate="{required:true}" /></td>
                <input name="paraType" type="hidden" id="paraType" /></td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">参数编号:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="paraCode" id="paraCode" validate="{required:true}"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">参数值:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input type="text" name="paraValue" id="paraValue" validate="{required:true}" />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">参数备注:</td>
            <td align="left" class="l-table-edit-td" style="width:160px">
            <input name="paraRemark" type="text" id="paraRemark" ltype="text"  />
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>

        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button1" class="l-button" style="width: 80px;" onclick="javascript:window.history.go(-1);"/>

    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
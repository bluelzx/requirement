<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>新增用户
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%@ include file="include.meta.jsp"%>

    <script type="text/javascript">
    
    	var validator = null;
    	
    	function doAddRemark(){
        	if(validator.form()){
        		$.ajax({
								                type: 'POST',
								                url: '<%=path%>/doAddRemark.do',
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
								                	$("#Button1").attr("disabled",false);
								                    if (data){//成功
								                    	var myRemark = $('<div  class="messageLog">'+
								                    					'<div  class="messageSpan"><img src="<%=path%>/LigerUI/lib/ligerUI/skins/icons/memeber.gif" />'+
								                    					data.logCreator
								                    					+'<span style="padding-left: 200px;">'+
								                    					data.logTime
								                    					+'</span></div>'
								                    					+'<div class="messageLine">&nbsp;</div><div class="messageContent"><pre>'
								                    					+data.logText
								                    					+'</pre></div>'
								                    					+'</div>');
								                    	$("#outer").append(myRemark);
								                    	$("#remark").val('');
								                    	$("#remark").focus();					
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
        }
    	
        $(function () {
        	
        	$("#remark").focus();
        	
        	validator  = $("form").validate({
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
            
            $("#pageloading").hide();
        });  
        
    </script>
    <style type="text/css">
           body{ font-size:12px;}
        .l-table-edit {}
        .l-table-edit-td{ padding:4px;}
        .l-button-submit,.l-button-test{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
        .l-verify-tip{ left:230px; top:120px;}
        .messageLog{width: 400px;margin-top: 20px;margin-bottom: 30px;background-color: #F0FAF8}
        .messageSpan{width: 400px; padding-left: 10px;margin-top: 10px;}
        .messageLine{padding-left: 10px;margin: 5px 0;line-height: 1px;border-left: 400px solid #ddd; 400px solid #ddd;text-align: left;}
        .messageContent{padding-left: 30px;margin: 20px 0;}
    </style>

</head>

<body style="padding:10px">
<div class="l-loading" style="display:block" id="pageloading"></div> 
    <form name="form1" method="post" action="<%=path%>/doAddRemark.do"   id="form1">
    	<input name="requirementId" id="requirementId" value="<c:out value="${requirementId}"/>" type="hidden"/>
    	<input name="taskCode" id="taskCode" value="<c:out value="${taskCode}"/>" type="hidden"/>
    	
    <div id="outer">
    <c:forEach items="${logs}" var="log" varStatus="iNumber">
    <div  class="messageLog">
    	<div  class="messageSpan"><img src="<%=path%>/LigerUI/lib/ligerUI/skins/icons/memeber.gif" /><c:out value="${log.logCreator}"/> <span style="padding-left: 200px;"><c:out value="${log.logTime}"/></span> </div>
    	<div class="messageLine">&nbsp;</div>
    	<div class="messageContent"><pre><c:out value="${log.logText}" escapeXml="false"/></pre></div>
    </div>
    </c:forEach>
    </div>
    
    <div id="remarkForm" style="width: 400px;">
    	<div id="remarkTile"><h4>填写你的备注</h4> </div>
    	<div style="padding: 0 20px;margin: 5px 0;line-height: 1px;border-left: 400px solid #ddd; 400px solid #ddd;">&nbsp;</div>
    	<div style="padding: 0 1px;margin: 20px 0;">
    	<dl>
    		<dd><textarea name="remark" id="remark" cols="100" rows="5" class="l-textarea" style="width:400px" validate="{required:true}"></textarea></dd>
    		<dt style="padding: 0 1px;margin: 10px 0;"><input type="button" onclick="javascript:doAddRemark()" value="提交" id="Button1" class="l-button" /></dt>
    	</dl>
    	</div>
    </div>
    </form>
    <div style="display:none"></div>

</body>
</html>
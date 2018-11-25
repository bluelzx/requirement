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
        var myFileUpload;
        
        $(function () {
        	
        	
        	
            myFileUpload = $("#file_upload").uploadify({
            'swf':'<%=path%>/js/uploadify/uploadify.swf',
            'uploader':'<%=path%>/doTmpUploadFile.do;jsessionid=<%=session.getId()%>',
            auto:false,
            buttonText : '选择要上传文件',
            debug : false,
            buttonClass : 'l-button',
            removeCompleted : false,
			onUploadSuccess : function(file,data,response){
				//var myData = eval('('+data+')');
				$("#form1").append("<input type='hidden' value='"+data+"' id='"+file.id+"' name='uploadFiles' />");
				var myCancel = $("#"+file.id+" .cancel a");
				if(myCancel){
					myCancel.on("click",function(){
						$(this).hide();
						$("#"+file.id).remove();
					});
				}
			}
            });
            
			$("#requirementCode").ligerComboBox(
                {
                    url: '<%=path%>/getSelectRequirements.do',
                    valueField: 'requirementCode',
                    textField: 'requirementCode', 
                    valueFieldID : 'requirementId', 
                    selectBoxWidth: 200,
                    autocomplete: true,
                    width: 200, initValue :'<c:out value="${requirementCode}"/>'
                }
            ); 
            
            
            
        });
        
        function startUpload(){
        	var requirementId = $('#requirementId').val();
        	if(requirementId==""){
        		$.ligerDialog.error('亲,请选择要需求!');
        		requirementId.focus();
        		return;
        	}
        	$('#file_upload').uploadify('upload','*');
        }
        
        function mySubmit(){
        	if(myFileUpload.data('uploadify').queueData.queueLength){
       			$.ligerDialog.error("你选择了文件但是还没有上传!");
       			return;
       		}else{
       			var myFile = "";
			    		$("input[name='uploadFiles']").each(function(){
			    			if(myFile==""){
			    				myFile = $(this).val();
			    			}else{
			    				myFile = myFile+","+$(this).val();
			    			}
			    		});
			    		
			    		$("#form1").append("<input type='hidden' value='"+myFile+"' name='allFiles' />");
       		}
        	form1.submit();
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
    <form name="form1" method="post" action="<%=path%>/doSmartUpload.do" enctype="multipart/form-data"   id="form1">
        <input name="fromRtree"  type="hidden" value="<c:out value="${fromRtree}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
            <td align="right" class="l-table-edit-td">需求编号:</td>
            <td align="left" class="l-table-edit-td" style="width:460px">
            <input type="text" name="requirementCode" id="requirementCode" value="<c:out value="${requirementCode}"/>"/>
           		<input type="hidden" name="requirementId" id="requirementId" value="<c:out value="${requirementCode}"/>"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">文件:</td>
            <td align="left" class="l-table-edit-td" style="width:460px">
            <div style="margin-bottom: 50px;">
		   <p><input type="file" name="file_upload" id="file_upload"/></p>
		   <p><a href="javascript:startUpload()">开始上传</a></p>
		   </div>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>

        </table>
 <br />
<input type="button" value="提交" id="Button1" class="l-button l-button-submit" onclick="javascript:mySubmit();"/>
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button1" class="l-button" style="width: 80px;" onclick="javascript:window.history.go(-1);"/>
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
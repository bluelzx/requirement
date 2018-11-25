<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=6" />
    
    <link href="<%=path%>/js/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
    
    <script src="<%=path%>/js/uploadify/jquery-1.8.0.min.js" type="text/javascript"></script>
     <script src="<%=path%>/js/uploadify/swfobject.js" type="text/javascript"></script>
    <script src="<%=path%>/js/uploadify/jquery.uploadify.js" type="text/javascript"></script>
   	<link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script type="text/javascript">
        var eee;
        
        
        $(function () {
        	
        	
        	
            $("#file_upload").uploadify({
            'swf':'<%=path%>/js/uploadify/uploadify.swf',
            'uploader':'<%=path%>/doTmpUploadFile.do;jsessionid=<%=session.getId()%>',
            auto:false,
            buttonText : '选择要上传文件',
            debug : true,
            buttonClass : 'l-button',
			onUploadSuccess : function(file,data,response){
				var myData = eval('('+data+')');
				alert(myData.fileCode);
			}
            });
            
			$("#requirementId").ligerComboBox(
                {
                    url: '<%=path%>/getSelectRequirements.do',
                    valueField: 'requirementId',
                    textField: 'requirementCode', 
                    selectBoxWidth: 200,
                    autocomplete: true,
                    width: 200, initValue :'<c:out value="${requirementId}"/>'
                }
            ); 
            
            
            
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
    <form name="form1" method="post" action="<%=path%>/doUpoadFile.do" enctype="multipart/form-data"   id="form1">
        <input name="fromRtree"  type="hidden" value="<c:out value="${requirementCode!=null}"/>"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
            <td align="right" class="l-table-edit-td">需求编号:</td>
            <td align="left" class="l-table-edit-td" style="width:460px">
            <input type="text" name="requirementId" id="requirementId" value="<c:out value="${requirementId}"/>"/>
            </td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">文件:</td>
            <td align="left" class="l-table-edit-td" style="width:460px">
           
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

    <div style="height:20px;border-bottom: 1px solid #ccc;margin-top: 1px;">
    <p><img src="<%=path%>/LigerUI/lib/ligerUI/skins/icons/communication.gif" />  附件上传：</p>
   </div>  
   <div>
   <p><input type="file" name="file_upload" id="file_upload"/></p>
   <p><a href="javascript:$('#file_upload').uploadify('upload','*')">开始上传</a></p>
   </div>
</body>
</html>
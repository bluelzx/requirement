<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
         <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="include.meta.jsp"%>
            <script type="text/javascript">
				var tab =null;
                $(function ()
                {
					$("#tree1").ligerTree({
                    url:'<%=path%>/getAllRequirementTree.do',
                    idFieldName :'requirementId',
                    textFieldName : 'requirementCode',
             		parentIDFieldName :'parentCode',
                    checkbox: false,
                    slide: false,
                    nodeWidth: 120,
                    onSelect: function (node)
                    {
                       //tab.reload("home1");
					   //alert(node.data.requirementName);
					   $("#home1").attr("src","<%=path%>/toViewRequirement.do?requirementId="+node.data.requirementId);
					   $("#home2").attr("src","<%=path%>/toListReTask.do?requirementId="+node.data.requirementId);
					   $("#home3").attr("src","<%=path%>/toListReUser.do?requirementId="+node.data.requirementId);
					   $("#home4").attr("src","<%=path%>/toListReFile.do?requirementId="+node.data.requirementId);
					  
                    }
                });
                
                    $("#layout1").ligerLayout({ leftWidth: 300,allowLeftResize :false,allowLeftCollapse :false});
                    tab = $("#tab1").ligerTab({ height:'100%'});
					            
                });
                
         </script> 
        <style type="text/css"> 

                </style>
    </head>
    <body >  
      <div id="layout1">
            <div position="left" title="需求树">
            <ul id="tree1" style="margin-top:3px;"></ul>
            </div>
            <div position="center" id="tab1">
            	<div tabid="home1" title="基本信息" style="height:100%" >
                <iframe frameborder="0" name="home1" id="home1" src=""></iframe>
            	</div> 
            	<div tabid="home2" title="工作任务" style="height:100%" >
                <iframe frameborder="0" name="home2" id="home2" src=""></iframe>
            	</div> 
            	<div tabid="home4" title="相关文档" style="height:100%" >
                <iframe frameborder="0" name="home4" id="home4" src=""></iframe>
            	</div>
            	<div tabid="home3" title="工作人员" style="height:100%" >
                <iframe frameborder="0" name="home3" id="home3" src=""></iframe>
            	</div> 
            	
            </div>  
        </div> 
    </body>
    </html>

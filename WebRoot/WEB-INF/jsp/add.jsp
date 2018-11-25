<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>新增用户
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%@ include file="include.meta.jsp"%>

    <script type="text/javascript">
    	function getData()
        {
            return [
                { text: '已分配菜单',id : '0' }
            ];
        }
        var actionNode;
        var userMenus;
        function genUserMenus(data,parentId){
        	for (var i = 0; i < data.length; i++)
                {
                	var mydata = data[i];
                	var menuCode = mydata.menuCode;
                	if(menuCode&&mydata['__status']!='delete'){
                		if(parentId == undefined)
                			parentId = '0';
		        		userMenus = menuCode+':'+parentId+':'+mydata.treedataindex+';'+userMenus;
		        	}
		        	if(data[i].children){
		        		genUserMenus(data[i].children,menuCode);
		        	}
                }
        	
        }
        function deleteItem()
        {		
        		
                
            if (actionNode){
            	if(actionNode.id!=0)
                	t2.remove(actionNode);
            }
        }
        function gotoList(){
        	
        }
        var eee;
        $(function () {
        	
        	window['t1'] =
            $("#tree1").ligerTree({
                nodeDraggable: false,
                url: '<%=path%>/getAllMenuForUser.do',
                idFieldName :'menuCode',
             	parentIDFieldName :'parentMenu'
            });


            var menu = $.ligerMenu({ width: 120, items:
            [
                { text: '删除', click: deleteItem, icon: 'delete' } 
            ]
            });

            window['t2'] =
            $("#tree2").ligerTree({
                nodeDraggable: tree1,
                data: getData(),
                onContextmenu: function (node, e)
                {
                    actionNode = node.data;
                    menu.show({ top: e.pageY, left: e.pageX });
                    return false;
                }
            });


            treeDraggable(t1, t2);
        	
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
								                url: '<%=path%>/checkUserCode.do',
								                data: 'userCode='+$("#userCode").val(),
								                dataType: 'json',
								                beforeSend: function ()
								                {
								                    $("#Button1").attr("disabled",true);
								                    $("#pageloading").show();
								                },
								                success: function (data)
								                {
								                	$("#pageloading").hide();
								                    if (data=='true'){
								                    	$("#Button1").attr("disabled",false);
								                    	$.ligerDialog.error('用户'+$("#userCode").val()+'已经存在,请选择其他用户编号!')
								                     	return;
								                     }else{
								                     	//菜单树
									                	userMenus = "";
										        	    var tdatas = t2.data;
										                genUserMenus(tdatas,'0');
										                $("#userMenus").val(userMenus);
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
    <form name="form1" method="post" action="<%=path%>/saveSysUser.do"   id="form1">
    	<input name="userMenus" id="userMenus" type="hidden"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">用户编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="userCode" type="text" id="userCode" ltype="text" validate="{required:true,maxlength:10}" /></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">用户名称:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="userName" type="text" id="userName" ltype="text" validate="{required:true,maxlength:10}" /></td>
            <td align="left"></td>
            </tr>
            <!-- 
            <tr>
            <td align="right" class="l-table-edit-td">用户密码:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="password" type="text" id="password" ltype="text" validate="{required:true,minlength:3,maxlength:10}" /></td>
            <td align="left"></td>
            </tr>
            -->
           
            <tr>
                <td align="right" class="l-table-edit-td">用户类型:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                <select name="userType" id="userType" ltype="select">
					<option value="1">项目管理人员</option>
					<option value="2">开发人员</option>
					<option value="3">测试人员</option>
				</select>
                </td>
                <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">归属团队:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
                <select name="myTeam" id="myTeam" ltype="select">
					<option value="1">本行</option>
					<option value="2">外包</option>
					<option value="3">项目</option>
				</select>
                </td>
                <td align="left"></td>
            </tr>
            
            <tr>
                <td align="right" class="l-table-edit-td">分配菜单:</td>
                <td align="left" class="l-table-edit-td" style="width:180px">
               		<div style="width: 300px; height: 400px; margin-left: 0px; margin-right: 1px; float: left;border: 1px solid #ccc; overflow: auto;">
               			<ul id="tree1"></ul>
               		</div>
                </td>
                <td align="left">
                 <div style="width: 300px; height: 400px; margin: 10px; margin-left: 1px; float: left;border: 1px solid #ccc; overflow: auto;">
                	<ul id="tree2"></ul>
                 </div>
                </td>
            </tr>
        </table>
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
 &nbsp; &nbsp; &nbsp; &nbsp;
<input type="button" value="返回" id="Button1" class="l-button" style="width: 80px;" onclick="javascript:window.history.go(-1);"/>

    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>
<br>
<br>
    
</body>
</html>
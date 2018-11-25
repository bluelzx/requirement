<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="<%=path%>/LigerUI/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" /> 
    <script src="<%=path%>/LigerUI/lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/core/base.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/core/inject.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerButton.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerListBox.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=path%>/LigerUI/lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=path%>/LigerUI/lib/jquery-validation/messages_cn.js" type="text/javascript"></script>

    <script type="text/javascript">
        var eee;
        $(function () {
            $.metadata.setType("attr", "validate");
            
            $("#parentMenuText").ligerComboBox({
                width: 180,
                selectBoxWidth: 200,
                selectBoxHeight: 200,
                slide :false,
                valueField: 'menuCode', treeLeafOnly:false,valueFieldID:'parentMenu',
                tree: {
                    url:'<%=path%>/indexSysMenu.do',
                    idFieldName :'menuCode',
             		parentIDFieldName :'parentMenu',
                    checkbox: false,
                    slide: false,
                    nodeWidth: 120
                    }
            });
            
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
                   liger.get("listbox2").selectAll();
                    $.ajax({
			                type: 'POST',
			                url: '<%=path%>/doSaveDyMenu.do',
			                data: $("#form1").serialize(),
			                dataType: 'json',
			                beforeSend: function ()
			                {
			                    $("#myloading").loading.show();
			                },
			                success: function (data)
			                {
			                	$("#myloading").loading.hide();
			                    if (!data) return;
			                   
			                },
			                error: function (XMLHttpRequest, textStatus, errorThrown)
			                {
			                    try
			                    {
			                        $("#myloading").loading.hide();
			                    }
			                    catch (e)
			                    {
			
			                    }
			                }
			            });
                }
            });
            $("form").ligerForm();
            
            $("#listbox1").ligerListBox({
            	url : '<%=path%>/getAllUserForAddMenu.do',
                isShowCheckBox: false,
                isMultiSelect: true,
                valueField : 'userCode',
                textField : 'userName',
                height: 140,
                width :180
            });
            $("#listbox2").ligerListBox({
                isShowCheckBox: false,
                isMultiSelect: true,
                 valueField : 'userCode',
                textField : 'userName',
                height: 140,
                width : 180,
                valueFieldID : 'toUserIds'
            });

            
        });
        function moveToLeft()
        {
            var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
            var selecteds = box2.getSelectedItems();
            if (!selecteds || !selecteds.length) return;
            box2.removeItems(selecteds);
            box1.addItems(selecteds);
        }
        function moveToRight()
        {
            var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
            var selecteds = box1.getSelectedItems();
            if (!selecteds || !selecteds.length) return;
            box1.removeItems(selecteds);
            box2.addItems(selecteds);
        }
        function moveAllToLeft()
        { 
            var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
            var selecteds = box2.data;
            if (!selecteds || !selecteds.length) return;
            box1.addItems(selecteds);
            box2.removeItems(selecteds); 
        }
        function moveAllToRight()
        { 
            var box1 = liger.get("listbox1"), box2 = liger.get("listbox2");
            var selecteds = box1.data;
            if (!selecteds || !selecteds.length) return;
            box2.addItems(selecteds);
            box1.removeItems(selecteds);
            
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
    <div style="position: absolute;z-index: 91000;  top:40%; left:50%; overflow:hidden;
    background:url('<%=path%>/LigerUI/lib/images/loading.gif') no-repeat 0px 0px;width:24px; height:24px; 
     display:none;" id="myloading"></div>
    <form name="form1" method="post" action="<%=path%>/doSaveDyMenu.do"   id="form1">
    	<input name="parentMenu"  id="parentMenu" type="hidden" />
    	<input name="menuOrder"  id="menuOrder" type="hidden" />
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
            <tr>
                <td align="right" class="l-table-edit-td">菜单编号:</td>
                <td align="left" class="l-table-edit-td" style="width:160px"><input name="menuCode" type="text" id="menuCode" ltype="text" validate="{required:true,minlength:2,maxlength:10}" /></td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            
            <tr>
            <td align="right" class="l-table-edit-td">菜单名称:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="text" type="text" id="text" ltype="text" validate="{required:true,minlength:3,maxlength:10}" /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            <tr>
            <td align="right" class="l-table-edit-td">URL:</td>
            <td align="left" class="l-table-edit-td" style="width:160px"><input name="url" type="text" id="url" ltype="text"  /></td>
            <td align="left"></td>
            <td align="left"></td>
            </tr>
            <tr>
            <td align="right" class="l-table-edit-td">分配给用户:<input type="hidden" name="toUserIds" id="toUserIds"/></td>
            <td align="left" class="l-table-edit-td" style="width:180px" >
            	<div id="listbox1" ></div>
            </td>
            <td align="center">
            	<div style="margin:1px;float:center;" class="middle">
				         <input type="button" style="display: block;width:30px; margin:2px;" onclick="moveToLeft()" value="<" />
				          <input type="button" style="display: block;width:30px; margin:2px;" onclick="moveToRight()" value=">" />
				          <input type="button" style="display: block;width:30px; margin:2px;" onclick="moveAllToLeft()" value="<<" />
				         <input type="button" style="display: block;width:30px; margin:2px;" onclick="moveAllToRight()" value=">>" />
				</div>
			</td>
            <td align="right">
	            <div style="margin:4px;float:left;">
					<div id="listbox2"></div> 
				</div>
			</td>
            </tr>
        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
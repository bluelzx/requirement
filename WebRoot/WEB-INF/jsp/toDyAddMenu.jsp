<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%@ include file="include.meta.jsp"%>
    <script type="text/javascript">
    	
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
        	//父节点	
        	var parentNode = t1.getParent(actionNode.treedataindex);
        	var menuCode = actionNode.menuCode;
            var newnode = $.extend(true, {}, actionNode);   
            newnode.menuName = '测试添加';
            newnode.text = '测试添加';
            t1.append(parentNode, [newnode],actionNode.treedataindex,false); 
            //if (actionNode){
            //	$.ligerDialog.open({ title :'添加菜单信息',height: 350,width :580, url: '<%=path%>/toAddMenuWin.do', isResize: true,allowClose :true });	
            //}
        }
        
        function addSubMenu()
        {	
        	//父节点	
            var newnode = $.extend(true, {}, actionNode);   
            newnode.menuName = '测试添加子';
            newnode.text = '测试添加子菜单';
            newnode.treedataindex= t1.nodes.length+1;
            t1.append(actionNode.treedataindex, [newnode]); 
            //if (actionNode){
            //	$.ligerDialog.open({ title :'添加菜单信息',height: 350,width :580, url: '<%=path%>/toAddMenuWin.do', isResize: true,allowClose :true });	
            //}
        }
        function addMenuUp()
        {	
        	//父节点	
        	var parentNode = t1.getParent(actionNode.treedataindex);
        	var menuCode = actionNode.menuCode;
            var newnode = $.extend(true, {}, actionNode);   
            newnode.menuName = '测试添加上方';
            newnode.text = '测试添加上方';
            newnode.treedataindex= t1.nodes.length+1;
            t1.append(parentNode, [newnode],actionNode.treedataindex,false); 
            //if (actionNode){
            //	$.ligerDialog.open({ title :'添加菜单信息',height: 350,width :580, url: '<%=path%>/toAddMenuWin.do', isResize: true,allowClose :true });	
            //}
        }
        function addMenuDown()
        {	
        	//父节点	
        	var parentNode = t1.getParent(actionNode.treedataindex);
        	var menuCode = actionNode.menuCode;
            var newnode = $.extend(true, {}, actionNode);   
            newnode.menuName = '测试添加下方';
            newnode.text = '测试添加下方';
            newnode.treedataindex= t1.nodes.length+1;
            t1.append(parentNode, [newnode],actionNode.treedataindex,true); 
            //if (actionNode){
            //	$.ligerDialog.open({ title :'添加菜单信息',height: 350,width :580, url: '<%=path%>/toAddMenuWin.do', isResize: true,allowClose :true });	
            //}
        }
        
        function addMenu(){
        	if (actionNode){
        		
        	}
        }
        
        function addParentMenu(){
        	//父节点
        	//todo 这里还有问题?!!!!!!!!fuck	
        	treenode = t1.getNodeDom(actionNode);
            var parentTreeNode = t1.getParentTreeItem(treenode);
            if (!parentTreeNode) return null;
            var parentIndex = $(parentTreeNode).attr("treedataindex");
        	var parentNode = getParentDataIndex(t1.data,parentIndex);
        	var mynodes = t1.nodes;
        	
        	var menuCode = actionNode.menuCode;
            var newnode = $.extend(true, {}, actionNode);   
            newnode.menuName = '测试添加父节点';
            newnode.text = '测试添加父节点';
            modifyDataIndex(mynodes.length,newnode);
            t1.append(parentNode, [newnode]);
            //removeAllNode([actionNode]); 
            t1.remove(actionNode);
            var addnode = $.extend(true, {}, actionNode);
            modifyDataIndex(mynodes.length,addnode);
            //addnode.treedataindex= mynodes.length; 
            t1.append(newnode.treedataindex, [addnode]); 
            
        }
        
        function removeAllNode(removeNode){
        var mmnode = null;
        	for(var i=0;i<removeNode.length;i++){
        	mmnode =  $.extend(true, {}, removeNode[i]);
	        	t1.remove(removeNode[i]);
	        	if(mmnode.children)
	        		removeAllNode(mmnode.children);
        		}
        }
        
        function modifyDataIndex(treedataindex,addnode){
        		if(addnode['__status']!='delete')
        			addnode.treedataindex= treedataindex;
	        	if(addnode.children){
	        		treedataindex = treedataindex+1;
	        		modifyDataIndex(treedataindex,addnode.children);
	        	} 
        }
        
        function  getParentDataIndex(data, treedataindex)
        {
            var dataTemp = null;
            for (var i = 0; i < data.length; i++)
            {   dataTemp = data[i];
                if (dataTemp.treedataindex == treedataindex && dataTemp['__status']!='delete')
                    return dataTemp;
                if (dataTemp.children)
                {
                    var targetData = getParentDataIndex(dataTemp.children, treedataindex);
                    if (targetData) return targetData;
                }
            }
            return null;
        }
        
        function mytest(){
        	userMenus = "";
        	    var tdatas = t2.data;
                genUserMenus(tdatas,'0');
                $("#userMenus").val(userMenus);
        	alert($("#userMenus").val());
        }
        var eee;
        $(function () {
        	
        	var menu1 = $.ligerMenu({ width: 120, items:
            [
                { text: '新增父菜单', click: addParentMenu, icon: 'plus' }, 
                { text: '新增子菜单', click: addSubMenu, icon: 'plus' }, 
                { text: '新增前菜单', click: addMenuUp, icon: 'plus' }, 
                { text: '新增后菜单', click: addMenuDown, icon: 'plus' }, 
                { text: '分配用户', click: deleteItem, icon: 'customers' }
            ]
            });
        	var menu2 = $.ligerMenu({ width: 120, items:
            [
                { text: '新增子菜单', click: addSubMenu, icon: 'plus' }, 
                { text: '新增前菜单', click: addMenuUp, icon: 'plus' }, 
                { text: '新增后菜单', click: addMenuDown, icon: 'plus' }, 
                { text: '分配用户', click: deleteItem, icon: 'customers' }
            ]
            });
        	
        	window['t1'] =
            $("#tree1").ligerTree({
                nodeDraggable: true,
                url: '<%=path%>/getAllMenuForUser.do',
                idFieldName :'menuCode',
             	parentIDFieldName :'parentMenu',
             	onContextmenu: function (node, e)
                {
                    actionNode = node.data;
                    if(actionNode.parentMenu == 0){
                    	menu2.show({ top: e.pageY, left: e.pageX });
                    }else{
                    	menu1.show({ top: e.pageY, left: e.pageX });
                    }
                    
                    return false;
                }
            });


            

            
        	
            
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

    <form name="form2" method="post" action="<%=path%>/saveSysUser.do"   id="form1">
    	<input name="userMenus" id="userMenus" type="hidden"/>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" >
        	<tr><td align="left" class="l-table-edit-td">菜单管理:</td></tr>
            <tr>
                <td align="left" class="l-table-edit-td" style="width:180px">
               		<div style="width: 300px; height: 400px; margin-left: 0px; margin-right: 1px; float: left;border: 1px solid #ccc; overflow: auto;">
               			<ul id="tree1"></ul>
               		</div>
                </td>
            </tr>
        </table>
 <br />
<input type="submit" value="提交" id="Button1" class="l-button l-button-submit" />
<input type="button" value="mytest" id="Button1" onclick="mytest()" />
    </form>
    <div style="display:none">
    <!--  数据统计代码 --></div>

    
</body>
</html>
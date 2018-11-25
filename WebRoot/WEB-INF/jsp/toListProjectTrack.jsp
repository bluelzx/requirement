<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="include.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="include.meta.1.3.jsp"%>
    <script type="text/javascript">
        var mygrid = null;
        
        
        
         function toDownLoad(){
        	 window.location.href="<%=path%>/downLoadProjectTrack.do?startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val();
        }
        
       function f_search()
        {
        	mygrid.options.url='<%=path%>/listProjectTrack.do';
            mygrid.options.parms=$("#searchForm").serializeArray();
            mygrid.loadData();
        }
        
        $(function () {
        
        	$("#startDate").ligerDateEditor({ showTime: false,format: "yyyyMMdd",  labelWidth: 100, labelAlign: 'left' });
            $("#endDate").ligerDateEditor({ showTime: false, format: "yyyyMMdd", labelWidth: 100, labelAlign: 'left' });
        
            mygrid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '项目名称', name: 'projectName',id:'id1', align: 'left', width: 200 },
                { display: '紧急程度', name: 'urgent',align: 'center', width: 100 ,render: function (rowdata, rowindex, value){
                					if(value==1)
                						return "1-一般";
                					if(value==2)
                						return "2-优先";
                					if(value==3)
                						return "3-紧急(连续性)";
                					if(value==4)
                						return "4-紧急";
                			}  },
                { display: '责任人', name: 'owner', width: 100,align:'center' },
                { display: '需求类型', name: 'rtype', align: 'center', width: 150 },
                { display: '评估工时', name: 'planmanhaur',align: 'center', width: 100 },
                { display: '领取日期', name: 'createDate', width: 100,align:'center' },
                { display: '计划完成日期', name: 'planfinishDate',align: 'center', width: 100 },
                { display: '需求部门', name: 'rdept', width: 100,align:'center' },
                { display: '需求提出者', name: 'presenter', width: 100,align:'center' },
                { display: '项目状态', name: 'projectStatus', width: 300,align:'center',render: function (rowdata, rowindex, value){
                					return "开发"+rowdata.pig+",测试"+rowdata.pts+",验收"+rowdata.pcf+",已完成"+rowdata.cntall;
                			}  },
                { display: '是否关闭', name: 'isClosed', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					if(value=="Y")
                						return "是";
                					if(value=="N")
                						return "否";
                } },
                { display: '是否逾期', name: 'isOverDate', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					if(value=="Y")
                						return "是";
                					if(value=="N")
                						return "否";
                }  },
                { display: '是否新增', name: 'isAdded', width: 100,align:'center',render: function (rowdata, rowindex, value){
                					if(value=="Y")
                						return "是";
                					if(value=="N")
                						return "否";
                }  }
                ],pageSize:<%=Constants.LIST_PAGE_SIZE%>,pageSizeOptions:[20,30,50,100],rownumbers:true,enabledSort:false,
                url: '<%=path%>/listProjectTrack.do',
                root: 'rows',
                record: 'total',
                dataAction: 'server', //服务器排序
                usePager: true,       //服务器分页
                width: '99%',height:'99%',
                toolbar: { items: [
                { text: '下载', click: toDownLoad, icon: 'down' }
                ]
                }
            });
			

            $("#pageloading").hide();
            
        });
        
       
    </script>
    <style type="text/css">
           body{ font-size:12px;}
        .l-table-edit {}
        .l-table-edit-td{ padding:4px;}
        .l-button-submit,.l-button-test{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
        .l-verify-tip{ left:230px; top:120px;}
        #errorLabelContainer{ padding:10px; width:300px; border:1px solid #FF4466; display:none; background:#FFEEEE; color:Red;}
    </style>
</head>
<body style="padding:6px; overflow:hidden;">
<form id="searchForm" name="" action="" method="post">
<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="right" class="l-table-edit-td">
						开始日期:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="startDate" type="text" id="startDate" ltype="text" value="<c:out value="${startDate}"/>" />  
					</td>

					<td align="right" class="l-table-edit-td">
						结束日期:
					</td>
					<td align="left" class="l-table-edit-td" style="width:160px">
						<input name="endDate" type="text" id="endDate" ltype="text" value="<c:out value="${endDate}"/>" />
					</td>

					<td align="right" class="l-table-edit-td"></td>
					<td align="left" class="l-table-edit-td " style="width:160px">
						<input id="btnOK" type="button" class="l-button"
							style="width:100px" value="查询" onclick="f_search()" />
					</td>

				</tr>
			</table>
		</form>
<b/>
    <div id="maingrid4" style="margin:0; padding:0"></div>
   

  <div style="display:none;">
  <!-- g data total ttt -->
</div>
 
</body>
</html>


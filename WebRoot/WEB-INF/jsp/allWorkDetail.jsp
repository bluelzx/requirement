<!DOCTYPE html>
<%@ include file="include.jsp"%>
<%@ page pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>我的首页</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%@ include file="include.meta.jsp"%>
	</head>
	<body>
		<div style="margin: 0px; padding: 0px; width: 99%;" id="maingrid4"
			class="l-panel l-frozen" ligeruiid="maingrid4">
			<div class="l-panel-header" style="display: none;">
				<span class="l-panel-header-text"></span>
			</div>
			<div class="l-grid-loading" style="display: none;">
				加载中...
			</div>
			<div class="l-clear"></div>
			<div class="l-panel-bwarp">
				<div class="l-panel-body">
					<div class="l-grid" id="maingrid4grid" style="height: 723.37px;">
						<div class="l-grid-dragging-line"></div>
						<div class="l-grid2" style="width: 100%; ">
							<div class="l-grid-header l-grid-header2" style="height: 23px;">
								<div class="l-grid-header-inner" style="width: 100%;">
									<table cellspacing="0" cellpadding="0"
										class="l-grid-header-table">
										<tbody>
											<tr class="l-grid-hd-row">
							<td class="l-grid-hd-cell" id="maingrid4|hcell|id1" style="height: 23px; width: 130px;" columnindex="1" ><div class="l-grid-hd-cell-inner" style="width: 130px;"><span class="l-grid-hd-cell-text">用户名称</span></div></td>
							<td class="l-grid-hd-cell" id="maingrid4|hcell|c104" style="height: 23px; width: 100px;" columnindex="2" ><div class="l-grid-hd-cell-inner" style="width: 100px;"><span class="l-grid-hd-cell-text">正常工时</span></div></td>
							<td class="l-grid-hd-cell" id="maingrid4|hcell|c105" style="height: 23px; width: 100px;" columnindex="3" ><div class="l-grid-hd-cell-inner" style="width: 100px;"><span class="l-grid-hd-cell-text">加班工时</span></div></td>
							<td class="l-grid-hd-cell" id="maingrid4|hcell|c106" style="height: 23px; width: 200px;" columnindex="4" ><div class="l-grid-hd-cell-inner" style="width: 200px;"><span class="l-grid-hd-cell-text">需求名称</span></div></td>
							<td class="l-grid-hd-cell" id="maingrid4|hcell|c107" style="height: 23px; width: 200px;" columnindex="5" ><div class="l-grid-hd-cell-inner" style="width: 200px;"><span class="l-grid-hd-cell-text">任务名称</span></div></td>
							<td class="l-grid-hd-cell" id="maingrid4|hcell|c108" style="height: 23px; width: 200px;" columnindex="6" ><div class="l-grid-hd-cell-inner" style="width: 200px;"><span class="l-grid-hd-cell-text">备注</span></div></td>
							<td class="l-grid-hd-cell l-grid-hd-cell-last" id="maingrid4|hcell|c109" style="height: 23px; width: 250px;" columnindex="7" ><div class="l-grid-hd-cell-inner" style="width: 250px;"><span class="l-grid-hd-cell-text">累计投入</span></div></td>
							</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="l-grid-body l-grid-body2 l-scroll"
								style="height: 701.37px;">
								<div class="l-grid-body-inner" style="width: 100%;">
									<table cellspacing="0" cellpadding="0"
										class="l-grid-body-table">
										<tbody>
											<%List<WorkRecordDetail> reusltDetails = (List<WorkRecordDetail>)request.getAttribute("reusltDetails"); %>
										<% for(WorkRecordDetail detail :reusltDetails){ %>
											<% if(detail.getDisType()==2){ %>
													<tr class="l-grid-row <% if(detail.getManhour()==0&&detail.getOthour()==0){ %>l-selected<% }else{ %>l-grid-row-alt<% } %>" >
													<td style="width:130px;  " class="l-grid-row-cell " ><div style="width:124px;height:22px;min-height:22px; text-align:center;color: red; font-size: 1.2em;font-weight:bold;" class="l-grid-row-cell-inner" ><%=detail.getUserName() %></div></td>
													<td style="width:100px;  " class="l-grid-row-cell " ><div style="width:94px;height:22px;min-height:22px; text-align:center;color: red; font-size: 1.2em;font-weight:bold;" class="l-grid-row-cell-inner"><%=detail.getManhour() %></div></td>
													<td style="width:100px;  " class="l-grid-row-cell " ><div style="width:94px;height:22px;min-height:22px; text-align:center;color: red; font-size: 1.2em;font-weight:bold;" class="l-grid-row-cell-inner"><%=detail.getOthour()%></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"></div></td>
													<td style="width:250px;  " class="l-grid-row-cell l-grid-row-cell-last" ><div style="width:244px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"></div></td>
													</tr>
												<% }else{ %>
													<tr class="l-grid-row " >
													<td style="width:130px;  " class="l-grid-row-cell " ><div style="width:124px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"><%=detail.getUserName() %></div></td>
													<td style="width:100px;  " class="l-grid-row-cell " ><div style="width:94px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"><%=detail.getManhour() %></div></td>
													<td style="width:100px;  " class="l-grid-row-cell " ><div style="width:94px;height:22px;min-height:22px; text-align:center;" class="l-grid-row-cell-inner"><%=detail.getOthour()%></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:left;" class="l-grid-row-cell-inner" title="<%=detail.getRequirementName() %>"><%=detail.getRequirementName()==null?"":detail.getRequirementName() %></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:left;" class="l-grid-row-cell-inner" title="<%=detail.getTaskName() %>"><%=detail.getTaskName()==null?"":detail.getTaskName() %></div></td>
													<td style="width:200px;  " class="l-grid-row-cell " ><div style="width:194px;height:22px;min-height:22px; text-align:left;" class="l-grid-row-cell-inner" title="<%=detail.getRemark()==null?"":detail.getRemark() %>"><%=detail.getRemark()==null?"":detail.getRemark() %></div></td>
													<td style="width:250px;  " class="l-grid-row-cell l-grid-row-cell-last" ><div style="width:242px;height:22px;min-height:22px; text-align:right;" class="l-grid-row-cell-inner">正常工时:<span style="font-weight:bold;"><%=detail.getSumMan() %></span>,加班工时:<span style="font-weight:bold;"><%=detail.getSumOt() %></span></div></td>
													</tr>
												<% }%>
										<% } %>
											
											
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>

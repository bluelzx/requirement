package com.lanzx.rmmsys.view;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.ManhaurList;
import com.lanzx.rmmsys.entity.ManhaurListSum;
import com.lanzx.rmmsys.entity.ProjectTrack;
import com.lanzx.rmmsys.service.ManhaurListService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class ManhaurListController extends BaseController{
	
	private ManhaurListService manhaurListService;

	@RequestMapping(value="toListManhaurList")
	public String toListManhaurList(HttpServletRequest req){
		return "toListManhaurList";
	}
	
	@RequestMapping(value="listManhaurList")
	@ResponseBody
	public ListVO listManhaurList(HttpServletRequest req){
		ListVO vo = new ListVO();
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		vo.setRows(manhaurListService.getManhaurList(likeCondition));
		vo.setTotal(manhaurListService.getTotalManhaurList());
		return vo;
	}
	@RequestMapping(value="toListProjectTrack")
	public String toListProjectTrack(HttpServletRequest req){
		String startDate = DateUtil.getLastFireDate();
		String endDate = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		req.setAttribute("startDate", startDate);
		req.setAttribute("endDate", endDate);
		return "toListProjectTrack";
	}
	
	@RequestMapping(value="listProjectTrack")
	@ResponseBody
	public ListVO listProjectTrack(HttpServletRequest req){
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		ListVO vo = new ListVO();
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isBlank(startDate)){
			startDate = DateUtil.getLastFireDate();
		}
		if(StringUtils.isBlank(endDate)){
			endDate = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		}
		likeCondition.put("startDate", startDate);
		likeCondition.put("endDate", endDate);
		vo.setRows(manhaurListService.getProjectTrackList(likeCondition));
		vo.setTotal(manhaurListService.getTotalProjectTrack(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="toListManhaurListSum")
	public String toListManhaurListSum(HttpServletRequest req){
		return "toListManhaurListSum";
	}
	
	@RequestMapping(value="listManhaurListSum")
	@ResponseBody
	public ListVO listManhaurListSum(HttpServletRequest req){
		ListVO vo = new ListVO();
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		vo.setRows(manhaurListService.getManhaurListSum(likeCondition));
		vo.setTotal(manhaurListService.getTotalManhaurListSum());
		return vo;
	}
	
	@RequestMapping(value="downLoadManhaurList")
	public void downLoadManhaurList(HttpServletRequest req,HttpServletResponse response){
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		List<ManhaurList> lists = manhaurListService.getManhaurList(likeCondition);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		//设置默认列宽
		sheet.setDefaultColumnWidth(50);
		
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		
		HSSFRow row1 = sheet.createRow(0);
		
		HSSFCell newCell1 = row1.createCell(0);
		newCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell1.setCellValue("类型");
		newCell1.setCellStyle(style);
		
		HSSFCell newCell2 = row1.createCell(1);
		newCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell2.setCellValue("人员");
		newCell2.setCellStyle(style);
		
		HSSFCell newCell3 = row1.createCell(2);
		newCell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell3.setCellValue("需求编号");
		newCell3.setCellStyle(style);
		
		HSSFCell newCell4 = row1.createCell(3);
		newCell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell4.setCellValue("需求描述");
		newCell4.setCellStyle(style);
		
		HSSFCell newCell5 = row1.createCell(4);
		newCell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell5.setCellValue("任务描述");
		newCell5.setCellStyle(style);
		
		HSSFCell newCell6 = row1.createCell(5);
		newCell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell6.setCellValue("工时(已确认)");
		newCell6.setCellStyle(style);
		
		HSSFCell newCell7 = row1.createCell(6);
		newCell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell7.setCellValue("工时(待确认)");
		newCell7.setCellStyle(style);
		
		HSSFCell newCell8 = row1.createCell(7);
		newCell8.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell8.setCellValue("工时(合计)");
		newCell8.setCellStyle(style);
		
		HSSFCell newCell9 = row1.createCell(8);
		newCell9.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell9.setCellValue("完成日期");
		newCell9.setCellStyle(style);
		
		for(int i=0,totalSize=lists.size();i<totalSize;i++){
			ManhaurList item = lists.get(i);
			
			HSSFRow row2 = sheet.createRow(i+1);
			HSSFCell hcell1 = row2.createCell(0);
			hcell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell1.setCellValue(item.getMtype());
			hcell1.setCellStyle(style);
			
			HSSFCell hcell2 = row2.createCell(1);
			hcell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell2.setCellValue(item.getPersonName());
			hcell2.setCellStyle(style);
			
			HSSFCell hcell3 = row2.createCell(2);
			hcell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell3.setCellValue(item.getRequirementCode());
			hcell3.setCellStyle(style);
			
			HSSFCell hcell4 = row2.createCell(3);
			hcell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell4.setCellValue(item.getRequirementName());
			hcell4.setCellStyle(style);
			
			HSSFCell hcell5 = row2.createCell(4);
			hcell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell5.setCellValue(item.getTaskName());
			hcell5.setCellStyle(style);
			
			HSSFCell hcell6 = row2.createCell(5);
			hcell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell6.setCellValue(item.getDoneTime());
			hcell6.setCellStyle(style);
			
			HSSFCell hcell7 = row2.createCell(6);
			hcell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell7.setCellValue(item.getTodoTime());
			hcell7.setCellStyle(style);
			
			HSSFCell hcell8 = row2.createCell(7);
			hcell8.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell8.setCellValue(item.getSumTime());
			hcell8.setCellStyle(style);
			
			HSSFCell hcell9 = row2.createCell(8);
			hcell9.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell9.setCellValue(item.getEndTime());
			hcell9.setCellStyle(style);
		}
		
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition", "attachment; filename=\""+SystemUtil.getName("数据应用中心-人员工时明细.xls")+"\"");
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log(req,"导出人员工时明细");
	}
	@RequestMapping(value="downLoadProjectTrack")
	public void downLoadProjectTrack(HttpServletRequest req,HttpServletResponse response){
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		if(StringUtils.isBlank(startDate)){
			startDate = DateUtil.getLastFireDate();
		}
		if(StringUtils.isBlank(endDate)){
			endDate = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		}
		likeCondition.put("startDate", startDate);
		likeCondition.put("endDate", endDate);
		List<ProjectTrack> lists = manhaurListService.getProjectTrackList(likeCondition);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		//设置默认列宽
		sheet.setDefaultColumnWidth(50);
		sheet.autoSizeColumn(9, true);
		sheet.autoSizeColumn(10, true);
		sheet.autoSizeColumn(11, true);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		
		HSSFRow row1 = sheet.createRow(0);
		
		HSSFCell newCell1 = row1.createCell(0);
		newCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell1.setCellValue("项目名称");
		newCell1.setCellStyle(style);
		
		HSSFCell newCell2 = row1.createCell(1);
		newCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell2.setCellValue("紧急程度");
		newCell2.setCellStyle(style);
		
		HSSFCell newCell3 = row1.createCell(2);
		newCell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell3.setCellValue("责任人");
		newCell3.setCellStyle(style);
		
		HSSFCell newCell4 = row1.createCell(3);
		newCell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell4.setCellValue("需求类型");
		newCell4.setCellStyle(style);
		
		HSSFCell newCell5 = row1.createCell(4);
		newCell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell5.setCellValue("评估工时");
		newCell5.setCellStyle(style);
		
		HSSFCell newCell6 = row1.createCell(5);
		newCell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell6.setCellValue("领取日期");
		newCell6.setCellStyle(style);
		
		HSSFCell newCell7 = row1.createCell(6);
		newCell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell7.setCellValue("计划完成日期");
		newCell7.setCellStyle(style);
		
		HSSFCell newCell8 = row1.createCell(7);
		newCell8.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell8.setCellValue("需求部门");
		newCell8.setCellStyle(style);
		
		HSSFCell newCell9 = row1.createCell(8);
		newCell9.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell9.setCellValue("需求提出者");
		newCell9.setCellStyle(style);
		
		HSSFCell newCell10 = row1.createCell(9);
		newCell10.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell10.setCellValue("项目状态");
		newCell10.setCellStyle(style);
		
		HSSFCell newCell11 = row1.createCell(10);
		newCell11.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell11.setCellValue("是否关闭");
		newCell11.setCellStyle(style);
		
		HSSFCell newCell12 = row1.createCell(11);
		newCell12.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell12.setCellValue("是否逾期");
		newCell12.setCellStyle(style);
		
		HSSFCell newCell13 = row1.createCell(12);
		newCell13.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell13.setCellValue("是否新增");
		newCell13.setCellStyle(style);
		
		for(int i=0,totalSize=lists.size();i<totalSize;i++){
			ProjectTrack item = lists.get(i);
			
			HSSFRow row2 = sheet.createRow(i+1);
			HSSFCell hcell1 = row2.createCell(0);
			hcell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell1.setCellValue(item.getProjectName());
			hcell1.setCellStyle(style);
			
			HSSFCell hcell2 = row2.createCell(1);
			hcell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			String tempurgnt = item.getUrgent();
			if("1".equals(tempurgnt)){
				hcell2.setCellValue("1-一般");
			}else if("2".equals(tempurgnt)){
				hcell2.setCellValue("2-优先");
			}else if("3".equals(tempurgnt)){
				hcell2.setCellValue("3-紧急(连续性)");
			}else {
				hcell2.setCellValue("4-紧急");
			}
			hcell2.setCellStyle(style);
			
			HSSFCell hcell3 = row2.createCell(2);
			hcell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell3.setCellValue(item.getOwner());
			hcell3.setCellStyle(style);
			
			HSSFCell hcell4 = row2.createCell(3);
			hcell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell4.setCellValue(item.getRtype());
			hcell4.setCellStyle(style);
			
			HSSFCell hcell5 = row2.createCell(4);
			hcell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell5.setCellValue(item.getPlanmanhaur());
			hcell5.setCellStyle(style);
			
			HSSFCell hcell6 = row2.createCell(5);
			hcell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell6.setCellValue(item.getCreateDate());
			hcell6.setCellStyle(style);
			
			HSSFCell hcell7 = row2.createCell(6);
			hcell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell7.setCellValue(item.getPlanfinishDate());
			hcell7.setCellStyle(style);
			
			HSSFCell hcell8 = row2.createCell(7);
			hcell8.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell8.setCellValue(item.getRDept());
			hcell8.setCellStyle(style);
			
			HSSFCell hcell9 = row2.createCell(8);
			hcell9.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell9.setCellValue(item.getPresenter());
			hcell9.setCellStyle(style);
			
			HSSFCell hcell10 = row2.createCell(9);
			hcell10.setCellType(HSSFCell.CELL_TYPE_STRING);
			String projectStatus = "开发"+item.getPig()+",测试"+item.getPts()+",验收"+item.getPcf()+",已完成"+item.getCntall();
			hcell10.setCellValue(projectStatus);
			hcell10.setCellStyle(style);
			
			HSSFCell hcell11 = row2.createCell(10);
			hcell11.setCellType(HSSFCell.CELL_TYPE_STRING);
			if("Y".equals(item.getIsClosed())){
				hcell11.setCellValue("是");
			}else{
				hcell11.setCellValue("否");
			}
			hcell11.setCellStyle(style);
			
			HSSFCell hcell12 = row2.createCell(11);
			hcell12.setCellType(HSSFCell.CELL_TYPE_STRING);
			if("Y".equals(item.getIsOverDate())){
				hcell12.setCellValue("是");
			}else{
				hcell12.setCellValue("否");
			}
			hcell12.setCellStyle(style);
			
			HSSFCell hcell13 = row2.createCell(12);
			hcell13.setCellType(HSSFCell.CELL_TYPE_STRING);
			if("Y".equals(item.getIsAdded())){
				hcell13.setCellValue("是");
			}else{
				hcell13.setCellValue("否");
			}
			hcell13.setCellStyle(style);
		}
		
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition", "attachment; filename=\""+SystemUtil.getName("数据应用中心项目跟踪表("+startDate+"-"+endDate+").xls")+"\"");
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log(req,"数据应用中心项目跟踪表("+startDate+"-"+endDate+")");
	}
	
	@RequestMapping(value="downLoadManhaurListSum")
	public void downLoadManhaurListSum(HttpServletRequest req,HttpServletResponse response){
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		List<ManhaurListSum> lists = manhaurListService.getManhaurListSum(likeCondition);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		//设置默认列宽
		sheet.setDefaultColumnWidth(50);
		
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		
		HSSFRow row1 = sheet.createRow(0);
		
		HSSFCell newCell1 = row1.createCell(0);
		newCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell1.setCellValue("人员");
		newCell1.setCellStyle(style);
		
		HSSFCell newCell2 = row1.createCell(1);
		newCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell2.setCellValue("类型");
		newCell2.setCellStyle(style);
		
		HSSFCell newCell3 = row1.createCell(2);
		newCell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell3.setCellValue("工时(已确认)");
		newCell3.setCellStyle(style);
		
		HSSFCell newCell4 = row1.createCell(3);
		newCell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell4.setCellValue("工时(待确认)");
		newCell4.setCellStyle(style);
		
		HSSFCell newCell5 = row1.createCell(4);
		newCell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell5.setCellValue("工时(合计)");
		newCell5.setCellStyle(style);
		
		HSSFCell newCell6 = row1.createCell(5);
		newCell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell6.setCellValue("任务数(合计)");
		newCell6.setCellStyle(style);
		
		HSSFCell newCell7 = row1.createCell(6);
		newCell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell7.setCellValue("任务数(已确认)");
		newCell7.setCellStyle(style);
		
		for(int i=0,totalSize=lists.size();i<totalSize;i++){
			ManhaurListSum item = lists.get(i);
			
			HSSFRow row2 = sheet.createRow(i+1);
			HSSFCell hcell1 = row2.createCell(0);
			hcell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell1.setCellValue(item.getPersonName());
			hcell1.setCellStyle(style);
			
			HSSFCell hcell2 = row2.createCell(1);
			hcell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell2.setCellValue(item.getMtype());
			hcell2.setCellStyle(style);
			
			HSSFCell hcell3 = row2.createCell(2);
			hcell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell3.setCellValue(item.getDoneTime());
			hcell3.setCellStyle(style);
			
			HSSFCell hcell4 = row2.createCell(3);
			hcell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell4.setCellValue(item.getTodoTime());
			hcell4.setCellStyle(style);
			
			HSSFCell hcell5 = row2.createCell(4);
			hcell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell5.setCellValue(item.getSumTime());
			hcell5.setCellStyle(style);
			
			HSSFCell hcell6 = row2.createCell(5);
			hcell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell6.setCellValue(item.getSumTask());
			hcell6.setCellStyle(style);
			
			HSSFCell hcell7 = row2.createCell(6);
			hcell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell7.setCellValue(item.getDoneTask());
			hcell7.setCellStyle(style);
			
		}
		
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition", "attachment; filename=\""+SystemUtil.getName("数据应用中心-人员工时汇总.xls")+"\"");
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log(req,"导出人员工时汇总");
	}
	
	public ManhaurListService getManhaurListService() {
		return manhaurListService;
	}

	public void setManhaurListService(ManhaurListService manhaurListService) {
		this.manhaurListService = manhaurListService;
	}
}

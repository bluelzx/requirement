package com.lanzx.rmmsys.view;

import java.io.File;
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
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.UploadFile;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.FileService;
import com.lanzx.rmmsys.service.SysRequirementService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class RequirementController extends BaseController {

	private SysRequirementService requirementService;
	
	private FileService fileService;
	
	
	/**
	 * 需求树列表
	 * @param req
	 * @return
	 */
	@RequestMapping(value="toRequirementTree")
	public String toRequirementTree(HttpServletRequest req){
		return "requirementTree";
	}
	
	@RequestMapping(value="toListToAssignReq")
	public String toListToAssignRequirement(HttpServletRequest req){
		return "toListToAssignReq";
	}
	
	@RequestMapping(value="listToAssignRequirement")
	@ResponseBody
	public ListVO listToAssignRequirement(HttpServletRequest req){
		String owner = req.getParameter("owner");
		Map<String,Object> likeCondition = getListCondition(req, owner);
		ListVO vo = new ListVO();
		vo.setRows(requirementService.getToAssignRequirement(likeCondition));
		vo.setTotal(requirementService.getTotalToAssignRequirement(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="toListLaunchRequirement")
	public String toListLaunchRequirement(HttpServletRequest req){
		return "toListLaunchReq";
	}
	
	@RequestMapping(value="listLaunchRequirement")
	@ResponseBody
	public ListVO listLaunchRequirement(HttpServletRequest req){
		String owner = req.getParameter("owner");
		Map<String,Object> likeCondition = getListCondition(req, owner);
		ListVO vo = new ListVO();
		vo.setRows(requirementService.getAllLaunchRequirement(likeCondition));
		vo.setTotal(requirementService.getTotalLaunchRequirement(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="listMyRequirement")
	@ResponseBody
	public ListVO listMyRequirement(HttpServletRequest req){
		String owner = SystemUtil.getLoginUser(req).getUserCode();
		return listRequirement(req,owner);
	}
	
	@RequestMapping(value="toListMyRequirement")
	public String toListMyRequirement(HttpServletRequest req){
		return "toListMyRequirement";
	}
	
	@RequestMapping(value="closeByRequirementId")
	@ResponseBody
	public String closeByRequirementId(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		String firstCloseTime = req.getParameter("firstCloseTime");
		if(StringUtils.isBlank(requirementId)){
			return "false";
		}else{
			String confirmCloseTime = DateUtil.getCurrentDate(Constants.DATA_FORMATE_1);
			String confirmCloser = SystemUtil.getLoginUser(req).getUserCode();
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("requirementId", requirementId);
			likeCondition.put("confirmCloseTime", confirmCloseTime);
			likeCondition.put("confirmCloser", confirmCloser);
			if(firstCloseTime!=null)
			likeCondition.put("firstCloseTime", firstCloseTime);
			requirementService.closeByRequirementId(likeCondition);
		}
		log(req, requirementId, "", null, "关闭需求");
		return "true";
	}
	
	@RequestMapping(value="getAllRequirementTree")
	@ResponseBody
	public List<Requirement> getAllRequirement(HttpServletRequest req){
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 0);
		likeCondition.put("endRow", 1000000);
		return requirementService.getAllRequirement(likeCondition);
	}
	
	@RequestMapping(value="downLoadRequirements")
	public void downLoadRequirements(HttpServletRequest req,HttpServletResponse response){
		String owner = req.getParameter("owner");
		Map<String,Object> likeCondition = getListCondition(req, owner);
		int startRow = 1;
		int endRow = Integer.MAX_VALUE;
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		List<Requirement> requirements = requirementService.getAllRequirement(likeCondition);
		
		Map<String,Object> likeCondition1 = new HashMap<String, Object>();
		likeCondition1.put("startRow", 1);
		likeCondition1.put("endRow", Integer.MAX_VALUE);
		likeCondition1.put("paraType", 2);
		List<Parameter> paras = paraService.getParas(likeCondition1);
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		
		HSSFSheet sheet = wb.createSheet();
		sheet.autoSizeColumn(1, true);
		HSSFRow hRow = sheet.createRow(0);
		HSSFCell newCell1 = hRow.createCell(0);
		newCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell1.setCellValue("需求编号");
		
		HSSFCell newCell2 = hRow.createCell(1);
		newCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell2.setCellValue("需求名称");
		
		HSSFCell newCell21 = hRow.createCell(2);
		newCell21.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell21.setCellValue("需求类型");
		
		HSSFCell newCell10 = hRow.createCell(3);
		newCell10.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell10.setCellValue("需求部门");
		
		HSSFCell newCell11 = hRow.createCell(4);
		newCell11.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell11.setCellValue("需求提出者");
		
		HSSFCell newCell3 = hRow.createCell(5);
		newCell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell3.setCellValue("需求状态");
		
		HSSFCell newCell6 = hRow.createCell(6);
		newCell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell6.setCellValue("录入者");
		
		HSSFCell newCell5 = hRow.createCell(7);
		newCell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell5.setCellValue("录入时间");
		
		HSSFCell newCell4 = hRow.createCell(8);
		newCell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell4.setCellValue("责任人");
		
		HSSFCell newCell7 = hRow.createCell(9);
		newCell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell7.setCellValue("预计开始时间");
		
		HSSFCell newCell8 = hRow.createCell(10);
		newCell8.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell8.setCellValue("预计结束时间");
		
		HSSFCell newCell9 = hRow.createCell(11);
		newCell9.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell9.setCellValue("实际完成时间");
		
		HSSFCell newCell12 = hRow.createCell(12);
		newCell12.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell12.setCellValue("备注");
		
		HSSFCell newCell13 = hRow.createCell(13);
		newCell13.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell13.setCellValue("重要程度");
		
		for(int i=0;i<requirements.size();i++){
			
			Requirement rm = requirements.get(i);
			
			HSSFRow r = sheet.createRow(i+1);
			HSSFCell newrCell1 = r.createCell(0);
			newrCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell1.setCellValue(rm.getRequirementCode());
			
			HSSFCell newrCell2 = r.createCell(1);
			newrCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell2.setCellValue(rm.getRequirementName());
			
			HSSFCell newrCell21 = r.createCell(2);
			newrCell21.setCellType(HSSFCell.CELL_TYPE_STRING);
			String rType = "空";
			for(Parameter pa:paras){
				if(Integer.parseInt(pa.getParaCode())==(rm.getRequirementType())){
					rType = pa.getParaValue();
					break;
				}
			}
			newrCell21.setCellValue(rType);
			
			HSSFCell newrCell3 = r.createCell(3);
			newrCell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell3.setCellValue(rm.getDept());
			
			HSSFCell newrCell4 = r.createCell(4);
			newrCell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell4.setCellValue(rm.getPresenter());
			
			
			
			HSSFCell newrCell11 = r.createCell(5);
			newrCell11.setCellType(HSSFCell.CELL_TYPE_STRING);
			String rStatus = "未开始";
			if(2==rm.getStatus()){
				rStatus = "进行中";
			}else if(3==rm.getStatus()){
				rStatus = "完成";
			}else if(4==rm.getStatus()){
				rStatus = "关闭";
			}
			newrCell11.setCellValue(rStatus);
			
			HSSFCell newrCell6 = r.createCell(6);
			newrCell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell6.setCellValue(rm.getCreator());
			
			HSSFCell newrCell5 = r.createCell(7);
			newrCell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell5.setCellValue(rm.getCreateTime());
			
			HSSFCell newrCell7 = r.createCell(8);
			newrCell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell7.setCellValue(rm.getOwner());
			
			HSSFCell newrCell8 = r.createCell(9);
			newrCell8.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell8.setCellValue(rm.getStartDate());
			
			HSSFCell newrCell9 = r.createCell(10);
			newrCell9.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell9.setCellValue(rm.getEndDate());
			
			HSSFCell newrCell10 = r.createCell(11);
			newrCell10.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell10.setCellValue(rm.getCloseTime());
			
			HSSFCell newrCell12 = r.createCell(12);
			newrCell12.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell12.setCellValue(rm.getRemark());
			
			HSSFCell newrCell13 = r.createCell(13);
			newrCell13.setCellType(HSSFCell.CELL_TYPE_STRING);
			newrCell13.setCellValue(rm.getUrgent()==1?"普通":"重要");
		}
		
		sheet.autoSizeColumn(0, true);
		sheet.autoSizeColumn(1, true);
		sheet.autoSizeColumn(2, true);
		sheet.autoSizeColumn(3, true);
		sheet.autoSizeColumn(4, true);
		sheet.autoSizeColumn(5, true);
		sheet.autoSizeColumn(6, true);
		sheet.autoSizeColumn(7, true);
		sheet.autoSizeColumn(8, true);
		sheet.autoSizeColumn(9, true);
		sheet.autoSizeColumn(10, true);
		sheet.autoSizeColumn(11, true);
		sheet.autoSizeColumn(12, true);
		
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition", "attachment; filename=\""+SystemUtil.getName("需求列表.xls")+"\"");
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log(req,"下载需求");
	}
	
	@RequestMapping(value="disableByRCode")
	@ResponseBody
	public String disableByCode(HttpServletRequest req){
		String requirementId  = req.getParameter("requirementId");
		requirementService.disableByCode(requirementId);
		log(req, requirementId, "", "","删除需求成功!");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="toAddRequirement")
	public String toAddRequirement(HttpServletRequest req){
		//无项目需求号时，生成默认T需求号
		String requirementCode = "T-"+DateUtil.getCurrentDate(Constants.DATA_FORMATE_3)+"-";
		requirementCode = requirementCode+requirementService.getNextTempRequirementCode(requirementCode);
		req.setAttribute("requirementCode", requirementCode);
		return "toAddRequirement";
	}
	
	@RequestMapping(value="toViewRequirement")
	public String toViewRequirement(HttpServletRequest req){
		String requirementId  = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			Requirement requirement = requirementService.getRequirementByCode(requirementId);
			req.setAttribute("requirement", requirement);
			return "toViewRequirement";
		}
		return null;
	}
	
	@RequestMapping(value="toModifyRequirement")
	public String toModifyRequirement(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			Requirement requirement = requirementService.getRequirementByCode(requirementId);
			req.setAttribute("requirement", requirement);
			return "toModifyRequirement";
		}
		return null;
	}
	
	@RequestMapping(value="doModifyRequirement")
	public String doModifyRequirement(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		String requirementName = req.getParameter("requirementName");
		String remark = req.getParameter("remark");
		String important = req.getParameter("important");
		String urgent = req.getParameter("urgent");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String dept = req.getParameter("dept");
		String presenter = req.getParameter("presenter");
		String parentCode = req.getParameter("parentCode");
		String requirementType = req.getParameter("requirementType");
		String owner = req.getParameter("owner");
		String watcher = req.getParameter("watcher");
		String planManHaur = req.getParameter("planManHaur");
		String projectCode = req.getParameter("projectCode");
		String businessType = req.getParameter("businessType");
//		parentCode = StringUtils.isBlank(parentCode)?"0":parentCode;
		User user =  SystemUtil.getLoginUser(req);
		String creator = user==null?"admin":user.getUserCode();
		
		Requirement rm = new Requirement();
		rm.setRequirementId(requirementId);
		rm.setRequirementCode(requirementCode);
		rm.setRequirementName(requirementName);
		rm.setRemark(remark);
		rm.setCreator(creator);
		rm.setStartDate(startDate);
		rm.setEndDate(endDate);
		rm.setDept(dept);
		rm.setPresenter(presenter);
		rm.setParentCode(parentCode);
		if(StringUtils.isNotBlank(requirementType)){
			rm.setRequirementType(Integer.parseInt(requirementType));
		}
		if(StringUtils.isNotBlank(important)){
			rm.setImportant(Integer.parseInt(important));
		}
		if(StringUtils.isNotBlank(urgent)){
			rm.setUrgent(Integer.parseInt(urgent));
		}
		if(StringUtils.isNotBlank(planManHaur)){
			rm.setPlanManHaur(Double.parseDouble(planManHaur));
		}
		if(StringUtils.isNotBlank(businessType)){
			rm.setBusinessType(Integer.parseInt(businessType));
		}
		if(StringUtils.isNotBlank(watcher)){
			rm.setWatcher(watcher);
		}
		rm.setOwner(owner);
		rm.setProjectCode(projectCode);
		requirementService.updateRequirement(rm);
		
		
		log(req, requirementId, "修改需求");
		
		return "redirect:toListAllRequirement.do";
	}
	
	@RequestMapping(value="saveRequirement")
	public String saveRequirement(HttpServletRequest req){
		String requirementId = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
		String requirementCode = req.getParameter("requirementCode");
		String requirementName = req.getParameter("requirementName");
		String remark = req.getParameter("remark");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String dept = req.getParameter("dept");
		String presenter = req.getParameter("presenter");
		String parentCode = req.getParameter("parentCode");
		String owner = req.getParameter("owner");
		String watcher = req.getParameter("watcher");
		String requirementType = req.getParameter("requirementType");
		String planManHaur = req.getParameter("planManHaur");
		String projectCode = req.getParameter("projectCode");
//		parentCode = StringUtils.isBlank(parentCode)?"0":parentCode;
		User user =  SystemUtil.getLoginUser(req);
		String creator = user==null?"admin":user.getUserCode();
		String important = req.getParameter("important");
		String urgent = req.getParameter("urgent");
		String businessType = req.getParameter("businessType");
		
		Requirement rm = new Requirement();
		rm.setRequirementId(requirementId);
		rm.setRequirementCode(requirementCode);
		rm.setRequirementName(requirementName);
		rm.setRemark(remark);
		rm.setCreator(creator);
		rm.setStartDate(startDate);
		rm.setEndDate(endDate);
		rm.setDept(dept);
		rm.setPresenter(presenter);
		rm.setParentCode(parentCode);
		rm.setStatus(Constants.REQUIREMENT_STATUS_BEGIN);
		rm.setOwner(owner);
		rm.setProjectCode(projectCode);
		if(StringUtils.isNotBlank(requirementType)){
			rm.setRequirementType(Integer.parseInt(requirementType));
		}
		if(StringUtils.isNotBlank(important)){
			rm.setImportant(Integer.parseInt(important));
		}
		if(StringUtils.isNotBlank(urgent)){
			rm.setUrgent(Integer.parseInt(urgent));
		}
		if(StringUtils.isNotBlank(businessType)){
			rm.setBusinessType(Integer.parseInt(businessType));
		}
		if(StringUtils.isNotBlank(planManHaur)){
			rm.setPlanManHaur(Double.parseDouble(planManHaur));
		}
		if(StringUtils.isNotBlank(watcher)){
			rm.setWatcher(watcher);
		}
		requirementService.insertRequirement(rm);
		
		//把临时上传文件复制到当前需求的文件夹下
		String uploadFiles =  req.getParameter("allFiles");
		String basePath = SystemUtil.getFileSavePath(req);
		if(StringUtils.isNotBlank(uploadFiles)){
			for(String fileCode:uploadFiles.split(",")){
				UploadFile uFile = fileService.getFileByCode(fileCode);
				File fileFrom = new File(uFile.getFilePath());
				File fileTo = new File(basePath+requirementCode+"/"+uFile.getFileName());
				File fileDic = new File(basePath+requirementCode+"/");
				if(!fileDic.exists()){
					fileDic.mkdirs();
				}
				fileFrom.renameTo(fileTo);
				uFile.setRequirementId(requirementCode);
				uFile.setFilePath(basePath+requirementCode+"/"+uFile.getFileName());
				fileService.updateTmpFile(uFile);
			}
		}
		
		log(req, requirementId, "新增需求");
		
		return "redirect:toListAllRequirement.do";
	}
	
	@RequestMapping(value="toListAllRequirement")
	public String toListAllRequirement(HttpServletRequest req){
//		List<Parameter> importantParas = getParas(Constants.PARA_TYPE_3);
//		req.setAttribute("importantParas", importantParas);
//		List<Parameter> urgentParas = getParas(Constants.PARA_TYPE_4);
//		req.setAttribute("urgentParas", urgentParas);
		return "toListAllRequirement";
	}
	
	@RequestMapping(value="getSelectRequirements")
	@ResponseBody
	public List<Requirement> getSelectRequirements(HttpServletRequest req){
		String key = req.getParameter("key");
		return requirementService.getSelectRequirements(key);
	}
	
	@RequestMapping(value="getUnCloseSelectRequirements")
	@ResponseBody
	public List<Requirement> getUnCloseSelectRequirements(HttpServletRequest req){
		String key = req.getParameter("key");
		return requirementService.getUnCloseSelectRequirements(key);
	}
	
	private Map<String,Object> getListCondition(HttpServletRequest req,String owner){
		String requirementName = req.getParameter("requirementName");
		String requirementCode = req.getParameter("requirementCode");
		String status = req.getParameter("status");
		String requirementType = req.getParameter("requirementType");
		String important = req.getParameter("important");
		String urgent = req.getParameter("urgent");
		String businessType = req.getParameter("businessType");
		String projectCode = req.getParameter("projectCode");
		String dept = req.getParameter("dept");
		String presenter = req.getParameter("presenter");
		
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(req.getParameter("page"))){
			Integer pageNum = Integer.parseInt(req.getParameter("page"));
			Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
			int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
			int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
			likeCondition.put("startRow", startRow);
			likeCondition.put("endRow", endRow);
		}
		if(StringUtils.isNotBlank(requirementName)){
			likeCondition.put("requirementName", requirementName);
		}
		if(StringUtils.isNotBlank(owner)){
			likeCondition.put("owner", owner);
		}
		if(StringUtils.isNotBlank(projectCode)){
			likeCondition.put("projectCode", projectCode);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(status)){
			likeCondition.put("status", Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(requirementType)){
			likeCondition.put("requirementType", Integer.parseInt(requirementType));
		}
		if(StringUtils.isNotBlank(important)){
			likeCondition.put("important", Integer.parseInt(important));
		}
		if(StringUtils.isNotBlank(urgent)){
			likeCondition.put("urgent", Integer.parseInt(urgent));
		}
		if(StringUtils.isNotBlank(businessType)){
			likeCondition.put("businessType", Integer.parseInt(businessType));
		}
		if(StringUtils.isNotBlank(dept)){
			likeCondition.put("dept", dept);
		}
		if(StringUtils.isNotBlank(presenter)){
			likeCondition.put("presenter", presenter);
		}
		
		return likeCondition;
	}
	
	private ListVO listRequirement(HttpServletRequest req,String owner){
		Map<String,Object> likeCondition = getListCondition(req, owner);
		ListVO vo = new ListVO();
		vo.setRows(requirementService.getAllRequirement(likeCondition));
		vo.setTotal(requirementService.getTotalRequirement(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="listAllRequirement")
	@ResponseBody
	public ListVO listAllRequirement(HttpServletRequest req){
		String owner = req.getParameter("owner");
		return listRequirement(req,owner);
	}

	@RequestMapping(value="checkRequirementCode")
	@ResponseBody
	public String checkRequirementCode(HttpServletRequest req){
		String rCode = req.getParameter("requirementCode");
		Requirement rem = requirementService.getRequirementByRequirementCode(rCode);
		if(rem!=null){
			return "true";
		}else{
			return "false";
		}
	}
	
	public SysRequirementService getRequirementService() {
		return requirementService;
	}

	public void setRequirementService(SysRequirementService requirementService) {
		this.requirementService = requirementService;
	}

	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	
	
}

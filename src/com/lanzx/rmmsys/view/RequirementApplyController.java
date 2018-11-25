package com.lanzx.rmmsys.view;

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.RApplyTaskRelation;
import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.RequirementTestApply;
import com.lanzx.rmmsys.service.RequirementApplyService;
import com.lanzx.rmmsys.service.SysRequirementService;
import com.lanzx.rmmsys.service.SysUserService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class RequirementApplyController extends BaseController {
	
	private RequirementApplyService applyService;
	
	private SysRequirementService requirementService;
	
	private SysUserService userService;

	public RequirementApplyService getApplyService() {
		return applyService;
	}

	public void setApplyService(RequirementApplyService applyService) {
		this.applyService = applyService;
	}
	
	@RequestMapping(value="toListRequirementApply")
	public String toListRequirementApply(HttpServletRequest req){
		return "toListRequirementApply";
	}
	
	@RequestMapping(value="downApplyAsWord")
	public String downApplyAsWord(HttpServletRequest req, HttpServletResponse response) throws Exception{
		String applyCode = req.getParameter("applyCode");
		RequirementTestApply apply = applyService.getApplyByCode(applyCode);
		String devPrincipalName = userService.getUserByUserCode(apply.getDevPrincipal()).getUserName();
		String applyTime = apply.getApplyTime();
		String filename = new String("项目送测清单".getBytes("GB2312"),"ISO-8859-1")+"_"+apply.getApplyCode()+"_"+ new String(devPrincipalName.getBytes("GB2312"),"ISO-8859-1")+"_"+applyTime+".doc";
	 	response.reset();
	 	response.setContentType("application/vnd.ms-word");
	 	response.setHeader("content-disposition", "attachment;filename="+filename);
	 	PrintWriter writer = response.getWriter();
	 	
	 	String templatePath = req.getSession().getServletContext().getRealPath("/")+""+File.separator+"templates";
	 	VelocityEngine ve = new VelocityEngine();
		Properties pp = new Properties();
		pp.put(ve.FILE_RESOURCE_LOADER_PATH, templatePath);
		ve.init(pp);
		Template t = ve.getTemplate("apply.vm", "GBK");
		VelocityContext vc = new VelocityContext();
		vc.put("applyCode", encode2HtmlUnicode(apply.getApplyCode()));
		vc.put("applyVersion", encode2HtmlUnicode(apply.getApplyVersion()));
		vc.put("applyName", converStr(apply.getApplyName()));
		vc.put("devPrincipal", encode2HtmlUnicode(devPrincipalName));
		String reportSelf = apply.getReportSelf();
		if("1".equals(reportSelf)){
			vc.put("reportSelf1", encode2HtmlUnicode("√"));
			vc.put("reportSelf2", " ");
		}else{
			vc.put("reportSelf1", " ");
			vc.put("reportSelf2", encode2HtmlUnicode(" √ "));
		}
		vc.put("applyTime1", encode2HtmlUnicode(applyTime.substring(0, 4)));
		vc.put("applyTime2", encode2HtmlUnicode(applyTime.substring(4, 6)));
		vc.put("applyTime3", encode2HtmlUnicode(applyTime.substring(6, 8)));
		vc.put("applyDept", encode2HtmlUnicode(apply.getApplyDept()));
		String applyFinishTime = apply.getApplyFinishTime();
		if(StringUtils.isNotBlank(applyFinishTime)){
			vc.put("applyFinishTime1", "        ");
			vc.put("applyFinishTime2", encode2HtmlUnicode(" √ "));
			vc.put("applyFinishTime3", applyFinishTime.substring(0, 4));
			vc.put("applyFinishTime4", applyFinishTime.substring(4, 6));
			vc.put("applyFinishTime5", applyFinishTime.substring(6, 8));
		}else{
			vc.put("applyFinishTime1", encode2HtmlUnicode(" √ "));
			vc.put("applyFinishTime2", "");
			vc.put("applyFinishTime3", "");
			vc.put("applyFinishTime4", "");
			vc.put("applyFinishTime5", "");
		}
		vc.put("howToTest", converStr(apply.getHowToTest()));
		vc.put("info", converStr(apply.getInfo()));
		StringWriter sw = new StringWriter();
		t.merge(vc, sw);
	 	writer.write(sw.toString());
	 	writer.flush();
	 	writer.close();
		return null;
	}
	
	/**
	 * 换行
	 * @param myStr
	 * @return
	 */
	public String converStr(String myStr){
		if(StringUtils.isNotBlank(myStr)){
		String[] applyNames =  myStr.split("\n");
		StringBuffer applyName = new StringBuffer();
		int applyLength = applyNames.length;
		for(int i=0;i<applyLength;i++ ){
			if(StringUtils.isNotBlank(applyNames[i]) ){
				if( i!=(applyLength-1)){
					applyName.append("<p class=3DMsoNormal>").append(encode2HtmlUnicode(applyNames[i])).append("</p>");
				}else{
					applyName.append(encode2HtmlUnicode(applyNames[i]));
				}
			}
		}
		
		return applyName.toString();
		}else{
			return "";
		}
	}
	
	/**
	 * 中文转换成界面显示
	 * @param myStr
	 * @return
	 */
	public  String encode2HtmlUnicode(String myStr){
		StringBuilder sb = new StringBuilder();
		if(StringUtils.isNotBlank(myStr)){
			for(char myChar:myStr.toCharArray()){
				if(myChar>255){
					sb.append("&#"+(myChar & 0xffff)+";");
				}else{
					sb.append(myChar);
				}
			}
		}
		return sb.toString();
	}
	
	@RequestMapping(value="listAllRequirementApply")
	@ResponseBody
	public ListVO listAllRequirementApply(HttpServletRequest req){
		String requirementCode = req.getParameter("requirementCode");
		String requirementName = req.getParameter("requirementName");
		String applyDept = req.getParameter("applyDept");
		String conner = req.getParameter("conner");
		String status = req.getParameter("status");
		Map<String,Object> likeCondition =  new HashMap<String,Object>();
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(requirementName)){
			likeCondition.put("requirementName", requirementName);
		}
		if(StringUtils.isNotBlank(applyDept)){
			likeCondition.put("applyDept", applyDept);
		}
		if(StringUtils.isNotBlank(conner)){
			likeCondition.put("conner", conner);
		}
		if(StringUtils.isNotBlank(status)){
			likeCondition.put("status", status);
		}
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		ListVO vo = new ListVO();
		vo.setRows(applyService.getAllRequirementApply(likeCondition));
		vo.setTotal(applyService.getTotalRequirementApply(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="toAddRequirementApply")
	public String toAddRequirementApply(HttpServletRequest req){
		
		String requirementId  = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			Requirement requirement = requirementService.getRequirementByCode(requirementId);
//			String applyCode = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3)+requirement.getOwner();
			String applyCode = requirement.getRequirementCode();
			String nextNum = applyService.getNextApplyCode(applyCode);
			if(nextNum==null){
				nextNum = "01";
			}
			applyCode = applyCode+nextNum;
			req.setAttribute("applyCode", applyCode);
			req.setAttribute("requirementId", requirementId);
			req.setAttribute("requirementCode", requirement.getRequirementCode());
			req.setAttribute("requirementName", requirement.getRequirementName());
			req.setAttribute("devPrincipal", requirement.getOwner());
			String userName = userService.getUserByUserCode(requirement.getOwner()).getUserName();
			req.setAttribute("devPrincipalName",userName);
			req.setAttribute("applyDept", requirement.getDept());
			req.setAttribute("conner", requirement.getPresenter());
			req.setAttribute("applyVersion", DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
			req.setAttribute("applyName", requirement.getRequirementCode()+","+requirement.getRequirementName());
		}
		
		return "toAddRequirementApply";
	}
	
	@RequestMapping(value="finishApply")
	@ResponseBody
	public String finishApply(HttpServletRequest req){
		String applyCode = req.getParameter("applyCode");
		int status = 2;//已完成送测
		
		RequirementTestApply apply = new RequirementTestApply();
		apply.setApplyCode(applyCode);
		apply.setStatus(status);
		apply.setApplyTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
		applyService.updateApplyStatus(apply);
		
		apply = applyService.getApplyByCode(applyCode);
		log(req, apply.getRequirementId(), "", "", "需求送测");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="doOnLine")
	@ResponseBody
	public String doOnLine(HttpServletRequest req){
		String applyCode = req.getParameter("applyCode");
		int status = 3;//申请上线
		
		RequirementTestApply apply = new RequirementTestApply();
		apply.setApplyCode(applyCode);
		apply.setStatus(status);
		applyService.updateApplyStatus(apply);
		
		apply = applyService.getApplyByCode(applyCode);
		log(req, apply.getRequirementId(), "", "", "需求申请上线");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="doFinishOnLine")
	@ResponseBody
	public String doFinishOnLine(HttpServletRequest req){
		String applyCode = req.getParameter("applyCode");
		int status = 4;//上线完成
		String onLineDate = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		RequirementTestApply apply = new RequirementTestApply();
		apply.setApplyCode(applyCode);
		apply.setStatus(status);
		apply.setOnLineDate(onLineDate);
		applyService.updateApplyOnLineDate(apply);
		
		apply = applyService.getApplyByCode(applyCode);
		log(req, apply.getRequirementId(), "", "", "需求上线完成");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="doAddApplyFromRequirement")
	@ResponseBody
	public String doAddFromRequirement(HttpServletRequest req){
		saveApply(req);
		return "true";
	}
	
	private void saveApply(HttpServletRequest req){
		String applyCode = req.getParameter("applyCode");
		String requirementId = req.getParameter("requirementId");
		String devPrincipal = req.getParameter("devPrincipal");
		String applyDept = req.getParameter("applyDept");
		String conner = req.getParameter("conner");
		String applyVersion = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		String applyName = req.getParameter("applyName");
		String reportSelf = req.getParameter("reportSelf");
		String applyTime = req.getParameter("applyTime");
		if(StringUtils.isBlank(applyTime)){
//			applyTime = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
			applyTime = "";
		}
		String applyFinishTime = req.getParameter("applyFinishTime");
		String howToTest = req.getParameter("howToTest");
		String info = req.getParameter("info");
		
		RequirementTestApply apply = new RequirementTestApply();
		apply.setApplyCode(applyCode);
		apply.setApplyDept(applyDept);
		apply.setApplyFinishTime(applyFinishTime);
		apply.setApplyName(applyName);
		apply.setApplyVersion(applyVersion);
		apply.setApplyTime(applyTime);
		apply.setConner(conner);
		apply.setDevPrincipal(devPrincipal);
		apply.setInfo(info);
		apply.setHowToTest(howToTest);
		apply.setReportSelf(reportSelf);
		apply.setRequirementId(requirementId);
		apply.setApplyVersion(applyVersion);
		apply.setStatus(1);//待送测
		apply.setCreateTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
		apply.setCreator(SystemUtil.getLoginUser(req).getUserCode());
		
		applyService.insertRequirementApply(apply);
		
		String taskCode = req.getParameter("taskCode");
		if(StringUtils.isNotBlank(taskCode)){
			String[] taskCodes = taskCode.split(",");
			for(String code :taskCodes){
				if(StringUtils.isNotBlank(code)){
					RApplyTaskRelation relation = new RApplyTaskRelation();
					relation.setApplyCode(applyCode);
					relation.setTaskCode(code);
					applyService.insertRApplyTaskRelation(relation);
				}
			}
		}
		
		log(req, apply.getRequirementId(), "", "", "需求申请送测");
		
//		Requirement requirement = new Requirement();
//		requirement.setRequirementId(requirementId);
//		requirement.setStatus(Constants.REQUIREMENT_STATUS_TESTED);
//		requirementService.updateRequirementStatus(requirement);
	}

	public SysRequirementService getRequirementService() {
		return requirementService;
	}

	public void setRequirementService(SysRequirementService requirementService) {
		this.requirementService = requirementService;
	}

	public SysUserService getUserService() {
		return userService;
	}

	public void setUserService(SysUserService userService) {
		this.userService = userService;
	}
	

}

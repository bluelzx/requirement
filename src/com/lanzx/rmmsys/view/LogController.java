package com.lanzx.rmmsys.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Log;
import com.lanzx.rmmsys.service.LogService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.LogMonitor;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class LogController {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	private LogService logService;

	public LogService getLogService() {
		return logService;
	}

	public void setLogService(LogService logService) {
		this.logService = logService;
	}
	
	@RequestMapping(value="toAddRemark")
	public String toAddRemark(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		String taskCode = req.getParameter("taskCode");
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		if(StringUtils.isNotBlank(requirementId)){
			likeCondition.put("requirementId", requirementId);
			req.setAttribute("requirementId", requirementId);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
			req.setAttribute("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(taskCode)){
			likeCondition.put("taskCode", taskCode);
			req.setAttribute("taskCode", taskCode);
		}
		List<Log> logs = logService.getLog(likeCondition);
		req.setAttribute("logs", logs);
		return "toAddRemark";
	}
	
	@RequestMapping(value="doAddRemark")
	@ResponseBody
	public Log doAddRemark(HttpServletRequest req){
		
		String requirementId = req.getParameter("requirementId");
		String taskCode = req.getParameter("taskCode");
		String remark = req.getParameter("remark");
		
		Log log = new Log();
		if(StringUtils.isNotBlank(requirementId)){
			log.setRequirementId(requirementId);
		}
		if(StringUtils.isNotBlank(taskCode)){
			log.setTaskCode(taskCode);
		}
		log.setLogCode(DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14));
		log.setLogTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		log.setLogCreator(userCode);
		log.setLogText(remark);
		LogMonitor.getInstance().receive(log);
		
		return log;
	}
	
	@RequestMapping(value="toListLog")
	public String toListLog(HttpServletRequest req){
		return "toListLog";
	}
	
	@RequestMapping(value="listAllLog")
	@ResponseBody
	public ListVO listAllLog(HttpServletRequest req){
		String logCreator = req.getParameter("userCode");
		String requirementCode = req.getParameter("requirementCode");
		String requirementId = req.getParameter("requirementId");
		String taskCode = req.getParameter("taskCode");
		String logText = req.getParameter("logText");
		String logTime = req.getParameter("logTime");
		
		ListVO vo = new ListVO();
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(logCreator)){
			likeCondition.put("logCreator", logCreator);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(requirementId)){
			likeCondition.put("requirementId", requirementId);
		}
		likeCondition.put("logText", logText);
		if(StringUtils.isNotBlank(taskCode)){
			likeCondition.put("taskCode", taskCode);
		}
		likeCondition.put("logTime", logTime);
		vo.setRows(logService.getLog(likeCondition));
		vo.setTotal(logService.getTotalLog(likeCondition));
		return vo;
	}
}

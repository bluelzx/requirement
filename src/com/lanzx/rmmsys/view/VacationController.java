package com.lanzx.rmmsys.view;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Vacation;
import com.lanzx.rmmsys.service.VactionService;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class VacationController extends BaseController {

	private VactionService vacationService;

	public VactionService getVacationService() {
		return vacationService;
	}

	public void setVacationService(VactionService vacationService) {
		this.vacationService = vacationService;
	}
	
	@RequestMapping(value="toAddVacation")
	public String toAddVacation(HttpServletRequest req){
		return "toAddVacation";
	}
	
	@RequestMapping(value="saveVacation")
	public String saveVacation(HttpServletRequest req){
		String startTime = req.getParameter("startTime");
		String endTime = req.getParameter("endTime");
		String startTimeD = req.getParameter("startTimeD");
		String endTimeD = req.getParameter("endTimeD");
		String proposer = req.getParameter("proposer");
		String remark = req.getParameter("remark");
		String creator = SystemUtil.getLoginUser(req).getUserCode();
		Vacation vacation = new Vacation();
		vacation.setStartTime(startTime+startTimeD);
		vacation.setEndTime(endTime+endTimeD);
		vacation.setProposer(proposer);
		vacation.setCreator(creator);
		vacation.setRemark(remark);
		vacationService.insertVacation(vacation);
		return "redirect:toListVacation.do";
	}
	
	@RequestMapping(value="toListVacation")
	public String toListVacation(HttpServletRequest req){
		return "toListVacation";
	}
	
	@RequestMapping(value="doListVacation")
	@ResponseBody
	public ListVO doListVacation(HttpServletRequest req){
		String startTime = req.getParameter("startTime");
		String endTime = req.getParameter("endTime");
		String proposer = req.getParameter("proposer");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(startTime)){
			likeCondition.put("startTime", startTime);
		}
		if(StringUtils.isNotBlank(endTime)){
			likeCondition.put("endTime", endTime);
		}
		if(StringUtils.isNotBlank(proposer)){
			likeCondition.put("proposer", proposer);
		}
		ListVO vo = new ListVO();
		vo.setRows(vacationService.getAllVacation(likeCondition));
		vo.setTotal(vacationService.getTotalVacation(likeCondition));
		return vo;
	}
}

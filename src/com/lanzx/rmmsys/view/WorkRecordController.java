package com.lanzx.rmmsys.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.WorkRecordDetail;
import com.lanzx.rmmsys.entity.WorkRecordToTal;
import com.lanzx.rmmsys.service.WorkRecordService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;

@Controller
public class WorkRecordController extends BaseController{

	private WorkRecordService workRecordService;
	
	@RequestMapping(value="getAllWorkRecordToTal")
	@ResponseBody
	public ListVO getAllWorkRecordToTal(HttpServletRequest req){
		int startRow = 0;
		int endRow = Integer.MAX_VALUE;
		String workDate = DateUtil.getCurrentDateBefore(Constants.DATA_FORMATE_3);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		likeCondition.put("workDate", workDate);
		ListVO vo = new ListVO();
		vo.setRows(workRecordService.getAllWorkRecordToTal(likeCondition));
		vo.setTotal(workRecordService.getWorkRecordToTalCount(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="getWorkRecordDetail")
	@ResponseBody
	public ListVO getWorkRecordDetail(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		int startRow = 0;
		int endRow = Integer.MAX_VALUE;
		String workDate = DateUtil.getCurrentDateBefore(Constants.DATA_FORMATE_3);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		likeCondition.put("workDate", workDate);
		likeCondition.put("userCode", userCode);
		ListVO vo = new ListVO();
		vo.setRows(workRecordService.getWorkRecordDetail(likeCondition));
		vo.setTotal(workRecordService.getWorkRecordDetailCount(likeCondition));
		return vo;
	}

	public WorkRecordService getWorkRecordService() {
		return workRecordService;
	}

	public void setWorkRecordService(WorkRecordService workRecordService) {
		this.workRecordService = workRecordService;
	}
}

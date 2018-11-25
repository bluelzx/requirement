package com.lanzx.rmmsys.view;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.lanzx.rmmsys.entity.Log;
import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.service.SysParaService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.LogMonitor;
import com.lanzx.rmmsys.utils.SystemUtil;

public class BaseController {

	protected SysParaService paraService;

	public SysParaService getParaService() {
		return paraService;
	}

	public void setParaService(SysParaService paraService) {
		this.paraService = paraService;
	} 
	
	
	public List<Parameter> getParas(String paraType){
		List<Parameter> paras = new ArrayList<Parameter>();
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		if(StringUtils.isNotBlank(paraType))
			likeCondition.put("paraType", paraType);
		paras = paraService.getParas(likeCondition);
		return paras;
	}
	
	public String getJsonString(Object obj){
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void log(HttpServletRequest req,String requirementId,String taskCode,String userCode,String text){
		Log log = new Log();
		log.setRequirementId(requirementId);
		log.setTaskCode(taskCode);
		log.setLogCode(DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14));
		log.setLogTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
		if(StringUtils.isBlank(userCode)){
			userCode = SystemUtil.getLoginUser(req).getUserCode();
		}
		log.setLogCreator(userCode);
		log.setLogText(text);
		LogMonitor.getInstance().receive(log);
	}
	
	public void log(HttpServletRequest req,String text){
		log(req, "", "", "", text);
	}
	
	public void log(HttpServletRequest req,String requirementId,String text){
		log(req, requirementId, "", "", text);
	}
	
}

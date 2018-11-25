package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Parameter;

public interface SysParaService {

public List<Parameter> getParas(Map<String, Object> likeCondition);
	
	public int getTotalPara(Map<String, Object> likeCondition);
	
	public void insertPara(Parameter para);
	
	public void updatePara(Parameter para);
	
	public void deletePara(Parameter para);
	
	public Parameter getParaByTypeAndCode(Parameter para);
}

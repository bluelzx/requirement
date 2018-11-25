package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Parameter;


@Mapper("paraDao")
public interface   SysParaDao {

	public List<Parameter> getParas(Map<String, Object> likeCondition);
	
	public int getTotalPara(Map<String, Object> likeCondition);
	
	public void insertPara(Parameter para);
	
	public void updatePara(Parameter para);
	
	public void deletePara(Parameter para);
	
	public Parameter getParaByTypeAndCode(Parameter para);
}

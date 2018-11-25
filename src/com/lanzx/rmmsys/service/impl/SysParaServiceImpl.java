package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.SysParaDao;
import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.service.SysParaService;

public class SysParaServiceImpl implements SysParaService {

	private SysParaDao paraDao;
	
	public List<Parameter> getParas(Map<String, Object> likeCondition) {
		return paraDao.getParas(likeCondition);
	}

	public int getTotalPara(Map<String, Object> likeCondition) {
		return paraDao.getTotalPara(likeCondition);
	}

	public void insertPara(Parameter para) {
		paraDao.insertPara(para);
	}

	public SysParaDao getParaDao() {
		return paraDao;
	}

	public void setParaDao(SysParaDao paraDao) {
		this.paraDao = paraDao;
	}

	public void deletePara(Parameter para) {
		paraDao.deletePara(para);
	}

	public void updatePara(Parameter para) {
		paraDao.updatePara(para);
	}

	public Parameter getParaByTypeAndCode(Parameter para) {
		return paraDao.getParaByTypeAndCode(para);
	}

}

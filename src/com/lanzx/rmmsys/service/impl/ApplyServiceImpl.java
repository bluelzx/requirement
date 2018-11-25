package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.RApplyTaskDao;
import com.lanzx.rmmsys.dao.RequirementApplyDao;
import com.lanzx.rmmsys.entity.RApplyTaskRelation;
import com.lanzx.rmmsys.entity.RequirementTestApply;
import com.lanzx.rmmsys.service.RequirementApplyService;

public class ApplyServiceImpl implements RequirementApplyService {

	private RequirementApplyDao requirementApplyDao;
	
	private RApplyTaskDao applyTaskDao;
	
	public List<RequirementTestApply> getAllRequirementApply(Map<String, Object> likeCondition) {
		return requirementApplyDao.getAllRequirementApply(likeCondition);
	}

	public String getNextApplyCode(String applyCode) {
		return requirementApplyDao.getNextApplyCode(applyCode);
	}

	public int getTotalRequirementApply(Map<String, Object> likeCondition) {
		return requirementApplyDao.getTotalRequirementApply(likeCondition);
	}

	public void insertRequirementApply(RequirementTestApply requirementApply) {
		requirementApplyDao.insertRequirementApply(requirementApply);
	}

	public RequirementApplyDao getRequirementApplyDao() {
		return requirementApplyDao;
	}

	public void setRequirementApplyDao(RequirementApplyDao requirementApplyDao) {
		this.requirementApplyDao = requirementApplyDao;
	}

	public RequirementTestApply getApplyByCode(String applyCode) {
		return requirementApplyDao.getApplyByCode(applyCode);
	}

	public void insertRApplyTaskRelation(RApplyTaskRelation rApplyTaskRelation) {
		applyTaskDao.insertRApplyTaskRelation(rApplyTaskRelation);
	}

	public RApplyTaskDao getApplyTaskDao() {
		return applyTaskDao;
	}

	public void setApplyTaskDao(RApplyTaskDao applyTaskDao) {
		this.applyTaskDao = applyTaskDao;
	}

	public void updateApplyStatus(RequirementTestApply requirementApply) {
		requirementApplyDao.updateApplyStatus(requirementApply);
	}

	public void updateApplyOnLineDate(RequirementTestApply requirementApply) {
		requirementApplyDao.updateApplyOnLineDate(requirementApply);
	}

}

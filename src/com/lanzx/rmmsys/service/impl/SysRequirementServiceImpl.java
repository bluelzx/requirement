package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.lanzx.rmmsys.dao.SysRequirementDao;
import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.RequirementCount;
import com.lanzx.rmmsys.service.SysRequirementService;

public class SysRequirementServiceImpl implements SysRequirementService{

	private SysRequirementDao requirementDao;
	
	public SysRequirementDao getRequirementDao() {
		return requirementDao;
	}

	public void setRequirementDao(SysRequirementDao requirementDao) {
		this.requirementDao = requirementDao;
	}

	public List<Requirement> getAllRequirement(Map<String,Object> likeCondition) {
		return requirementDao.getAllRequirement(likeCondition);
	}

	public int getTotalRequirement(Map<String, Object> likeCondition) {
		return requirementDao.getTotalRequirement(likeCondition);
	}

	public void insertRequirement(Requirement requirement) {
		requirementDao.insertRequirement(requirement);
	}

	public void disableByCode(String requirementId) {
		requirementDao.disableByCode(requirementId);
		requirementDao.disableTaskByCode(requirementId);
	}

	public void updateRequirement(Requirement requirement) {
		requirementDao.updateRequirement(requirement);	
	}

	public Requirement getRequirementByCode(String requirementCode) {
		return requirementDao.getRequirementByCode(requirementCode);
	}

	public List<Requirement> getSelectRequirements(String requirementCode) {
		return requirementDao.getSelectRequirements(requirementCode);
	}

	public Requirement getRequirementByRequirementCode(String requirementCode) {
		return requirementDao.getRequirementByRequirementCode(requirementCode);
	}

	public String getNextTempRequirementCode(String requirementCode) {
		return requirementDao.getNextTempRequirementCode(requirementCode);
	}

	public Requirement getRequirementById(String requirementCode) {
		return requirementDao.getRequirementById(requirementCode);
	}

	public void closeByRequirementId(Map<String, Object> likeCondition) {
		 requirementDao.closeByRequirementId(likeCondition);
		 String firstCloseTime = (String) likeCondition.get("firstCloseTime");
		 if(StringUtils.isBlank(firstCloseTime)){
			 requirementDao.updateFirstColse(likeCondition);
		 }
	}

	public List<Requirement> getToAssignRequirement(Map<String, Object> likeCondition) {
		return requirementDao.getToAssignRequirement(likeCondition);
	}

	public int getTotalToAssignRequirement(Map<String, Object> likeCondition) {
		return requirementDao.getTotalToAssignRequirement(likeCondition);
	}

	public List<Requirement> getAllLaunchRequirement(Map<String, Object> likeCondition) {
		return requirementDao.getAllLaunchRequirement(likeCondition);
	}

	public int getTotalLaunchRequirement(Map<String, Object> likeCondition) {
		return requirementDao.getTotalLaunchRequirement(likeCondition);
	}

	public List<RequirementCount> getRequirementCount(Map<String, Object> likeCondition) {
		return requirementDao.getRequirementCount(likeCondition);
	}

	public void updateRequirementStatus(Requirement requirement) {
		requirementDao.updateRequirementStatus(requirement);
	}

	public List<Requirement> getUnCloseSelectRequirements(String requirementCode) {
		return requirementDao.getUnCloseSelectRequirements(requirementCode);
	}

}

package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.RequirementCount;

public interface SysRequirementService {

public void insertRequirement(Requirement requirement);
	
	public int getTotalRequirement(Map<String,Object> likeCondition);
	
	public List<Requirement> getAllRequirement(Map<String,Object> likeCondition);
	
	public void closeByRequirementId(Map<String,Object> likeCondition);
	
	public void disableByCode(String requirementId);
	
	public void updateRequirement(Requirement requirement);
	
	public Requirement getRequirementByCode(String requirementCode);
	
	public Requirement getRequirementById(String requirementCode);
	
	public Requirement getRequirementByRequirementCode(String requirementCode);
	
	public List<Requirement> getSelectRequirements(String requirementCode);
	
	public List<Requirement> getUnCloseSelectRequirements(String requirementCode);
	
	public String  getNextTempRequirementCode(String requirementCode);
	
public List<Requirement> getToAssignRequirement(Map<String,Object> likeCondition);
	
	public int getTotalToAssignRequirement(Map<String,Object> likeCondition);
	
	public List<Requirement> getAllLaunchRequirement(Map<String,Object> likeCondition);
	
	public int getTotalLaunchRequirement(Map<String,Object> likeCondition);
	
	/** 按需求类型和状态显示需求数，紧急程度，重要程度 */
	public List<RequirementCount> getRequirementCount(Map<String,Object> likeCondition);
	
	public void updateRequirementStatus(Requirement requirement);
}

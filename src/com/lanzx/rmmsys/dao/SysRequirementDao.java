package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.RequirementCount;

@Mapper("sysRequirementDao")
public interface SysRequirementDao {

	public void insertRequirement(Requirement requirement);
	
	public int getTotalRequirement(Map<String,Object> likeCondition);
	
	public List<Requirement> getAllRequirement(Map<String,Object> likeCondition);
	
	public List<Requirement> getAllLaunchRequirement(Map<String,Object> likeCondition);
	
	public int getTotalLaunchRequirement(Map<String,Object> likeCondition);
	
	public List<Requirement> getToAssignRequirement(Map<String,Object> likeCondition);
	
	public int getTotalToAssignRequirement(Map<String,Object> likeCondition);
	
	public void closeByRequirementId(Map<String,Object> likeCondition);
	
	public void disableByCode(String requirementId);
	
	public void disableTaskByCode(String requirementId);
	
	public void updateRequirement(Requirement requirement);
	
	public void updateRequirementStatus(Requirement requirement);
	
	public Requirement getRequirementByCode(String requirementCode);
	
	public Requirement getRequirementById(String requirementCode);
	
	public Requirement getRequirementByRequirementCode(String requirementCode);
	
	public List<Requirement> getSelectRequirements(@Param(value="requirementCode") String requirementCode);
	
	public List<Requirement> getUnCloseSelectRequirements(@Param(value="requirementCode") String requirementCode);
	
	public String  getNextTempRequirementCode(@Param(value="requirementCode") String requirementCode);
	
	public List<RequirementCount> getRequirementCount(Map<String,Object> likeCondition);
	
	public void updateFirstColse(Map<String,Object> likeCondition);
}

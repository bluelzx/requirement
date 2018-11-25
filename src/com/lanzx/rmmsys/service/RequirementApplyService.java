package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.lanzx.rmmsys.entity.RApplyTaskRelation;
import com.lanzx.rmmsys.entity.RequirementTestApply;

public interface RequirementApplyService {

	public int getTotalRequirementApply(Map<String,Object> likeCondition);
	
	public List<RequirementTestApply> getAllRequirementApply(Map<String,Object> likeCondition);
	
	public String getNextApplyCode(String applyCode);
	
	public void insertRequirementApply(RequirementTestApply requirementApply);
	
	public RequirementTestApply getApplyByCode(@Param(value="applyCode")String applyCode);

	public void insertRApplyTaskRelation(RApplyTaskRelation rApplyTaskRelation);
	
	public void updateApplyStatus(RequirementTestApply requirementApply);
	
	public void updateApplyOnLineDate(RequirementTestApply requirementApply);
}

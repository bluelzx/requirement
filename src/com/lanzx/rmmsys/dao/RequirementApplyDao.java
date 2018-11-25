package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.RequirementTestApply;

@Mapper("requirementApplyDao")
public interface RequirementApplyDao {

	public int getTotalRequirementApply(Map<String,Object> likeCondition);
	
	public List<RequirementTestApply> getAllRequirementApply(Map<String,Object> likeCondition);
	
	public String getNextApplyCode(@Param(value="applyCode")String applyCode);
	
	public void insertRequirementApply(RequirementTestApply requirementApply);
	
	public void updateApplyStatus(RequirementTestApply requirementApply);
	
	public void updateApplyOnLineDate(RequirementTestApply requirementApply);
	
	public RequirementTestApply getApplyByCode(@Param(value="applyCode")String applyCode);

}

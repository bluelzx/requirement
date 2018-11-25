package com.lanzx.rmmsys.dao;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.RApplyTaskRelation;

@Mapper("rApplyTaskDao")
public interface RApplyTaskDao {

	public void insertRApplyTaskRelation(RApplyTaskRelation rApplyTaskRelation);
	
	public void deleteRApplyTaskRelation(@Param(value="applyCode")String applyCode);
}

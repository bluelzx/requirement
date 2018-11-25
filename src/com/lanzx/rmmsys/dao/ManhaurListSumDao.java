package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.ManhaurListSum;

@Mapper("manhaurListSumDao")
public interface ManhaurListSumDao {

	public List<ManhaurListSum> getManhaurListSum(Map<String,Object> likeCondition);
	
	public int getTotalManhaurListSum();
}

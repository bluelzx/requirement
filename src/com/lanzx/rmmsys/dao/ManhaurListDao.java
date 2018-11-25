package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.ManhaurList;

@Mapper("manhaurListDao")
public interface ManhaurListDao {

	public List<ManhaurList> getManhaurList(Map<String,Object> likeCondition);
	
	public int getTotalManhaurList();
}

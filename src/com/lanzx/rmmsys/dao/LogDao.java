package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Log;

@Mapper("logDao")
public interface LogDao {
	
	public List<Log> getLog(Map<String, Object> likeCondition);
	
	public int getTotalLog(Map<String, Object> likeCondition);
	
	public void insertLog(Log log);
}

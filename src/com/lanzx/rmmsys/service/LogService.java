package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Log;

public interface LogService {

public List<Log> getLog(Map<String, Object> likeCondition);
	
	public int getTotalLog(Map<String, Object> likeCondition);
	
	public void insertLog(Log log);
}

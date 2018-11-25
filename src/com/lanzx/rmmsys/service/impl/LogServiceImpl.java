package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.LogDao;
import com.lanzx.rmmsys.entity.Log;
import com.lanzx.rmmsys.service.LogService;

public class LogServiceImpl implements LogService {

	private LogDao logDao;
	
	public List<Log> getLog(Map<String, Object> likeCondition) {
		return logDao.getLog(likeCondition);
	}

	public int getTotalLog(Map<String, Object> likeCondition) {
		return logDao.getTotalLog(likeCondition);
	}

	public void insertLog(Log log) {
		logDao.insertLog(log);
	}

	public LogDao getLogDao() {
		return logDao;
	}

	public void setLogDao(LogDao logDao) {
		this.logDao = logDao;
	}

}

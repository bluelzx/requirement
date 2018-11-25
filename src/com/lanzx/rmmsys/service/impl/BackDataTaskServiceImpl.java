package com.lanzx.rmmsys.service.impl;

import java.util.Map;

import com.lanzx.rmmsys.dao.SpringTaskDao;
import com.lanzx.rmmsys.service.BackDataTaskService;

public class BackDataTaskServiceImpl implements BackDataTaskService {

	private SpringTaskDao springTaskDao;

	public SpringTaskDao getSpringTaskDao() {
		return springTaskDao;
	}

	public void setSpringTaskDao(SpringTaskDao springTaskDao) {
		this.springTaskDao = springTaskDao;
	}

	public String doBackData(Map<String,String> map) {
		return springTaskDao.doBackData(map);
	}
	
	
}

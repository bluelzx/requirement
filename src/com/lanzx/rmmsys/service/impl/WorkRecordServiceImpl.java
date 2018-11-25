package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.WorkRecordDao;
import com.lanzx.rmmsys.entity.WorkRecordDetail;
import com.lanzx.rmmsys.entity.WorkRecordToTal;
import com.lanzx.rmmsys.service.WorkRecordService;

public class WorkRecordServiceImpl implements WorkRecordService {
	
	private WorkRecordDao workRecordDao;

	public List<WorkRecordToTal> getAllWorkRecordToTal(Map<String, Object> likeCondition) {
		return workRecordDao.getAllWorkRecordToTal(likeCondition);
	}

	public List<WorkRecordDetail> getWorkRecordDetail(
			Map<String, Object> likeCondition) {
		return workRecordDao.getWorkRecordDetail(likeCondition);
	}

	public WorkRecordDao getWorkRecordDao() {
		return workRecordDao;
	}

	public void setWorkRecordDao(WorkRecordDao workRecordDao) {
		this.workRecordDao = workRecordDao;
	}

	public int getWorkRecordDetailCount(Map<String, Object> likeCondition) {
		return workRecordDao.getWorkRecordDetailCount(likeCondition);
	}

	public int getWorkRecordToTalCount(Map<String, Object> likeCondition) {
		return workRecordDao.getWorkRecordToTalCount(likeCondition);
	}

	public List<WorkRecordDetail> getWorkDetail(Map<String, Object> likeCondition) {
		return workRecordDao.getWorkDetail(likeCondition);
	}

}

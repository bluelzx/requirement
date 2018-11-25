package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.WorkRecordDetail;
import com.lanzx.rmmsys.entity.WorkRecordToTal;

public interface WorkRecordService {

	public List<WorkRecordToTal> getAllWorkRecordToTal(Map<String, Object> likeCondition);
	
	public List<WorkRecordDetail> getWorkRecordDetail(Map<String, Object> likeCondition);
	
	public List<WorkRecordDetail> getWorkDetail(Map<String, Object> likeCondition);

	public int getWorkRecordToTalCount(Map<String, Object> likeCondition);
	
	public int getWorkRecordDetailCount(Map<String, Object> likeCondition);

}

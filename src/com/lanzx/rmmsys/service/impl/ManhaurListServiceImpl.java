package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.ManhaurListDao;
import com.lanzx.rmmsys.dao.ManhaurListSumDao;
import com.lanzx.rmmsys.dao.ProjectTrackDao;
import com.lanzx.rmmsys.entity.ManhaurList;
import com.lanzx.rmmsys.entity.ManhaurListSum;
import com.lanzx.rmmsys.entity.ProjectTrack;
import com.lanzx.rmmsys.service.ManhaurListService;

public class ManhaurListServiceImpl implements ManhaurListService {

	private ManhaurListDao manhaurListDao;
	
	private ManhaurListSumDao manhaurListSumDao;
	
	private ProjectTrackDao projectTrackDao;
	
	public List<ManhaurList> getManhaurList(Map<String,Object> likeCondition) {
		return manhaurListDao.getManhaurList(likeCondition);
	}

	public int getTotalManhaurList() {
		return manhaurListDao.getTotalManhaurList();
	}

	public List<ManhaurListSum> getManhaurListSum(Map<String, Object> likeCondition) {
		return manhaurListSumDao.getManhaurListSum(likeCondition);
	}

	public int getTotalManhaurListSum() {
		return manhaurListSumDao.getTotalManhaurListSum();
	}

	public ManhaurListDao getManhaurListDao() {
		return manhaurListDao;
	}

	public void setManhaurListDao(ManhaurListDao manhaurListDao) {
		this.manhaurListDao = manhaurListDao;
	}

	public ManhaurListSumDao getManhaurListSumDao() {
		return manhaurListSumDao;
	}

	public void setManhaurListSumDao(ManhaurListSumDao manhaurListSumDao) {
		this.manhaurListSumDao = manhaurListSumDao;
	}

	public List<ProjectTrack> getProjectTrackList(Map<String, Object> likeCondition) {
		return projectTrackDao.getProjectTrackList(likeCondition);
	}

	public int getTotalProjectTrack(Map<String, Object> likeCondition) {
		return projectTrackDao.getTotalProjectTrack(likeCondition);
	}

	public ProjectTrackDao getProjectTrackDao() {
		return projectTrackDao;
	}

	public void setProjectTrackDao(ProjectTrackDao projectTrackDao) {
		this.projectTrackDao = projectTrackDao;
	}

}

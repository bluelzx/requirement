package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.ManhaurList;
import com.lanzx.rmmsys.entity.ManhaurListSum;
import com.lanzx.rmmsys.entity.ProjectTrack;

public interface ManhaurListService {

	public List<ManhaurList> getManhaurList(Map<String,Object> likeCondition);
	
	public int getTotalManhaurList();
	
	public List<ManhaurListSum> getManhaurListSum(Map<String,Object> likeCondition);
	
	public int getTotalManhaurListSum();
	
	public List<ProjectTrack> getProjectTrackList(Map<String,Object> likeCondition);
	
	public int  getTotalProjectTrack(Map<String,Object> likeCondition);

}

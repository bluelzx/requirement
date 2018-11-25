package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.ProjectTrack;

@Mapper("projectTrackDao")
public interface ProjectTrackDao {
	
	public List<ProjectTrack> getProjectTrackList(Map<String,Object> likeCondition);
	
	public int  getTotalProjectTrack(Map<String,Object> likeCondition);
}

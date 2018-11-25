package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Project;

public interface ProjectService {

	public List<Project> getProjectList(Map<String, Object> likeCondition);

	public void insertProject(Project project);

	public int getTotalProject(Map<String, Object> likeCondition);

	public void deleteProject(String projectCode);

	public Project getProjectByCode(String projectCode);
	
	public void updateProject(Project project);
}

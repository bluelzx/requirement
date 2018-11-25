package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Project;

@Mapper("projectDao")
public interface ProjectDao {

	public List<Project> getProjectList(Map<String, Object> likeCondition);

	public void insertProject(Project project);

	public int getTotalProject(Map<String, Object> likeCondition);

	public void deleteProject(String projectCode);

	public Project getProjectByCode(String projectCode);
	
	public void updateProject(Project project);
}

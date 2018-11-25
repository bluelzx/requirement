package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.ProjectDao;
import com.lanzx.rmmsys.entity.Project;
import com.lanzx.rmmsys.service.ProjectService;

public class ProjectServiceImpl implements ProjectService {

	private ProjectDao projectDao;
	
	public void deleteProject(String projectCode) {
		projectDao.deleteProject(projectCode);
	}

	public Project getProjectByCode(String projectCode) {
		return projectDao.getProjectByCode(projectCode);
	}

	public List<Project> getProjectList(Map<String, Object> likeCondition) {
		return projectDao.getProjectList(likeCondition);
	}

	public int getTotalProject(Map<String, Object> likeCondition) {
		return projectDao.getTotalProject(likeCondition);
	}

	public void insertProject(Project project) {
		projectDao.insertProject(project);
	}

	public ProjectDao getProjectDao() {
		return projectDao;
	}

	public void setProjectDao(ProjectDao projectDao) {
		this.projectDao = projectDao;
	}

	public void updateProject(Project project) {
		projectDao.updateProject(project);
	}

}

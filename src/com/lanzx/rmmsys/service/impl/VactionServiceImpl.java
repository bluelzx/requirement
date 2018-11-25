package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.VacationDao;
import com.lanzx.rmmsys.entity.Vacation;
import com.lanzx.rmmsys.service.VactionService;

public class VactionServiceImpl implements VactionService {

	private VacationDao vacationDao;
	
	public List<Vacation> getAllVacation(Map<String, Object> likeCondition) {
		return vacationDao.getAllVacation(likeCondition);
	}

	public int getTotalVacation(Map<String, Object> likeCondition) {
		return vacationDao.getTotalVacation(likeCondition);
	}

	public void insertVacation(Vacation vacation) {
		vacationDao.insertVacation(vacation);
	}

	public VacationDao getVacationDao() {
		return vacationDao;
	}

	public void setVacationDao(VacationDao vacationDao) {
		this.vacationDao = vacationDao;
	}

}

package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Vacation;
@Mapper("vacationDao")
public interface VacationDao {

	public List<Vacation> getAllVacation(Map<String, Object> likeCondition);
	
	public int getTotalVacation(Map<String, Object> likeCondition);
	
	public void insertVacation(Vacation vacation);
}

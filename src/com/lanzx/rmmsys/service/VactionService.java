package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Vacation;

public interface VactionService {

	public List<Vacation> getAllVacation(Map<String, Object> likeCondition);
	
	public int getTotalVacation(Map<String, Object> likeCondition);
	
	public void insertVacation(Vacation vacation);
}

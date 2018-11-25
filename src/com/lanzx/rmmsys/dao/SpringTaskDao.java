package com.lanzx.rmmsys.dao;

import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

@Mapper("springTaskDao")
public interface SpringTaskDao {

	public String doBackData(Map<String,String> map);
}

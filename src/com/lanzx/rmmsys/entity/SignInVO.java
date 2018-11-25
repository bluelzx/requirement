package com.lanzx.rmmsys.entity;

public class SignInVO {

	/** Y为已经签满当天时间或者还没有到提醒时间 N为没有签或者没满当天时间 */
	public String result;
	
	public  double todayInputHour;

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public double getTodayInputHour() {
		return todayInputHour;
	}

	public void setTodayInputHour(double todayInputHour) {
		this.todayInputHour = todayInputHour;
	}
	
	
}

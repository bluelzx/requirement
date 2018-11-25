package com.lanzx.rmmsys.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.RandomStringUtils;

public class DateUtil {

	/**
	 * 得到当前日期
	 * @param formate 日期格式
	 * @return
	 */
	public static String getCurrentDate(String formate){
		DateFormat df = new SimpleDateFormat(formate);
		return df.format(new Date());
	}
	
	/**
	 * 得到前一天日期
	 * @param formate 日期格式
	 * @return
	 */
	public static String getCurrentDateBefore(String formate){
		DateFormat df = new SimpleDateFormat(formate);
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int day = cal.get(Calendar.DATE);
		cal.set(Calendar.DATE, day-1);
		return df.format(cal.getTime());
	}
	

	/**
	 * 得到上周五
	 * @return
	 */
	public static String getLastFireDate() {
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		int currentDay = cal.get(Calendar.DAY_OF_WEEK);
		if (currentDay == Calendar.FRIDAY) {// 当天就是星期五
			cal.add(Calendar.DAY_OF_WEEK, -7);
		} else if (currentDay == Calendar.MONDAY) {// MONDAY
			cal.add(Calendar.DAY_OF_WEEK, -3);
		} else if (currentDay == Calendar.SATURDAY) {// SATURDAY
			cal.add(Calendar.DAY_OF_WEEK, -8);
		} else if (currentDay == Calendar.THURSDAY) {// THURSDAY
			cal.add(Calendar.DAY_OF_WEEK, -6);
		} else if (currentDay == Calendar.WEDNESDAY) {// WEDNESDAY
			cal.add(Calendar.DAY_OF_WEEK, -5);
		} else if (currentDay == Calendar.TUESDAY) {// TUESDAY
			cal.add(Calendar.DAY_OF_WEEK, -4);
		} else if (currentDay == Calendar.SUNDAY) {// SUNDAY
			cal.add(Calendar.DAY_OF_WEEK, -2);
		}

		return df.format(cal.getTime());
	}
	
	/**
	 * 日期转换
	 * @param formate1
	 * @param formate2
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static String getFmtDate(String formate1,String formate2,String date) throws Exception{
		DateFormat df1 = new SimpleDateFormat(formate1);
		DateFormat df2 = new SimpleDateFormat(formate2);
		return df2.format(df1.parse(date));
	}
	
	/**
	 * 产生一个随机编号
	 * @param formate
	 * @param randomLeng
	 * @return
	 */
	public static String getRandomCode(String formate,int randomLeng){
		return getCurrentDate(formate)+RandomStringUtils.randomNumeric(randomLeng);
	}
	
	/**
	 * 计算两日期相差小时数
	 * @param fromDate
	 * @param toDate
	 * @return
	 */
	public static long getBetweenHours(Date fromDate,Date toDate){
		long hours = 0;
		long hourTime = 60*60*1000;
		hours = Math.abs(fromDate.getTime()-toDate.getTime())/hourTime;
		return hours;
	}
	
	/**
	 * 计算两日期相差天数
	 * @param fromDate
	 * @param toDate
	 * @return
	 */
	public static long getBetweenDays(Date fromDate,Date toDate){
		long hours = 0;
		long hourTime = 24*60*60*1000;
		hours = Math.abs(fromDate.getTime()-toDate.getTime())/hourTime;
		return hours;
	}
	
	public static void main(String[] str){
//		DateFormat df = new SimpleDateFormat(Constants.DATA_FORMATE_3);
//		try {
//			Date fromDate = df.parse("20140228");
//			Date toDate = df.parse("20140301");
//			int days = (int) DateUtil.getBetweenDays(fromDate, toDate);
//			System.out.println(days);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		DateFormat df = new SimpleDateFormat("yyyyMMdd");
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.DAY_OF_WEEK, -2);
//		System.out.println(df.format(cal.getTime()));
		System.out.println(getLastFireDate());
	}
}

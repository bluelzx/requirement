package com.lanzx.rmmsys.utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;

import com.lanzx.rmmsys.entity.Log;
import com.lanzx.rmmsys.service.LogService;


public class LogMonitor implements Runnable {

	/** 执行线程 默认最大线程数为2 */
	private  static ExecutorService taskThreadExecuter = Executors.newFixedThreadPool(2);
	
	/** 告警信息队列 */
	private LinkedBlockingQueue<Log> queue = new LinkedBlockingQueue<Log>();

	
	public void receive(Log log){
		try {
			queue.put(log);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	
	private LogMonitor(){
		
	}
	
	private static LogMonitor instance = null;
	
	public static LogMonitor getInstance(){
		if(instance==null){
			instance = new LogMonitor();
		}
		return instance;
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}


	public void start(){
		Thread t = new Thread(this,"logthread");
		t.start();
		System.out.println("日志模块功能启用完成");
	}
	
	public void run() {
		while(true){
			try {
				final Log log = queue.take();
				if(log!=null){
					taskThreadExecuter.execute(new Runnable(){
						public void run() {
							LogService logService =  (LogService) ApplicationContextUtil.getBean("logService");
							logService.insertLog(log);
						}
					});
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

	
}

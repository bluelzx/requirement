package com.lanzx.rmmsys.utils;

public class Constants {
	
	public final static String RESULT_SUCCESS =  "success";
	
	public final static String RESULT_FAIL =  "fail";
	
	public final static String DEFAUL_PASSWORD = "123456";
	
	/** 默认分页 50 */
	public final static int LIST_PAGE_SIZE = 50;
	
	/** 任务类型  */
	public final static String PARA_TYPE_1 = "1";
	
	/** 需求类型  */
	public final static String PARA_TYPE_2 = "2";
	
	/** 重要程度  */
	public final static String PARA_TYPE_3 = "3";
	
	/** 紧急程度  */
	public final static String PARA_TYPE_4 = "4";
	
	/** 业务分类  */
	public final static String PARA_TYPE_5 = "5";
	
	//任务状态
	/** 任务状态：没签收,未开始 */
	public final static int TASK_STATUS_BEGIN = 1;
	/** 任务状态：进行中 */
	public final static int TASK_STATUS_DOING = 2;
	/** 任务状态：完成 */
	public final static int TASK_STATUS_FINISH = 3;
	
	/** 任务状态：挂起 */
	public final static int TASK_STATUS_FREEZE = 4;
	
	/** 任务状态：逾期未完成 */
	public final static int TASK_STATUS_DOING_OVERDUE = 5;
	
	/** 任务状态：逾期完成 */
	public final static int TASK_STATUS_FINISH_OVERDUE = 6;
	
	/** 任务状态：正常关闭 */
	public final static int TASK_STATUS_CLOSE = 7;
	
	/** 任务状态：逾期关闭 */
	public final static int TASK_STATUS_CLOSE_OVERDUE = 8;
	
	/** 任务状态：等待前置任务 */
	public final static int TASK_STATUS_WATI = -1;
	
	//需求状态
	/** 需求状态：没人签收任务,未开始 */
	public final static int REQUIREMENT_STATUS_BEGIN = 1;
	/** 需求状态：进行中 */
	public final static int REQUIREMENT_STATUS_DOING = 2;
	/** 需求状态：所有任务都已经完成 */
	public final static int REQUIREMENT_STATUS_FINISH = 3;
	/** 需求状态：手工关闭 */
	public final static int REQUIREMENT_STATUS_CLOSE = 4;
	/** 需求状态：已送测 */
	public final static int REQUIREMENT_STATUS_TESTED = 5;
	
	
	//任务类型
	/** 任务类型：数据模型ETL开发 */
	public final static int TASK_TYPE_ETL = 1;
	/** 任务类型：汇总开发 */
	public final static int TASK_TYPE_PROC = 2;
	/** 任务类型：报表开发 */
	public final static int TASK_TYPE_REPORT = 3;
	/** 任务类型：临时提取数据 */
	public final static int TASK_TYPE_TEMP = 4;
	/** 任务类型：测试 */
	public final static int TASK_TYPE_TEST = 5;
	/** 任务类型：日常琐事 */
	public final static int TASK_TYPE_TRIVIAL = 6;
	/** 任务类型：自动确认 */
	public final static int TASK_TYPE_CONFORM = 99;
	
	
	//任务组
	/** 任务类型：应用组 */
	public final static int TASK_GROUP_APP = 1;
	/** 任务类型：数据组 */
	public final static int TASK_GROUP_DATA = 2;
	
	
	/** 日期格式 yyyyMMddHHmmss */
	public static final String DATA_FORMATE_1 = "yyyyMMddHHmmss";
	
	/**  日期格式 yyyyMMddHHmm */
	public static final String DATA_FORMATE_2 = "yyyyMMddHHmm";
	
	/**  日期格式 yyyyMMdd */
	public static final String DATA_FORMATE_3 = "yyyyMMdd";
	
	/**  日期格式 yyyyMM */
	public static final String DATA_FORMATE_4 = "yyyyMM";
	
	/**  日期格式 yyyyMMdd HH:mm:ss */
	public static final String DATA_FORMATE_5 = "yyyyMMdd HH:mm:ss";
	
	/**  日期格式 yyyyMMdd HH:mm */
	public static final String DATA_FORMATE_6 = "yyyyMMdd HH:mm";
	
	/**  日期格式 yyyy-MM-dd HH:mm */
	public static final String DATA_FORMATE_7 = "yyyy-MM-dd HH:mm";
}

/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import com.google.common.collect.Lists;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.web.Servlets;
import cn.net.ecode.modules.file.entity.FileUserBiz;
import cn.net.ecode.modules.file.service.FileService;
import cn.net.ecode.modules.test.dao.TestDataDao;
import cn.net.ecode.modules.test.entity.TestData;

/**
 * 单表生成Service
 * @author ThinkGem
 * @version 2014-10-27
 */
@Service
@Transactional(readOnly = true)
public class TestDataService extends CrudService<TestDataDao, TestData> {
	
	/**
	 * 获取单条数据
	 * @param testData
	 * @return
	 */
	public TestData get(TestData testData) {
		return super.get(testData);
	}
	
	/**
	 * 查询列表数据
	 * @param testData
	 * @return
	 */
	public List<TestData> findList(TestData testData) {
		return super.findList(testData);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param testData
	 * @return
	 */
	public Page<TestData> findPage(Page<TestData> page, TestData testData) {
		return super.findPage(page, testData);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param testData
	 */
	@Transactional(readOnly = false)
	public void save(TestData testData) {
		super.save(testData);

		// 保存上传附件
		FileUserBiz file = new FileUserBiz("testData1", testData);
		FileService.getInstance().saveFileUserBiz(file);

		// 保存上传附件2
		FileUserBiz file2 = new FileUserBiz("testData2", testData);
		FileService.getInstance().saveFileUserBiz(file2);

		// 如果不是在流程中运行保存，则跳过流程任务操作相关程序代码。
		// 以下三行代码，为测试用，请不要在正式环境中存在，否则将造成流程数据错误。
		String taskCommandInfo = Servlets.getRequest().getParameter("taskCommandInfo");
		if (StringUtils.isBlank(taskCommandInfo)){
			return;
		}

//		// 推动流程流转（自动）
//		Flow flow = new Flow(testBaoxiao);  // 业务对象要求必须包含主键（默认取业务对象的getId()方法，作为流程和表单的关联关系）。
//		flow.getPersiVars().put("amount", 3000); // 设置流程变量，此值应从表单中获取
//		flow.getPersiVars().put("金额", testBaoxiao.getMoney()); // 设置流程变量，此值应从表单中获取
//		flow.getPersiVars().put("部门经理输入数据集", Lists.newArrayList("system", "wangzhen")); // 设置流程变量，此值应从表单中获取
//		FlowService.getInstance().completeTask(flow);
//
//		// 推动流程流转（获取当前任务信息）
//		Flow flow = new Flow(testData, true);
//		if (StringUtils.isNotBlank(flow.getTaskId())){
//			Task task = FlowService.getInstance().getTask(flow.getTaskId());
//			String nodeId = task.getNodeId();		// 当前环节ID
//			String nodeName = task.getNodeName();	// 当前环节名称
//		}
//		FlowService.getInstance().completeTask(flow);
		
	}
	
	/**
	 * 删除数据
	 * @param testData
	 */
	@Transactional(readOnly = false)
	public void delete(TestData testData) {
		super.delete(testData);
	}
	
	/**
	 * 测试调度任务执行方法
	 */
	public void executeTestTask(){
		logger.debug("测试调度任务方法被执行了, 执行开始! 等待10秒...");
		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		logger.debug("测试调度任务方法被执行了, 执行完毕! ");
	}
	
}
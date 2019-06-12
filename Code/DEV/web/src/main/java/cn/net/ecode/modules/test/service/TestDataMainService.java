/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.test.dao.TestDataChildDao;
import cn.net.ecode.modules.test.dao.TestDataMainDao;
import cn.net.ecode.modules.test.entity.TestDataChild;
import cn.net.ecode.modules.test.entity.TestDataMain;

/**
 * 主子表增删改Service
 * @author ThinkGem
 * @version 2016-10-09
 */
@Service
@Transactional(readOnly = true)
public class TestDataMainService extends CrudService<TestDataMainDao, TestDataMain> {
	
	@Autowired
	private TestDataChildDao testDataChildDao;
	
	/**
	 * 获取单条数据
	 * @param testDataMain
	 * @return
	 */
	public TestDataMain get(TestDataMain testDataMain) {
		TestDataMain entity = super.get(testDataMain);
		if (entity != null){
			entity.setTestDataChildList(testDataChildDao.findList(new TestDataChild(entity)));
		}
		return entity;
	}
	
	/**
	 * 查询列表数据
	 * @param testDataMain
	 * @return
	 */
	public List<TestDataMain> findList(TestDataMain testDataMain) {
		return super.findList(testDataMain);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param testDataMain
	 * @return
	 */
	public Page<TestDataMain> findPage(Page<TestDataMain> page, TestDataMain testDataMain) {
		return super.findPage(page, testDataMain);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param testDataMain
	 */
	@Transactional(readOnly = false)
	public void save(TestDataMain testDataMain) {
		super.save(testDataMain);
		for (TestDataChild testDataChild : testDataMain.getTestDataChildList()){
			if (!TestDataChild.STATUS_DELETE.equals(testDataChild.getStatus())){
				testDataChild.setTestDataMain(testDataMain);
				if (testDataChild.getIsNewRecord()){
					testDataChild.preInsert();
					testDataChildDao.insert(testDataChild);
				}else{
					testDataChild.preUpdate();
					testDataChildDao.update(testDataChild);
				}
			}else{
				testDataChildDao.delete(testDataChild);
			}
		}
	}
	
	/**
	 * 删除数据
	 * @param testDataMain
	 */
	@Transactional(readOnly = false)
	public void delete(TestDataMain testDataMain) {
		super.delete(testDataMain);
		TestDataChild testDataChild = new TestDataChild();
		testDataChild.setTestDataMain(testDataMain);
		testDataChild.preUpdate();
		testDataChildDao.delete(testDataChild);
	}
	
}
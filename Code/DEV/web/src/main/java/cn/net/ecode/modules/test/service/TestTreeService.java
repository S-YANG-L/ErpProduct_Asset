/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.service.TreeService;
import cn.net.ecode.modules.test.dao.TestTreeDao;
import cn.net.ecode.modules.test.entity.TestTree;

/**
 * 树结构数据表Service
 * @author ThinkGem
 * @version 2016-10-08
 */
@Service
@Transactional(readOnly = true)
public class TestTreeService extends TreeService<TestTreeDao, TestTree> {

	/**
	 * 获取单条数据
	 * @param testTree
	 * @return
	 */
	public TestTree get(TestTree testTree) {
		return super.get(testTree);
	}
	
	/**
	 * 查询列表
	 */
	public List<TestTree> findList(TestTree testTree) {
		return super.findList(testTree);
	}
	
	/**
	 * 查询全部列表
	 * @return
	 */
	public List<TestTree> findAllList(TestTree testTree) {
		return dao.findAllList(testTree);
	}
	

	/**
	 * 保存数据（插入或更新）
	 */
	@Transactional(readOnly = false)
	public void save(TestTree testTree) {
		super.save(testTree);
	}

	/**
	 * 保存数据（删除）
	 */
	@Transactional(readOnly = false)
	public void delete(TestTree testTree) {
		super.delete(testTree);
	}
	
	/**
	 * 获取当前节点下的启用列表
	 * 
	 * @param testTree
	 * @return
	 */
	public List<TestTree> getEnabledList(TestTree testTree) {
		return dao.getEnabledList(testTree);
	}

	/**
	 * 停用当前节点
	 */
	@Transactional(readOnly = false)
	public void disable(TestTree testTree) {
		dao.disable(testTree);
	}

	/**
	 * 停用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void disableByGroup(TestTree testTree) {
		dao.disableByGroup(testTree);
	}

	/**
	 * 启用当前节点
	 */
	@Transactional(readOnly = false)
	public void enable(TestTree testTree) {
		dao.enable(testTree);
	}

	/**
	 * 启用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void enableByGroup(TestTree testTree) {
		dao.enableByGroup(testTree);
	}
	
	/** 
	 * 获取子节点中最大的排序号
	 * @param testTree
	 * @return int  
	 */
	public int getMaxSort(TestTree testTree) {
		return dao.getMaxSort(testTree);
	}
	
	/** 
	 * 获取子节点最大的个数
	 * @param testTree
	 * @return int  
	 */
	public int getMaxSize(TestTree testTree) {
		return dao.getMaxSize(testTree);
	}

    public List<TestTree> findListTree() {
	    return dao.findListTree();
    }
}
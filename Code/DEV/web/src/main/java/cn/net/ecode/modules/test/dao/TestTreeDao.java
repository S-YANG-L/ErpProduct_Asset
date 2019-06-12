/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.dao;
import java.util.List;

import cn.net.ecode.common.persistence.TreeDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.test.entity.TestTree;

/**
 * 树结构数据表DAO接口
 * @author ThinkGem
 * @version 2016-10-08
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {

	/**
	 * 获取当前节点下的启用节点列表
	 * @param testTree
	 * @return
	 */
	public List<TestTree> getEnabledList(TestTree testTree);

	/**
	 * 停用当前节点
	 * @param testTree
	 * @return
	 */
	public int disable(TestTree testTree);

	/**
	 * 停用当前节点和子节点
	 * @param testTree
	 * @return
	 */
	public int disableByGroup(TestTree testTree);

	/**
	 * 启用当前节点
	 * @param testTree
	 * @return
	 */
	public int enable(TestTree testTree);

	/**
	 * 启用当前节点和子节点
	 * @param testTree
	 * @return
	 */
	public int enableByGroup(TestTree testTree);
	
	/** 
	 * 获取子节点中最大的排序号
	 * @param testTree
	 * @return int  
	 */
	public int getMaxSort(TestTree testTree);
	
	/** 
	 * 获取子节点最大的个数
	 * @param testTree
	 * @return int  
	 */
	public int getMaxSize(TestTree testTree);

    List<TestTree> findListTree();
}
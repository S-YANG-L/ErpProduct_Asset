/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.dao;

import cn.net.ecode.common.persistence.TreeDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.basic.entity.InvSort;


import java.util.List;

/**
 * 产品分类DAO接口
 * @Package: cn.net.ecode.scm.basic.dao 
 * @ClassName: InvSortDao
 * @author: 车磊岩
 * @date: 2016年5月23日 上午11:53:51 
 * @Version: V1.0
 */
@MyBatisDao
public interface InvSortDao extends TreeDao<InvSort> {

	/**
	 * 获取当前节点下的启用节点列表
	 * @param invSort
	 * @return
	 */
	public List<InvSort> getEnabledList(InvSort invSort);

	/**
	 * 停用当前节点
	 * @param invSort
	 * @return
	 */
	public int disable(InvSort invSort);

	/**
	 * 停用当前节点和子节点
	 * @param invSort
	 * @return
	 */
	public int disableByGroup(InvSort invSort);

	/**
	 * 启用当前节点
	 * @param invSort
	 * @return
	 */
	public int enable(InvSort invSort);

	/**
	 * 启用当前节点和子节点
	 * @param invSort
	 * @return
	 */
	public int enableByGroup(InvSort invSort);

	/** 
	 * 获取子节点中最大的排序号
	 * @param invSort
	 * @return int  
	 */
	public int getMaxSort(InvSort invSort);

	/** 
	 * 获取子节点最大的个数
	 * @param invSort
	 * @return int  
	 */
	public int getMaxSize(InvSort invSort);

}
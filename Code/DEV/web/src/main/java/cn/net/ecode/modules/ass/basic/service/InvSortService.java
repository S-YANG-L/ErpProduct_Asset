/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.service;

import cn.net.ecode.common.service.TreeService;
import cn.net.ecode.modules.ass.basic.dao.InvSortDao;
import cn.net.ecode.modules.ass.basic.entity.InvSort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 产品分类Service
 * @Package: cn.net.ecode.modules.ass.basic.service 
 * @ClassName: InvSortService
 * @author: 车磊岩
 * @date: 2016年5月23日 上午11:53:10 
 * @Version: V1.0
 */
@Service
@Transactional(readOnly = true)
public class InvSortService extends TreeService<InvSortDao, InvSort> {

	/**
	 * 获取单条数据
	 * @param invSort
	 * @return
	 */
	public InvSort get(InvSort invSort) {
		return super.get(invSort);
	}

	/**
	 * 查询列表
	 */
	public List<InvSort> findList(InvSort invSort) {
		return super.findList(invSort);
	}

	/**
	 * 查询全部列表
	 * @return
	 */
	public List<InvSort> findAllList(InvSort invSort) {
		return dao.findAllList(invSort);
	}

	/**
	 * 保存数据（插入或更新）
	 */
	@Transactional(readOnly = false)
	public void save(InvSort invSort) {
		super.save(invSort);
	}

	/**
	 * 保存数据（删除）
	 */
	@Transactional(readOnly = false)
	public void delete(InvSort invSort) {
		super.delete(invSort);
	}

	/**
	 * 获取当前节点下的启用列表
	 * 
	 * @param invSort
	 * @return
	 */
	public List<InvSort> getEnabledList(InvSort invSort) {
		return dao.getEnabledList(invSort);
	}

	/**
	 * 停用当前节点
	 */
	@Transactional(readOnly = false)
	public void disable(InvSort invSort) {
		dao.disable(invSort);
	}

	/**
	 * 停用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void disableByGroup(InvSort invSort) {
		dao.disableByGroup(invSort);
	}

	/**
	 * 启用当前节点
	 */
	@Transactional(readOnly = false)
	public void enable(InvSort invSort) {
		dao.enable(invSort);
	}

	/**
	 * 启用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void enableByGroup(InvSort invSort) {
		dao.enableByGroup(invSort);
	}

	/** 
	 * 获取子节点中最大的排序号
	 * @param invSort
	 * @return int  
	 */
	public int getMaxSort(InvSort invSort) {
		return dao.getMaxSort(invSort);
	}

	/** 
	 * 获取子节点最大的个数
	 * @param invSort
	 * @return int  
	 */
	public int getMaxSize(InvSort invSort) {
		return dao.getMaxSize(invSort);
	}

}
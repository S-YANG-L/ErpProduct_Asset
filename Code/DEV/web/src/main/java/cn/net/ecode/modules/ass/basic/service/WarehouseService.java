/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.service;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.basic.dao.WarehouseDao;
import cn.net.ecode.modules.ass.basic.entity.Warehouse;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 仓库表Service
 * @author 肖敦山
 * @version 2015-11-19
 */
@Service
@Transactional(readOnly = true)
public class WarehouseService extends CrudService<WarehouseDao, Warehouse> {

	/**
	 * 获取单条数据
	 * @param warehouse
	 * @return
	 */
	public Warehouse get(Warehouse warehouse) {
		return super.get(warehouse);
	}
	
	/**
	 * 查询列表数据
	 * @param warehouse
	 * @return
	 */
	public List<Warehouse> findList(Warehouse warehouse) {
		return super.findList(warehouse);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param warehouse
	 * @return
	 */
	public Page<Warehouse> findPage(Page<Warehouse> page, Warehouse warehouse) {
		return super.findPage(page, warehouse);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param warehouse
	 */
	@Transactional(readOnly = false)
	public void save(Warehouse warehouse) {
		super.save(warehouse);
	}
	
	/**
	 * 删除数据
	 * @param warehouse
	 */
	@Transactional(readOnly = false)
	public void delete(Warehouse warehouse) {
		super.delete(warehouse);
	}
	/**
	 * 删除数据时判断仓库编码是否已经使用
	 * @Title: findWhcode 
	 * @updateBy：Mc
	 * @date: 2016年6月16日 下午4:19:45 
	 * @param warehouse
	 * @return
	 */
	public List<Warehouse> findWhcode(Warehouse warehouse){
		return dao.findWhcode(warehouse);
	}
	
}
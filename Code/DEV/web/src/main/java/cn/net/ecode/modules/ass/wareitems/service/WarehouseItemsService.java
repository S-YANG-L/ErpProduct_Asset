/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.wareitems.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.dao.WarehouseItemsDao;

/**
 * 仓库物品信息Service
 * @author tiange
 * @version 2018-10-13
 */
@Service
@Transactional(readOnly = true)
public class WarehouseItemsService extends CrudService<WarehouseItemsDao, WarehouseItems> {
	
	/**
	 * 获取单条数据
	 * @param warehouseItems
	 * @return
	 */
	public WarehouseItems get(WarehouseItems warehouseItems) {
		return super.get(warehouseItems);
	}
	
	/**
	 * 查询列表数据
	 * @param warehouseItems
	 * @return
	 */
	public List<WarehouseItems> findList(WarehouseItems warehouseItems) {
		return super.findList(warehouseItems);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param warehouseItems
	 * @return
	 */
	public Page<WarehouseItems> findPage(Page<WarehouseItems> page, WarehouseItems warehouseItems) {
		return super.findPage(page, warehouseItems);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param warehouseItems
	 */
	@Transactional(readOnly = false)
	public void save(WarehouseItems warehouseItems) {
		super.save(warehouseItems);
	}
	
	/**
	 * 删除数据
	 * @param warehouseItems
	 */
	@Transactional(readOnly = false)
	public void delete(WarehouseItems warehouseItems) {
		super.delete(warehouseItems);
	}
    /**
     * 产看仓库库存
     */
    public WarehouseItems getQty(WarehouseItems warehouseItems) {
	   return  dao.getQty(warehouseItems);
    }
	/**
	 * 产看仓库
	 */
	public List<WarehouseItems> getWhcode(WarehouseItems warehouseItems) {
		return  dao.getWhcode(warehouseItems);
	}
}
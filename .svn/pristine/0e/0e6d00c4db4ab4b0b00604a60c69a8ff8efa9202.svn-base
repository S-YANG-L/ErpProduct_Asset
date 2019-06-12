/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.warehouse.service;

import java.util.List;

import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.warehouse.dao.WarehouseInfoDao;

/**
 * 仓库管理Service
 * @author sun
 * @version 2018-09-18
 */
@Service
@Transactional(readOnly = true)
public class WarehouseInfoService extends CrudService<WarehouseInfoDao, WarehouseInfo> {
	
	/**
	 * 获取单条数据
	 * @param WarehouseInfo
	 * @return
	 */
	public WarehouseInfo get(WarehouseInfo WarehouseInfo) {
		return super.get(WarehouseInfo);
	}
	/**
	 * 查询列表数据
	 * @param WarehouseInfo
	 * @return
	 */
	public List<WarehouseInfo> findList(WarehouseInfo WarehouseInfo) {
		return super.findList(WarehouseInfo);
	}
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param WarehouseInfo
	 * @return
	 */
	public Page<WarehouseInfo> findPage(Page<WarehouseInfo> page, WarehouseInfo WarehouseInfo) {
		return super.findPage(page, WarehouseInfo);
	}
	/**
	 * 保存数据（插入或更新）
	 * @param WarehouseInfo
	 */
	@Transactional(readOnly = false)
	public void save(WarehouseInfo WarehouseInfo) {
		WarehouseInfo.setId(IdGen.nextId());
		super.save(WarehouseInfo);
	}
	/**
	 * 删除数据
	 * @param WarehouseInfo
	 */
	@Transactional(readOnly = false)
	public void delete(WarehouseInfo WarehouseInfo) {
		super.delete(WarehouseInfo);
	}
	/**
	 * 物理删除数据
	 * @param WarehouseInfo
	 */
	@Transactional(readOnly = false)
	public void deleteDtl(WarehouseInfo WarehouseInfo) {
		// TODO Auto-generated method stub
		dao.deleteDtl(WarehouseInfo);
	}
	/**
	 * 停用
	 * @param WarehouseInfo
	 */
	@Transactional(readOnly = false)
	public void disable(WarehouseInfo WarehouseInfo) {
		dao.disable(WarehouseInfo);
	}
	/**
	 * 启用
	 * @param WarehouseInfo
	 */
	@Transactional(readOnly = false)
	public void normal(WarehouseInfo WarehouseInfo) {
		// TODO Auto-generated method stub
		dao.normal(WarehouseInfo);
	}
}
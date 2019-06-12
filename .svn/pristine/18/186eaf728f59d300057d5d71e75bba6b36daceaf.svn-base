/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.supplier.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.supplier.entity.SupplierInfo;
import cn.net.ecode.modules.ass.supplier.dao.SupplierInfoDao;

/**
 * 供货商Service
 * @author zhaohongbin
 * @version 2018-11-03
 */
@Service
@Transactional(readOnly = true)
public class SupplierInfoService extends CrudService<SupplierInfoDao, SupplierInfo> {
	
	/**
	 * 获取单条数据
	 * @param supplierInfo
	 * @return
	 */
	public SupplierInfo get(SupplierInfo supplierInfo) {
		return super.get(supplierInfo);
	}
	
	/**
	 * 查询列表数据
	 * @param supplierInfo
	 * @return
	 */
	public List<SupplierInfo> findList(SupplierInfo supplierInfo) {
		return super.findList(supplierInfo);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param supplierInfo
	 * @return
	 */
	public Page<SupplierInfo> findPage(Page<SupplierInfo> page, SupplierInfo supplierInfo) {
		return super.findPage(page, supplierInfo);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param supplierInfo
	 */
	@Transactional(readOnly = false)
	public void save(SupplierInfo supplierInfo) {
		super.save(supplierInfo);
	}
	
	/**
	 * 删除数据
	 * @param supplierInfo
	 */
	@Transactional(readOnly = false)
	public void delete(SupplierInfo supplierInfo) {
		super.delete(supplierInfo);
	}
	
}
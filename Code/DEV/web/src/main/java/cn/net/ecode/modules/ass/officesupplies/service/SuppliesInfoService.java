/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.officesupplies.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.officesupplies.entity.SuppliesInfo;
import cn.net.ecode.modules.ass.officesupplies.dao.SuppliesInfoDao;

/**
 * 办公用品Service
 * @author sun
 * @version 2018-09-10
 */
@Service
@Transactional(readOnly = true)
public class SuppliesInfoService extends CrudService<SuppliesInfoDao, SuppliesInfo> {
	
	/**
	 * 获取单条数据
	 * @param suppliesInfo
	 * @return
	 */
	public SuppliesInfo get(SuppliesInfo suppliesInfo) {
		return super.get(suppliesInfo);
	}
	
	/**
	 * 查询列表数据
	 * @param suppliesInfo
	 * @return
	 */
	public List<SuppliesInfo> findList(SuppliesInfo suppliesInfo) {
		return super.findList(suppliesInfo);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param suppliesInfo
	 * @return
	 */
	public Page<SuppliesInfo> findPage(Page<SuppliesInfo> page, SuppliesInfo suppliesInfo) {
		return super.findPage(page, suppliesInfo);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param suppliesInfo
	 */
	@Transactional(readOnly = false)
	public void save(SuppliesInfo suppliesInfo) {
		super.save(suppliesInfo);
	}
	
	/**
	 * 删除数据
	 * @param suppliesInfo
	 */
	@Transactional(readOnly = false)
	public void delete(SuppliesInfo suppliesInfo) {
		super.delete(suppliesInfo);
	}
	
	/**
	 * 物理删除数据
	 * @param suppliesInfo
	 * @author shj
	 */
	
	@Transactional(readOnly = false)
	public void deleteDtl(SuppliesInfo suppliesInfo) {
		// TODO Auto-generated method stub
		dao.deleteDtl(suppliesInfo);
		
	}
	
	/**
	 * 查询编码是否存在
	 * @param suppliesInfo
	 * @author shj
	 */
	@Transactional(readOnly = false)
	public List<SuppliesInfo> getprosuppliesCode(SuppliesInfo suppliesInfo) {
		// TODO Auto-generated method stub
		return dao.getprosuppliesCode(suppliesInfo);
	}
	
}
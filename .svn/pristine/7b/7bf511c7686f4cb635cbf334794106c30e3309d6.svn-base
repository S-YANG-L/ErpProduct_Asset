/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.service;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.basic.dao.RdstyleDao;
import cn.net.ecode.modules.ass.basic.entity.Rdstyle;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 收发类别表Service
 * @author 肖敦山
 * @version 2015-11-19
 */
@Service
@Transactional(readOnly = true)
public class RdstyleService extends CrudService<RdstyleDao, Rdstyle> {

	/**
	 * 获取单条数据
	 * @param rdstyle
	 * @return
	 */
	public Rdstyle get(Rdstyle rdstyle) {
		return super.get(rdstyle);
	}
	
	/**
	 * 查询列表数据
	 * @param rdstyle
	 * @return
	 */
	public List<Rdstyle> findList(Rdstyle rdstyle) {
		return super.findList(rdstyle);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param rdstyle
	 * @return
	 */
	public Page<Rdstyle> findPage(Page<Rdstyle> page, Rdstyle rdstyle) {
		return super.findPage(page, rdstyle);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param rdstyle
	 */
	@Transactional(readOnly = false)
	public void save(Rdstyle rdstyle) {
		super.save(rdstyle);
	}
	
	/**
	 * 删除数据
	 * @param rdstyle
	 */
	@Transactional(readOnly = false)
	public void delete(Rdstyle rdstyle) {
		super.delete(rdstyle);
	}
	
}
/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.location.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.location.entity.AssLocation;
import cn.net.ecode.modules.ass.location.dao.AssLocationDao;

/**
 * 存放地点Service
 * @author yangjianjun
 * @version 2018-09-29
 */
@Service
@Transactional(readOnly = true)
public class AssLocationService extends CrudService<AssLocationDao, AssLocation> {
	
	/**
	 * 获取单条数据
	 * @param assLocation
	 * @return
	 */
	public AssLocation get(AssLocation assLocation) {
		return super.get(assLocation);
	}
	
	/**
	 * 查询列表数据
	 * @param assLocation
	 * @return
	 */
	public List<AssLocation> findList(AssLocation assLocation) {
		return super.findList(assLocation);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assLocation
	 * @return
	 */
	public Page<AssLocation> findPage(Page<AssLocation> page, AssLocation assLocation) {
		return super.findPage(page, assLocation);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param assLocation
	 */
	@Transactional(readOnly = false)
	public void save(AssLocation assLocation) {
		super.save(assLocation);
	}
	
	/**
	 * 删除数据
	 * @param assLocation
	 */
	@Transactional(readOnly = false)
	public void delete(AssLocation assLocation) {
		super.delete(assLocation);
	}

    public AssLocation getLocalCodeSql(AssLocation assLocation) {
         return dao.getLocalCodeSql(assLocation);
    }
}
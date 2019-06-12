package cn.net.ecode.modules.ass.report.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.report.dao.RecipientsDao;
import cn.net.ecode.modules.ass.report.entity.Recipients;

/**
 * 耗材领用信息service
 * @author tiange
 * @version 2018-10-17
 */
@Service
@Transactional(readOnly = true)
public class RecipientsService extends CrudService<RecipientsDao, Recipients> {
	/**
	 * 获取单条数据
	 * @param recipients
	 * @return
	 */
	public Recipients get(Recipients recipients) {
		return super.get(recipients);
	}
	
	/**
	 * 查询列表数据
	 * @param recipients
	 * @return
	 */
	public List<Recipients> findList(Recipients recipients) {
		return super.findList(recipients);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param recipients
	 * @return
	 */
	public Page<Recipients> findPage(Page<Recipients> page, Recipients recipients) {
		return super.findPage(page, recipients);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param recipients
	 */
	@Transactional(readOnly = false)
	public void save(Recipients recipients) {
		super.save(recipients);
	}
	
	/**
	 * 删除数据
	 * @param recipients
	 */
	@Transactional(readOnly = false)
	public void delete(Recipients recipients) {
		super.delete(recipients);
	}
}

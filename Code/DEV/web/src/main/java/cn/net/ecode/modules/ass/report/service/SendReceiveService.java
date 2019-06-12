package cn.net.ecode.modules.ass.report.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.report.dao.SendReceiveDao;
import cn.net.ecode.modules.ass.report.entity.SendReceive;

/**
 * 收发存明细报表信息Service
 * @author tiange
 * @version 2018-10-16
 */
@Service
@Transactional(readOnly = true)
public class SendReceiveService extends CrudService<SendReceiveDao, SendReceive> {
	/**
	 * 获取单条数据
	 * @param sendReceive
	 * @return
	 */
	public SendReceive get(SendReceive sendReceive) {
		return super.get(sendReceive);
	}
	
	/**
	 * 查询列表数据
	 * @param sendReceive
	 * @return
	 */
	public List<SendReceive> findList(SendReceive sendReceive) {
		return super.findList(sendReceive);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param sendReceive
	 * @return
	 */
	public Page<SendReceive> findPage(Page<SendReceive> page, SendReceive sendReceive) {
		return super.findPage(page, sendReceive);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param sendReceive
	 */
	@Transactional(readOnly = false)
	public void save(SendReceive sendReceive) {
		super.save(sendReceive);
	}
	
	/**
	 * 删除数据
	 * @param sendReceive
	 */
	@Transactional(readOnly = false)
	public void delete(SendReceive sendReceive) {
		super.delete(sendReceive);
	}
	/**
	 * 筛选相应的物品
	 */
	public List<SendReceive> findDetail(SendReceive sendReceive) {
		return dao.findDetail(sendReceive);
	}
}

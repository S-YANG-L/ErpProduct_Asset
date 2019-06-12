package cn.net.ecode.modules.ass.inout.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.inout.dao.InoutBillsDao;
import cn.net.ecode.modules.ass.inout.entity.InoutBills;

/**
 * 入库子表Service
 * @author tiange
 *
 */
@Service
@Transactional(readOnly = true)
public class InoutBillsService extends CrudService<InoutBillsDao, InoutBills> {
	/**
	 * 获取单条数据
	 * @param inoutBills
	 * @return
	 */
	public InoutBills get(InoutBills inoutBills) {
		return super.get(inoutBills);
	}

	/**
	 * 查询列表数据
	 * @param inoutBills
	 * @return
	 */
	public List<InoutBills> findList(InoutBills inoutBills) {
		return super.findList(inoutBills);
	}
	

	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param inoutBills
	 * @return
	 */
	public Page<InoutBills> findPage(Page<InoutBills> page, InoutBills inoutBills) {
		return super.findPage(page, inoutBills);
	}

	/**
	 * 保存数据（插入或更新）
	 * @param inoutBills
	 */
	@Transactional(readOnly = false)
	public void save(InoutBills inoutBills) {
		super.save(inoutBills);
		
	}

	/**
	 * 删除数据
	 * @param inoutBills
	 */
	@Transactional(readOnly = false)
	public void delete(InoutBills inoutBills) {
		super.delete(inoutBills);
	}
}

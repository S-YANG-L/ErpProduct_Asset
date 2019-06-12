/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.approval.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.approval.entity.FlowHelp;
import cn.net.ecode.modules.ass.approval.dao.FlowHelpDao;

/**
 * 审批流程记录Service
 * @author zhaohongbin
 * @version 2018-10-14
 */
@Service
@Transactional(readOnly = true)
public class FlowHelpService extends CrudService<FlowHelpDao, FlowHelp> {
	
	/**
	 * 获取单条数据
	 * @param flowHelp
	 * @return
	 */
	public FlowHelp get(FlowHelp flowHelp) {
		return super.get(flowHelp);
	}
	
	/**
	 * 查询列表数据
	 * @param flowHelp
	 * @return
	 */
	public List<FlowHelp> findList(FlowHelp flowHelp) {
		return super.findList(flowHelp);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param flowHelp
	 * @return
	 */
	public Page<FlowHelp> findPage(Page<FlowHelp> page, FlowHelp flowHelp) {
		return super.findPage(page, flowHelp);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param flowHelp
	 */
	@Transactional(readOnly = false)
	public void save(FlowHelp flowHelp) {
		super.save(flowHelp);
	}
	
	/**
	 * 删除数据
	 * @param flowHelp
	 */
	@Transactional(readOnly = false)
	public void delete(FlowHelp flowHelp) {
		super.delete(flowHelp);
	}
    /**
     * 得到审批人
     * @param flowHelp
     */
    @Transactional(readOnly = false)
    public FlowHelp getFlowren(FlowHelp flowHelp) {
        return dao.getFlowren(flowHelp);
    }
    /**
     * 判断审批流程记录表的更新添加
     */
    public List<FlowHelp> findFlowId(FlowHelp flowHelp) {
        return dao.findFlowId(flowHelp);
    }
}
/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.service;

import java.util.Date;
import java.util.List;
import cn.jpush.api.utils.StringUtils;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.entity.content.AppMsgContent;
import cn.net.ecode.modules.sys.entity.content.PcMsgContent;
import cn.net.ecode.modules.sys.utils.MsgPushUtils;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBill;
import cn.net.ecode.modules.ass.orderbill.dao.OrderBillDao;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBills;
import cn.net.ecode.modules.ass.orderbill.dao.OrderBillsDao;

/**
 * 物资采购Service
 * @author zhaohongbin
 * @version 2018-10-15
 */

@Service
@Transactional(readOnly = true)
public class OrderBillService extends CrudService<OrderBillDao, OrderBill> {
	
	@Autowired
	private OrderBillsDao orderBillsDao;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private CommonService commonService;
	/**
	 * 获取单条数据
	 * @param orderBill
	 * @return
	 */
	public OrderBill get(OrderBill orderBill) {
		OrderBill entity = super.get(orderBill);
		return entity;
	}
	
	/**
	 * 查询列表数据
	 * @param orderBill
	 * @return
	 */
	public List<OrderBill> findList(OrderBill orderBill) {
		return super.findList(orderBill);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param orderBill
	 * @return
	 */
	public Page<OrderBill> findPage(Page<OrderBill> page, OrderBill orderBill) {
		return super.findPage(page, orderBill);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param orderBill
	 */
	@Transactional(readOnly = false)
	public void save(OrderBill orderBill) {
        if (orderBill.getIsNewRecord()) {
            orderBill.setApprovalStatus("1");
            orderBill.setInoutStatus("0");
            super.save(orderBill);
            approvalSubmit(orderBill);
            seveDtl(orderBill);
        } else {
            if (orderBill.getApprovalStatus().equals("0")||orderBill.getApprovalStatus().equals("3")) {
                orderBill.setApprovalStatus("1");
                super.save(orderBill);
                approvalSubmit(orderBill);
                OrderBills orderBills=new OrderBills();
                orderBills.setSysCode(orderBill.getSysCode());
                orderBillsDao.delete(orderBills);
                seveDtl(orderBill);
            }
            if (orderBill.getStep().equals("2")) {
                super.save(orderBill);
                OrderBills orderBills=new OrderBills();
                orderBills.setSysCode(orderBill.getSysCode());
                orderBillsDao.delete(orderBills);
                seveDtl(orderBill);
            }
        }
	}

    /**
     * 保存子表
     * @param orderBill
     */
    public void seveDtl(OrderBill orderBill) {
        for (OrderBills orderBills1 : orderBill.getOrderBillsList()) {
        	
        	if(orderBills1.getPrice() == null||orderBills1.getPrice().equals("")){
        		orderBills1.setPrice(0.0);
        	}
            orderBills1.preInsert();
            orderBills1.setSysCode(orderBill.getSysCode());
            orderBillsDao.insert(orderBills1);
        }
    }
    /**
     * 改变采购状态
     * @param sysCode
     */
    public void updateOrderStatus(String sysCode) {
        dao.updateOrderStatus(sysCode);
    }
	/**
	 * 删除数据
	 * @param orderBill
	 */
	@Transactional(readOnly = false)
	public void delete(OrderBill orderBill) {
		super.delete(orderBill);
		OrderBills orderBills = new OrderBills();
		orderBills.setSysCode(orderBill.getSysCode());
		orderBills.preUpdate();
		orderBillsDao.delete(orderBills);
	}

    /**
     * 查询子表数据
     * @param orderBills
     * @return
     */
    public List<OrderBill> findUsedCode(OrderBills orderBills) {
	    return  orderBillsDao.findUsedCode(orderBills);
    }
    /**
     * 申请提交代码
     */
    public void approvalSubmit(OrderBill orderBill) {
        double sumAll=0f;
        for(OrderBills orderBills:orderBill.getOrderBillsList()){
            sumAll=sumAll+orderBills.getSumMoney();
        }
        User currUser = UserUtils.getUser();
        OrderBill orderBill1 = new OrderBill();
        orderBill1.setBuyerCode(currUser.getRefCode());
        Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        FlowBusiness flowBusiness = new FlowBusiness();
        if (orderBill.getApproval() != null) {
            flowBusiness.setApprovalCode(orderBill.getApproval()); // 必填-审核人编码
        } else if (orderBill.getApprovalCode() != null) {
            flowBusiness.setApprovalCode(orderBill.getApprovalCode()); // 必填-审核人编码
        }
        flowBusiness.setLinkUrlPc("/orderbill/orderBill/form?sysCode=" + orderBill.getSysCode());// 必填=单据详情页链接地址
        flowBusiness.setBizKey(orderBill.getSysCode()); // 必填-业务单号/id
        flowBusiness.setApprovalName(currUser.getUserName());
        flowBusiness.setBilltypeCode("CG"); // 必填-单据类型
        flowBusiness.setCompanyCode(orderBill.getCompanyCode());// 必填-公司编码
        flowBusiness.setOfficeCode(common.getOfficeCode());// 必填-部门编码
        flowBusiness.setFlowId(orderBill.getFlowId()); // 必填-工作流模板ID
        flowBusiness.setBillDate(new Date()); // 必填-单据日期
        flowBusiness.setApplicantCode(currUser.getUserCode()); // 必填-申请人编码
        // flowBusiness.setLinkUrlApp("../billDetail/overTimeBill.w?id="+overtime.getId());
        // // 选填-APP单据详情页链接地址
        flowBusiness.setBillAmt(null); // 选填-单据金额
        flowBusiness.setContent(currUser.getUserName() + "提交的采购单--"+sumAll+"元"); // 选填-业务描述
        flowBusinessService.submit(flowBusiness);
        try{
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //  msgContent.addButton("办理", "/a/usedinfo/assetUsedInfo/form?id=" + assetUsedInfo.getId());
            MsgPushUtils.push(msgContent, orderBill.getId(), BillTypeUtils.CG, orderBill.getApprovalCode());

        }catch (Exception e){
        }
    }

    /**
     * @Title: undo
     * @Description: 撤回申请
     * @param flowBusiness
     * @return
     */
    @Transactional(readOnly = false)
    public String unSubmit(FlowBusiness flowBusiness) {
        String msg = null;
        if (StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unSubmit(flowBusiness.getBizKey());
            if (StringUtils.isEmpty(msg)) {
                // 更改业务表数据 TO-DO
                OrderBill o = new OrderBill();
                o.setId(flowBusiness.getBizKey());
                OrderBill o1 = get(o);
                o1.setApprovalStatus("0");
                dao.update(o1);
            }
        }
        return msg;
    }

    /**
     * @Title: undo
     * @Description: 撤回审批
     * @param flowBusiness
     */

    @Transactional(readOnly = false)
    public String unDo(FlowBusiness flowBusiness) {
        String msg = null;
        if (StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unDo(flowBusiness.getBizKey());
            //更改业务表数据 TO-DO
            OrderBill orderBill = new OrderBill();
            orderBill.setId(flowBusiness.getBizKey());
            OrderBill orderBill1 = get(orderBill);
            orderBill1.setApprovalStatus("0");
            dao.update(orderBill1);
        }
        return msg;
    }
    /**
     * 同意审批
     *
     * @param orderBill
     */
    @Transactional(readOnly = false)
    public void agree(OrderBill orderBill) {
        // 调用JUDP3.0 同意方法
        String isEnd = flowBusinessService.auditPass(orderBill.getFlowBusinessId(), orderBill.getApprovalMemo1(),
                orderBill.getNextApprovalCode());
        // 更改业务表数据 TO-DO
        if ("1".equals(isEnd)) {// 已经终审
            OrderBill hl = get(orderBill);
            hl.setApprovalStatus("2");
            dao.update(hl);
        } else {
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //  msgContent.addButton("办理", "/a/usedinfo/assetUsedInfo/form?id=" + assetUsedInfo.getId());
            MsgPushUtils.push(msgContent, orderBill.getId(), BillTypeUtils.CG, orderBill.getNextApprovalCode());
            OrderBill hl = get(orderBill);
            hl.setApprovalStatus("1");
            dao.update(hl);
        }

    }

    @Transactional(readOnly = false)
    public void disagree(OrderBill orderBill) {
        // 调用JUDP3.0 不同意方法
        flowBusinessService.auditUnpass(orderBill.getFlowBusinessId(), orderBill.getApprovalMemo1());

        // 更改业务表数据 TO-DO
        OrderBill hl = get(orderBill);
        hl.setApprovalStatus("3");
        dao.update(hl);

    }

    public List<OrderBill> selectListData(OrderBill orderBill) {
        return dao.selectListData(orderBill);
    }
}
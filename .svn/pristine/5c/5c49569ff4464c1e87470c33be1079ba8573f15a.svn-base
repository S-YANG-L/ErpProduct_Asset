/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.outbound.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;
import cn.net.ecode.modules.sys.entity.content.AppMsgContent;
import cn.net.ecode.modules.sys.entity.content.PcMsgContent;
import cn.net.ecode.modules.sys.utils.MsgPushUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fr.general.jsqlparser.expression.StringValue;

import org.apache.commons.lang3.StringUtils;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.approval.entity.FlowHelp;
import cn.net.ecode.modules.ass.approval.service.FlowHelpService;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;

import cn.net.ecode.modules.ass.outbound.dao.OutboundBillDao;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;


import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import cn.net.ecode.modules.ass.outbound.dao.OutboundBillDtlDao;

/**
 * 物资出库Service
 * @author tiange
 * @version 2018-10-11
 */
@Service
@Transactional(readOnly = true)
public class OutboundBillService extends CrudService<OutboundBillDao, OutboundBill> {
	
	@Autowired
	private OutboundBillDtlDao outboundBillDtlDao;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private PushModelService pushModelService;
    @Autowired
    private AppMessageService appMessageService;
    @Autowired
    private PushService pushService;
    @Autowired
    private WarehouseItemsService warehouseItemsService;
    @Autowired
    private FlowHelpService flowHelpService;
	/**
	 * 获取单条数据
	 * @param outboundBill
	 * @return
	 */
	public OutboundBill get(OutboundBill outboundBill) {
		return super.get(outboundBill);
	}
	/**
	 * 获取部门信息
	 * @param outboundBill
	 * @return
	 */
	public OutboundBill getOffice(OutboundBill outboundBill) {
        return dao.getOffice(outboundBill);
    }
	
    /**
     * @param outboundBill
     * @return
     * @Title: getCompanyCode
     * @Description: 根据userCode查询公司编码
     */
    public String getCompanyCode(OutboundBill outboundBill) {
        return dao.getCompanyCode(outboundBill);
    }
	
	/**
	 * 查询列表数据
	 * @param outboundBill
	 * @return
	 */
	public List<OutboundBill> findList(OutboundBill outboundBill) {
		return super.findList(outboundBill);
	}


    /**
     * 保存数据（插入或更新）
     *
     * @param outboundBill
     */
    @Transactional(readOnly = false)
    public void save(OutboundBill outboundBill) {
        if (outboundBill.getIsNewRecord()) {
            if (!outboundBill.getApprovalStatus().equals("2")) {
            	outboundBill.setApprovalStatus("1");
                outboundBill.setMemo("标准出库");
                outboundBill.setSysCode(IdGen.nextId());
                super.save(outboundBill);
                submitForApproval(outboundBill);
                FlowHelp flowHelp = new FlowHelp();
                flowHelp.setApplicantCode(UserUtils.getUser().getUserCode());
                flowHelp.setApplicantName(UserUtils.getUser().getUserName());
                flowHelp.setStep("1");
                flowHelp.setFlowId(outboundBill.getSysCode());
                flowHelpService.save(flowHelp);
            }else{
                super.save(outboundBill);
            }
        } else {
            if (outboundBill.getApprovalStatus().equals("0")||outboundBill.getApprovalStatus().equals("3")) {
            	outboundBill.setApprovalStatus("1");
                super.save(outboundBill);
                submitForApproval(outboundBill);
            }
            updateInsertFlowHelp(outboundBill);
            if (outboundBill.getStep().equals("2")) {
                OutboundBillDtl outboundBillDtl=new OutboundBillDtl();
                outboundBillDtl.setSysCode(outboundBill.getSysCode());
                outboundBillDtlDao.delete(outboundBillDtl);
                for (OutboundBillDtl outboundBillDtl1 : outboundBill.getOutboundBillDtlList()) {
                	WarehouseItems warehouseItemsIs=new WarehouseItems();
                	warehouseItemsIs.setWhCode(outboundBillDtl1.getWhCode());
                    warehouseItemsIs.setArticlesCode(outboundBillDtl1.getArticlesCode());
                    WarehouseItems warehouseItemsReturn = warehouseItemsService.getQty(warehouseItemsIs);
                	outboundBillDtl1.setOutInitialQty(warehouseItemsReturn.getQty());
                	outboundBillDtl1.setOutInitialPrice(warehouseItemsReturn.getPrice());
                	outboundBillDtl1.setOutInitialMoney(warehouseItemsReturn.getSumMoney());
                    outboundBillDtl1.setSysId(IdGen.nextId());
                    outboundBillDtl1.preInsert();
                    outboundBillDtl1.setOrderDate(new Date());
                    outboundBillDtl1.setSysCode(outboundBill.getSysCode());
                    outboundBillDtl1.setSumMoney(outboundBillDtl1.getOutboundNumber()*outboundBillDtl1.getPrice());
                    warehouseOut(outboundBillDtl1);
                    outboundBillDtlDao.insert(outboundBillDtl1);
                }
            }
        }
    }
    /**
     * 仓库出库
     */
    public void warehouseOut(OutboundBillDtl outboundBillDtl) {
        WarehouseItems warehouseItemsIs=new WarehouseItems();
        warehouseItemsIs.setWhCode(outboundBillDtl.getWhCode());
        warehouseItemsIs.setArticlesCode(outboundBillDtl.getArticlesCode());
        WarehouseItems warehouseItemsReturn= warehouseItemsService.getQty(warehouseItemsIs);
        if(warehouseItemsReturn!=null){
            Double qty=warehouseItemsReturn.getQty()-outboundBillDtl.getOutboundNumber();
            warehouseItemsReturn.setQty(qty);
            warehouseItemsReturn.setSumMoney(warehouseItemsReturn.getQty()*warehouseItemsReturn.getPrice());
            warehouseItemsService.update(warehouseItemsReturn);
        }
    }
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param outboundBill
	 * @return
	 */
	public Page<OutboundBill> findPage(Page<OutboundBill> page, OutboundBill outboundBill) {
		return super.findPage(page, outboundBill);
	}
	
	@Transactional(readOnly = false)
    public void agree(OutboundBill outboundBill) {
        // 调用JUDP3.0 同意方法
        String isEnd = flowBusinessService.auditPass(outboundBill.getFlowBusinessId(), outboundBill.getApprovalMemo(), outboundBill.getNextApprovalCode());

        //更改业务表数据 TO-DO
        if ("1".equals(isEnd)) {//已经终审
        	OutboundBill hl = get(outboundBill);
            hl.setApprovalStatus("2");
            dao.update(hl);
        } else {
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //msgContent.addButton("办理", "/a/allotinfo/assetAllotInfo/form?id=" + assetAllotInfo.getId()+"&pageFlag=1&stepId="+assetAllotInfo.getStepId()+"&step="+assetAllotInfo.getStep());
            MsgPushUtils.push(msgContent, outboundBill.getId(), BillTypeUtils.CK, outboundBill.getNextApprovalCode());

            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",outboundBill.getNextApprovalCode(),"您有新的待办，请及时处理！");
        	OutboundBill hl = get(outboundBill);
            hl.setApprovalStatus("1");
            dao.update(hl);
        }
        /*//如果下一步审批人为空，证明该流程已经结束
        if (cn.net.ecode.common.utils.StringUtils.isNotEmpty(outboundBill.getNextApprovalCode())) {
            //推送----Mc add 20170228
            Map<String, Boolean> map = pushModelService.pushType(outboundBill.getNextApprovalCode());
            if (!map.isEmpty()) {
                //判断单据类通知推送方式
                if (map.get("billNotice")) {
                    if (map.get("pushAurora")) {
                        //极光推送
                        appMessageService.pushMessage(outboundBill.getNextApprovalCode(), outboundBill.getOutbounderName() + "的办公用品出库申请", outboundBill.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.WZCK, null);//调用极光推送接口
                    }
                    if (map.get("pushWeChat")) {
                        //微信推送
                        AppMessage message = new AppMessage();
                        message.setApplicantName(outboundBill.getOutbounderName());
                        message.setApplyDate(outboundBill.getOutboundDate());
                        message.setApplyMoney(null);
                        message.setBizKey(outboundBill.getId());
                        message.setBizType(BillTypeUtils.WZCK);
                        message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.WZCK));
                        message.setReceiverType(Message.RECEIVER_TYPE_USER);
                        message.setReceiverCodes(outboundBill.getNextApprovalCode());
                        message.setReceiverNames(outboundBill.getNextApprovalName());
                        message.setAgree(true);
                        appMessageService.pushWeChatMessage(message);
                    }
                } else {
                    //保存延时推送中间表数据
                    Push push = new Push();
                    User curr = UserUtils.getUser();
                    push.setOriginateCode(curr.getUserCode());
                    push.setOriginateName(curr.getUserName());
                    push.setReceiverCode(outboundBill.getNextApprovalCode());
                    push.setReceiverName(outboundBill.getNextApprovalName());
                    //当前时间加上半小时
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(new Date());
                    calendar.add(Calendar.MINUTE, 30);
                    push.setReceiverDate(calendar.getTime());
                    push.setReceiverContent(outboundBill.getOutbounderName() + "的办公用品出库申请");
                    push.setBizKey(outboundBill.getId());
                    push.setBizType(BillTypeUtils.ZCLY);
                    push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.WZCK));
                    push.setReceiverType(Message.RECEIVER_TYPE_USER);
                    //业务单据参数
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Map<String, String> param = new HashMap<String, String>();
                    param.put("applicantName", outboundBill.getOutbounderName());
                    param.put("applyDate", sdf.format(outboundBill.getOutboundDate()));
                    String pushParam = JsonMapper.toJsonString(param);
                    push.setPushParam(pushParam);
                    push.preInsert();
                    push.setIsNewRecord(true);//插入表数据
                    pushService.save(push);
                }
            }
            //end
        }*/

    }
	
    @Transactional(readOnly = false)
    public void disagree(OutboundBill outboundBill) {
/*        //极光推送 20161102 Mc add
        if (outboundBill.getOutbounderName() != null) {
            Map<String, Boolean> map = pushModelService.pushType(outboundBill.getOutbounderName());
            if (!map.isEmpty()) {
                //判断单据类通知推送方式
                if (map.get("billNotice")) {
                    if (map.get("pushAurora")) {
                        //极光推送
                        appMessageService.pushMessage(outboundBill.getOutbounderCode(), UserUtils.getUser().getUserName() + "不同意您提交的申请",
                        		outboundBill.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.WZCK, null);//调用极光推送接口
                    }
                    if (map.get("pushWeChat")) {
                        //微信推送
                        AppMessage message = new AppMessage();
                        message.setApplicantName(outboundBill.getOutbounderName());
                        message.setApplyDate(outboundBill.getOutboundDate());
                        message.setApplyMoney(null);
                        message.setBizKey(outboundBill.getId());
                        message.setBizType(BillTypeUtils.WZCK);
                        message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.WZCK));
                        message.setReceiverType(Message.RECEIVER_TYPE_USER);
                        message.setReceiverCodes(outboundBill.getOutbounderCode());
                        message.setReceiverNames(outboundBill.getOutbounderName());
                        message.setAgree(false);
                        appMessageService.pushWeChatMessage(message);
                    }
                } else {
                    //保存延时推送中间表数据
                    Push push = new Push();
                    User curr = UserUtils.getUser();
                    push.setOriginateCode(curr.getUserCode());
                    push.setOriginateName(curr.getUserName());
                    push.setReceiverCode(outboundBill.getOutbounderCode());
                    push.setReceiverName(outboundBill.getOutbounderName());
                    //当前时间加上半小时
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(new Date());
                    calendar.add(Calendar.MINUTE, 30);
                    push.setReceiverDate(calendar.getTime());
                    push.setReceiverContent(outboundBill.getOutbounderName() + "的" + BillTypeUtils.getBillTypeName(BillTypeUtils.WZCK));
                    push.setBizKey(outboundBill.getId());
                    push.setBizType(BillTypeUtils.WZCK);
                    push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.WZCK));
                    push.setReceiverType(Message.RECEIVER_TYPE_USER);
                    //业务单据参数
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Map<String, String> param = new HashMap<String, String>();
                    param.put("applicantName", outboundBill.getOutbounderName());
                    param.put("applyDate", sdf.format(outboundBill.getOutboundDate()));
                    String pushParam = JsonMapper.toJsonString(param);
                    push.setPushParam(pushParam);
                    push.preInsert();
                    push.setIsNewRecord(true);//插入表数据
                    pushService.save(push);
                }
            }
        }*/
        //end
        // 调用JUDP3.0 不同意方法
        flowBusinessService.auditUnpass(outboundBill.getFlowBusinessId(), outboundBill.getApprovalMemo());
        //更改业务表数据 TO-DO
        OutboundBill hl = get(outboundBill);
        hl.setApprovalStatus("3");
        dao.update(hl);
    }
    
    /**
     * @return
     * @Title: unDo
     * @Description: 撤回审批
     */
    @Transactional(readOnly = false)
    public String unDo(FlowBusiness flowBusiness) {
        String msg = null;
        if (StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unDo(flowBusiness.getBizKey());

        }
        return msg;
    }
    
    /**
     * 撤回申请
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
                //更改业务表数据 TO-DO
            	OutboundBill o = new OutboundBill();
                o.setId(flowBusiness.getBizKey());
                OutboundBill o1 = get(o);
                o1.setApprovalStatus("0");
                dao.update(o1);
            }
        }
        return msg;
    }
    
    /**
     * 提交审批
     * @param outboundBill
     */
    public void submitForApproval(OutboundBill outboundBill) {
        User currUser = UserUtils.getUser();
        //调用JUDP3.0工作流----start ydy
        OutboundBill outboundBill1 = new OutboundBill();
        outboundBill1.setOutbounderCode(currUser.getRefCode());
        OutboundBill ot = getOffice(outboundBill1);
        FlowBusiness flowBusiness = new FlowBusiness();
        if (outboundBill.getApproval() != null) {
            flowBusiness.setApprovalCode(outboundBill.getApproval());    // 必填-审核人编码
        } else if (outboundBill.getApprovalCode() != null) {
            flowBusiness.setApprovalCode(outboundBill.getApprovalCode());    // 必填-审核人编码
        }
        flowBusiness.setLinkUrlPc("/outbound/outboundBill/form?sysCode=" + outboundBill.getSysCode());// 必填-单据详情页链接地址
        flowBusiness.setBizKey(outboundBill.getSysCode()); // 必填-业务单号/id
        flowBusiness.setBilltypeCode("WZCK"); // 必填-单据类型
        flowBusiness.setCompanyCode(ot.getCompanyCode());// 必填-公司编码
        flowBusiness.setOfficeCode(ot.getOfficeCode());//  必填-部门编码
        flowBusiness.setFlowId(outboundBill.getFlowId()); // 必填-工作流模板ID
        flowBusiness.setBillDate(new Date()); // 必填-单据日期
        flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
        //  flowBusiness.setLinkUrlApp("../billDetail/AssetUsedInfoBill.w?id="+AssetUsedInfo.getId()); // 选填-APP单据详情页链接地址
        flowBusiness.setBillAmt(null);    // 选填-单据金额
        flowBusiness.setContent(currUser.getUserName() + "提交的办公用品领用申请");    // 选填-业务描述
        flowBusinessService.submit(flowBusiness);

        OutboundBill hl = get(outboundBill);
        hl.setApprovalStatus("1");
        dao.update(hl);
        try{
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //msgContent.addButton("办理", "/a/allotinfo/assetAllotInfo/form?id=" + assetAllotInfo.getId()+"&pageFlag=1&stepId="+assetAllotInfo.getStepId()+"&step="+assetAllotInfo.getStep());
            MsgPushUtils.push(msgContent, outboundBill.getId(), BillTypeUtils.CK, outboundBill.getApprovalCode());

            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",outboundBill.getApprovalCode(),"您有新的待办，请及时处理！");
        }catch (Exception e){
        }
    }

    /**
     * 判断审批流程记录表的更新添加
     */
    public void updateInsertFlowHelp(OutboundBill outboundBill) {
        FlowHelp flowHelp = new FlowHelp();
        int step = 0;
        if (outboundBill.getStep().equals("")) {
            step = 1;
        } else {
            step = Integer.parseInt(outboundBill.getStep()) + 1;
        }
        flowHelp.setStep(String.valueOf(step));
        flowHelp.setFlowId(outboundBill.getSysCode());
        flowHelp.setApplicantCode(UserUtils.getUser().getUserCode());
        flowHelp.setApplicantName(UserUtils.getUser().getUserName());
        flowHelpService.delete(flowHelp);
        flowHelp.preInsert();
        flowHelpService.insert(flowHelp);
    }

	
	/**
	 * 删除数据
	 * @param outboundBill
	 */
	@Transactional(readOnly = false)
	public void delete(OutboundBill outboundBill) {
		super.delete(outboundBill);
		OutboundBillDtl outboundBillDtl = new OutboundBillDtl();
		outboundBillDtl.setSysCode(outboundBill.getSysCode());
		outboundBillDtl.preUpdate();
		outboundBillDtlDao.delete(outboundBillDtl);
	}
	
    /**
     * 通过outboundBillDtl中outboundCode得到子表数据
     * @param outboundBillDtl
     * @return
     */
    public List<OutboundBillDtl> findoutboundCode(OutboundBillDtl outboundBillDtl) {
        return outboundBillDtlDao.findoutboundCode(outboundBillDtl);
    }

    @Transactional(readOnly = false)
    public void deleteFlowLog(OutboundBill outboundBill) {
        dao.deleteFlowLog(outboundBill);
    }

    public Page<OutboundBill> findOutboundBillList(Page page, OutboundBill outboundBill) {
        outboundBill.setPage(page);
        List<OutboundBill> list = dao.findList(outboundBill);
        page.setList(list);
        return page;
    }
}
/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.service;

import java.text.SimpleDateFormat;
import java.util.*;

import cn.jpush.api.utils.StringUtils;
import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.approval.entity.FlowHelp;
import cn.net.ecode.modules.ass.approval.service.FlowHelpService;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.msg.entity.Message;
import cn.net.ecode.modules.msg.entity.PushMessage;
import cn.net.ecode.modules.sys.entity.Office;
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
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.ass.usedinfo.dao.AssetUsedInfoDao;

/**
 * 资产领用Service
 *
 * @author zhaohongbin
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class AssetUsedInfoService extends CrudService<AssetUsedInfoDao, AssetUsedInfo> {
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private AssetInfoService assetInfoService;
    @Autowired
    private AssetUsedDtlService assetUsedDtlService;
    @Autowired
    private PushModelService pushModelService;
    @Autowired
    private AppMessageService appMessageService;
    @Autowired
    private PushService pushService;
    @Autowired
    private FlowHelpService flowHelpService;
    /**
     * 获取单条数据
     *
     * @param assetUsedInfo
     * @return
     */
    public AssetUsedInfo get(AssetUsedInfo assetUsedInfo) {
        return super.get(assetUsedInfo);
    }

    /**
     * 查询列表数据
     *
     * @param assetUsedInfo
     * @return
     */
    public List<AssetUsedInfo> findList(AssetUsedInfo assetUsedInfo) {
        return super.findList(assetUsedInfo);
    }

    /**
     * 查询分页数据
     *
     * @param page          分页对象
     * @param assetUsedInfo
     * @return
     */
    public Page<AssetUsedInfo> findPage(Page<AssetUsedInfo> page, AssetUsedInfo assetUsedInfo) {
        return super.findPage(page, assetUsedInfo);
    }
    /**
     * 保存数据（插入或更新）
     *
     * @param assetUsedInfo
     */
    @Transactional(readOnly = false)
    public void save(AssetUsedInfo assetUsedInfo) {
        if (assetUsedInfo.getIsNewRecord()) {
            //调拨领用不需要开启审批流直接完成
            if (!assetUsedInfo.getApprovalStatus().equals("2")) {
                assetUsedInfo.setApprovalStatus("1");
                assetUsedInfo.setId(IdGen.nextId());
                assetUsedInfo.setIsNewRecord(true);
                super.save(assetUsedInfo);
                submitForApproval(assetUsedInfo);
                FlowHelp flowHelp = new FlowHelp();
                flowHelp.setApplicantCode(UserUtils.getUser().getUserCode());
                flowHelp.setApplicantName(UserUtils.getUser().getUserName());
                flowHelp.setStep("1");
                flowHelp.setFlowId(assetUsedInfo.getId());
                flowHelpService.save(flowHelp);
            }else{
                assetUsedInfo.setId(IdGen.nextId());
                assetUsedInfo.setIsNewRecord(true);
                super.save(assetUsedInfo);
            }
        } else {
            if (assetUsedInfo.getApprovalStatus().equals("0") || assetUsedInfo.getApprovalStatus().equals("3")) {
                assetUsedInfo.setApprovalStatus("1");
                super.save(assetUsedInfo);
                submitForApproval(assetUsedInfo);
            }
            updateInsertFlowHelp(assetUsedInfo);
            if (assetUsedInfo.getStep().equals("2")) {
                for (AssetUsedDtl assetUsedDtl : assetUsedInfo.getAssetUsedDtls()) {
                    assetUsedDtl.setUsedCode(assetUsedInfo.getId());
                    User user = new User();
                    user.setUserCode(assetUsedInfo.getReceiverCode());
                    assetUsedDtl.setUser(user);
                    assetUsedDtl.setReturnStatus("0");
                    assetUsedDtl.setUserName(assetUsedInfo.getReceiverName());
                    assetUsedDtl.setId(IdGen.nextId());
                    assetUsedDtl.preInsert();
                    assetUsedDtl.setIsNewRecord(true);
                    assetUsedDtlService.save(assetUsedDtl);
                    upDateStatus(assetUsedInfo, assetUsedDtl);
                }
            }
        }

    }
    /**
     * 改变使用人跟状态
     */
    public void upDateStatus(AssetUsedInfo assetUsedInfo, AssetUsedDtl assetUsedDtl) {
        AssetInfo assetInfo = new AssetInfo();
        assetInfo.setAssetCode(assetUsedDtl.getAssetCode());
        assetInfo.setAssetStatus("1");
        User user = new User();
        user.setUserCode(assetUsedInfo.getReceiverCode());
        Office office = new Office();
        office.setOfficeCode(assetUsedInfo.getUsedOfficeCode());
        assetInfo.setOffice(office);
        assetInfo.setOfficeName(assetUsedInfo.getUsedOfficeName());
        assetInfo.setUser(user);
        assetInfo.setUserName(assetUsedInfo.getReceiverName());
        assetInfo.setUseDate(assetUsedInfo.getReceiverDate());
        assetInfoService.updatauserStatus(assetInfo);
    }

    /**
     * 判断审批流程记录表的更新添加
     */
    public void updateInsertFlowHelp(AssetUsedInfo assetUsedInfo) {
        FlowHelp flowHelp = new FlowHelp();
        int step = 0;
        if (assetUsedInfo.getStep().equals("")) {
            step = 1;
        } else {
            step = Integer.parseInt(assetUsedInfo.getStep()) + 1;
        }
        flowHelp.setStep(String.valueOf(step));
        flowHelp.setFlowId(assetUsedInfo.getId());
        flowHelp.setApplicantCode(UserUtils.getUser().getUserCode());
        flowHelp.setApplicantName(UserUtils.getUser().getUserName());
        flowHelpService.delete(flowHelp);
        flowHelp.preInsert();
        flowHelpService.insert(flowHelp);
    }

    /**
     * 提交审批
     *
     * @param assetUsedInfo
     */
    public void submitForApproval(AssetUsedInfo assetUsedInfo) {
        User currUser = UserUtils.getUser();
        //调用JUDP3.0工作流----start ydy
        AssetUsedInfo assetUsedInfo1 = new AssetUsedInfo();
        assetUsedInfo1.setReceiverCode(currUser.getRefCode());
        AssetUsedInfo ot = getOffice(assetUsedInfo1);
        FlowBusiness flowBusiness = new FlowBusiness();
        if (assetUsedInfo.getApproval() != null) {
            flowBusiness.setApprovalCode(assetUsedInfo.getApproval());    // 必填-审核人编码
        } else if (assetUsedInfo.getApprovalCode() != null) {
            flowBusiness.setApprovalCode(assetUsedInfo.getApprovalCode());    // 必填-审核人编码
        }
        flowBusiness.setLinkUrlPc("/usedinfo/assetUsedInfo/form?id=" + assetUsedInfo.getId());// 必填-单据详情页链接地址
        flowBusiness.setBizKey(assetUsedInfo.getId()); // 必填-业务单号/id
        flowBusiness.setBilltypeCode("ZCLY"); // 必填-单据类型
        flowBusiness.setCompanyCode(ot.getUsedCompanyCode());// 必填-公司编码
        flowBusiness.setOfficeCode(ot.getUsedOfficeCode());//  必填-部门编码
        flowBusiness.setFlowId(assetUsedInfo.getFlowId()); // 必填-工作流模板ID
        flowBusiness.setBillDate(new Date()); // 必填-单据日期
        flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
        //  flowBusiness.setLinkUrlApp("../billDetail/AssetUsedInfoBill.w?id="+AssetUsedInfo.getId()); // 选填-APP单据详情页链接地址
        flowBusiness.setBillAmt(null);    // 选填-单据金额
        flowBusiness.setContent(currUser.getUserName() + "提交的资产领用申请");    // 选填-业务描述
        flowBusinessService.submit(flowBusiness);
        try{
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
         //   msgContent.addButton("办理", "/a/usedinfo/assetUsedInfo/form?id=" + assetUsedInfo.getId());
            // 即时推送消息
            MsgPushUtils.push(msgContent, assetUsedInfo.getId(), BillTypeUtils.ZCJY, assetUsedInfo.getApprovalCode());
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetUsedInfo.getApprovalCode(),"您有新的待办，请及时处理！");
        }catch (Exception e){
        }
    }
    /**
     * 删除数据
     *
     * @param assetUsedInfo
     */
    @Transactional(readOnly = false)
    public void delete(AssetUsedInfo assetUsedInfo) {
        super.delete(assetUsedInfo);
    }
    /**
     * 删除删除流程日志数据
     *
     * @param assetUsedInfo
     */
    @Transactional(readOnly = false)
    public void deleteFlowLog(AssetUsedInfo assetUsedInfo) {
        dao.deleteFlowLog(assetUsedInfo);
    }
    /**
     * @param assetUsedInfo
     * @return
     * @Title:getOffice
     * @Description:获取部门信息
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年9月2日 下午3:41:52
     */
    public AssetUsedInfo getOffice(AssetUsedInfo assetUsedInfo) {
        return dao.getOffice(assetUsedInfo);
    }

    /**
     * @param assetUsedInfo
     * @return
     * @Title: getCompanyCode
     * @Description: 根据userCode查询公司编码
     */
    public String getCompanyCode(AssetUsedInfo assetUsedInfo) {
        return dao.getCompanyCode(assetUsedInfo);
    }


    @Transactional(readOnly = false)
    public void agree(AssetUsedInfo assetUsedInfo) {

        // 调用JUDP3.0 同意方法
        String isEnd = flowBusinessService.auditPass(assetUsedInfo.getFlowBusinessId(), assetUsedInfo.getApprovalMemo1(), assetUsedInfo.getNextApprovalCode());


        //更改业务表数据 TO-DO
        if ("1".equals(isEnd)) {//已经终审
            AssetUsedInfo hl = get(assetUsedInfo);
            hl.setApprovalStatus("2");
            dao.update(hl);
        } else {
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //  msgContent.addButton("办理", "/a/usedinfo/assetUsedInfo/form?id=" + assetUsedInfo.getId());
            MsgPushUtils.push(msgContent, assetUsedInfo.getId(), BillTypeUtils.ZCJY, assetUsedInfo.getNextApprovalCode());

            //app激光推送
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetUsedInfo.getNextApprovalCode(),"您有新的待办，请及时处理！");
            AssetUsedInfo hl = get(assetUsedInfo);
            hl.setApprovalStatus("1");
            dao.update(hl);
        }
    }

    @Transactional(readOnly = false)
    public void disagree(AssetUsedInfo assetUsedInfo) {
        // 调用JUDP3.0 不同意方法
        flowBusinessService.auditUnpass(assetUsedInfo.getFlowBusinessId(), assetUsedInfo.getApprovalMemo1());

        //更改业务表数据 TO-DO
        AssetUsedInfo hl = get(assetUsedInfo);
        hl.setApprovalStatus("3");
        dao.update(hl);
    }

    /**
     * @return
     * @Title: unDo
     * @Description: 撤回审批
     * @author: Mc
     * @date: 2017年10月16日 下午1:18:47
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
     * @return
     * @Title:getAll
     * @Description:查看详情
     * @date: 2016年9月14日 下午2:40:53
     */
    public List<AssetUsedInfo> getAll(AssetUsedInfo assetUsedInfo) {
        return dao.getAll(assetUsedInfo);
    }

    @Transactional(readOnly = false)
    public String unSubmit(FlowBusiness flowBusiness) {
        String msg = null;
        if (StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unSubmit(flowBusiness.getBizKey());
            if (StringUtils.isEmpty(msg)) {
                //更改业务表数据 TO-DO
                AssetUsedInfo o = new AssetUsedInfo();
                o.setId(flowBusiness.getBizKey());
                AssetUsedInfo o1 = get(o);
                o1.setApprovalStatus("0");
                dao.update(o1);
            }
        }
        return msg;
    }


}
/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.cancelstocks.service;

import java.text.SimpleDateFormat;
import java.util.*;
import cn.jpush.api.utils.StringUtils;
import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedDtlService;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
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
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnInfo;
import cn.net.ecode.modules.ass.cancelstocks.dao.AssetReturnInfoDao;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;
import cn.net.ecode.modules.ass.cancelstocks.dao.AssetReturnDtlDao;

/**
 * 资产退库Service
 *
 * @author zhaohongbin
 * @version 2018-10-08
 */
@Service
@Transactional(readOnly = true)
public class AssetReturnInfoService extends CrudService<AssetReturnInfoDao, AssetReturnInfo> {

    @Autowired
    private AssetReturnDtlDao assetReturnDtlDao;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private PushModelService pushModelService;
    @Autowired
    private AppMessageService appMessageService;
    @Autowired
    private PushService pushService;
    @Autowired
    private AssetInfoService assetInfoService;
    @Autowired
    private AssetUsedDtlService assetUsedDtlService;
    /**
     * 获取单条数据
     *
     * @param assetReturnInfo
     * @return
     */
    public AssetReturnInfo get(AssetReturnInfo assetReturnInfo) {
        AssetReturnInfo entity = super.get(assetReturnInfo);
        return entity;
    }

    /**
     * 查询列表数据
     *
     * @param assetReturnInfo
     * @return
     */
    public List<AssetReturnInfo> findList(AssetReturnInfo assetReturnInfo) {
        return super.findList(assetReturnInfo);
    }

    /**
     * 查询分页数据
     *
     * @param page            分页对象
     * @param assetReturnInfo
     * @return
     */
    public Page<AssetReturnInfo> findPage(Page<AssetReturnInfo> page, AssetReturnInfo assetReturnInfo) {
        return super.findPage(page, assetReturnInfo);
    }

    /**
     * @param assetReturnInfo
     * @return
     * @Title:getOffice
     * @Description:获取部门信息
     * @date: 2016年9月2日 下午3:41:52
     */
    public AssetReturnInfo getOffice(AssetReturnInfo assetReturnInfo) {
        return dao.getOffice(assetReturnInfo);
    }

    /**
     * 保存数据（插入或更新）
     *
     * @param assetReturnInfo
     */
    @Transactional(readOnly = false)
    public void save(AssetReturnInfo assetReturnInfo) {
        if (assetReturnInfo.getIsNewRecord()) {
            assetReturnInfo.setId(IdGen.nextId());
            assetReturnInfo.setApprovalStatus("1");
            assetReturnInfo.setIsNewRecord(true);
            super.save(assetReturnInfo);
            saveDtl(assetReturnInfo);
            submitForApproval(assetReturnInfo);
        } else {
            if (assetReturnInfo.getApprovalStatus().equals("0") || assetReturnInfo.getApprovalStatus().equals("3")) {
                //提交时就改变审核状态
                assetReturnInfo.setApprovalStatus("1");
                super.save(assetReturnInfo);
                submitForApproval(assetReturnInfo);
            }
            AssetReturnDtl assetReturnDtle=new AssetReturnDtl();
            assetReturnDtle.setReturnCode(assetReturnInfo.getId());
            assetReturnDtlDao.delete(assetReturnDtle);
            saveDtl(assetReturnInfo);
        }
    }
    //保存子表
    public void saveDtl(AssetReturnInfo assetReturnInfo) {
        for (AssetReturnDtl assetReturnDtl : assetReturnInfo.getAssetReturnDtlList()) {
            assetReturnDtl.setReturnCode(assetReturnInfo.getId());
            assetReturnDtl.preInsert();
            assetReturnDtl.setId(IdGen.nextId());
            assetReturnDtlDao.insert(assetReturnDtl);
            assetUsedDtlService.updateReturn(assetReturnDtl.getAssetCode());
        }
    }
    /**
     * 提交审批
     *
     * @param assetReturnInfo
     */
    public void submitForApproval(AssetReturnInfo assetReturnInfo) {
        User currUser = UserUtils.getUser();
        //调用JUDP3.0工作流----start ydy
        AssetReturnInfo assetReturnInfo1 = new AssetReturnInfo();
        assetReturnInfo1.setRetireCode(currUser.getRefCode());
        AssetReturnInfo ot = getOffice(assetReturnInfo1);
        FlowBusiness flowBusiness = new FlowBusiness();
        if (assetReturnInfo.getApproval() != null) {
            flowBusiness.setApprovalCode(assetReturnInfo.getApproval());    // 必填-审核人编码
        } else if (assetReturnInfo.getApprovalCode() != null) {
            flowBusiness.setApprovalCode(assetReturnInfo.getApprovalCode());    // 必填-审核人编码
        }
        flowBusiness.setLinkUrlPc("/cancelstocks/assetReturnInfo/form?id=" + assetReturnInfo.getId());// 必填-单据详情页链接地址
        flowBusiness.setBizKey(assetReturnInfo.getId()); // 必填-业务单号/id
        flowBusiness.setBilltypeCode("ZCTK"); // 必填-单据类型
        flowBusiness.setCompanyCode(ot.getReturnCompanyCode());// 必填-公司编码
        flowBusiness.setOfficeCode(ot.getReturnOfficeCode());//  必填-部门编码
        flowBusiness.setFlowId(assetReturnInfo.getFlowId()); // 必填-工作流模板ID
        flowBusiness.setBillDate(new Date()); // 必填-单据日期
        flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
        //  flowBusiness.setLinkUrlApp("../billDetail/assetReturnInfoBill.w?id="+assetReturnInfo.getId()); // 选填-APP单据详情页链接地址
        flowBusiness.setBillAmt(null);    // 选填-单据金额
        flowBusiness.setContent(currUser.getUserName() + "提交的资产退库申请");    // 选填-业务描述
        flowBusinessService.submit(flowBusiness);
        try{
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
         //   msgContent.addButton("办理", "/a/cancelstocks/assetReturnInfo/form?id=" + assetReturnInfo.getId());
            MsgPushUtils.push(msgContent, assetReturnInfo.getId(), BillTypeUtils.ZCTK, assetReturnInfo.getApprovalCode());

            //app激光推送
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetReturnInfo.getApprovalCode(),"您有新的待办，请及时处理！");
        }catch (Exception e){
        }
    }

    /**
     * 删除数据
     *
     * @param assetReturnInfo
     */
    @Transactional(readOnly = false)
    public void delete(AssetReturnInfo assetReturnInfo) {
        super.delete(assetReturnInfo);
        AssetReturnDtl assetReturnDtl = new AssetReturnDtl();
        assetReturnDtl.setReturnCode(assetReturnInfo.getId());
        assetReturnDtl.preUpdate();
        assetReturnDtlDao.delete(assetReturnDtl);
    }

    /**
     * 得到子表数据的sql
     * @param assetReturnDtl
     * @return
     */
    public List<AssetReturnDtl> findUsedCode(AssetReturnDtl assetReturnDtl) {
        return assetReturnDtlDao.findUsedCode(assetReturnDtl);
    }

    @Transactional(readOnly = false)
    public void agree(AssetReturnInfo assetReturnInfo) {
        // 调用JUDP3.0 同意方法
        String isEnd = flowBusinessService.auditPass(assetReturnInfo.getFlowBusinessId(), assetReturnInfo.getApprovalMemo1(), assetReturnInfo.getNextApprovalCode());


        //更改业务表数据 TO-DO
        if ("1".equals(isEnd)) {//已经终审
            AssetReturnInfo hl = get(assetReturnInfo);
            hl.setApprovalStatus("2");
            dao.update(hl);
            AssetReturnDtl assetReturnDtl1=new AssetReturnDtl();
            assetReturnDtl1.setReturnCode(assetReturnInfo.getId());
            List<AssetReturnDtl> assetUsedDtls = findUsedCode(assetReturnDtl1);
            for (AssetReturnDtl assetReturnDtl : assetUsedDtls) {
                AssetInfo assetInfo = new AssetInfo();
                assetInfo.setAssetCode(assetReturnDtl.getAssetCode());
                assetInfo.setAssetStatus("0");
                User user=new User();
                user.setUserCode("");
                Office office=new Office();
                office.setOfficeCode("");
                assetInfo.setOffice(office);
                assetInfo.setOfficeName("");
                assetInfo.setUser(user);
                assetInfo.setUserName("");
                assetInfo.setUseDate(null);
                assetInfoService.updatauserStatus(assetInfo);
            }

        } else {
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //msgContent.addButton("办理", "/a/cancelstocks/assetReturnInfo/form?id=" + assetReturnInfo.getId());
            MsgPushUtils.push(msgContent, assetReturnInfo.getId(), BillTypeUtils.ZCTK, assetReturnInfo.getNextApprovalCode());

            //app激光推送
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetReturnInfo.getNextApprovalCode(),"您有新的待办，请及时处理！");
            AssetReturnInfo hl = get(assetReturnInfo);
            hl.setApprovalStatus("1");
            dao.update(hl);
        }

    }

    @Transactional(readOnly = false)
    public void disagree(AssetReturnInfo assetReturnInfo) {

        //end
        // 调用JUDP3.0 不同意方法
        flowBusinessService.auditUnpass(assetReturnInfo.getFlowBusinessId(), assetReturnInfo.getApprovalMemo1());
        //更改业务表数据 TO-DO
        AssetReturnInfo hl = get(assetReturnInfo);
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
            //更改业务表数据 TO-DO
            AssetReturnInfo hl1 = new AssetReturnInfo();
            hl1.setId(flowBusiness.getBizKey());
            AssetReturnInfo hl = get(hl1);
            hl.setApprovalStatus("0");
            dao.update(hl);
        }
        return msg;
    }

    /**
     * @return
     * @Title:getAll
     * @Description:查看详情
     * @date: 2016年9月14日 下午2:40:53
     */
    public List<AssetReturnInfo> getAll(AssetReturnInfo assetReturnInfo) {
        return dao.getAll(assetReturnInfo);
    }

    @Transactional(readOnly = false)
    public String unSubmit(FlowBusiness flowBusiness) {
        String msg = null;
        if (StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unSubmit(flowBusiness.getBizKey());
            if (StringUtils.isEmpty(msg)) {
                //更改业务表数据 TO-DO
                AssetReturnInfo o = new AssetReturnInfo();
                o.setId(flowBusiness.getBizKey());
                AssetReturnInfo o1 = get(o);
                o1.setApprovalStatus("0");
                dao.update(o1);
            }
        }
        return msg;
    }
    @Transactional(readOnly = false)
    public void deleteFlowLog(AssetReturnInfo assetReturnInfo) {
        dao.deleteFlowLog(assetReturnInfo);
    }
}
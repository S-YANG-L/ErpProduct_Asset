/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.allotinfo.service;

import java.text.SimpleDateFormat;
import java.util.*;

import cn.jpush.api.utils.StringUtils;
import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.approval.entity.FlowHelp;
import cn.net.ecode.modules.ass.approval.service.FlowHelpService;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedDtlService;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedInfoService;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.msg.entity.Message;
import cn.net.ecode.modules.msg.entity.PushMessage;
import cn.net.ecode.modules.sys.dao.UserDao;
import cn.net.ecode.modules.sys.entity.Employee;
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
import cn.net.ecode.modules.ass.allotinfo.entity.AssetAllotInfo;
import cn.net.ecode.modules.ass.allotinfo.dao.AssetAllotInfoDao;
import cn.net.ecode.modules.ass.allotinfo.entity.AssetAllotDtl;
import cn.net.ecode.modules.ass.allotinfo.dao.AssetAllotDtlDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 资产调拨管理Service
 *
 * @author zhaohongbin
 * @version 2018-10-10
 */
@Service
@Transactional(readOnly = true)
public class AssetAllotInfoService extends CrudService<AssetAllotInfoDao, AssetAllotInfo> {

    @Autowired
    private AssetAllotDtlDao assetAllotDtlDao;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private PushModelService pushModelService;
    @Autowired
    private AppMessageService appMessageService;
    @Autowired
    private PushService pushService;
    @Autowired
    private AssetUsedInfoService assetUsedInfoService;
    @Autowired
    private AssetUsedDtlService assetUsedDtlService;
    @Autowired
    private CodeRuleService codeRuleService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private AssetInfoService assetInfoService;

    /**
     * 获取单条数据
     *
     * @param assetAllotInfo
     * @return
     */
    public AssetAllotInfo get(AssetAllotInfo assetAllotInfo) {
        AssetAllotInfo entity = super.get(assetAllotInfo);
        return entity;
    }

    /**
     * 查询列表数据
     *
     * @param assetAllotInfo
     * @return
     */
    public List<AssetAllotInfo> findList(AssetAllotInfo assetAllotInfo) {
        return super.findList(assetAllotInfo);
    }

    /**
     * 查询分页数据
     *
     * @param page           分页对象
     * @param assetAllotInfo
     * @return
     */
    public Page<AssetAllotInfo> findPage(Page<AssetAllotInfo> page, AssetAllotInfo assetAllotInfo) {
        return super.findPage(page, assetAllotInfo);
    }

    /**
     * 保存数据（插入或更新）
     *
     * @param assetAllotInfo
     */
    @Transactional(readOnly = false)
    public void save(AssetAllotInfo assetAllotInfo) {
        if (assetAllotInfo.getIsNewRecord()) {
            assetAllotInfo.setId(IdGen.nextId());
            assetAllotInfo.setIsNewRecord(true);
            if (assetAllotInfo.getAllotTypeCode().equals("01")) {
                assetAllotInfo.setApprovalStatus("1");
                super.save(assetAllotInfo);
                saveDtl(assetAllotInfo, "5");
                submitForApproval(assetAllotInfo);
            } else if (assetAllotInfo.getAllotTypeCode().equals("02")) {
                assetAllotInfo.setApprovalStatus("2");
                super.save(assetAllotInfo);
                saveDtl(assetAllotInfo, "7");
            } else {
                assetAllotInfo.setApprovalStatus("2");
                super.save(assetAllotInfo);
                saveDtl(assetAllotInfo, "6");
            }
        } else {
            //状态为0，3在进行提交
            if (assetAllotInfo.getApprovalStatus().equals("0") || assetAllotInfo.getApprovalStatus().equals("3")) {
                assetAllotInfo.setApprovalStatus("1");
                submitForApproval(assetAllotInfo);
                super.save(assetAllotInfo);
                AssetAllotDtl assetAllotDtl1 = new AssetAllotDtl();
                assetAllotDtl1.setAllotCode(assetAllotInfo.getId());
                assetAllotDtlDao.wulidelete(assetAllotDtl1);
                saveDtl(assetAllotInfo, "5");
            }
            if (assetAllotInfo.getStep().equals("2")) {
                //公共得到部门，公司编码名称
                Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
                Office office = new Office();
                office.setOfficeCode(common.getOfficeCode());
                //凑调拨领用主子表
                AssetUsedInfo assetUsedInfo = new AssetUsedInfo();
                assetUsedInfo.setUsedCode(codeRuleService.createCode("ZCLY", "", common.getOfficeCode(), common.getCompanyCode()));
                assetUsedInfo.setReceiverCode(assetAllotInfo.getAllotUserCode());
                assetUsedInfo.setReceiverName(assetAllotInfo.getAllotUserName());
                assetUsedInfo.setUsedOfficeCode(assetAllotInfo.getAllotOfficeCode());
                assetUsedInfo.setUsedOfficeName(assetAllotInfo.getAllotOfficeName());
                assetUsedInfo.setApprovalStatus("2");
                assetUsedInfo.setReceiverDate(new Date());
                assetUsedInfo.setNotes("调拨领用");
                List<AssetUsedDtl> list = new ArrayList<>();
                String[] assetCodes = new String[assetAllotInfo.getAssetAllotDtlList().size()];
                int j = 0;
                for (AssetAllotDtl assetAllotDtl : assetAllotInfo.getAssetAllotDtlList()) {
                    assetCodes[j] = assetAllotDtl.getAssetCode();
                    AssetInfo assetInfo = new AssetInfo();
                    assetInfo.setAssetCode(assetAllotDtl.getAssetCode());
                    assetInfo = assetInfoService.getAssetCodesql(assetInfo);
                    assetInfo.setOffice(office);
                    assetInfo.setAssetStatus("1");
                    assetInfo.setOfficeName(common.getOfficeName());
                    User user = new User();
                    user.setUserCode(assetAllotInfo.getAllotUserCode());
                    assetInfo.setUser(user);
                    assetInfo.setUserName(assetAllotInfo.getAllotUserName());
                    assetInfoService.update(assetInfo);
                    AssetUsedDtl assetUsedDtl = new AssetUsedDtl();
                    assetUsedDtl.setAssetCode(assetAllotDtl.getAssetCode());
                    assetUsedDtl.setAssetName(assetAllotDtl.getAssetName());
                    assetUsedDtl.setSortCode(assetAllotDtl.getSortCode());
                    assetUsedDtl.setSortName(assetAllotDtl.getSortName());
                    assetUsedDtl.setBrand(assetAllotDtl.getBrand());
                    assetUsedDtl.setVersion(assetAllotDtl.getVersion());
                    assetUsedDtl.setReturnStatus("0");
                    user.setUserCode(UserUtils.getUser().getUserCode());
                    assetUsedDtl.setUser(user);
                    assetUsedDtl.setUserName(UserUtils.getUser().getUserName());
                    assetUsedDtl.setStoragePlace(assetAllotDtl.getStoragePlace());
                    list.add(assetUsedDtl);
                    j++;
                }
                if (list.size() != 0) {
                    //调拨领用 改变原来领用人无法退库
                    AssetUsedDtl assetUsedDtl1 = new AssetUsedDtl();
                    assetUsedDtl1.setAssetCodes(assetCodes);
                    assetUsedDtlService.updateUserinfo(assetUsedDtl1);
                    assetUsedInfoService.save(assetUsedInfo);
                    for (AssetUsedDtl assetUsedDtl : list) {
                        assetUsedDtl.setUsedCode(assetUsedInfo.getId());
                        assetUsedDtlService.save(assetUsedDtl);
                    }
                }
            }
        }
    }


    /**
     * 保存子表
     */
    public void saveDtl(AssetAllotInfo assetAllotInfo, String assetStatus) {
        for (AssetAllotDtl assetAllotDtl : assetAllotInfo.getAssetAllotDtlList()) {
            assetAllotDtl.setChangeOffice("使用部门由'" + assetAllotInfo.getOfficeName() + "'变成了'" + assetAllotInfo.getAllotOfficeName() + "'");
            assetAllotDtl.setChangeStoragePlace("使用存放地址由'" + assetAllotDtl.getStoragePlace() + "'变成了'" + assetAllotInfo.getStoragePlace() + "'");
            assetAllotDtl.setAllotCode(assetAllotInfo.getId());
            assetAllotDtl.setAllotOfficeCode(assetAllotInfo.getAllotOfficeCode());
            assetAllotDtl.setAllotOfficeName(assetAllotInfo.getAllotOfficeName());
            assetAllotDtl.setId(IdGen.nextId());
            assetAllotDtl.preInsert();
            assetAllotDtlDao.insert(assetAllotDtl);
            //改变资产表状态
            AssetInfo assetInfo = new AssetInfo();
            assetInfo.setAssetCode(assetAllotDtl.getAssetCode());
            assetInfo = assetInfoService.getAssetCodesql(assetInfo);
            assetInfo.setAssetStatus(assetStatus);
            assetInfoService.update(assetInfo);
        }
    }

    /**
     * 删除数据
     *
     * @param assetAllotInfo
     */
    @Transactional(readOnly = false)
    public void delete(AssetAllotInfo assetAllotInfo) {
        super.delete(assetAllotInfo);
        AssetAllotDtl assetAllotDtl = new AssetAllotDtl();
        assetAllotDtl.setAllotCode(assetAllotInfo.getId());
        assetAllotDtl.preUpdate();
        assetAllotDtlDao.delete(assetAllotDtl);
    }

    public List<AssetAllotDtl> findUsedCode(AssetAllotDtl assetAllotDtl) {
        return assetAllotDtlDao.findUsedCode(assetAllotDtl);
    }


    /**
     * 提交审批
     *
     * @param assetAllotInfo
     */
    public void submitForApproval(AssetAllotInfo assetAllotInfo) {
        User currUser = UserUtils.getUser();
        //调用JUDP3.0工作流----start ydy
        Common common = commonService.getOfficeCompany(currUser.getUserCode());
        FlowBusiness flowBusiness = new FlowBusiness();
        flowBusiness.setApprovalCode(assetAllotInfo.getApprovalCode());    // 必填-审核人编码
        flowBusiness.setLinkUrlPc("/allotinfo/assetAllotInfo/form?id=" + assetAllotInfo.getId());// 必填-单据详情页链接地址
        flowBusiness.setBizKey(assetAllotInfo.getId()); // 必填-业务单号/id
        flowBusiness.setBilltypeCode("ZCDB"); // 必填-单据类型
        flowBusiness.setCompanyCode(common.getCompanyCode());// 必填-公司编码
        flowBusiness.setOfficeCode(common.getOfficeCode());//  必填-部门编码
        flowBusiness.setFlowId(assetAllotInfo.getFlowId()); // 必填-工作流模板ID
        flowBusiness.setBillDate(new Date()); // 必填-单据日期
        flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
        //  flowBusiness.setLinkUrlApp("../billDetail/assetAllotInfoBill.w?id="+assetAllotInfo.getId()); // 选填-APP单据详情页链接地址
        flowBusiness.setBillAmt(null);    // 选填-单据金额
        flowBusiness.setContent(currUser.getUserName() + "提交的资产调拨申请");    // 选填-业务描述
        flowBusinessService.submit(flowBusiness);
        //调用JUDP3.0工作流----end
        try{
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
           // msgContent.addButton("办理", "/a/allotinfo/assetAllotInfo/form?id=" + assetAllotInfo.getId()+"&pageFlag=1&stepId="+flowBusiness.getId()+"&step=1");
            MsgPushUtils.push(msgContent, assetAllotInfo.getId(), BillTypeUtils.ZCDB, assetAllotInfo.getApprovalCode());

            //app激光推送
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetAllotInfo.getApprovalCode(),"您有新的待办，请及时处理！");
        }catch (Exception e){
        }
    }

    @Transactional(readOnly = false)
    public void agree(AssetAllotInfo assetAllotInfo) {
        // 调用JUDP3.0 同意方法
        String isEnd = flowBusinessService.auditPass(assetAllotInfo.getFlowBusinessId(), assetAllotInfo.getApprovalMemo1(), assetAllotInfo.getNextApprovalCode());

        //更改业务表数据 TO-DO
        if ("1".equals(isEnd)) {//已经终审
            AssetAllotInfo hl = get(assetAllotInfo);
            hl.setApprovalStatus("2");
            dao.update(hl);
        } else {
            // PC即时推送消息
            PcMsgContent msgContent = new PcMsgContent();
            msgContent.setTitle("提示信息");
            msgContent.setContent("您有新的待办，请及时处理！");
            //msgContent.addButton("办理", "/a/allotinfo/assetAllotInfo/form?id=" + assetAllotInfo.getId()+"&pageFlag=1&stepId="+assetAllotInfo.getStepId()+"&step="+assetAllotInfo.getStep());
            MsgPushUtils.push(msgContent, assetAllotInfo.getId(), BillTypeUtils.ZCDB, assetAllotInfo.getNextApprovalCode());

            //app激光推送
            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
            jiGuangPushUtil.pushNotice("alias",assetAllotInfo.getNextApprovalCode(),"您有新的待办，请及时处理！");
            AssetAllotInfo hl = get(assetAllotInfo);
            hl.setApprovalStatus("1");
            dao.update(hl);
        }
    }

    @Transactional(readOnly = false)
    public void disagree(AssetAllotInfo assetAllotInfo) {
        // 调用JUDP3.0 不同意方法
        flowBusinessService.auditUnpass(assetAllotInfo.getFlowBusinessId(), assetAllotInfo.getApprovalMemo1());
        upDateAssetStatus(assetAllotInfo);
        //更改业务表数据 TO-DO
        AssetAllotInfo hl = get(assetAllotInfo);
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
            AssetAllotInfo hl1 = new AssetAllotInfo();
            hl1.setId(flowBusiness.getBizKey());
            AssetAllotInfo hl = get(hl1);
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
    public List<AssetAllotInfo> getAll(AssetAllotInfo assetAllotInfo) {
        return dao.getAll(assetAllotInfo);
    }

    @Transactional(readOnly = false)
    public String unSubmit(AssetAllotInfo assetAllotInfo) {
        String msg = null;
        if (StringUtils.isNotEmpty(assetAllotInfo.getBizKey())) {
            // 调用JUDP3.0 撤回方法
            msg = flowBusinessService.unSubmit(assetAllotInfo.getBizKey());
            upDateAssetStatus(assetAllotInfo);
            if (StringUtils.isEmpty(msg)) {
                //更改业务表数据 TO-DO
                AssetAllotInfo o = new AssetAllotInfo();
                o.setId(assetAllotInfo.getBizKey());
                AssetAllotInfo o1 = get(o);
                o1.setApprovalStatus("0");
                dao.update(o1);
            }
        }
        return msg;
    }


    public Page<User> findNextApprovalPage(FlowBusiness flowBusiness, String allotOfficeCode, HttpServletRequest request, HttpServletResponse response) {
        Page<User> page = flowBusinessService.findNextApprovalPage(new Page(request, response), flowBusiness);
        try {
            this.entityClass.getMethod("setPage", new Class[]{Page.class}).invoke(flowBusiness, new Object[]{page});
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        List<User> list = page.getList();
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                list.get(i).getLoginCode();
                Common common = commonService.getOfficeCompany(list.get(i).getLoginCode());
                if (allotOfficeCode.equals(common.getOfficeCode())) {
                } else {
                    list.remove(i);
                    i--;
                }
            }
        } else {
        }
        page.setList(list);
        return page;
    }

    @Transactional(readOnly = false)
    public void deleteFlowLog(AssetAllotInfo assetAllotInfo) {
        upDateAssetStatus(assetAllotInfo);
        dao.deleteFlowLog(assetAllotInfo);
    }

    /**
     *驳回改变资产状态有 调拨中到（闲置：领用）
     * @param assetAllotInfo
     */
    public void upDateAssetStatus(AssetAllotInfo assetAllotInfo){
        AssetInfo assetInfo = new AssetInfo();
        assetInfo.setAssetCodes(assetAllotInfo.getAssetCodes());
        List<AssetInfo> assetInfos = assetInfoService.findListPrint(assetInfo);
        if (assetInfos.size() != 0) {
            for (AssetInfo assetInfo1:assetInfos) {
                if(assetInfo1.getUserName()==null||assetInfo1.getUserName().equals("")){
                    assetInfo1.setAssetStatus("0");
                    assetInfoService.update(assetInfo1);
                }else{
                    assetInfo1.setAssetStatus("1");
                    assetInfoService.update(assetInfo1);
                }
            }
        }
    }

}
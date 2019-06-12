/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetcheck.service;

import java.util.ArrayList;
import java.util.List;

import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtlSM;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetClean;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.assetsclean.service.AssetCleanService;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.common.utils.JiGuangPushUtil;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.entity.content.AppMsgContent;
import cn.net.ecode.modules.sys.utils.MsgPushUtils;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheck;
import cn.net.ecode.modules.ass.assetcheck.dao.AssetCheckDao;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.assetcheck.dao.AssetCheckDtlDao;

/**
 * 资产盘点Service
 *
 * @author zhaohongbin
 * @version 2018-10-20
 */
@Service
@Transactional(readOnly = true)
public class AssetCheckService extends CrudService<AssetCheckDao, AssetCheck> {

    @Autowired
    private AssetCheckDtlDao assetCheckDtlDao;
    @Autowired
    private AssetInfoService assetInfoService;
    @Autowired
    private AssetCleanService assetCleanService;
    @Autowired
    private CodeRuleService codeRuleService;
    @Autowired
    private CommonService commonService;
    /**
     * 获取单条数据
     *
     * @param assetCheck
     * @return
     */
    public AssetCheck get(AssetCheck assetCheck) {
        AssetCheck entity = super.get(assetCheck);
        return entity;
    }

    /**
     * 查询列表数据
     *
     * @param assetCheck
     * @return
     */
    public List<AssetCheck> findList(AssetCheck assetCheck) {
        return super.findList(assetCheck);
    }

    /**
     * 查询分页数据
     *
     * @param page       分页对象
     * @param assetCheck
     * @return
     */
    public Page<AssetCheck> findPage(Page<AssetCheck> page, AssetCheck assetCheck) {
        return super.findPage(page, assetCheck);
    }

    /**
     * 保存数据（插入或更新）
     *
     * @param assetCheck
     */
    @Transactional(readOnly = false)
    public void save(AssetCheck assetCheck) {
        if(assetCheck.getIsNewRecord()){
            assetCheck.setSubmitStatus("0");
            super.save(assetCheck);
            AssetInfo assetInfo=new AssetInfo();
            assetInfo.setSortCode(assetCheck.getSortCode());
            assetInfo.setOffice(assetCheck.getOffice());
            assetInfo.setRegionCode(assetCheck.getRegionCode());
            List<AssetCheckDtl> assetCheckDtls=assetInfoService.findListCheck(assetInfo);
            if(assetCheckDtls!=null){
                for (AssetCheckDtl assetCheckDtl : assetCheckDtls) {
                    assetCheckDtl.setChackCode(assetCheck.getId());
                    if(assetCheckDtl.getUser()!=null&&assetCheckDtl.getUser().getUserCode()!=null){
                        try{
                            JiGuangPushUtil jiGuangPushUtil=new JiGuangPushUtil();
                            jiGuangPushUtil.pushNotice("alias",assetCheckDtl.getUser().getUserCode(),"您有待处理的盘点单，请及时查看！");
                        }catch (Exception e){
                        }
                    }
                    if (assetCheckDtl.getIsNewRecord()) {
                        assetCheckDtl.preInsert();
                        assetCheckDtl.setSubmitStatus("0");
                        assetCheckDtl.setAssetStatus("0");
                        assetCheckDtlDao.insert(assetCheckDtl);
                    } else {
                        assetCheckDtl.preUpdate();
                        assetCheckDtlDao.update(assetCheckDtl);
                    }
                }
            }
        }else{
            assetCheck.setSubmitStatus("1");
            super.save(assetCheck);
            AssetCheckDtl assetCheckDtl=new AssetCheckDtl();
            assetCheckDtl.setChackCode(assetCheck.getId());
            List<AssetCheckDtl> assetCheckDtls = this.findCheckCode(assetCheckDtl);
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            //生成盘亏清理
            AssetClean assetClean=new AssetClean();
            assetClean.setCleanDate(assetCheck.getHandleTime());
            assetClean.setCleanCode(codeRuleService.createCode("ZCQL","",common.getOfficeCode(),common.getCompanyCode()));
            assetClean.setCleanerCode(assetCheck.getHandleCode());
            assetClean.setCleanerName(assetCheck.getHandleName());
            assetClean.setNotes("盘亏清理");
            List<AssetCleanDtl> cleanDtlList=new ArrayList<>();
           for(AssetCheckDtl assetCheckDtl1:assetCheckDtls){
             if(assetCheckDtl1.getAssetStatus().equals("0")||assetCheckDtl1.getAssetStatus().equals("2")){
                 AssetCleanDtl assetCleanDtl=new AssetCleanDtl();
                 assetCleanDtl.setAssetCode(assetCheckDtl1.getAssetCode());
                 assetCleanDtl.setAssetName(assetCheckDtl1.getAssetName());
                 assetCleanDtl.setSortCode(assetCheckDtl1.getSortCode());
                 assetCleanDtl.setSortName(assetCheckDtl1.getSortName());
                 assetCleanDtl.setBrand(assetCheckDtl1.getBrand());
                 assetCleanDtl.setVersion(assetCheckDtl1.getVersion());
                 assetCleanDtl.setStoragePlace(assetCheckDtl1.getStoragePlace());
                 cleanDtlList.add(assetCleanDtl);
             }
             //修改子表
               assetCheckDtl1.setSubmitStatus("1");
               if(assetCheckDtl1.getAssetStatus().equals("0")){
                   assetCheckDtl1.setAssetStatus("2");
               }
               assetCheckDtl1.preUpdate();
               assetCheckDtlDao.update(assetCheckDtl1);
           }
           //子表有数据在清除
           if(cleanDtlList==null||cleanDtlList.size()==0){
           }else{
               assetClean.setAssetCleanDtlList(cleanDtlList);
               assetCleanService.save(assetClean);
           }
            //修改盘点子表已提交状态
            assetCheckDtlDao.updateSubmitStatus(assetCheck.getId());

        }

    }

    /**
     * 删除数据
     *
     * @param assetCheck
     */
    @Transactional(readOnly = false)
    public void delete(AssetCheck assetCheck) {
        super.delete(assetCheck);
        AssetCheckDtl assetCheckDtl = new AssetCheckDtl();
        assetCheckDtl.setChackCode(assetCheck.getId());
        assetCheckDtl.preUpdate();
        assetCheckDtlDao.delete(assetCheckDtl);
    }


    public List<AssetCheckDtl> findCheckCode(AssetCheckDtl assetCheckDtl) {
        return assetCheckDtlDao.findCheckCode(assetCheckDtl);
    }

    public void updateCheckStatus(AssetCheckDtl assetCheckDtl) {
         assetCheckDtlDao.updateCheckStatus(assetCheckDtl);
    }

// * App端查询自己的待盘资产
    public List<AssetCheckDtl> undeterminedAssetCheck(String userCode) {
        return assetCheckDtlDao.undeterminedAssetCheck(userCode);
    }
    // * App端查询自己的待盘资产分类用
    public List<AssetCheckDtl> undeterminedAssetCheckFen(AssetCheckDtl assetCheckDtl) {
        return assetCheckDtlDao.undeterminedAssetCheckFen(assetCheckDtl);
    }
    @Transactional(readOnly = false)
    public void updateAssetCheckDtLosses(AssetCheckDtl assetCheckDtl) {
         assetCheckDtlDao.updateAssetCheckDtLosses(assetCheckDtl);
    }

    public List<AssetCheckDtlSM> findCheckCodeSM(AssetCheckDtlSM AssetCheckDtlSM) {
      return assetCheckDtlDao.findCheckCodeSM(AssetCheckDtlSM);
    }
    @Transactional(readOnly = false)
    public void updateCheckCodeSM(AssetCheckDtlSM assetCheckDtlSM) {
        assetCheckDtlDao.updateCheckCodeSM(assetCheckDtlSM);
    }
}
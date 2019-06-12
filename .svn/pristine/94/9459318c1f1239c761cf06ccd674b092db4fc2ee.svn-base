/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.ascheck.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.inout.dao.InoutBillDao;
import cn.net.ecode.modules.ass.inout.dao.InoutBillsDao;
import cn.net.ecode.modules.ass.inout.entity.InoutBill;
import cn.net.ecode.modules.ass.inout.entity.InoutBills;
import cn.net.ecode.modules.ass.inout.service.InoutBillService;
import cn.net.ecode.modules.ass.outbound.dao.OutboundBillDao;
import cn.net.ecode.modules.ass.outbound.dao.OutboundBillDtlDao;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.outbound.service.OutboundBillService;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;
import cn.net.ecode.modules.sys.utils.UserUtils;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.ascheck.entity.AsCheck;
import cn.net.ecode.modules.ass.ascheck.dao.AsCheckDao;
import cn.net.ecode.modules.ass.ascheck.entity.AsCheckDtl;
import cn.net.ecode.modules.ass.ascheck.dao.AsCheckDtlDao;

/**
 * 办公用品盘点Service
 *
 * @author zhaohongbin
 * @version 2018-10-17
 */
@Service
@Transactional(readOnly = true)
public class AsCheckService extends CrudService<AsCheckDao, AsCheck> {

    @Autowired
    private AsCheckDtlDao asCheckDtlDao;
    @Autowired
    private InoutBillDao inoutBillDao;
    @Autowired
    private InoutBillsDao inoutBillsDao;
    @Autowired
    private OutboundBillDao outboundBillDao;
    @Autowired
    private OutboundBillDtlDao outboundBillDtlDao;
    @Autowired
    private CommonService commonService;
    @Autowired
    private WarehouseItemsService warehouseItemsService;
    @Autowired
    private CodeRuleService codeRuleService;
    List<InoutBills> inoutBillsList;
    List<OutboundBillDtl> outboundBillList ;

    /**
     * 获取单条数据
     *
     * @param asCheck
     * @return
     */
    public AsCheck get(AsCheck asCheck) {
        return super.get(asCheck);
    }

    /**
     * 查询列表数据
     *
     * @param asCheck
     * @return
     */
    public List<AsCheck> findList(AsCheck asCheck) {
        return super.findList(asCheck);
    }

    /**
     * 查询分页数据
     *
     * @param page    分页对象
     * @param asCheck
     * @return
     */
    public Page<AsCheck> findPage(Page<AsCheck> page, AsCheck asCheck) {
        return super.findPage(page, asCheck);
    }

    /**
     * 保存数据（插入或更新）
     *
     * @param asCheck
     */
    @Transactional(readOnly = false)
    public void save(AsCheck asCheck) {
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        if (asCheck.getIsNewRecord()) {
            super.save(asCheck);
            saveDtl(asCheck, common);
            createyingIn(asCheck, common);
            createyingOut(asCheck, common);
        } else {

        }
    }

    /**
     * 保存子表数据
     *
     * @param asCheck
     * @return
     */
    public void saveDtl(AsCheck asCheck, Common common) {
        inoutBillsList = new ArrayList<>();
        outboundBillList = new ArrayList<>();
        for (AsCheckDtl asCheckDtl : asCheck.getAsCheckDtlList()) {
            asCheckDtl.setCheckCode(asCheck.getId());
            asCheckDtl.preInsert();
            asCheckDtl.setSumMoney(asCheckDtl.getCheckQty()*asCheckDtl.getPrice());
            asCheckDtlDao.insert(asCheckDtl);
            if (asCheckDtl.getCheckQty() > asCheckDtl.getQty()) {
            	//盘盈入库
                InoutBills inoutBills = new InoutBills();
                inoutBills.setGrantNo("3");
                inoutBills.setVersion(asCheckDtl.getVersion());
                inoutBills.setBrand(asCheckDtl.getBrand());
                inoutBills.setArticleCode(asCheckDtl.getArticlesCode());
                inoutBills.setArticlesName(asCheckDtl.getArticlesName());
                inoutBills.setSortCode(asCheckDtl.getSortCode());
                inoutBills.setSortName(asCheckDtl.getSortName());
                inoutBills.setInInitialQty(Double.valueOf(asCheckDtl.getQty()));
                inoutBills.setInInitialPrice(Double.valueOf(asCheckDtl.getPrice()));
                inoutBills.setInInitialMoney(asCheckDtl.getQty()*asCheckDtl.getPrice());
                inoutBills.setQty(asCheckDtl.getCheckQty()-asCheckDtl.getQty());
                inoutBills.setPrice(asCheckDtl.getPrice());
                inoutBills.setSumMoney(asCheckDtl.getPrice()*inoutBills.getQty());
                inoutBillsList.add(inoutBills);
            } else if (asCheckDtl.getCheckQty() < asCheckDtl.getQty()) {
                //盘亏出库
                OutboundBillDtl outboundBillDtl = new OutboundBillDtl();
                outboundBillDtl.setVersion(asCheckDtl.getVersion());
                outboundBillDtl.setBrand(asCheckDtl.getBrand());
                outboundBillDtl.setArticlesCode(asCheckDtl.getArticlesCode());
                outboundBillDtl.setArticlesName(asCheckDtl.getArticlesName());
                outboundBillDtl.setSortCode(asCheckDtl.getSortCode());
                outboundBillDtl.setSortName(asCheckDtl.getSortName());
                outboundBillDtl.setWhCode(asCheck.getWhCode());
                outboundBillDtl.setWhName(asCheck.getWhName());
                outboundBillDtl.setOutInitialQty(Double.valueOf(asCheckDtl.getQty()));
                outboundBillDtl.setOutInitialPrice(Double.valueOf(asCheckDtl.getPrice()));
                outboundBillDtl.setOutInitialMoney(asCheckDtl.getQty()*asCheckDtl.getPrice());
                outboundBillDtl.setQty(asCheckDtl.getQty());
                outboundBillDtl.setOrderDate(new Date());
                outboundBillDtl.setPrice(asCheckDtl.getPrice());
                outboundBillDtl.setOutboundNumber(asCheckDtl.getQty()-asCheckDtl.getCheckQty());
                outboundBillDtl.setSumMoney(asCheckDtl.getPrice()*outboundBillDtl.getOutboundNumber());
                outboundBillList.add(outboundBillDtl);
            }
            warehouseOutin(asCheckDtl);
        }
    }

    /**
     * 仓库数据变化
     */
    public void warehouseOutin(AsCheckDtl asCheckDtl) {
        WarehouseItems warehouseItemsIs=new WarehouseItems();
        warehouseItemsIs.setWhCode(asCheckDtl.getWhCode());
        warehouseItemsIs.setArticlesCode(asCheckDtl.getArticlesCode());
        WarehouseItems warehouseItemsReturn= warehouseItemsService.getQty(warehouseItemsIs);
        if(warehouseItemsReturn!=null){
            warehouseItemsReturn.setQty(asCheckDtl.getCheckQty());
            warehouseItemsReturn.setSumMoney(asCheckDtl.getSumMoney());
            warehouseItemsService.update(warehouseItemsReturn);
        }
    }
    /**
     * 生成盘盈入库单
     *
     * @param asCheck
     * @return
     */
    public void createyingIn(AsCheck asCheck, Common common) {
        if (inoutBillsList != null && inoutBillsList.size() != 0) {
            InoutBill inoutBill = new InoutBill();
            inoutBill.setBillCode(codeRuleService.createBgCode("BGRK","办公用品入库"));
            inoutBill.setCompanyCode(common.getCompanyCode());
            inoutBill.setCompanyName(common.getCompanyName());
            inoutBill.setDeptCode(common.getOfficeCode());
            inoutBill.setDeptName(common.getOfficeName());
            inoutBill.setOrderDate(new Date());
            inoutBill.setWhCode(asCheck.getWhCode());
            inoutBill.setWhName(asCheck.getWhName());
            inoutBill.setPsnCode(UserUtils.getUser().getUserCode());
            inoutBill.setPsnName(UserUtils.getUser().getUserName());
            inoutBill.setMemo("盘盈入库");
            inoutBill.preInsert();
            inoutBillDao.insert(inoutBill);
            for (InoutBills inoutBills : inoutBillsList) {
                inoutBills.setSysCode(inoutBill.getSysCode());
                inoutBills.preInsert();
                inoutBillsDao.insert(inoutBills);
            }
        }

    }

    /**
     * 生成盘亏出库单
     * @param asCheck
     * @return
     */
    public void createyingOut(AsCheck asCheck, Common common) {
        if (outboundBillList != null && outboundBillList.size() != 0) {
            OutboundBill outboundBill = new OutboundBill();
            outboundBill.setOutboundCode(codeRuleService.createBgCode("BGLY","办公用品领用"));
            outboundBill.setCompanyCode(common.getCompanyCode());
            outboundBill.setCompanyName(common.getCompanyName());
            outboundBill.setOfficeCode(common.getOfficeCode());
            outboundBill.setOfficeName(common.getOfficeName());
            outboundBill.setOutboundDate(new Date());
            outboundBill.setWhCode(asCheck.getWhCode());
            outboundBill.setWhName(asCheck.getWhName());
            outboundBill.setOutbounderCode(UserUtils.getUser().getUserCode());
            outboundBill.setOutbounderName(UserUtils.getUser().getUserName());
            outboundBill.setMemo("盘亏出库");
            outboundBill.setApprovalStatus("2");
            outboundBill.preInsert();
            outboundBillDao.insert(outboundBill);
            for (OutboundBillDtl outboundBillDtl : outboundBillList) {
                outboundBillDtl.setSysCode(outboundBill.getSysCode());
                outboundBillDtl.preInsert();
                outboundBillDtlDao.insert(outboundBillDtl);
            }
        }
    }


    /**
     * 删除数据
     *
     * @param asCheck
     */
    @Transactional(readOnly = false)
    public void delete(AsCheck asCheck) {
        super.delete(asCheck);
        AsCheckDtl asCheckDtl = new AsCheckDtl();
        asCheckDtl.setCheckCode(asCheck.getCheckCode());
        asCheckDtl.preUpdate();
        asCheckDtlDao.delete(asCheckDtl);
    }

    /**
     * 得到子表数据
     *
     * @param asCheckDtl
     * @return
     */
    public List<AsCheckDtl> findCheckCode(AsCheckDtl asCheckDtl) {
        return asCheckDtlDao.findCheckCode(asCheckDtl);
    }
}
/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.inout.service;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.inout.dao.InoutBillDao;
import cn.net.ecode.modules.ass.inout.dao.InoutBillsDao;
import cn.net.ecode.modules.ass.inout.entity.InoutBill;
import cn.net.ecode.modules.ass.inout.entity.InoutBills;
import cn.net.ecode.modules.ass.orderbill.service.OrderBillService;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;
import com.alibaba.fastjson.JSONArray;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;


/**
 * 入库主表Service
 * @version 2015-11-24
 */
@Service
@Transactional(readOnly = true)
public class InoutBillService extends CrudService<InoutBillDao, InoutBill> {
    @Autowired
    private InoutBillsDao inoutBillsDao;
    @Autowired
    private WarehouseItemsService warehouseItemsService;
    @Autowired
    private OrderBillService orderBillService;
    /**
     * 获取单条数据
     *
     * @param inoutBill
     * @return
     */
    public InoutBill get(InoutBill inoutBill) {
        return super.get(inoutBill);
    }

    /**
     * 查询列表数据
     *
     * @param inoutBill
     * @return
     */
    public List<InoutBill> findList(InoutBill inoutBill) {
        return super.findList(inoutBill);
    }


    /**
     * 查询分页数据
     * @param page 分页对象1
     * @param inoutBill
     * @return
     */

    /**
     * @param inoutBills
     * @return
     * @description 查询采购入库子表
     */
    public List<InoutBills> findList(InoutBills inoutBills) {
        return inoutBillsDao.findList(inoutBills);
    }

    public Page<InoutBill> findPage(Page<InoutBill> page, InoutBill inoutBill) {
        return super.findPage(page, inoutBill);
    }


    /**
     * 查询子表数据
     *
     * @param inoutBills
     * @return
     */
    public List<InoutBills> findInoutBillsDtl(InoutBills inoutBills) {
        return inoutBillsDao.findInoutBillsDtl(inoutBills);
    }



    /**
     * 保存数据（插入或更新）
     *
     * @param inoutBill
     */
    @Transactional(readOnly = false)
    public void save(InoutBill inoutBill) {
        super.save(inoutBill);
    }



    /**
     * 删除数据
     *
     * @param inoutBill
     */
    @Transactional(readOnly = false)
    public void delete(InoutBill inoutBill) {
        super.delete(inoutBill);
    }

    /**
     * @param inoutBill
     * @Title: saveOrderBill
     * @Description: 主子表保存
     */
    @Transactional(readOnly = false)
    public void saveInoutBill(InoutBill inoutBill) {
        inoutBill.setSysCode(IdGen.nextId());
        inoutBill.setMemo("标准入库");
        inoutBill.preInsert();
        super.save(inoutBill);
        //3.保存子表信息
        if(inoutBill.getInoutBillsListOrderbill()==null){
        }else{
            for (InoutBills inoutBills : inoutBill.getInoutBillsListOrderbill()) {
                inoutBills.setGrantNo("1");
                orderBillService.updateOrderStatus(inoutBills.getSysCode());
                saveDtl(inoutBill, inoutBills);
                saveWarehouseItems(inoutBill,inoutBills);
            }
        }
        if(inoutBill.getInoutBillsListArticles()==null){
        }else{
            for (InoutBills inoutBills : inoutBill.getInoutBillsListArticles()) {
                inoutBills.setGrantNo("2");
                saveDtl(inoutBill, inoutBills);
                saveWarehouseItems(inoutBill,inoutBills);
            }
        }
    }

    /**
     * 保存子表
     *
     * @param inoutBills
     */
    public void saveDtl(InoutBill inoutBill, InoutBills inoutBills) {
//        String sysCode=request.getParameter("sysCode");
        WarehouseItems warehouseItemsIs=new WarehouseItems();
        warehouseItemsIs.setWhCode(inoutBill.getWhCode());
        warehouseItemsIs.setArticlesCode(inoutBills.getArticleCode());
        WarehouseItems warehouseItemsReturn= warehouseItemsService.getQty(warehouseItemsIs);
        if(warehouseItemsReturn==null){
            inoutBills.setSysId(IdGen.nextId());
            inoutBills.setSysCode(inoutBill.getSysCode());
            if (inoutBills.getPrice() == null) {
                inoutBills.setPrice(0.0);
                inoutBills.setSumMoney(inoutBills.getQty()*inoutBills.getPrice());
            }
            inoutBills.setSumMoney((inoutBills.getQty()*inoutBills.getPrice()));
            inoutBills.setRelaSerialno(String.valueOf(inoutBills.getSerialNo()));
          	inoutBills.setInInitialQty(0.0);
        	inoutBills.setInInitialPrice(0.0);
        	inoutBills.setInInitialMoney(0.0);
            inoutBills.preInsert();
            inoutBillsDao.insert(inoutBills);
        }else{
            inoutBills.setSysId(IdGen.nextId());
            inoutBills.setSysCode(inoutBill.getSysCode());
            if (inoutBills.getPrice() == null) {
                inoutBills.setPrice(0.0);
                inoutBills.setSumMoney(inoutBills.getQty()*inoutBills.getPrice());
            }
            inoutBills.setSumMoney((inoutBills.getQty()*inoutBills.getPrice()));
            inoutBills.setRelaSerialno(String.valueOf(inoutBills.getSerialNo()));
          	inoutBills.setInInitialQty(warehouseItemsReturn.getQty());
        	inoutBills.setInInitialPrice(warehouseItemsReturn.getPrice());
        	inoutBills.setInInitialMoney(warehouseItemsReturn.getSumMoney());
            inoutBills.preInsert();
            inoutBillsDao.insert(inoutBills);
        }
        
    
    }

    /**
     * 保存到仓库
     *
     * @param inoutBills
     */
    public void saveWarehouseItems(InoutBill inoutBill,InoutBills inoutBills) {
        WarehouseItems warehouseItemsIs=new WarehouseItems();
        warehouseItemsIs.setWhCode(inoutBill.getWhCode());
        warehouseItemsIs.setArticlesCode(inoutBills.getArticleCode());
        WarehouseItems warehouseItemsReturn= warehouseItemsService.getQty(warehouseItemsIs);
        if(warehouseItemsReturn==null){
            WarehouseItems warehouseItems =setWarehouseItems(inoutBill,inoutBills);
            warehouseItems.setQty(inoutBills.getQty());
            warehouseItems.setPrice(inoutBills.getPrice());
            warehouseItems.setSumMoney(inoutBills.getQty()*inoutBills.getPrice());
            warehouseItemsService.save(warehouseItems);
        }else{
            WarehouseItems warehouseItems =setWarehouseItems(inoutBill,inoutBills);
            warehouseItems.setId(warehouseItemsReturn.getId());
            Double sumMoney = Double.valueOf(warehouseItemsReturn.getSumMoney()+inoutBills.getSumMoney());
            Double qty=warehouseItemsReturn.getQty()+inoutBills.getQty();
            Double price=sumMoney/qty;
            warehouseItems.setPrice(price);
            warehouseItems.setQty(qty);
            warehouseItems.setSumMoney(sumMoney);
            warehouseItemsService.update(warehouseItems);
        }
    }

    /**
     * 设置子表数据
     * @param inoutBill
     * @param inoutBills
     */
    public WarehouseItems setWarehouseItems(InoutBill inoutBill,InoutBills inoutBills) {
        WarehouseItems warehouseItems = new WarehouseItems();
        warehouseItems.setArticlesName(inoutBills.getArticlesName());
        warehouseItems.setArticlesCode(inoutBills.getArticleCode());
        warehouseItems.setWhCode(inoutBill.getWhCode());
        warehouseItems.setWhName(inoutBill.getWhName());
        warehouseItems.setQty(inoutBills.getQty());
        warehouseItems.setSortCode(inoutBills.getSortCode());
        warehouseItems.setSortName(inoutBills.getSortName());
        warehouseItems.setVersion(inoutBills.getVersion());
        warehouseItems.setPrice(inoutBills.getPrice());
        warehouseItems.setBrand(inoutBills.getBrand());
        warehouseItems.setUnit(inoutBills.getUnit());
        return warehouseItems;
    }

}
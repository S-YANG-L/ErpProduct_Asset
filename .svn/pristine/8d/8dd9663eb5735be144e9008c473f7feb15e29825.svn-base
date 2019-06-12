
package cn.net.ecode.modules.ass.inout.web;

import cn.net.ecode.common.config.Global;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnInfo;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.inout.entity.InoutBill;
import cn.net.ecode.modules.ass.inout.entity.InoutBills;
import cn.net.ecode.modules.ass.inout.service.InoutBillService;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBill;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBills;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;
import cn.net.ecode.modules.sys.utils.UserUtils;

import com.alibaba.fastjson.JSONArray;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *
 * @author tiange
 * @date 2018/10/14 23:10
 * @param
 * @return
 */
@Controller
@RequestMapping(value = "${adminPath}/scm/inout/inoutBill")
public class InoutBillController extends BaseController {

    @Autowired
    private InoutBillService inoutBillService;
    @Autowired
    private WarehouseInfoService warehouseInfoService;
    @Autowired
    private CodeRuleService codeRuleService;
    /**
     * 获取数据
     */
    @ModelAttribute
    public InoutBill get(String sysCode, boolean isNewRecord) {
        return inoutBillService.get(sysCode, isNewRecord);
    }

    /**
     * @return
     * @Title: materialStorageForm
     * @Description: 采购物资入库单界面
     * @date: 2018年1月18日 下午2:58:55
     */
    @RequiresPermissions("inout:inoutBill:edit")
    @RequestMapping(value = "materialStorageForm")
    public String materialStorageForm(InoutBill inoutBill, Model model) {
        if (StringUtils.isNotBlank(inoutBill.getSysCode())) {
            model.addAttribute("sysCode", inoutBill.getSysCode());
        }
        if (inoutBill.getIsNewRecord()) {
            inoutBill.setOrderDate(new Date());
            inoutBill.setPsnCode(UserUtils.getUser().getUserCode());
            inoutBill.setPsnName(UserUtils.getUser().getUserName());
        } else {
            inoutBill.setOrderDate(inoutBill.getOrderDate());
            inoutBill.setPsnCode(inoutBill.getPsnCode());
            inoutBill.setPsnName(inoutBill.getPsnName());
        }

        //得到仓库名称
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);

        model.addAttribute("inoutBill", inoutBill);
        return "ecode/asset/base/inout/materialStorageForm";
    }
    /**
     * @return
     * @Title: materialStorageForm
     * @Description: 盘盈入库单查看编辑
     * @date: 2018年1月18日 下午2:58:55
     */
    @RequiresPermissions("inout:inoutBill:edit")
    @RequestMapping(value = "materialStorageCheckForm")
    public String materialStorageCheckForm(InoutBill inoutBill, Model model) {
        if (StringUtils.isNotBlank(inoutBill.getSysCode())) {
            model.addAttribute("billCode", inoutBill.getSysCode());
        }
        //得到仓库名称
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);
        model.addAttribute("inoutBill", inoutBill);
        return "ecode/asset/base/inout/materialStorageCheckForm";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("inout:inoutBill:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<InoutBill> listData(InoutBill inoutBill) {
        Page<InoutBill> page = inoutBillService.findPage(inoutBill);
        return page;
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("inout:inoutBill:view")
    @RequestMapping(value = {"materialInoutList", ""})
    public String list(InoutBill inoutBill, Model model) {
        inoutBill.setMemo("标准入库");
        model.addAttribute("inoutBill", inoutBill);
        return "ecode/asset/base/inout/materialInoutList";
    }
    /**
     * 查询列表
     */
    @RequiresPermissions("inout:inoutBill:view")
    @RequestMapping(value = {"materialInoutListIn", ""})
    public String materialInoutListIn(InoutBill inoutBill, Model model) {
        inoutBill.setMemo("盘盈入库");
        model.addAttribute("inoutBill", inoutBill);
        return "ecode/asset/base/inout/materialInoutCheckList";
    }
    /**
     * 删除数据
     */
    @RequiresPermissions("inout:inoutBill:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(InoutBill inoutBill) {
        inoutBillService.delete(inoutBill);
        return renderResult(Global.TRUE, "删除出入库表成功！");
    }

    /**
     * @return
     * @Title: materialStorageSave
     * @Description: 入库单保存
     * @date: 2018年1月18日 下午2:59:11
     */
    @RequiresPermissions("inout:inoutBill:edit")
    @ResponseBody
    @RequestMapping(value = "materialStorageSave")
    public String materialStorageSave(InoutBill inoutBill) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, inoutBill)) {
            return renderResult(Global.FALSE, message);
        }
        //生成办公用品编码
        if (inoutBill.getIsNewRecord()) {
            inoutBill.setBillCode(codeRuleService.createBgCode("BGRK","办公用品入库"));
        }
        inoutBillService.saveInoutBill(inoutBill);
        return renderResult(Global.TRUE, "入库成功！");

    }

    /**
     * 查询子表数据
     *
     * @param inoutBills
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "InoutBillsDtl")
    public List<InoutBills> InoutBillsDtl(InoutBills inoutBills) {
        List<InoutBills> page = inoutBillService.findInoutBillsDtl(inoutBills);
        return page;
    }
    /**@author tiange
     * APP端保存保存办公用品入库
     * @param inoutBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
	@RequestMapping(value = "materialStorageSaveAPP")
	public Map<String, Object> materialStorageSaveAPP(InoutBill inoutBill, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
	        //生成办公用品编码:RK+当前年月日+6位流水号
	        if (inoutBill.getIsNewRecord()) {
	            String rkCode ="RK";
	            SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMMdd");
	            rkCode = rkCode + codeDate.format(new Date());
	            Random random = new Random();
	            for(int i=0;i<6;i++){
	                rkCode+=random.nextInt(10);
	            }
	            inoutBill.setBillCode(rkCode);
	        }
            List<InoutBills> inoutBillso = JSONArray.parseArray(inoutBill.getInoutBillsList(), InoutBills.class);
            inoutBill.setInoutBillsListArticles(inoutBillso);
            List<InoutBills> inoutOrderbillso = JSONArray.parseArray(inoutBill.getInoutOrderbillsList(), InoutBills.class);
            inoutBill.setInoutBillsListOrderbill(inoutOrderbillso);
	        inoutBillService.saveInoutBill(inoutBill);
			result.put("code", "200");
			result.put("message", "success");

		} catch (Exception e) {// 如果失败 result存这个
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
    
    /**
     * APP端办公用品入库列表
     * @author tiange
     * @param inoutBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getInoutBillList")
    public Map<String, Object> getInoutBillList(InoutBill inoutBill,HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            Page<InoutBill> page = inoutBillService.findPage(new Page<InoutBill>(request, response),inoutBill);
            result.put("page", page);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * APP端办公用品入库编辑
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getInoutBillApp")
    public  Map<String, Object> getInoutBillApp(String sysCode){
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", inoutBillService.get(sysCode));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    
    /**
     * APP端办公用品采入库得到子表数据
     * @param inoutBills
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDtlDataAPP")
    public Map<String, Object>  getDtlDataAPP(InoutBills inoutBills) {

        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功

            result.put("page", inoutBillService.findInoutBillsDtl(inoutBills));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    
}
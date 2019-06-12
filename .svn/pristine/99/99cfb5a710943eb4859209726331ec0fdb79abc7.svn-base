/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.dao.CommonDao;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBills;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBill;
import cn.net.ecode.modules.ass.orderbill.service.OrderBillService;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 物资采购Controller
 * @author zhaohongbin
 * @version 2018-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/orderbill/orderBill")
public class OrderBillController extends BaseController {
	@Autowired
	private OrderBillService orderBillService;
	@Autowired
	private CodeRuleService codeRuleService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private FlowBusinessService flowBusinessService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public OrderBill get(String sysCode, boolean isNewRecord) {
		return orderBillService.get(sysCode, isNewRecord);
	}
	/**
	 * 查询列表
	 */
	@RequiresPermissions("orderbill:orderBill:view")
	@RequestMapping(value = {"list", ""})
	public String list(OrderBill orderBill, Model model) {
		model.addAttribute("orderBill", orderBill);
		return "ecode/asset/base/orderbill/orderBillList";
	}
    /**
     * 查询列表
     */
    @RequestMapping(value = {"assetOrderBillsList"})
    public String assetOrderBillsList(OrderBill orderBill, Model model) {
        model.addAttribute("orderBill", orderBill);
        return "ecode/asset/base/inout/assetOrderBillsList";
    }

	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("orderbill:orderBill:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<OrderBill> listData(OrderBill orderBill, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OrderBill> page = orderBillService.findPage(new Page<OrderBill>(request, response), orderBill); 
		return page;
	}
    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlData")
    public List<OrderBill> getDtlData(OrderBills orderBills) {
        List<OrderBill> orderBillList = orderBillService.findUsedCode(orderBills);
        return orderBillList;
    }
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("orderbill:orderBill:view")
	@RequestMapping(value = "form")
	public String form(OrderBill orderBill, Model model) {
        if (StringUtils.isNotBlank(orderBill.getId())) {
            model.addAttribute("sysCode", orderBill.getId());
        }
        if (orderBill.getIsNewRecord() == true) {
            orderBill.setBuyerCode(UserUtils.getUser().getUserCode());
            orderBill.setBuyerName(UserUtils.getUser().getUserName());
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            Office office=new Office();
            office.setOfficeCode(common.getCompanyCode());
            orderBill.setOffice(office);
            orderBill.setOfficeName(common.getOfficeName());
            orderBill.setCompanyCode(common.getCompanyCode());
            orderBill.setCompanyName(common.getCompanyName());
            orderBill.setOrderDate(new Date());
        } else {
            orderBill.setBuyerCode(orderBill.getBuyerName());
            orderBill.setBtypeCode(orderBill.getBtypeCode());
            orderBill.setOrderDate(orderBill.getOrderDate());
        }
		model.addAttribute("orderBill", orderBill);
		return "ecode/asset/base/orderbill/orderBillForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("orderbill:orderBill:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(OrderBill orderBill) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, orderBill)){
			return renderResult(Global.FALSE, message);
		}
        //生成办公用品编码
        if (orderBill.getIsNewRecord()) {
            orderBill.setCgCode(codeRuleService.createBgCode("BGCG","办公用品采购"));
        }
		orderBillService.save(orderBill);
        if(orderBill.getStep().equals("")){
            return renderResult(Global.TRUE, "提交申请成功！");
        }else if(orderBill.getStep().equals("1")){
            return renderResult(Global.TRUE, "审批通过！");
        }else{
            return renderResult(Global.TRUE, "采购成功！");
        }
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("orderbill:orderBill:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(OrderBill orderBill) {
        if(orderBill.getInoutStatus().equals("0")){
            orderBillService.delete(orderBill);
            return renderResult(Global.TRUE, "删除物资采购成功！");
        }else{
            return renderResult(Global.FALSE, "已经入库不能删除！");
        }
	}
    /**
     * @Title: undo
     * @Description: 撤回申请
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "unSubmit",method = RequestMethod.POST)
    public Map<String , Object> unSubmit(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        String msg = null;
        try {
            msg = orderBillService.unSubmit(flowBusiness);
            if(org.apache.commons.lang3.StringUtils.isEmpty(msg)){//如果msg信息为空
                result.put("true", "单据撤回成功！");
                result.put("code", "200");
                result.put("message", "success");
            }else{
                if(msg.equals("当前单据未提交或已撤回")){
                    result.put("true", "单据撤回成功！");
                    result.put("code", "200");
                    result.put("message", "success");
                }else{
                    result.put("false", msg);
                    result.put("code", "201");
                    result.put("message", "fail");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }


    /**
     * @Title: unDo
     * @Description: 撤回审批
     * @author: 陈玉春
     * @date: 2018年1月14日 下午5:25:28
     */

    @RequiresPermissions("purchase:orderBill:edit")
    @ResponseBody
    @RequestMapping(value = "unDo")
    public String unDo(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        String msg = orderBillService.unDo(flowBusiness);
        // 如果msg信息为空
        if(StringUtils.isBlank(msg)){
            return renderResult("true", "撤回申请成功！");
        }else{
            return renderResult("false", msg);
        }
    }
    /**
     * @Title: getNextFlowBusiness
     * @Description: 判断工作流是否为最后一步
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getNextFlowBusiness")
    public Integer getNextFlowBusiness(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response) {
        FlowBusiness nextFlowBusiness;
        nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
        if(nextFlowBusiness!=null){
            return 1;  //不是最后一步
        }
        else{
            return 0;  //是最后一步
        }
    }


    /**
     * @Description:审批通过PC
     * @param orderBill
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("orderbill:orderBill:edit")
    @ResponseBody
    @RequestMapping(value = "agreePC")
    public String agreePC(OrderBill orderBill,HttpServletRequest request, HttpServletResponse response) {
        try {
            String isEnd=request.getParameter("isEnd");
            String sysCode=request.getParameter("sysCode");
            orderBill.setIsEnd(Integer.parseInt(isEnd));
            orderBill.setId(sysCode);
            orderBillService.agree(orderBill);
            return renderResult(Global.TRUE, "审批通过！");
        } catch (Exception e) {
            e.printStackTrace();
            return renderResult(Global.TRUE, "出现问题！");
        }

    }

    /**
     * 驳回申请
     * @param orderBill
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("orderbill:orderBill:edit")
    @ResponseBody
    @RequestMapping(value = "disagreePC")
    public String disagreePC(OrderBill orderBill,HttpServletRequest request, HttpServletResponse response){
        try {
            String sysCode=request.getParameter("sysCode");
            orderBill.setId(sysCode);
            orderBillService.disagree(orderBill);
            return renderResult(Global.TRUE, "已驳回！");
        } catch (Exception e) {
            return renderResult(Global.TRUE, "出现问题！");
        }
    }
    
    /**
     * APP端保存保存办公用品采购
     * @author tiange
     * @param orderBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
	@RequestMapping(value = "saveAPP")
	public Map<String, Object> saveAPP(OrderBill orderBill, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (orderBill.getIsNewRecord()) {
	            String cgCode ="CG";
	            SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMMdd");
	            cgCode = cgCode + codeDate.format(new Date());
	            Random random = new Random();
	            for(int i=0;i<6;i++){
	                cgCode+=random.nextInt(10);
	            }
	            orderBill.setCgCode(cgCode);
	        }
			orderBillService.save(orderBill);
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
     * @author tiange
     * APP端办公用品采购
     * @param orderBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getOrderBillList")
    public Map<String, Object> getOrderBillList(OrderBill orderBill,HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            List<OrderBill> list = orderBillService.findList(orderBill);
            result.put("page", list);
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
     * @author tiange
     * APP端办公用品编辑
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getinfoApp")
    public  Map<String, Object> getinfoApp(String id){
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", orderBillService.get(id));
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
     * APP端办公用品采购得到子表数据
     * @author tiange
     * @param orderBills
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getDtlDataAPP")
    public Map<String, Object>  getDtlDataAPP(OrderBills orderBills) {

        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功

            result.put("page", orderBillService.findUsedCode(orderBills));
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
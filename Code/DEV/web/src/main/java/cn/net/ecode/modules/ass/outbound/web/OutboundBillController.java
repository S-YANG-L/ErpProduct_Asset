/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.outbound.web;


import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.sys.entity.Office;
import com.alibaba.fastjson.JSONArray;
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
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.outbound.service.OutboundBillService;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;

/**
 * 物资出库Controller
 *
 * @author tiange
 * @version 2018-10-11
 */
@Controller
@RequestMapping(value = "${adminPath}/outbound/outboundBill")
public class OutboundBillController extends BaseController {
    @Autowired
    private WarehouseInfoService warehouseInfoService;
    @Autowired
    private OutboundBillService outboundBillService;
    @Autowired
    private FlowLogService flowLogService;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private CodeRuleService codeRuleService;
    /**
     * 获取数据
     */
    @ModelAttribute
    public OutboundBill get(String sysCode, boolean isNewRecord) {
        return outboundBillService.get(sysCode, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @RequestMapping(value = {"list", ""})
    public String list(OutboundBill outboundBill, Model model) {
        outboundBill.setMemo("标准出库");
        model.addAttribute("outboundBill", outboundBill);
        return "ecode/asset/base/outbound/outboundBillList";
    }

    /**
     * 查到相应子表列表
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @RequestMapping(value = {"outboundBillDtlList", ""})
    public String outboundBillDtlList(OutboundBillDtl outboundBillDtl, Model model) {

        model.addAttribute("outboundBillDtl", outboundBillDtl);
        return "ecode/asset/base/outbound/outboundBillDtlList";
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @RequestMapping(value = {"listCheckOut", ""})
    public String listCheckOut(OutboundBill outboundBill, Model model) {
        outboundBill.setMemo("盘亏出库");
        model.addAttribute("outboundBill", outboundBill);
        return "ecode/asset/base/outbound/outboundBillCheckList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<OutboundBill> listData(OutboundBill outboundBill, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<OutboundBill> page = outboundBillService.findPage(new Page<OutboundBill>(request, response), outboundBill);
        return page;
    }

    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "findoutboundCode")
    public List<OutboundBillDtl> findoutboundCode(OutboundBillDtl outboundBillDtl) {
        List<OutboundBillDtl> page = outboundBillService.findoutboundCode(outboundBillDtl);
        return page;
    }


    /**
     * 查看编辑表单
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @RequestMapping(value = "form")
    public String form(OutboundBill outboundBill, Model model) {
        if (StringUtils.isNotBlank(outboundBill.getSysCode())) {
            model.addAttribute("outboundCode", outboundBill.getSysCode());
        }
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);
        if (outboundBill.getIsNewRecord() == true) {
            outboundBill.setOutbounderCode(UserUtils.getUser().getUserCode());
            outboundBill.setOutbounderName(UserUtils.getUser().getUserName());
            OutboundBill outboundBill1 = outboundBillService.getOffice(outboundBill);
            outboundBill.setOfficeCode(outboundBill1.getOfficeCode());
            outboundBill.setOfficeName(outboundBill1.getOfficeName());
            outboundBill.setCompanyCode(outboundBill1.getCompanyCode());
            outboundBill.setCompanyName(outboundBill1.getCompanyName());
            outboundBill.setOutboundDate(new Date());
        } else {
            outboundBill.setOfficeCode(outboundBill.getOffice().getOfficeCode());
            outboundBill.setOutbounderCode(outboundBill.getOutbounderCode());
            outboundBill.setOutbounderName(outboundBill.getOutbounderName());
            outboundBill.setOutboundDate(outboundBill.getOutboundDate());
        }
        model.addAttribute("outboundBill", outboundBill);
        return "ecode/asset/base/outbound/outboundBillForm";
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("outbound:outboundBill:view")
    @RequestMapping(value = "formCheck")
    public String formCheck(OutboundBill outboundBill, Model model) {
        if (StringUtils.isNotBlank(outboundBill.getSysCode())) {
            model.addAttribute("outboundCode", outboundBill.getSysCode());
        }
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);
        model.addAttribute("outboundBill", outboundBill);
        return "ecode/asset/base/outbound/outboundBillCheckForm";
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("outbound:outboundBill:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(OutboundBill outboundBill) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, outboundBill)) {
            return renderResult(Global.FALSE, message);
        }        //生成办公用品编码:RK+当前年月日+6位流水号
        //生成办公用品编码
        if (outboundBill.getIsNewRecord()) {
            outboundBill.setOutboundCode(codeRuleService.createBgCode("BGRK","办公用品入库"));
        }
        Office office=new Office();
        office.setOfficeCode(outboundBill.getOfficeCode());
        outboundBill.setOffice(office);
        outboundBillService.save(outboundBill);
        if (outboundBill.getStep().equals("")) {
            return renderResult(Global.TRUE, "提交申请成功！");
        } else if (outboundBill.getStep().equals("1") || outboundBill.getStep().equals("2")) {
            return renderResult(Global.TRUE, "审批通过！");
        } else {
            return renderResult(Global.TRUE, "确认成功！");
        }
    }

    /**
     * 删除数据
     */
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(OutboundBill outboundBill) {
        outboundBillService.delete(outboundBill);
        outboundBillService.deleteFlowLog(outboundBill);
        return renderResult(Global.TRUE, "删除办公用品领用成功！");
    }

    /**
     * 提交申请
     *
     * @param flowBusiness
     * @param user
     * @param model
     * @return
     */
    @RequestMapping({"approvalSelect"})
    public String approvalSelect(FlowBusiness flowBusiness, User user, Model model) {
        model.addAttribute("flowBusiness", flowBusiness);
        model.addAttribute("user", user);
        return "ecode/asset/base/outbound/approvalSelect";
    }


    /**
     * 得到下一步审批人
     *
     * @param flowBusiness
     * @param model
     * @return
     */
    @RequestMapping({"nextApprovalSelect"})
    public String nextApprovalSelect(FlowBusiness flowBusiness, Model model) {
        model.addAttribute("flowBusiness", flowBusiness);
        return "ecode/asset/base/outbound/nextApprovalSelect";
    }

    /**
     * 查询下一步审批人
     *
     * @param flowBusiness
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping({"listNextApprovalData"})
    public Page<User> listNextApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        Page<User> page = this.flowBusinessService.findNextApprovalPage(new Page(request, response), flowBusiness);
        page = filtration(page);
        return page;
    }

    /**
     * 过滤选择审批人只显示自己部门的
     *
     * @param page
     * @return
     */
    public Page<User> filtration(Page<User> page) {
        List<User> list = page.getList();
        OutboundBill outboundBill = new OutboundBill();
        outboundBill.setOutbounderCode(UserUtils.getUser().getUserCode());
        outboundBill = outboundBillService.getOffice(outboundBill);
        String office = outboundBill.getOfficeCode();
        String office2 = "";
        //选择审批人只显示自己部门的
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                list.get(i).getLoginCode();
                OutboundBill outboundBill1 = new OutboundBill();
                outboundBill1.setOutbounderCode(list.get(i).getLoginCode());
                outboundBill1 = outboundBillService.getOffice(outboundBill1);
                office2 = outboundBill1.getOfficeCode();
                if (office.equals(office2)) {
                } else {
                    list.remove(i);
                    i--;
                }
            }
        } else {
        }
        return page;
    }

    /**
     * 选择审批人只显示自己部门的
     *
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping({"listApprovalData"})
    public Page<User> listApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        Page<User> page = this.flowBusinessService.findApprovalPage(new Page(request, response), flowBusiness);
        page = filtration(page);
        return page;
    }
    /**
     *
     * @Title: agreeApp
     * @Description: 手机端审批通过方法
     * @param outboundBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "outBoundListApp")
    public Map<String , Object> outBoundListApp(OutboundBill outboundBill,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            String dateFilter=request.getParameter("dateFilter");
            if (StringUtils.isNotBlank(dateFilter)) {
                if ("近三天".equals(dateFilter)) { //近三天
                    outboundBill.setEndDate(new Date());
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.DATE, -3);
                    Date endDate = c.getTime();
                    outboundBill.setBeginDate(endDate);
                }else if ("近一周".equals(dateFilter)) { //近一周
                    outboundBill.setEndDate(new Date());
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.DATE, -7);
                    Date endDate = c.getTime();
                    outboundBill.setBeginDate(endDate);
                }else if ("近一月".equals(dateFilter)) { //近一个月
                    outboundBill.setEndDate(new Date());
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.MONTH, -1);
                    Date endDate = c.getTime();
                    outboundBill.setBeginDate(endDate);
                }else{}
            }
            Page<OutboundBill> page = outboundBillService.findPage(new Page<OutboundBill>(request, response), outboundBill);
            result.put("page",page);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            System.out.print(e);
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * @param outboundBill
     * @param request
     * @param response
     * @return
     * @Title:agreePC
     * @Description:审批通过PC
     */
    @RequiresPermissions("outbound:outboundBill:edit")
    @ResponseBody
    @RequestMapping(value = "agreePC")
    public String agreePC(OutboundBill outboundBill, HttpServletRequest request, HttpServletResponse response) {
        try {
            String isEnd = request.getParameter("isEnd");
            String sysCode = request.getParameter("sysCode");
            outboundBill.setIsEnd(Integer.parseInt(isEnd));
            outboundBill.setId(sysCode);
            outboundBillService.agree(outboundBill);
            return renderResult(Global.TRUE, "审批通过！");
        } catch (Exception e) {
            e.printStackTrace();
            return renderResult(Global.TRUE, "出现问题！");
        }

    }
    /**
     *
     * @Title: agreeApp
     * @Description: 手机端审批通过方法
     * @param outboundBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "agreeApp",method = RequestMethod.POST)
    public Map<String , Object> agreeApp(OutboundBill outboundBill,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            outboundBillService.agree(outboundBill);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * @param outboundBill
     * @param request
     * @param response
     * @return
     * @Title:disagreePC
     * @Description:驳回PC
     */
    @RequiresPermissions("outbound:outboundBill:edit")
    @ResponseBody
    @RequestMapping(value = "disagreePC")
    public String disagreePC(OutboundBill outboundBill, HttpServletRequest request, HttpServletResponse response) {
        try {
            String sysCode = request.getParameter("sysCode");
            outboundBill.setId(sysCode);
            outboundBillService.disagree(outboundBill);
            return renderResult(Global.TRUE, "已驳回！");
        } catch (Exception e) {
            return renderResult(Global.TRUE, "出现问题！");
        }
    }
    /**
     *
     * @Title: disagree
     * @Description: 手机端驳回
     * @param outboundBill
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "disagreeApp",method = RequestMethod.POST)
    public Map<String , Object> disagreeApp(OutboundBill outboundBill,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            outboundBillService.disagree(outboundBill);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * @return
     * @Title: unDo
     * @Description: 撤回审批
     * @author tiange
     */
    @ResponseBody
    @RequestMapping(value = "unDo", method = RequestMethod.POST)
    public Map<String, Object> unDo(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            String msg = outboundBillService.unDo(flowBusiness);
            // 如果msg信息为空
            if (org.apache.commons.lang3.StringUtils.isBlank(msg)) {
                result.put("code", "200");
                result.put("message", "单据撤回成功！");
            } else {
                result.put("code", "201");
                result.put("message", msg);
            }
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "网络错误！");
        }
        return result;
    }

    /**
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     * @Title: getNextFlowBusiness
     * @Description: 判断工作流是否为最后一步
     */
    @ResponseBody
    @RequestMapping(value = "getNextFlowBusiness")
    public Integer getNextFlowBusiness(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        FlowBusiness nextFlowBusiness;
        nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
        if (nextFlowBusiness != null) {
            return 1;  //不是最后一步
        } else {
            return 0;  //是最后一步
        }
    }

    @ResponseBody
    @RequestMapping(value = "unSubmit", method = RequestMethod.POST)
    public Map<String, Object> unSubmit(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        String msg = null;
        try {
            msg = outboundBillService.unSubmit(flowBusiness);
            if (org.apache.commons.lang3.StringUtils.isEmpty(msg)) {//如果msg信息为空
                result.put("true", "单据撤回成功！");
                result.put("code", "200");
                result.put("message", "success");
            } else {
                if (msg.equals("当前单据未提交或已撤回")) {
                    result.put("true", "单据撤回成功！");
                    result.put("code", "200");
                    result.put("message", "success");
                } else {
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
     * App端保存数据
     */
    @ResponseBody
    @RequestMapping(value = "saveAPP")
    public Map<String, Object> saveAPP(OutboundBill outboundBill) {
        Map<String, Object> result = new HashMap<String, Object>();
        //生成办公用品编码
        if (outboundBill.getIsNewRecord()) {
            outboundBill.setOutboundCode(codeRuleService.createBgCode("BGRK","办公用品入库"));
        }
        if(!outboundBill.getOutboundBillDtlListString().equals("undefined")){
            List<OutboundBillDtl> outboundBillDtlList = JSONArray.parseArray(outboundBill.getOutboundBillDtlListString(), OutboundBillDtl.class);
            outboundBill.setOutboundBillDtlList(outboundBillDtlList);
        }
        try {// 成功
            outboundBillService.save(outboundBill);
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
     * 手机端获取借款单条数据详情 lixin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情和审批流数据
     * @param outboundBill
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getOutBoundBill")
    public Map<String , Object> getBorrowBill(OutboundBill outboundBill,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            OutboundBill outboundBill1=  outboundBillService.get(outboundBill);
            OutboundBillDtl outboundBillDtl=new OutboundBillDtl();
            outboundBillDtl.setSysCode(outboundBill.getSysCode());
            List<OutboundBillDtl> page = outboundBillService.findoutboundCode(outboundBillDtl);
            outboundBill1.setOutboundBillDtlList(page);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(outboundBill.getBizKey());
            List<FlowBusiness> flowBusinessList = flowBusinessService.findList(flowBusiness);
            FlowLog flowLog=new FlowLog();
            flowLog.setBizKey(outboundBill.getBizKey());
            List<FlowLog> finishList = this.flowLogService.findFinishListByBizKey(flowLog);
            result.put("flList",finishList);
            result.put("flowBusinessList", flowBusinessList);
            // end
            result.put("list",outboundBill1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * 手机端获取领用单条数据详情加子表 zhaohongbin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情
     * @param outboundBill
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getOutBoundBillAPP")
    public Map<String , Object> getOutBoundBillAPP(OutboundBill outboundBill,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            OutboundBill outboundBill1=  outboundBillService.get(outboundBill);
            OutboundBillDtl outboundBillDtl=new OutboundBillDtl();
            outboundBillDtl.setSysCode(outboundBill1.getSysCode());
            List<OutboundBillDtl> page = outboundBillService.findoutboundCode(outboundBillDtl);
            outboundBill1.setOutboundBillDtlList(page);
            result.put("list",outboundBill1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * @Title:	全流程演示-未完成流程
     * @createBy：wfw
     * @date:
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "findNotFinishListByBizKey")
    public Map<String, Object> findNotFinishListByBizKey(FlowLog flowLog, HttpServletResponse response)throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            List<FlowLog> notFinishList = flowLogService.findNotFinishListByBizKey(flowLog);
            result.put("data", notFinishList);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
}
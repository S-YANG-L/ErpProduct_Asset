/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.approval.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.approval.entity.FlowHelp;
import cn.net.ecode.modules.ass.approval.service.FlowHelpService;

import java.util.HashMap;
import java.util.Map;

/**
 * 审批流程记录Controller
 *
 * @author zhaohongbin
 * @version 2018-10-14
 */
@Controller
@RequestMapping(value = "${adminPath}/approval/flowHelp")
public class FlowHelpController extends BaseController {

    @Autowired
    private FlowHelpService flowHelpService;

    /**
     * 获取数据
     */
    @ModelAttribute
    public FlowHelp get(String id, boolean isNewRecord) {
        return flowHelpService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("approval:flowHelp:view")
    @RequestMapping(value = {"list", ""})
    public String list(FlowHelp flowHelp, Model model) {
        model.addAttribute("flowHelp", flowHelp);
        return "ass/approval/flowHelpList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("approval:flowHelp:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<FlowHelp> listData(FlowHelp flowHelp, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<FlowHelp> page = flowHelpService.findPage(new Page<FlowHelp>(request, response), flowHelp);
        return page;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("approval:flowHelp:view")
    @RequestMapping(value = "form")
    public String form(FlowHelp flowHelp, Model model) {
        model.addAttribute("flowHelp", flowHelp);
        return "ass/approval/flowHelpForm";
    }

    /**
     * 查看编辑表单
     */
    @RequestMapping(value = "getFlowren")
    public Map<String, Object> getFlowren(FlowHelp flowHelp, Model model) {
        Map<String, Object> map = new HashMap<>();
        FlowHelp flowHelp1 = flowHelpService.getFlowren(flowHelp);
        map.put("applicantCode", flowHelp1.getApplicantCode());
        map.put("applicantName", flowHelp1.getApplicantName());
        return map;
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("approval:flowHelp:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(FlowHelp flowHelp) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, flowHelp)) {
            return renderResult(Global.FALSE, message);
        }
        flowHelpService.save(flowHelp);
        return renderResult(Global.TRUE, "保存审批流程记录成功！");
    }

    /**
     * 删除数据
     */
    @RequiresPermissions("approval:flowHelp:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(FlowHelp flowHelp) {
        flowHelpService.delete(flowHelp);
        return renderResult(Global.TRUE, "删除审批流程记录成功！");
    }

}
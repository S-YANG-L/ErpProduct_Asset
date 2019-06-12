/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.web;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.eflow.dao.FlowLogDao;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.PeoPleSearch;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.sys.entity.Menu;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;

/**
 * 移动端获取后台日志Controller
 *
 * @author Mc
 * @version 2016-06-20
 */
@Controller
@RequestMapping(value = "${adminPath}/app/appMessage")
public class AppMessageController extends BaseController {

    @Autowired
    private AppMessageService appMessageService;
    @Autowired
    private FlowLogService flowLogService;

    /**
     * 获取数据
     */
    @ModelAttribute
    public AppMessage get(String id, boolean isNewRecord) {
        return appMessageService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("app:appMessage:view")
    @RequestMapping(value = {"list", ""})
    public String list(AppMessage appMessage, Model model) {
        model.addAttribute("appMessage", appMessage);
        return "ecode/app/appMessageList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("app:appMessage:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<AppMessage> listData(AppMessage appMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AppMessage> page = appMessageService.findPage(new Page<AppMessage>(request, response), appMessage);
        return page;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("app:appMessage:view")
    @RequestMapping(value = "form")
    public String form(AppMessage appMessage, Model model) {
        model.addAttribute("appMessage", appMessage);
        return "ecode/app/appMessageForm";
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("app:appMessage:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(AppMessage appMessage) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, appMessage)) {
            return renderResult(Global.FALSE, message);
        }
        appMessageService.save(appMessage);
        return renderResult(Global.TRUE, "保存日志信息成功！");
    }

    /**
     * 删除数据
     */
    @RequiresPermissions("app:appMessage:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AppMessage appMessage) {
        appMessageService.delete(appMessage);
        return renderResult(Global.TRUE, "删除日志信息成功！");
    }

    /**
     * @param data
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @Title: findMessage 移动端消息条数
     * @updateBy：Mc
     * @date: 2016年6月20日 下午3:44:47
     */
    @ResponseBody
    @RequestMapping(value = "findMessage", method = RequestMethod.POST)
    public Map<String, Object> findMessage(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) throws Exception {
        //logger.debug("data:{}",data);
        AppMessage appMessage = JsonMapper.fromJsonString(data, AppMessage.class);
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            //成功
            appMessage.setReceiverCodes(UserUtils.getUser().getLoginCode());
            result.put("code", "200");
            result.put("message", "success");

        } catch (Exception e) {//失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * @param people
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @Title: 根据CompanyCode查user
     * @Description: 根据CompanyCode查user
     */
    @ResponseBody
    @RequestMapping(value = "findPersonnelInfo", method = RequestMethod.POST)
    public Map<String, Object> findPersonnelInfo(PeoPleSearch people, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            List<PeoPleSearch> perSonnelInfo = appMessageService.findPersonnelInfo(people); //通讯录排序
            result.put("list", perSonnelInfo);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {//失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @Title: findMessageNew
     * @createBy：Mc
     * @date: 2016年10月12日 下午4:35:57
     */
    @ResponseBody
    @RequestMapping(value = "findMessageNew", method = RequestMethod.POST)
    public Map<String, Object> findMessageNew(AppMessage appMessage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            //成功
            appMessage.setReceiverCodes(UserUtils.getUser().getUserCode());
            List<AppMessage> appMess = appMessageService.findMessageNew(appMessage);
            int messageCount = 0;
            String contentTitle = null;
            if (appMess != null) {
                messageCount = appMess.size();
                contentTitle = appMess.get(0).getContentTitle();
            }
            result.put("code", "200");
            result.put("message", "success");
            result.put("list", appMess);
            result.put("messageCount", messageCount);
            result.put("contentTitle", contentTitle);
        } catch (Exception e) {//失败
            System.out.print(e);
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * @return
     * @Title: findMessageTwo
     * @Description: TODO
     * @author: wuchunyan
     * @date: 2017年11月7日 下午3:38:03
     */
    @ResponseBody
    @RequestMapping(value = "findMessageTwo", method = RequestMethod.POST)
    public Map<String, Object> findMessageTwo(AppMessage appMessage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            //成功
            appMessage.setReceiverCodes(UserUtils.getUser().getUserCode());
            List<AppMessage> appMess = appMessageService.findMessageTwo(appMessage);
            int messageCount = 0;
            String contentTitle = null;
            if (appMess != null) {
                messageCount = appMess.size();
                contentTitle = appMess.get(0).getContentTitle();
            }
            result.put("code", "200");
            result.put("message", "success");
            result.put("list", appMess);
            result.put("messageCount", messageCount);
            result.put("contentTitle", contentTitle);
        } catch (Exception e) {//失败
            System.out.print(e);
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * @param appMessage
     * @return
     * @throws Exception
     * @Title: MessageList
     * @createBy：Mc
     * @date: 2016年10月24日 下午1:56:43
     */
    @ResponseBody
    @RequestMapping(value = "messageList", method = RequestMethod.POST)
    public Map<String, Object> messageList(AppMessage appMessage) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            //成功
            appMessage.setReceiverCodes(UserUtils.getUser().getLoginCode());
            List<AppMessage> appMess = appMessageService.messageList(appMessage);
            result.put("code", "200");
            result.put("message", "success");
            result.put("list", appMess);
        } catch (Exception e) {//失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }


    /**
     * @param appMessage
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @Title: findBillList
     * @Description: app端单据列 chenyuan
     */
    @ResponseBody
    @RequestMapping(value = "findBillList", method = RequestMethod.POST)
    public Map<String, Object> findBillList(AppMessage appMessage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            if (appMessage.getBilltypeCode() == null || "".equals(appMessage.getBilltypeCode()) || "BX".equals(appMessage.getBilltypeCode()) || "ZF".equals(appMessage.getBilltypeCode())) {
                Page<AppMessage> fee = appMessageService.findBillFeeList(new Page<AppMessage>(request, response), appMessage);
                result.put("fee", fee);
            } else {
                Page<AppMessage> page = appMessageService.findBillList(new Page<AppMessage>(request, response), appMessage);
                result.put("page", page);
            }
            //成功
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {//失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping({"finishData"})
    public Page<FlowLog> finishData(FlowLog flowLog, HttpServletRequest request, HttpServletResponse response, Model model) {
        flowLog.setApprovalCode(UserUtils.getUser().getUserCode());
        Page<FlowLog> page = this.appMessageService.fingFinishPage(new Page(request, response), flowLog);
        return page;
    }
    @ResponseBody
    @RequestMapping({"flowTodoListData"})
    public Page<FlowBusiness> flowToDoListData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<FlowBusiness> page = this.appMessageService.findProcessList(new Page(request, response), flowBusiness);
        return page;
    }
    @ResponseBody
    @RequestMapping({"findapplicationList"})
    public Page<FlowLog> findapplicationList(FlowLog flowLog, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<FlowLog> page = this.appMessageService.findapplicationList(new Page(request, response), flowLog);
        return page;
    }
    /**
     * 获取二级菜单接口
     *
     * @return
     * @Title: getAPPMenuRoleList
     * @Description: TODO
     * @author: Mc
     * @date: 2017年5月10日 上午11:21:58
     */
    @ResponseBody
    @RequestMapping(value = "getAPPMenuRoleList", method = RequestMethod.POST)
    public Map<String, Object> getAPPMenuRoleList(Menu menu, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            User user = UserUtils.getUser();
            menu.setUserCode(user.getUserCode());
            List<Menu> menuList = appMessageService.getRoleMenuByParentCode(menu);
            result.put("data", menuList);
            result.put("code", "200");
            result.put("message", "success");

        } catch (Exception e) {// 如果失败 result存这个
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }


}
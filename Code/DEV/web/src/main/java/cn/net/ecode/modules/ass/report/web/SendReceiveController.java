package cn.net.ecode.modules.ass.report.web;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.excel.ExcelExport;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.articlesfile.entity.ArticlesFile;
import cn.net.ecode.modules.ass.articlesfile.service.ArticlesFileService;
import cn.net.ecode.modules.ass.report.entity.Report;
import cn.net.ecode.modules.ass.report.entity.SendReceive;
import cn.net.ecode.modules.ass.report.service.SendReceiveService;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;

/**
 * 收发存明细报表信息Controller
 * @author tiange
 * @version 2018-10-16
 */
@Controller
@RequestMapping(value = "${adminPath}/sendReceive/sendReceive")
public class SendReceiveController extends BaseController {
	@Autowired
	private SendReceiveService sendReceiveService;
	@Autowired
	private WarehouseInfoService warehouseInfoService;
	@Autowired
	private ArticlesFileService articlesFileService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public SendReceive get(String id, boolean isNewRecord) {
		return sendReceiveService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("sendReceive:sendReceive:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendReceive sendReceive, Model model) {
		//获取仓库列表
		WarehouseInfo warehouseInfo = new WarehouseInfo();
		List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
		model.addAttribute("warehouses",warehouses);
		//获取物品名称
		ArticlesFile articlesFile = new ArticlesFile();
		List<ArticlesFile> articlesFiles = articlesFileService.findList(articlesFile);
		model.addAttribute("articlesFiles",articlesFiles);
		return "ecode/asset/base/report/sendReceiveList";
	}
	
	/**
	 * 查询相应列表
	 */
	@RequiresPermissions("sendReceive:sendReceive:view")
	@RequestMapping(value = {"listDetail", ""})
	public String listDetail(SendReceive sendReceive,Model model) {
		model.addAttribute("warehouseArticlesName",sendReceive.getWarehouseArticlesName());
		model.addAttribute("warehouseWhCodes",sendReceive.getWarehouseWhCodes());
		return "ecode/asset/base/report/sendReceiveList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("sendReceive:sendReceive:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<SendReceive> listData(SendReceive sendReceive, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendReceive> page = sendReceiveService.findPage(new Page<SendReceive>(request, response), sendReceive);
		return page;
	}

/*	*//**
	 * 查看编辑表单
	 *//*
	@RequiresPermissions("report:report:view")
	@RequestMapping(value = "form")
	public String form(Report report, Model model) {
		model.addAttribute("report", report);
		return "ecode/asset/base/wareitems/warehouseItemsForm";
	}*/
	
	/**
	 * 保存数据
	 */
	@RequiresPermissions("sendReceive:sendReceive:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(SendReceive sendReceive) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, sendReceive)){
			return renderResult(Global.FALSE, message);
		}
		sendReceiveService.save(sendReceive);
		return renderResult(Global.TRUE, "保存信息成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("sendReceive:sendReceive:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(SendReceive sendReceive) {
		sendReceiveService.delete(sendReceive);
		return renderResult(Global.TRUE, "删除信息成功！");
	}
	
	@RequiresPermissions("sendReceive:sendReceive:edit")
    @RequestMapping(value = "export")
    public String pwdAuditExport(SendReceive sendReceive, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "收发存明细表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<SendReceive> list = this.sendReceiveService.findList(sendReceive);
            for (int i = 0; i < list.size(); i++) {
            	SendReceive sendReceive1 = list.get(i);
            	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(sendReceive1.getInoutDate());//格式化数据
                sendReceive1.setInoutDateString(date);;
            }
            (new ExcelExport("收发存明细表", SendReceive.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/sendReceive/sendReceive/list";
        }
    }
}

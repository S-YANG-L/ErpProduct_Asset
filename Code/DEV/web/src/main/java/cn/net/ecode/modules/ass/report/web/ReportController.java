package cn.net.ecode.modules.ass.report.web;

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
import cn.net.ecode.modules.ass.report.service.ReportService;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;

/**
 * 报表信息Controller
 * @author tiange
 * @version 2018-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/report/report")
public class ReportController extends BaseController {
	
	@Autowired
	private ReportService reportService;
	@Autowired
	private WarehouseInfoService warehouseInfoService;
	@Autowired
	private ArticlesFileService articlesFileService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public Report get(String id, boolean isNewRecord) {
		return reportService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("report:report:view")
	@RequestMapping(value = {"list", ""})
	public String list(Report report, Model model) {
		//获取仓库列表
		WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses",warehouses);
		//获取物品名称
		ArticlesFile articlesFile = new ArticlesFile();
		List<ArticlesFile> articlesFiles = articlesFileService.findList(articlesFile);
		model.addAttribute("articlesFiles",articlesFiles);
		return "ecode/asset/base/report/wareSummaryList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("report:report:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<Report> listData(Report report, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Report> page = reportService.findPage(new Page<Report>(request, response), report); 
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
	@RequiresPermissions("report:report:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(Report report) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, report)){
			return renderResult(Global.FALSE, message);
		}
		reportService.save(report);
		return renderResult(Global.TRUE, "保存信息成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("report:report:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(Report report) {
		reportService.delete(report);
		return renderResult(Global.TRUE, "删除信息成功！");
	}
	
	@RequiresPermissions("report:report:edit")
    @RequestMapping(value = "export")
    public String pwdAuditExport(Report report, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "收发存汇总表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<Report> list = this.reportService.findList(report);
            for (int i = 0; i < list.size(); i++) {
            	Report report1 = list.get(i);
            }
            (new ExcelExport("收发存汇总表", Report.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/report/report/list";
        }
    }
}

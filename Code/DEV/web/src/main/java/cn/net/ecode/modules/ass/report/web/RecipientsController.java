package cn.net.ecode.modules.ass.report.web;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.sys.utils.UserUtils;
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
import cn.net.ecode.modules.ass.report.entity.Recipients;
import cn.net.ecode.modules.ass.report.entity.Report;
import cn.net.ecode.modules.ass.report.service.RecipientsService;
import cn.net.ecode.modules.ass.report.service.ReportService;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;

/**
 * 耗材领用信息controller
 * @author tiange
 * @version 2018-10-17
 */
@Controller
@RequestMapping(value = "${adminPath}/recipients/recipients")
public class RecipientsController extends BaseController {
	@Autowired
	private RecipientsService recipientsService;
	@Autowired
	private WarehouseInfoService warehouseInfoService;
	@Autowired
	private ArticlesFileService articlesFileService;
	@Autowired
	private CommonService commonService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public Recipients get(String id, boolean isNewRecord) {
		return recipientsService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("recipients:recipients:view")
	@RequestMapping(value = {"list", ""})
	public String list(Recipients recipients, Model model) {
		//获取仓库列表
		WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses",warehouses);
		//获取物品名称
		ArticlesFile articlesFile = new ArticlesFile();
		List<ArticlesFile> articlesFiles = articlesFileService.findList(articlesFile);
		model.addAttribute("articlesFiles",articlesFiles);
		return "ecode/asset/base/report/recipientsList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("recipients:recipients:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<Recipients> listData(Recipients recipients, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (!UserUtils.getUser().getRoleCodes().equals("100")) {
			Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
			recipients.setOfficeCode(common.getOfficeCode());
			recipients.setOfficeName(common.getOfficeName());
		}
		Page<Recipients> page = recipientsService.findPage(new Page<Recipients>(request, response), recipients); 
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
	@RequiresPermissions("recipients:recipients:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(Recipients recipients) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, recipients)){
			return renderResult(Global.FALSE, message);
		}
		recipientsService.save(recipients);
		return renderResult(Global.TRUE, "保存信息成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("recipients:recipients:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(Recipients recipients) {
		recipientsService.delete(recipients);
		return renderResult(Global.TRUE, "删除信息成功！");
	}
	
	@RequiresPermissions("recipients:recipients:edit")
    @RequestMapping(value = "export")
    public String pwdAuditExport(Recipients recipients, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "办公用品领用表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<Recipients> list = this.recipientsService.findList(recipients);
            for (int i = 0; i < list.size(); i++) {
            	Recipients recipients1 = list.get(i);
            	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(recipients1.getCreateDate());//格式化数据
                recipients1.setCreateDateString(date);
            }
            (new ExcelExport("办公用品领用表", Recipients.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/recipients/recipients/list";
        }
    }
}

/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.location.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
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
import cn.net.ecode.modules.ass.location.entity.AssLocation;
import cn.net.ecode.modules.ass.location.service.AssLocationService;
import java.util.*;

/**
 * 存放地点Controller
 * @author yangjianjun
 * @version 2018-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/location/assLocation")
public class AssLocationController extends BaseController {

	@Autowired
	private AssLocationService assLocationService;
	@Autowired
	private AssetInfoService assetInfoService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssLocation get(String id, boolean isNewRecord) {
		return assLocationService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("location:assLocation:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssLocation assLocation, Model model) {
		model.addAttribute("assLocation", assLocation);
		return "ecode/asset/base/location/assLocationList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("location:assLocation:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssLocation> listData(AssLocation assLocation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AssLocation> page = assLocationService.findPage(new Page<AssLocation>(request, response), assLocation); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("location:assLocation:view")
	@RequestMapping(value = "form")
	public String form(AssLocation assLocation, Model model) {
		if(assLocation.getIsNewRecord()){
			List<AssLocation>  assLocations=assLocationService.findList(assLocation);
			if(assLocations.size()!=0){
				Collections.sort(assLocations, new Comparator<AssLocation>() {
					@Override
					public int compare(AssLocation o1, AssLocation o2) {
						int a= Integer.parseInt(o1.getLocaleCode());
						int b= Integer.parseInt(o2.getLocaleCode());
						int i = a-b;
						return i;
					}
				});
				int newCode= Integer.parseInt(assLocations.get(assLocations.size()-1).getLocaleCode());
				assLocation.setLocaleCode(String.valueOf(newCode+1));
			}else {
				assLocation.setLocaleCode("10001");
			}
		}
		model.addAttribute("assLocation", assLocation);
		return "ecode/asset/base/location/assLocationForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("location:assLocation:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssLocation assLocation) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assLocation)){
			return renderResult(Global.FALSE, message);
		}
		if(assLocation.getIsNewRecord()){
			List<AssLocation> list = assLocationService.findAllList(assLocation);
			for (int i = 0; i < list.size(); i++) {
				AssLocation assLocation1 =  list.get(i);
				if (assLocation1.getLocaleCode().equals(assLocation.getLocaleCode())){
					return renderResult(Global.FALSE, "存放地点编码不能重复");
				}
				if (assLocation1.getLocaleName().equals(assLocation.getLocaleName())){
					return renderResult(Global.FALSE, "存放地点名称不能重复");
				}
			}
		}
		assLocationService.save(assLocation);
		return renderResult(Global.TRUE, "保存存放地点成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("location:assLocation:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssLocation assLocation) {
		AssetInfo assetInfo=new AssetInfo();
		assetInfo.setStoragePlaceCode(assLocation.getLocaleCode());
		List<AssetInfo> assetInfos=assetInfoService.findList(assetInfo);
		if(assetInfos.size()>0){
			return renderResult(Global.FALSE, "该存放地点已经存放资产,不能删除！");
		}else{
			assLocationService.delete(assLocation);
			return renderResult(Global.TRUE, "删除存放地点成功！");
		}
	}
    /**
     * App获取存放地址列表接口
     * @param assLocation
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "locationListApp")
    public Map<String , Object> locationListApp(AssLocation assLocation, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Page page = new Page<AssLocation>(request, response);
            Page<AssLocation> page1 = assLocationService.findPage(page, assLocation);
            result.put("page",page1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
}
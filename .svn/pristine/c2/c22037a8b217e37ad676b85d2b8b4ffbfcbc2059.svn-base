package cn.net.ecode.modules.ass.common.web;


import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 通用方法调用Controller  
 * @author Rambo
 * 2016年11月18日16:11:21
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/common")
public class CommonController {
	
	@Autowired
	private CommonService commonService;

	/**
	 * 
	 * 公共查询部门公司编码名称 
	 */
	@RequestMapping(value = "getOfficeCompany")
	public   Common getOfficeCompany(String usercode) {
        Common list = commonService.getOfficeCompany(usercode);
		return list;
	}

    /**
     * App公共查询部门公司编码名称 
     */
    @RequestMapping(value = "getOfficeCompanyApp")
    public   Map<String, Object> getOfficeCompanyApp(String usercode) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Common common = commonService.getOfficeCompany(usercode);
            result.put("data",common);
            result.put("code", "200");
            result.put("message", "success");

        } catch (Exception e) {// 如果失败 result存这个
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

}

package cn.net.ecode.modules.ass.app.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.sys.entity.Dict;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.UserDict;
import cn.net.ecode.modules.sys.service.OfficeService;
import cn.net.ecode.modules.sys.utils.DictUtils;
import cn.net.ecode.modules.sys.utils.UserDictUtils;


@Controller
@RequestMapping(value = "${adminPath}/app/basic")

public class AppBasicController extends BaseController{
	
	@Autowired
	private OfficeService officeService;
	@Autowired
	private FlowBusinessService flowBusinessService;
	@Autowired
	private FlowLogService flowLogService;
	
	/**
	 * @Title: billType 
	 * @createBy：Mc
	 * @date: 2016年11月29日 下午4:12:45 
	 * @param userDict
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "billType", method = RequestMethod.POST)	
	public Map<String, Object> billType(UserDict userDict,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功
			List<Dict> list = DictUtils.getDictList("eflow_bill_type");//根据字典获取数据			
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	/**
	 * @Title: officeList 
	 * @createBy：Mc
	 * @date: 2016年11月29日 下午5:23:23 
	 * @param office
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "officeList", method = RequestMethod.POST)	
	public Map<String, Object> officeList(Office office,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功			
			List<Office> list = officeService.findAllList(office);//获取部门数据
			for(int i = 0 ;i<list.size();i++){
				if(2!=list.get(i).getSortGrade()){
					list.remove(i);//移除不符合2级的部门
					i--;//for循环是先根据中间的值判断是否为true，然后再执行后面的i++  
				}				
			}
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	
	/**
	 * 
	 * @Title: getDictType 
	 * @Description: TODO
	 * @author: 崔志帅
	 * @date: 2017年6月19日 下午4:38:17 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getDictType", method = RequestMethod.POST)	
	public Map<String, Object> dictType(UserDict userDict,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功
			
			List<Dict> list = DictUtils.getDictList(userDict.getDictCode());//根据字典获取数据			
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: getUserDictType 
	 * @Description: TODO
	 * @author: wangtao
	 * @date: 2017年9月28日 下午4:54:17 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getUserDictType", method = RequestMethod.POST)
	public Map<String, Object> finduserdictType(UserDict userDict, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//成功
			List<UserDict> list = UserDictUtils.getUserDictList(userDict.getDictCode());
			result.put("code", "200");
			result.put("message", "success");
			result.put("list", list);
		} catch (Exception e) {//失败 
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	/**
	 * @Title:getNextFlowBusiness
	 * @Description:判断工作流是否为最终流程
	 * @createBy: xulan
	 * @date: 2018年10月10日16:38:20
	 * @param flowBusiness
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "getNextFlowBusiness", method = RequestMethod.POST)
	public Map<String, Object> getNextFlowBusiness(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		FlowBusiness nextFlowBusiness;
		try {
			nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
			Map<String, Object> mapData = new HashMap<String, Object>();
			mapData.put("hasNextStep", Boolean.valueOf(nextFlowBusiness != null));
			result.put("data", mapData);
			result.put("code", "200");
			result.put("message", "success");

		} catch (Exception e) {// 如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	/**
	 * @Title:获取未完成流程
	 * @createBy：xulan
	 * @date:  2018年10月10日16:53:59
	 * @param flowLog
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "findNotFinishListByBizKey", method = RequestMethod.POST)	
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

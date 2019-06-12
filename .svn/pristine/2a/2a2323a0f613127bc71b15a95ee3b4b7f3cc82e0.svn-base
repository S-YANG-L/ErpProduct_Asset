package cn.net.ecode.modules.ass.app.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.app.entity.AppRegister;
import cn.net.ecode.modules.ass.app.entity.UserPsd;
import cn.net.ecode.modules.ass.app.service.AppRegisterService;
import cn.net.ecode.modules.sys.entity.Module;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.entity.content.BaseMsgContent;
import cn.net.ecode.modules.sys.entity.content.EmailMsgContent;
import cn.net.ecode.modules.sys.entity.content.SmsMsgContent;
import cn.net.ecode.modules.sys.service.ModuleService;
import cn.net.ecode.modules.sys.service.UserService;
import cn.net.ecode.modules.sys.utils.MsgPushUtils;
import cn.net.ecode.modules.sys.utils.UserUtils;


@Controller
@RequestMapping(value = "/app/register")
public class AppRegisterController extends BaseController{

	@Autowired
	private AppRegisterService appRegisterService;
	@Autowired
	private ModuleService moduleService;
	@Autowired
	private UserService userService;
	
	/**
	 * @Title:savePerson
	 * @Description:员工注册保存
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月26日 下午1:53:22 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "savePerson", method = RequestMethod.POST)
	public Map<String, Object> savePerson(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			appRegister.setLoginCode(appRegister.getMobile());
			
			List<AppRegister> list=appRegisterService.findLoginCode(appRegister);
			if(list.size()>0){
				result.put("code", "200");
				result.put("message", "该手机号已注册");
			}
			else{
				appRegisterService.saveUser(appRegister);
				result.put("code", "200");
				result.put("message", "注册成功");
			}
//			User user=new User();
//			user.setUserCode(IdGen.nextId());
//			user.setUserName(appRegister.getUserName());
//			user.setEmail(appRegister.getEmail());
//			user.setLoginCode(appRegister.getMobile());
//			user.setExtendS5("1");
//			user.setPassword(appRegister.getPassword());
//			user.setCorpCode(appRegister.getCorpCode());
//			userService.save(user);
//			appRegister.setUserCode(user.getUserCode());
//			appRegisterService.update(appRegister);
			//成功
			
			//result.put("list", list);
		} catch (Exception e) {//失败 
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:findList
	 * @Description:根据登陆号查找该用户集团
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:37:23 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "findList", method = RequestMethod.POST)
	public Map<String, Object> findList(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AppRegister> list;
		try {	
		
			list=appRegisterService.findList(appRegister);//根据登陆号查找该用户集团
//			Map<String,Object> list1 = new HashMap<String,Object>();
//			list1.put("list", list);
//			Map<String,Object> mapData = new HashMap<String,Object>();
//			mapData.put("researchList", researchList);
			if(list.size()>0){
				result.put("data", list.get(0).getCorpCode());
			}
			result.put("code", "200");
			result.put("message", "success");
		

		} catch (Exception e) {//如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:findCorpCode
	 * @Description:查找企业码是否存在
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月3日 下午1:58:49 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "findCorpCode", method = RequestMethod.POST)
	public Map<String, Object> findCorpCode(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AppRegister> list;
		try {	
		
			list=appRegisterService.findCorpCode(appRegister);//查找企业码是否存在
			Map<String,Object> list1 = new HashMap<String,Object>();
			list1.put("list", list);
//			Map<String,Object> mapData = new HashMap<String,Object>();
//			mapData.put("researchList", researchList);
			result.put("data", list1);
			result.put("code", "200");
			result.put("message", "success");
		

		} catch (Exception e) {//如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:confirm
	 * @Description:确认用户
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:38:22 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "confirm", method = RequestMethod.POST)
	public Map<String, Object> confirm(AppRegister appRegister,String allId,HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String arr[]=allId.split(",");
			for(int i=0;i<arr.length;i++){
				appRegister.setUserCode(arr[i]);
				appRegisterService.updateExtendS5(appRegister);//更新ExtendS5等于1的自主注册的员工信息
			}
			
			//成功
			result.put("code", "200");
			result.put("message", "success");
			//result.put("list", list);
		} catch (Exception e) {//失败 
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	@RequestMapping(value = "list")
	public String list(AppRegister appRegister,  Model model) {
	   return "ecode/hr/personnel/userConfirmList";
	}
	/**
	 * 人事档案列表加载数据
	 * @param employee
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AppRegister> listData(AppRegister appRegister, HttpServletRequest request, HttpServletResponse response, Model model) {
		//employee.setStatus(null);
		Page<AppRegister> page = appRegisterService.findPage(new Page<AppRegister>(request, response), appRegister);
		return page;

	}
	@ResponseBody
	@RequestMapping(value = "findCorpUserList", method = RequestMethod.POST)
	public Map<String, Object> findCorpUserList(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AppRegister> list;
		try {	
		
			list=appRegisterService.findCorpUserList(appRegister);//查找手机号是否重复
			Map<String,Object> list1 = new HashMap<String,Object>();
			list1.put("list", list);
//			Map<String,Object> mapData = new HashMap<String,Object>();
//			mapData.put("researchList", researchList);
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");

		} catch (Exception e) {//如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:verificationCode
	 * @Description:验证码
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月4日 上午9:29:45 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "verificationCode", method = RequestMethod.POST)
	public Map<String, Object> verificationCode(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<AppRegister> list=appRegisterService.findList(appRegister);//根据登陆号查找该用户集团
			if(list.size()>0){
				User user=UserUtils.getByLoginCode(appRegister.getLoginCode(), list.get(0).getCorpCode());
				if(user!=null){
					BaseMsgContent msgContent = null;
					if(appRegister.getMobile().endsWith("mobile")){ //手机号找回密码
						if(StringUtils.isNoneBlank(user.getMobile())){
							msgContent = new SmsMsgContent();
							//生成验证码
							Random random = new Random();
							String verification="";
							for(int i=0;i<6;i++){
								verification+=random.nextInt(10);
							}
							appRegister.setVerificationCode(verification);
						     msgContent.setTitle(null);
						     msgContent.setContent("您好，您的验证码是："+verification+"（请勿透露给其他人）感谢您的使用。");
						     // 即时推送消息
						     MsgPushUtils.push(msgContent, "BizKey", "BizType", user.getUserCode());
							
							//MessageUtils.sendSms(null, "您好，您的验证码是："+verification+"（请勿透露给其他人）感谢您的使用。", Message.RECEIVER_TYPE_NONE, appRegister.getMobile(), appRegister.getUserName());//将验证码发送短信到注册人手机上
						    result.put("code", "200");
						    result.put("user", user);
							result.put("message", "sucess");
							result.put("verificationCode", appRegister.getVerificationCode());
						}else{
							result.put("code", "204");
							result.put("message", "该用户没有绑定手机号");
							return result;
						}
					}else if(appRegister.getMobile().equals("email")){ //邮箱找回密码
						if(StringUtils.isNoneBlank(user.getEmail())){
							msgContent = new EmailMsgContent();
							//生成验证码
							Random random = new Random();
							String verification="";
							for(int i=0;i<6;i++){
								verification+=random.nextInt(10);
							}
							appRegister.setVerificationCode(verification);
						     msgContent.setTitle(null);
						     msgContent.setContent("您好，您的验证码是："+verification+"（请勿透露给其他人）感谢您的使用。");
						     // 即时推送消息
						     MsgPushUtils.push(msgContent, "BizKey", "BizType", user.getUserCode());
							
							//MessageUtils.sendSms(null, "您好，您的验证码是："+verification+"（请勿透露给其他人）感谢您的使用。", Message.RECEIVER_TYPE_NONE, appRegister.getMobile(), appRegister.getUserName());//将验证码发送短信到注册人手机上
						    result.put("code", "200");
						    result.put("user", user);
							result.put("message", "sucess");
							result.put("verificationCode", appRegister.getVerificationCode());
						}else{
							result.put("code", "204");
							result.put("message", "该用户没有绑定邮箱");
							return result;
						}
					}
				}else{
					result.put("code", "203");
					result.put("message", "用户名不正确");
				}
			}else{
				result.put("code", "202");
				result.put("message", "未获取到集团编码");
			}
		} catch (Exception e) {//失败 
			System.out.print(e);
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:form
	 * @Description:个人企业页面
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月5日 下午5:03:31 
	 * @param holiday
	 * @param model
	 * @return
	 */

	@RequestMapping(value = "form")
	public String form(AppRegister appRegister, Model model) {
		model.addAttribute("appRegister", appRegister);
		return "ecode/app/personalRegistration";
	}
	/**
	 * @Title:findLoginCode
	 * @Description:查找手机号是否重复
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月9日 下午4:37:00 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "findLoginCode", method = RequestMethod.POST)
	public Map<String, Object> findLoginCode(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AppRegister> list;
		try {	
		
			list=appRegisterService.findLoginCode(appRegister);//查找手机号是否重复
			Map<String,Object> list1 = new HashMap<String,Object>();
			list1.put("list", list);
//			Map<String,Object> mapData = new HashMap<String,Object>();
//			mapData.put("researchList", researchList);
			result.put("data", list1);
			result.put("code", "200");
			result.put("message", "success");
		

		} catch (Exception e) {//如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title:moduleList
	 * @Description:模块列表
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年2月10日 上午9:49:09 
	 * @param appRegister
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "moduleList", method = RequestMethod.POST)
	public Map<String, Object> moduleList(AppRegister appRegister,HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Module> list;
		try {	
			Module module = new Module();
			module.setStatus("0");
			module.setCorpCode(appRegister.getCorpCode());
			list=moduleService.findList(module);//查找模块
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {//如果失败 result存这个
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	/***
	 * @author xulan
	 * @date 2018年10月11日09:52:35
	 * @Title: updatePassword
	 * @Description: 手机端--密码修改
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "updatePassword", method = RequestMethod.POST)
	public Map<String, Object> info(UserPsd userPsd, HttpServletRequest request, HttpServletResponse response, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		// UserPsd userPsd=JsonMapper.fromJsonString(params, UserPsd.class);
		User currentUser = UserUtils.getUser();
		if ((StringUtils.isNotBlank(userPsd.getOldPassword()))) {
			if (!UserService.validatePassword(userPsd.getOldPassword(), currentUser.getPassword())) {
				result.put("code", "201");
				result.put("message", "旧密码错误，请重新输入");
				return result;
			}
			if ((StringUtils.isBlank(userPsd.getNewPassword()))) {
				result.put("code", "201");
				result.put("message", "新密码不能为空，请重新输入");
				return result;
			}
			if (!StringUtils.equals(userPsd.getNewPassword(), userPsd.getConfirmNewPassword())) {
				result.put("code", "201");
				result.put("message", "新密码与确认新密码不同，请重新输入");
				return result;
			}
			this.userService.updatePassword(currentUser.getUserCode(), userPsd.getConfirmNewPassword());
			result.put("code", "200");
			result.put("message", "修改密码成功");
		} else {
			result.put("code", "201");
			result.put("message", "原密码不能为空！");
		}
		return result;
	}
}

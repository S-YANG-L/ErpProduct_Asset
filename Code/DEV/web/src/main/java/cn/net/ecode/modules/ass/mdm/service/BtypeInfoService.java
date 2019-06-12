/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.service;


import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.mdm.dao.BtypeAttrDao;
import cn.net.ecode.modules.ass.mdm.dao.BtypeExtDao;
import cn.net.ecode.modules.ass.mdm.dao.BtypeInfoDao;
import cn.net.ecode.modules.ass.mdm.entity.BtypeAttr;
import cn.net.ecode.modules.ass.mdm.entity.BtypeExt;
import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;
import cn.net.ecode.modules.ass.mdm.utils.MdmCommonUtils;
import cn.net.ecode.modules.sys.service.UserDictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.service
 * @ClassName: BtypeInfoService
 * @Description: TODO
 * @author: 于明珠
 * @date: 2015年9月18日 上午9:23:16
 * @Version: V1.0
 */
@Service
@Transactional(readOnly = true)
public class BtypeInfoService extends CrudService<BtypeInfoDao, BtypeInfo> {

	@Autowired
	private BtypeExtDao btypeExtDao;
	@Autowired
	private BtypeAttrDao btypeAttrDao;

	@Autowired
	private UserDictService userDictService; // 用户字典
	
	/**
	 * 获取单条数据
	 * 
	 * @param btypeInfo
	 * @return
	 */
	public BtypeInfo get(BtypeInfo btypeInfo) {
		return super.get(btypeInfo);
	}

	/**
	 * 查询列表数据
	 * 
	 * @param btypeInfo
	 * @return
	 */
	public List<BtypeInfo> findList(BtypeInfo btypeInfo) {
		return this.findList(btypeInfo);
	}

	/**
	 * 查询客户信息列表数据
	 * 
	 * @param page
	 * @param btypeInfo
	 * @return
	 */
	public Page<BtypeInfo> getKhList(Page<BtypeInfo> page, BtypeInfo btypeInfo) {
		return super.findPage(page, btypeInfo);
	}

	/**
	 * 查询分页数据
	 * 
	 * @param page
	 *            分页对象
	 * @param btypeInfo
	 * @return
	 */
	public Page<BtypeInfo> findPage(Page<BtypeInfo> page, BtypeInfo btypeInfo) {
		return super.findPage(page, btypeInfo);
	}

	public int getKhCount(BtypeInfo btypeInfo) {
		return dao.getKhCount(btypeInfo);
	}

	/**
	 * 保存数据（插入或更新）
	 * 
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void save(BtypeInfo btypeInfo, BtypeExt btypeExt,
			List<BtypeAttr> btypeAttrList) {

		if (btypeInfo.getIsNewRecord()) {
			// 保存Info表
			btypeInfo.preInsert();
			btypeInfo.setIsAdmin("0");
			dao.insert(btypeInfo);
			// 保存Ext表
			btypeExt.preInsert();
			btypeExt.setBtypeSorts(StringUtils.join(
					btypeInfo.getBtypeSortsList(), ","));
			btypeExt.setBtypeCode(btypeInfo.getBtypeCode());			
			btypeExt.setBtypeName(btypeInfo.getBtypeName());
			btypeExt.setPropertyCode(btypeInfo.getPropertyCode());
			btypeExt.setPropertyName(btypeInfo.getPropertyName());
			btypeExt.setCountryCode(btypeInfo.getCountryCode());
			btypeExt.setCountryName(btypeInfo.getCountryName());
			btypeExt.setTradeSortCode(btypeInfo.getTradeSortCode());
			btypeExt.setTradeSortName(btypeInfo.getTradeSortName());
			btypeExt.setGardenCode(btypeInfo.getGardenCode());
			btypeExt.setGardenName(btypeInfo.getGardenName());
			btypeExt.setMarketSortCode(btypeInfo.getMarketSortCode());
			btypeExt.setMarketSortName(btypeInfo.getMarketSortName());
			// btypeExt.setCityCode(MdmCommonUtils.getCityCode(btypeExt.getAreaCode()));
			// btypeExt.setCityName(MdmCommonUtils.getCityName(btypeExt.getAreaName()));
			// btypeExt.setProvinceCode(MdmCommonUtils.getProvinceCode(btypeExt.getAreaCode()));
			// btypeExt.setProvinceName(MdmCommonUtils.getProvinceName(btypeExt.getAreaName()));
			// btypeExt.setDistrictCode(MdmCommonUtils.getDistrictCode(btypeExt.getAreaCode()));
			// btypeExt.setDistrictName(MdmCommonUtils.getDistrictName(btypeExt.getAreaName()));
			if (btypeExt.getAreaCode() != null
					&& !btypeExt.getAreaCode().equals("")) {
				btypeExt = MdmCommonUtils.setAreaValue(btypeExt,
						btypeExt.getAreaCode(), btypeExt.getAreaName());
			}
			// logger.debug("ProvinceCode:{}",btypeExt.getProvinceCode());
			// logger.debug("ProvinceName:{}",btypeExt.getProvinceName());
			btypeExtDao.insert(btypeExt);
			// 保存Attr表
			List<String> list = btypeInfo.getBtypeSortsList();
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					BtypeAttr btypeAttr = new BtypeAttr();
					btypeAttr.preInsert();
					btypeAttr.setId(IdGen.nextId());
					btypeAttr.setBtypeCode(btypeInfo.getBtypeCode());
					btypeAttr.setBtypeName(btypeInfo.getBtypeName());
					btypeAttr.setAttributeSort("单位类型");
					btypeAttr.setAttributeValue(list.get(i));
					btypeAttr.setAttributeCode(btypeAttrDao
							.findAttrCodeByName(list.get(i)));
					btypeAttrDao.insert(btypeAttr);
				}
			}

		} else {
			// 更新Info表
			btypeInfo.preUpdate();
			dao.update(btypeInfo);
			// btypeExt=btypeInfo.getBtypeExt();
			// 保存Ext表
			btypeExt.preUpdate();
			btypeExt.setBtypeCode(btypeInfo.getBtypeCode());
			btypeExt.setBtypeName(btypeInfo.getBtypeName());
			btypeExt.setPropertyCode(btypeInfo.getPropertyCode());
			btypeExt.setPropertyName(btypeInfo.getPropertyName());
			btypeExt.setCountryCode(btypeInfo.getCountryCode());
			btypeExt.setCountryName(btypeInfo.getCountryName());
			btypeExt.setTradeSortCode(btypeInfo.getTradeSortCode());
			btypeExt.setTradeSortName(btypeInfo.getTradeSortName());
			btypeExt.setGardenCode(btypeInfo.getGardenCode());
			btypeExt.setGardenName(btypeInfo.getGardenName());
			btypeExt.setMarketSortCode(btypeInfo.getMarketSortCode());
			btypeExt.setMarketSortName(btypeInfo.getMarketSortName());
			btypeExt.setBtypeSorts(StringUtils.join(
					btypeInfo.getBtypeSortsList(), ","));
			btypeExt.setCityCode(MdmCommonUtils.getCityCode(btypeExt
					.getAreaCode()));
			btypeExt.setCityName(MdmCommonUtils.getCityName(btypeExt
					.getAreaName()));
			btypeExt.setProvinceCode(MdmCommonUtils.getProvinceCode(btypeExt
					.getAreaCode()));
			btypeExt.setProvinceName(MdmCommonUtils.getProvinceName(btypeExt
					.getAreaName()));
			btypeExt.setDistrictCode(MdmCommonUtils.getDistrictCode(btypeExt
					.getAreaCode()));
			btypeExt.setDistrictName(MdmCommonUtils.getDistrictName(btypeExt
					.getAreaName()));
			// btypeExt=MdmCommonUtils.setAreaValue(btypeExt,
			// btypeExt.getAreaCode(), btypeExt.getAreaName());
			btypeExtDao.update(btypeExt);
			// 删除Attr表
			BtypeAttr btAttr = new BtypeAttr();
			btAttr.setBtypeCode(btypeInfo.getBtypeCode());
			btypeAttrDao.deleteBtypeAttr(btAttr);
			// 保存Attr表
			List<String> list = btypeInfo.getBtypeSortsList();
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					BtypeAttr btypeAttr = new BtypeAttr();
					btypeAttr.preInsert();
					btypeAttr.setId(IdGen.nextId());
					btypeAttr.setBtypeCode(btypeInfo.getBtypeCode());
					btypeAttr.setBtypeName(btypeInfo.getBtypeName());
					btypeAttr.setAttributeSort("单位类型");
					btypeAttr.setAttributeValue(list.get(i));
					btypeAttr.setAttributeCode(btypeAttrDao
							.findAttrCodeByName(list.get(i)));
					btypeAttrDao.insert(btypeAttr);
				}
			}
			// if (btypeInfo.getBtypeAttrList() != null &&
			// btypeInfo.getBtypeAttrList().size() > 0) {
			// String[] attr = btypeInfo.getBtypeSortsList().split(",");
			// for (int i = 0; i < attr.length; i++) {
			// BtypeAttr btypeAttr = new BtypeAttr();
			// btypeAttr.preInsert();
			// btypeAttr.setId(IdGen.nextId());
			// btypeAttr.setBtypeCode(btypeInfo.getBtypeCode());
			// btypeAttr.setBtypeName(btypeInfo.getBtypeName());
			// btypeAttr.setAttributeName("单位类型");
			// btypeAttr.setAttributeValue(attr[i]);
			// btypeAttrDao.insert(btypeAttr);
			// }
			//
			// }
		}
	}

	/**
	 * 删除数据
	 * 
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void delete(BtypeInfo btypeInfo) {
		super.delete(btypeInfo);
	}

	/**
	 * 停用
	 * 
	 * @Title: disable
	 * @Description: TODO
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void disable(BtypeInfo btypeInfo) {
		dao.disable(btypeInfo);
	}

	/**
	 * 启用
	 * 
	 * @Title: enable
	 * @Description: TODO
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void enable(BtypeInfo btypeInfo) {
		dao.enable(btypeInfo);
	}

	/**
	 * 取消主管单位
	 * 
	 * @Title: isNotAdmin
	 * @Description: TODO
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void isNotAdmin(BtypeInfo btypeInfo) {
		dao.isNotAdmin(btypeInfo);
	}

	/**
	 * 设置主管单位
	 * 
	 * @Title: isAdmin
	 * @Description: TODO
	 * @param btypeInfo
	 */
	@Transactional(readOnly = false)
	public void isAdmin(BtypeInfo btypeInfo) {
		dao.isAdmin(btypeInfo);
	}

	/**
	 * @Title: findMaxCode
	 * @Description: 获取最大往来单位编码
	 * @param btypeInfo
	 * @return
	 */
	public List<BtypeInfo> findMaxCode(BtypeInfo btypeInfo) {

		return dao.findMaxCode(btypeInfo);
	}

	/**
	 * @Title: findCustomerData
	 * @Description: 获取客户数据
	 * @param BTYPE_NAME
	 * @return all
	 */
	public List<BtypeInfo> findCustomerData(BtypeInfo btypeInfo) {
		return dao.findCustomerData(btypeInfo);
	}

	/**
	 * 保存客户基本信息，同时保存项目 信息、联系人信息、每个项目 下的里程碑信息
	 * 
	 * @author lichangmei-2016.06.06
	 * @param btypeInfo
	 * @param model
	 * @return
	 *//*
	@Transactional(readOnly = false)
	public void saveKhInfo(BtypeInfo btypeInfo) {
		// 1.保存客户信息
		btypeInfo.setIsAdmin("0");
		if (StringUtils.isBlank(btypeInfo.getBtypeCode())) {
			String btypeCode = randomService.findMaxBianHao("MDM_BTYPE_INFO",
					"BTYPE_CODE");
			if (StringUtils.isBlank(btypeCode)) {
				btypeInfo.setBtypeCode(DateUtils.getYear()
						+ DateUtils.getMonth() + "0001");
			} else {
				btypeInfo.setBtypeCode(btypeCode); // 获取最大编号
			}
			btypeInfo.setCreateBy(UserUtils.getUser());
			btypeInfo.setCreateDate(new Date());
			btypeInfo.setUpdateBy(UserUtils.getUser());
			btypeInfo.setUpdateDate(new Date());
			dao.insert(btypeInfo);
		} else {
			btypeInfo.setUpdateBy(UserUtils.getUser());
			btypeInfo.setUpdateDate(new Date());
			dao.update(btypeInfo);
		}
		// 2.保存项目信息
		for (ProjectInfo projectInfo : btypeInfo.getProjectInfoList()) {
			if (StringUtils.isBlank(projectInfo.getProjectCode())) {
				projectInfo.preInsert();
				projectInfo.setCustomerCode(btypeInfo.getBtypeCode()); // 客户编码
				projectInfo.setCustomerName(btypeInfo.getBtypeName()); // 客户名称
				User currentUser = UserUtils.getUser();
				projectInfo.setProjXsCode(currentUser.getUserCode());
				projectInfo.setProjXsName(currentUser.getUserName());
				projectInfo.setCorpCode(currentUser.getCorpCode());
				projectInfo.setCorpName(currentUser.getCorpName());
				if (StringUtils.isBlank(projectInfo.getProjectCode())) {
					projectInfo.setProjectCode(randomService.findMaxBianHao(
							"PPM_PROJECT_INFO", "PROJECT_CODE")); // 获取最大编号
				}
				if (StringUtils.isNotBlank(projectInfo.getSortCode())) {
					projectInfo.setSortName(projectInfoService
							.findDictNameByDictCode(projectInfo.getSortCode())); // 根据项目分类编码查询名称
				}
				projectInfoService.insert(projectInfo);
				// 保存财务项目表
				ItemInfo paramT = new ItemInfo();
				paramT.setItemCode(projectInfo.getProjectCode());
				ItemInfo paramT1 = itemInfoDao.findItem(paramT);
				if (paramT1 == null) {
					swapItemInfo(projectInfo, paramT);
					itemInfoDao.insert(paramT);
				} else {
					paramT.preUpdate();
					paramT.setCorpCode(projectInfo.getCorpCode());
					paramT.setCorpName(projectInfo.getCorpName());
					paramT.setItemCode(projectInfo.getProjectCode());
					paramT.setItemName(projectInfo.getProjectName());
					paramT.setSortCode("1001");
					paramT.setSortName("工程项目");
					paramT.setFlag("1");
					itemInfoDao.update(paramT);
				}

				// 4.保存里程碑信息
				UserDict projJd = new UserDict();
				projJd.setDictTypeCode("project_stage");
				List<UserDict> jdList = userDictService.findList(projJd); // 获取里程碑信息（项目进度）
				Double sorts = 10.0;
				for (UserDict userDict : jdList) {
					ProjectMilestone projectMilestone = new ProjectMilestone();
					projectMilestone.preInsert();
					projectMilestone.setProjectCode(projectInfo
							.getProjectCode()); // 项目编码
					projectMilestone.setProjectName(projectInfo
							.getProjectName()); // 项目名称
					projectMilestone.setStageCode(userDict.getDictValue()); // 里程碑编码
					projectMilestone.setStageName(userDict.getDictName()); // 里程碑名称
					User cu = UserUtils.getUser();
					projectMilestone.setSorts(sorts);
					projectMilestone.setCorpCode(cu.getCorpCode());
					projectMilestone.setCorpName(cu.getCorpName());
					projectMilestoneService.insert(projectMilestone); // 保存
					sorts = sorts + 10.0;
				}
			} else {
				projectInfo.setCreateBy(UserUtils.getUser());
				projectInfo.setCreateDate(new Date());
				projectInfo.setUpdateBy(UserUtils.getUser());
				projectInfo.setUpdateDate(new Date());
				User currentUser = UserUtils.getUser();
				projectInfo.setCorpCode(currentUser.getCorpCode());
				projectInfo.setCorpName(currentUser.getCorpName());
				projectInfo.setCustomerCode(btypeInfo.getBtypeCode()); // 客户编码
				projectInfo.setCustomerName(btypeInfo.getBtypeName()); // 客户名称
				if (StringUtils.isNotBlank(projectInfo.getSortCode())) {
					projectInfo.setSortName(projectInfoService
							.findDictNameByDictCode(projectInfo.getSortCode())); // 根据项目分类编码查询名称
				}
				projectInfoService.update(projectInfo);
			}
		}
		// 3.保存联系人信息
		rwglSysKhLxrDao.deleteBykhCode(btypeInfo.getBtypeCode()); // 根据
																	// 客户编码，删除所有的联系人
		for (RwglSysKhLxr rwglSysKhLxr : btypeInfo.getRwglSysKhLxrList()) {
			rwglSysKhLxr.preInsert();
			rwglSysKhLxr.setKhCode(btypeInfo.getBtypeCode());
			rwglSysKhLxr.setLxrCode(randomService.getMaxBianHao(
					"RWGL_SYS_KH_LXR", "LXR_CODE", 0, RandomUtil.YEAR));
			rwglSysKhLxrDao.insert(rwglSysKhLxr);
		}
	}

	private void swapItemInfo(ProjectInfo projectInfo, ItemInfo paramT) {
		paramT.preInsert();
		paramT.setCorpCode(projectInfo.getCorpCode());
		paramT.setCorpName(projectInfo.getCorpName());
		paramT.setItemCode(projectInfo.getProjectCode());
		paramT.setItemName(projectInfo.getProjectName());
		paramT.setSortCode("1001");
		paramT.setSortName("工程项目");
		paramT.setFlag("1");
	}*/

	/**
	 * @Title: findBtypeInfo
	 * @Description: 查询客户信息
	 * @param btypeInfo
	 * @author liuchangmei
	 * @date 2016年6月12日
	 */
	public List<BtypeInfo> findBtypeInfo(BtypeInfo btypeInfo) {
		return dao.findBtypeInfo(btypeInfo);
	}

	public List<BtypeInfo> findBtypeInfoByCode(String code) {
		return dao.findBtypeInfoByCode(code);
	}

	public List<BtypeInfo> companyList() {
		return dao.companyList();
	}

	public List<BtypeInfo> findBtypeInfoByProjectCode(BtypeInfo btypeInfo) {
		return dao.findBtypeInfoByProjectCode(btypeInfo);
	}

	/**
	 * 
	 * @Title: appSave
	 * @createBy：Mc
	 * @date: 2017年1月18日 下午3:18:02
	 * @param btypeInfo
	 */
	/*@Transactional(readOnly = false)
	public void appSave(BtypeInfo btypeInfo) {
		// 保存客户信息表
		btypeInfo.setIsAdmin("0");
		btypeInfo.setId(btypeInfo.getBtypeCode());
		btypeInfo.setUpdateBy(UserUtils.getUser());
		btypeInfo.setUpdateDate(new Date());
		User currUser = UserUtils.getUser();
		if (btypeInfo.getIsNewRecord() == true) {
			String btypeCode = randomService.findMaxBianHao("MDM_BTYPE_INFO",
					"BTYPE_CODE");
			btypeInfo.setBtypeCode(DateUtils.getYear() + DateUtils.getMonth()
					+ "0001");
			if (StringUtils.isBlank(btypeCode)) {
				btypeInfo.setBtypeCode(DateUtils.getYear()
						+ DateUtils.getMonth() + "0001");
			} else {
				btypeInfo.setBtypeCode(btypeCode); // 获取最大编号
			}
			btypeInfo.setCreateBy(UserUtils.getUser());
			btypeInfo.setCreateDate(new Date());
			dao.insert(btypeInfo);
		} else {
			dao.update(btypeInfo);
		}
		// json串转化为list
		if (StringUtils.isNotBlank(btypeInfo.getJsonStr())) {
			List<RwglSysKhLxr> list = JSONArray.parseArray(
					btypeInfo.getJsonStr(), RwglSysKhLxr.class);
			btypeInfo.setRwglSysKhLxrList(list);
		}
		// 保存联系人表
		RwglSysKhLxr lxr=new RwglSysKhLxr();
		Page<RwglSysKhLxr> page=new Page<RwglSysKhLxr>();
		Page<RwglSysKhLxr> page1=rwglSysKhLxrService.findPage(page, lxr);
		if ((btypeInfo.getRwglSysKhLxrList().size() >= 0) && (page1 != null)) {
			for (RwglSysKhLxr rwglSysKhLxr : btypeInfo.getRwglSysKhLxrList()) {
				rwglSysKhLxr.setKhCode(btypeInfo.getBtypeCode());
				rwglSysKhLxrService.save(rwglSysKhLxr);
			}

		}
		CrmBtypeManager manager = new CrmBtypeManager();
		// 3.保存业务员信息
		if (btypeInfo.getManagerName() != null) {// 
			String arr[] = btypeInfo.getManagerCode().split(",");
			String arr1[] = btypeInfo.getManagerName().split(",");
			CrmBtypeManager crmbtypeManager1=new CrmBtypeManager();
			crmbtypeManager1.setBtypeCode(btypeInfo.getBtypeCode());
			crmbtypeManager1.preUpdate();
			crmBtypeManagerDao.deleteByBtypeCode(crmbtypeManager1);
			for (int i = 0; i < arr.length; i++) {
				manager.setEmpCode(arr[i]);
				manager.setEmpName(arr1[i]);
				manager.setUserCode(dao.getUserCode(arr[i]));//根据EmpCode查UserCode
				manager.setUserName(arr1[i]);
				manager.setBtypeCode(btypeInfo.getBtypeCode());
				manager.setBtypeName(btypeInfo.getBtypeName());
				manager.setCorpCode(currUser.getCorpCode());
				manager.setCorpName(currUser.getCorpName());
				manager.setUpdateBy(UserUtils.getUser());
				manager.setUpdateDate(new Date());
				manager.setStatus("0");
					manager.setId(IdGen.nextId());
					manager.setCreateBy(UserUtils.getUser());
					manager.setCreateDate(new Date());
					crmBtypeManagerDao.insert(manager);
				
			}
		}
	}*/
	//查询下拉菜单
	public List<BtypeInfo> btypeInfos(BtypeInfo btypeInfo){
		return dao.btypeInfos(btypeInfo);
		
	}
	/**
	 * @Title: 查询查寻单位机构编码 
	 *  赵君彦
	 */
	public String chcode(String btypeName){
		return dao.chcode(btypeName);
		
	}
	/**
	 * @Title: checkName 
	 * @Description: 校验单位名称和简称是否重复
	 * @author: Mc
	 * @date: 2017年6月13日 下午4:56:32 
	 * @return
	 */
	public List<BtypeInfo> checkName(BtypeInfo btypeInfo){
		return dao.checkName(btypeInfo);
	}
}
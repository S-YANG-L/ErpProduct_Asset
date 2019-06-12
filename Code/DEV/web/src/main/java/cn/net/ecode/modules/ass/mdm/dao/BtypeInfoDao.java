/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;

import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;

import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.dao 
 * @ClassName: BtypeInfoDao
 * @Description: TODO
 * @author: 于明珠
 * @date: 2015年9月18日 上午9:22:28 
 * @Version: V1.0
 */
@MyBatisDao
public interface BtypeInfoDao extends CrudDao<BtypeInfo> {

	List<BtypeInfo> companyList();

	/** 
	 * 停用
	 * @Title: disable 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	public int disable(BtypeInfo btypeInfo);

	/**
	 * 启用
	 * @Title: enable 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	public int enable(BtypeInfo btypeInfo);

	/**
	 * 取消主管单位
	 * @Title: isNotAdmin 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	public int isNotAdmin(BtypeInfo btypeInfo);

	/**
	 * 设置主管单位
	 * @Title: isAdmin 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	public int isAdmin(BtypeInfo btypeInfo);
	
	/** 
	 * @Title: 获得最大往来单位编号 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	public List<BtypeInfo> findMaxCode(BtypeInfo btypeInfo);
	/** 
	 * @Title: 获取客户数据
	 * @param btypeInfo
	 * @return all
	 */
	public List<BtypeInfo> findCustomerData(BtypeInfo btypeInfo);
	
	/** 
	 * @Title: findBtypeInfo  
	 * @Description: 查询客户信息
	 * @param btypeInfo
	 * @author liuchangmei
	 * @date 2016年6月12日
	 */
	public List<BtypeInfo> findBtypeInfo(BtypeInfo btypeInfo);
	public List<BtypeInfo> findBtypeInfoByCode(String code);

	public Page<BtypeInfo> getKhList(Page<BtypeInfo> page, BtypeInfo btypeInfo);

	public int getKhCount(BtypeInfo btypeInfo);

	public List<BtypeInfo> findBtypeInfoByProjectCode(BtypeInfo btypeInfo);

	public String getUserCode(String string);
	//查询下拉列表
	public List<BtypeInfo> btypeInfos(BtypeInfo btypeInfo);
	
	public List<BtypeInfo> checkName(BtypeInfo btypeInfo);
	//查询客户code
	public String chcode(String btypeName);
}
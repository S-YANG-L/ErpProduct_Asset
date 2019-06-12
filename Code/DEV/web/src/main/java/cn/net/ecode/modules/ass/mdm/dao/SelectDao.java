/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.dao;

import cn.net.ecode.common.persistence.annotation.MyBatisDao;

import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;
import cn.net.ecode.modules.sys.entity.UserDict;

import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.dao 
 * @ClassName: SelectDao
 * @Description: TODO
 * @author: 车磊岩
 * @date: 2015年9月22日 下午1:23:41 
 * @Version: V1.0
 */
@MyBatisDao
public interface SelectDao {
	
	//获取企业列表
	public List<BtypeInfo> findBtypeList(BtypeInfo btypeInfo);
	//根据字典类型编码获取用户字典
	public List<UserDict> findUserDictByTypeCode(UserDict userDict);
	//根据区编码返回市编码
	public String getCityCodeDistrictCode(String districtCode);
	//根据区编码返回省编码
	public String getProvinceCodeDistrictCode(String districtCode);

	
}
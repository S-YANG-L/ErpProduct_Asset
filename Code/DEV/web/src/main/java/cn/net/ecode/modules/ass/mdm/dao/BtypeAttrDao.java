/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.mdm.entity.BtypeAttr;


/**
 * 单位属性表DAO接口
 * @Package: cn.net.ecode.mdm.dao 
 * @ClassName: BtypeAttrDao
 * @Description: TODO
 * @author: 于明珠
 * @date: 2015年9月30日 上午11:18:23 
 * @Version: V1.0
 */
@MyBatisDao
public interface BtypeAttrDao extends CrudDao<BtypeAttr> {
	/** 
	 * @Title: 删除Attr表信息 
	 * @Description: TODO
	 * @param btypeAttr
	 * @return
	 */
	public int deleteBtypeAttr(BtypeAttr btypeAttr);
	
	/** 
	 * 根据名称查询编码
	 * @Title: findAttrCodeByName 
	 * @Description: TODO
	 * @param attrName
	 * @return
	 */
	public String findAttrCodeByName(String attrName);

}
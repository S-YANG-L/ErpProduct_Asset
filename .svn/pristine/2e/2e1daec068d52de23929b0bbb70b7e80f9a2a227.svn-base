/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.service;


import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.modules.ass.mdm.dao.SelectDao;
import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;
import cn.net.ecode.modules.sys.entity.UserDict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.service
 * @ClassName: SelectService
 * @Description: TODO
 * @author: 车磊岩
 * @date: 2015年9月22日 下午1:15:22
 * @Version: V1.0
 */
@Service
@Transactional(readOnly = true)
public class SelectService {
	
	@Autowired
	private SelectDao selectDao;
	
	public Page<BtypeInfo> findBtypeList(Page<BtypeInfo> page, BtypeInfo btypeInfo) {
		// 设置分页参数
		btypeInfo.setPage(page);
		page.setList(selectDao.findBtypeList(btypeInfo));
		return page;
	}
	
	public List<UserDict> findUserDictByTypeCode(UserDict userDict){
		return selectDao.findUserDictByTypeCode(userDict);
		
	}

}
/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.service;

import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.common.dao.CommonDao;
import cn.net.ecode.modules.ass.common.entity.Common;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
@Transactional(readOnly = true)
public class CommonService extends CrudService<CommonDao, Common>{

    public Common getOfficeCompany(String usercode) {
       return dao.getOfficeCompany(usercode);
    }
}
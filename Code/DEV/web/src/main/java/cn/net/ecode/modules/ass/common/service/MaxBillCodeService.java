/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.service;

import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.common.dao.MaxBillCodeDao;
import cn.net.ecode.modules.ass.common.entity.MaxBillCode;
import cn.net.ecode.modules.sys.entity.Company;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.service.CompanyService;
import cn.net.ecode.modules.sys.utils.DictUtils;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 单表生成Service
 * @author 肖敦山
 * @version 2015-10-27
 */
@Service
@Transactional(readOnly = true)
public class MaxBillCodeService extends CrudService<MaxBillCodeDao, MaxBillCode> {

	@Autowired
	private CompanyService companyService;
	
	@Transactional(readOnly = false)
	public String getMaxCode(String billType,String companyCode) {
		String strMaxBillCode;
		MaxBillCode maxBillCode = new MaxBillCode();		
		User currUser = UserUtils.getUser();
		maxBillCode.setCorpCode(currUser.getCorpCode());
		String year= DateUtils.getDate("yyyy").substring(2);
		maxBillCode.setAccountYear(year);
		maxBillCode.setBillsortCode(billType);
		maxBillCode.setCompanyCode(companyCode);
		MaxBillCode nowBillCode= dao.get(maxBillCode);
		if(nowBillCode==null){
			strMaxBillCode=billType+"-"+year+"000001";
			maxBillCode.setId(IdGen.nextId());
			maxBillCode.setCorpName(currUser.getCorpName());
			if(StringUtils.isNotBlank(companyCode)){
				Company company= companyService.get(companyCode);
				maxBillCode.setCompanyName(company.getCompanyName());
			}
			maxBillCode.setBillsortName(DictUtils.getDictLabel(billType, "bill_type", ""));
			maxBillCode.setMaxCode(1);
			insert(maxBillCode);			
		}
		else{
			
			maxBillCode.setMaxCode(nowBillCode.getMaxCode()+1);
			maxBillCode.setSysId(nowBillCode.getSysId());
			this.update(maxBillCode);
			strMaxBillCode=billType+"-"+year+ StringUtils.leftPad(String.valueOf(nowBillCode.getMaxCode()+1), 6, "0");
		}
		return strMaxBillCode;
	}	
	
	
	@Transactional(readOnly = false)
	public void update(MaxBillCode maxBillCode){
		dao.update(maxBillCode);
	}
	@Transactional(readOnly = false)
	public void insert(MaxBillCode maxBillCode){
		dao.insert(maxBillCode);
	}
}
/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.codingrule.dao.CodeRulesDao;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRules;

import cn.net.ecode.modules.ass.common.dao.CommonDao;
import cn.net.ecode.modules.ass.common.entity.CodeAssetSort;
import cn.net.ecode.modules.sys.entity.Office;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRule;
import cn.net.ecode.modules.ass.codingrule.dao.CodeRuleDao;

/**
 * 编码规则Service
 * @author zhaohongbin
 * @version 2018-09-10
 */
@Service
@Transactional(readOnly = true)
public class CodeRuleService extends CrudService<CodeRuleDao, CodeRule> {
    @Autowired
    private CodeRulesDao codeRulesDao;
    @Autowired
    private CommonDao commonDao;
    /**
	 * 获取单条数据
	 * @param codeRule
	 * @return
	 */
	public CodeRule get(CodeRule codeRule) {
		return super.get(codeRule);
	}
	/**
	 * 查询列表数据
	 * @param codeRule
	 * @return
	 */
	public List<CodeRule> findList(CodeRule codeRule) {
		return super.findList(codeRule);
	}
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param codeRule
	 * @return
	 */
	public Page<CodeRule> findPage(Page<CodeRule> page, CodeRule codeRule) {
		return super.findPage(page, codeRule);
	}
	/**
	 * 保存数据（插入或更新）
	 * @param codeRule
	 */
	@Transactional(readOnly = false)
	public void save(CodeRule codeRule) {
        if(codeRule.getIsNewRecord()){
            super.save(codeRule);
            saveall(codeRule);
        }else{
            super.save(codeRule);
            CodeRules codeRules = new CodeRules();
            codeRules.setCodeId(codeRule.getCodeId());
            codeRules.preUpdate();
            dao.deletecodeRules(codeRules);
            saveall(codeRule);
        }
    }

    /**
     *
     * 封装主子表保存编辑都执行的代码
     * @param codeRule
     */
    public void saveall(CodeRule codeRule) {
        CodeRules codeRules = new CodeRules();
        for (int i = 0; i < codeRule.getCodeRulesList().size(); i++) {
            codeRules.preInsert();
            CodeRules codeRules1=codeRule.getCodeRulesList().get(i);
            codeRules.setId(IdGen.nextId());
            codeRules.setCodeId(codeRule.getCodeId());
            codeRules.setRulesItemCode(codeRules1.getRulesItemCode());
            codeRules.setRulesItemName(codeRules1.getRulesItemName());
            codeRules.setCodeFormat(codeRules1.getCodeFormat());
            codeRules.setCodeFormatContent(codeRules1.getCodeFormatContent());
            codeRules.setCodeLen(codeRules1.getCodeLen());
            codeRules.setRulesRemarks(codeRules1.getRulesRemarks());
            codeRules.setFlowComplement(codeRules1.getFlowComplement());
            codeRules.setFlowComplementMode(codeRules1.getFlowComplementMode());
            dao.savecodeRules(codeRules);
        }
    }
	
	/**
	 * 删除数据
	 * @param codeRule
	 */
	@Transactional(readOnly = false)
	public void delete(CodeRule codeRule) {
		super.delete(codeRule);
	}

    @Transactional(readOnly = false)
    public List<CodeRules> findListDtl(CodeRules codeRules) {
	   return   dao.findListDtl(codeRules);
    }

    @Transactional(readOnly = false)
    public void deletecode(CodeRules codeRules) {
	    dao.deletecodeRules(codeRules);
    }

    /**
     * 资产模块编码生成
     */
    @Transactional(readOnly = false)
    public String createCode(String Re, String sortCode,String officeCode, String companyCode){
        //返回的编码
        String newCode = "";
        //获取规则
        CodeRule codeRule1 = this.getCodeRule(Re);
        newCode = newCode + Re;
        List<CodeRules> assetCodeRulesList = codeRule1.getCodeRulesList();
        for(CodeRules codeRules:assetCodeRulesList){
            //01 购入日期（六位） 02 资产分类编码 03 部门编码 04 公司编码 05 购入日期（八位）
            if(codeRules.getRulesItemCode().equals("01")){
                SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMM");
                newCode = newCode + codeDate.format(new Date());
            }else if(codeRules.getRulesItemCode().equals("02")) {
                newCode = newCode + sortCode;
            }else if(codeRules.getRulesItemCode().equals("03")) {
                newCode = newCode + officeCode;
            }else if(codeRules.getRulesItemCode().equals("04")) {
                newCode = newCode + companyCode;
            }else if(codeRules.getRulesItemCode().equals("05")) {
                SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMMdd");
                newCode = newCode + codeDate.format(new Date());
            }
        }
        //流水号
        String liushui="";
        //最大编码Int
        int serialstrint;
        //最大编码String
        String serialstring;
        CodeAssetSort codeAssetSort=new CodeAssetSort();
        codeAssetSort.setBillsortCode(Re);
        codeAssetSort.setBillsortName(codeRule1.getCodeObject());
        SimpleDateFormat accoutYear = new SimpleDateFormat("yyyyMM");accoutYear.format(new Date());
        codeAssetSort.setAccoutYear(accoutYear.format(new Date()));
        CodeAssetSort codeAssetSortNew= commonDao.getMaxbillcode(codeAssetSort);
        if(codeAssetSortNew==null){
            serialstring="1";
            for(int j=0;j<Integer.parseInt(codeRule1.getMaxCode());j++){
                liushui=liushui+"0";
            }
            DecimalFormat df=new DecimalFormat(liushui);
            String serial=df.format(Integer.parseInt(serialstring));
            newCode = newCode + serial;
            codeAssetSort.setMaxCode("1");
            codeAssetSort.setSysId(IdGen.nextId());
            codeAssetSort.preInsert();
            commonDao.insertBillcode(codeAssetSort);
        }else{
            serialstrint= Integer.parseInt(codeAssetSortNew.getMaxCode());
            serialstrint++;
            serialstring= String.valueOf(serialstrint);
            for(int j=0;j<Integer.parseInt(codeRule1.getMaxCode());j++){
                liushui=liushui+"0";
            }
            DecimalFormat df=new DecimalFormat(liushui);
            String serial=df.format(Integer.parseInt(serialstring));
            newCode = newCode+serial;
            codeAssetSortNew.setMaxCode(serialstring);
            commonDao.updateBillcode(codeAssetSortNew);
        }
        return newCode;
    }
    /**
     * 存放地址模块编码生成
     */
    @Transactional(readOnly = false)
    public String createBgCode(String code, String name){
        //返回的编码
        String newCode = "";
        newCode = newCode+code;
        CodeAssetSort codeAssetSort=new CodeAssetSort();
        codeAssetSort.setBillsortCode(code);
        codeAssetSort.setBillsortName(name);
        SimpleDateFormat accoutYear = new SimpleDateFormat("yyyyMM");accoutYear.format(new Date());
        codeAssetSort.setAccoutYear(accoutYear.format(new Date()));
        CodeAssetSort codeAssetSortNew= commonDao.getMaxbillcode(codeAssetSort);
        SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMMdd");
        newCode = newCode + codeDate.format(new Date());
        if(codeAssetSortNew==null){
            String rule="";
            for(int j=0;j<4;j++){
                rule=rule+"0";
            }
            DecimalFormat df=new DecimalFormat(rule);
            String serial=df.format(1);
            codeAssetSort.setMaxCode("1");
            codeAssetSort.setSysId(IdGen.nextId());
            codeAssetSort.preInsert();
            commonDao.insertBillcode(codeAssetSort);
            newCode = newCode + serial;
        }else{
            String rule="";
            for(int j=0;j<4;j++){
                rule=rule+"0";
            }
            DecimalFormat df=new DecimalFormat(rule);
            String serial=df.format(Integer.parseInt(codeAssetSortNew.getMaxCode()));
            int numall=Integer.parseInt(codeAssetSortNew.getMaxCode())+1;
            codeAssetSortNew.setMaxCode(String.valueOf(numall));
            commonDao.updateBillcode(codeAssetSortNew);
            newCode = newCode + serial;
        }
        return newCode;
    }
    /**
     * 存放地址，供货商模块编码生成
     */
    @Transactional(readOnly = false)
    public String createCgCode(String code, String name){
        //返回的编码
        String newCode = "";
        CodeAssetSort codeAssetSort=new CodeAssetSort();
        codeAssetSort.setBillsortCode(code);
        codeAssetSort.setBillsortName(name);
        CodeAssetSort codeAssetSortNew= commonDao.getMaxbillcode(codeAssetSort);
        if(codeAssetSortNew==null){
        }else{
            int numall=Integer.parseInt(codeAssetSortNew.getMaxCode())+1;
            codeAssetSortNew.setMaxCode(String.valueOf(numall));
            commonDao.updateBillcode(codeAssetSortNew);
            newCode= String.valueOf(10000+numall);
        }
        return newCode;
    }
    private CodeRule getCodeRule(String codeObjectId) {
        CodeRule entity = dao.getCodeRule(codeObjectId);
        if (entity != null){
            CodeRules codeRules = new CodeRules();
            String codeId = entity.getCodeId();
            codeRules.setCodeId(codeId);
            entity.setCodeRulesList(codeRulesDao.findList(codeRules));
        }
        return entity;
    }
}
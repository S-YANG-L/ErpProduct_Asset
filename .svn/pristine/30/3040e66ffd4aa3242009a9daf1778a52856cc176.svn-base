/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.price.service;

import java.util.List;

import cn.net.ecode.modules.ass.price.dao.InvPriceAdjustDao;
import cn.net.ecode.modules.ass.price.entity.InvPriceAdjust;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.sys.entity.Company;



/**
 * 面价管理Service
 * @author 陈玉春
 * @version 2016-05-24
 */
@Service
@Transactional(readOnly = true)
public class InvPriceAdjustService extends CrudService<InvPriceAdjustDao, InvPriceAdjust> {

	/*@Autowired
	private InvPriceDao invPriceDao;*/
	/**
	 * 获取单条数据
	 * @param invPriceAdjust
	 * @return
	 */
	public InvPriceAdjust get(InvPriceAdjust invPriceAdjust) {
		return super.get(invPriceAdjust);
	}
	
	/**
	 * 查询列表数据
	 * @param invPriceAdjust
	 * @return
	 */
	public List<InvPriceAdjust> findList(InvPriceAdjust invPriceAdjust) {
		return super.findList(invPriceAdjust);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param invPriceAdjust
	 * @return
	 */
	public Page<InvPriceAdjust> findPage(Page<InvPriceAdjust> page, InvPriceAdjust invPriceAdjust) {
		return super.findPage(page, invPriceAdjust);
	}
	
	
	/**
	 * 工作流保存数据（插入或更新）
	 * @param invPriceAdjust
	 */
	/*@Transactional(readOnly = false)
	public void save(InvPriceAdjust invPriceAdjust) {
		//1.保存主表
		if(invPriceAdjust.getIsNewRecord()==true){
			invPriceAdjust.setSysCode(IdGen.nextId());
			invPriceAdjust.setGrantBillNo(BillTypeUtils.getMaxBillCode(BillTypeUtils.JG, invPriceAdjust.getCompanyCode()));
		}
		invPriceAdjust.setPriceType("1");
		invPriceAdjust.setFlag("2");
		invPriceAdjust.setGrade("0");
		invPriceAdjust.setApprovalStatus("0");
		Date date=new Date();
		User currUser = UserUtils.getUser();
		invPriceAdjust.setCreateDate(date);
		invPriceAdjust.setUpdateDate(date);
		invPriceAdjust.setCreateBy(currUser);
		invPriceAdjust.setUpdateBy(currUser);
		invPriceAdjust.setSysDate(date);
		invPriceAdjust.setCorpCode(currUser.getCorpCode());
		invPriceAdjust.setCorpName(currUser.getCorpName());
		super.save(invPriceAdjust);
		//2.删除子表
		InvPrice invPrice=new InvPrice();
		invPrice.setSysCode(invPriceAdjust.getSysCode());
		invPriceDao.deleteInvPrice(invPrice);
		//3.保存子表
		if (invPriceAdjust.getInvPriceList() != null && invPriceAdjust.getInvPriceList().size() > 0) {
			List<InvPrice> invPriceList=invPriceAdjust.getInvPriceList();
			for (int i = 0; i < invPriceList.size(); i++) {
				InvPrice invPriceData=invPriceList.get(i);
				if (StringUtils.isBlank(invPriceData.getSysId())) {
					invPriceData.setSysId(IdGen.nextId());
				}
				invPriceData.setSysCode(invPriceAdjust.getSysCode());
				Integer maxSerialNo=invPriceDao.getMaxSerialNo(invPriceAdjust.getSysCode());
				if(maxSerialNo==null){
					invPriceData.setSerialNo(0l);
				}else{
					invPriceData.setSerialNo(Long.valueOf(maxSerialNo+1));
				}
				invPriceData.setPriceType("1");
				invPriceData.setFlag("2");
				invPriceData.setGrade("0");
				invPriceData.setLowPrice(0.0);
				invPriceData.setHighPrice(0.0);
				invPriceData.setBeginDate(invPriceAdjust.getBeginDate());
				if(invPriceAdjust.getEndDate()!=null){
					invPriceData.setEndDate(invPriceAdjust.getEndDate());
				}
				invPriceData.setCompanyCode(invPriceAdjust.getCompanyCode());
				invPriceData.setCompanyName(invPriceAdjust.getCompanyName());
				invPriceData.setApprovalStatus("0");
				invPriceData.setCorpCode(currUser.getCorpCode());
				invPriceData.setCorpName(currUser.getCorpName());
				invPriceData.setCreateBy(currUser);
				invPriceData.setCreateDate(date);
				invPriceData.setUpdateBy(currUser);
				invPriceData.setUpdateDate(date);
				invPriceDao.insert(invPriceData);
			}
		}*/
		
		// 推动流程流转
//		        invPriceAdjust.setSysCode(invPriceAdjust.getSysCode());
//				Flow flow = new Flow(invPriceAdjust); // 业务对象要求必须包含主键（默认取业务对象的getId()方法，作为流程和表单的关联关系）。
//				FlowService flowService = FlowService.getInstance();
//				ExpandTaskCommand taskCommand = flowService.getExpandTaskCommand(flow);
//				InvPriceAdjust invPriceMain = new InvPriceAdjust();
//				InvPrice invPriceChild=new InvPrice();
//				if (StringUtils.isNotBlank(taskCommand.getTaskId())) {
//					Task task = flowService.getTask(taskCommand.getTaskId());// 得到任务对象
//					if (task.getNodeId().equals("UserTask_2")) {// 提案审批节点
//						if (taskCommand.getTaskCommandId().equals("HandleCommand_2")) {// 不通过
//							System.out.println("====================提案审批不通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("3");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("3");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//							
//						} else if (taskCommand.getTaskCommandId().equals(
//								"HandleCommand_1")) {
//							System.out.println("====================提案审批通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("1");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("1");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//
//						}
//					} else if (task.getNodeId().equals("UserTask_3")) {// 协同节点
//						if (taskCommand.getTaskCommandId().equals("HandleCommand_2")) {// 不通过
//							System.out.println("====================协同审批不通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("3");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("3");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//
//						} else if (taskCommand.getTaskCommandId().equals("HandleCommand_1")) {
//							System.out.println("====================协同审批通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("1");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("1");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//
//						}
//					} else if (task.getNodeId().equals("UserTask_4")) {// 决策审批节点
//						if (taskCommand.getTaskCommandId().equals("HandleCommand_2")) {// 
//							System.out.println("====================决策审批不通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("3");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("3");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//						} else if (taskCommand.getTaskCommandId().equals(
//								"HandleCommand_1")) {// 通过
//							System.out.println("====================决策审批通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("1");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("1");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//						}
//					} else if (task.getNodeId().equals("UserTask_5")) {// 点检审批节点
//						if (taskCommand.getTaskCommandId().equals("HandleCommand_2")) {// 不通过
//							System.out.println("====================点检审批不通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("3");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("3");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//							}
//						 else if (taskCommand.getTaskCommandId().equals(
//								"HandleCommand_1")) {// 通过流程结束
//							System.out.println("====================点检审批通过");
//							invPriceMain.setSysCode(invPriceAdjust.getSysCode());
//							invPriceMain.setApprovalStatus("2");
//							invPriceMain.setApprovalDate(date);
//							invPriceMain.setApproval(currUser.getUserCode());
//							invPriceMain.setApprovalName(currUser.getUserName());
//							invPriceChild.setSysCode(invPriceAdjust.getSysCode());
//							invPriceChild.setApprovalStatus("2");
//							invPriceChild.setApprovalDate(date);
//							invPriceChild.setApproval(currUser.getUserCode());
//							invPriceChild.setApprovalName(currUser.getUserName());
//							//更新生效日期为当前日期
//							invPriceMain.setBeginDate(date);
//							//更新生效日期为当前日期
//							invPriceChild.setBeginDate(date);
//							dao.updateApproStatus(invPriceMain);
//							invPriceDao.updateApproStatus(invPriceChild);
//							if (invPriceAdjust.getInvPriceList() != null && invPriceAdjust.getInvPriceList().size() > 0) {
//								List<InvPrice> invPriceList=invPriceAdjust.getInvPriceList();
//								for (int i = 0; i < invPriceList.size(); i++) {
//									InvPrice invPriceData=invPriceList.get(i);
//									InvPrice lastInvPrice=new InvPrice();
//									lastInvPrice.setSysId(invPriceData.getSysId());
//									lastInvPrice.setCorpCode(invPriceData.getCorpCode());
//									lastInvPrice.setCompanyCode(invPriceData.getCompanyCode());
//									lastInvPrice.setBtypeCode(invPriceData.getBtypeCode());
//									lastInvPrice.setInvCode(invPriceData.getInvCode());
//									lastInvPrice=invPriceDao.findLastInvPrice(lastInvPrice);
//									if(lastInvPrice!=null){
//										InvPrice lastInv=new InvPrice();
//										lastInv.setSysId(lastInvPrice.getSysId());
//										//更新上一条的停用日期为当前日期
//										lastInv.setEndDate(date);
////										if(lastInvPrice.getEndDate()==null){
////											Date endDate= DateUtils.addDays(invPriceData.getBeginDate(),-1);
////											lastInv.setEndDate(endDate);
////										}
//										invPriceDao.updateLastInvPrice(lastInv);
//									}
//								}
//						}
//					}
//				  }
//				} else {// 发起流程
//					flow.getPersiVars().put("flowStartPerson", invPriceAdjust.getSysCode());
//					flow.getPersiVars().put("flowDeptCode",UserUtils.getUser().getEmployee().getOfficeCode());
//					
//					
//				}
//				flowService.completeTask(flow);
		
//	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param invPriceAdjust
	 */
	/*@Transactional(readOnly = false)
	public void savesmz(InvPriceAdjust invPriceAdjust) {
		//1.保存主表
		if(invPriceAdjust.getIsNewRecord()==true){
			invPriceAdjust.setSysCode(IdGen.nextId());
			invPriceAdjust.setGrantBillNo(BillTypeUtils.getMaxBillCode(BillTypeUtils.JG, invPriceAdjust.getCompanyCode()));
		}
		invPriceAdjust.setPriceType("1");
		invPriceAdjust.setFlag("2");
		invPriceAdjust.setGrade("0");
		invPriceAdjust.setApprovalStatus("0");
		Date date=new Date();
		User currUser = UserUtils.getUser();
		invPriceAdjust.setCreateDate(date);
		invPriceAdjust.setUpdateDate(date);
		invPriceAdjust.setCreateBy(currUser);
		invPriceAdjust.setUpdateBy(currUser);
		invPriceAdjust.setSysDate(date);
		invPriceAdjust.setCorpCode(currUser.getCorpCode());
		invPriceAdjust.setCorpName(currUser.getCorpName());
		super.save(invPriceAdjust);
		//2.删除子表
		InvPrice invPrice=new InvPrice();
		invPrice.setSysCode(invPriceAdjust.getSysCode());
		invPriceDao.deleteInvPrice(invPrice);
		//3.保存子表
		if (invPriceAdjust.getInvPriceList() != null && invPriceAdjust.getInvPriceList().size() > 0) {
			List<InvPrice> invPriceList=invPriceAdjust.getInvPriceList();
			for (int i = 0; i < invPriceList.size(); i++) {
				InvPrice invPriceData=invPriceList.get(i);
				if (StringUtils.isBlank(invPriceData.getSysId())) {
					invPriceData.setSysId(IdGen.nextId());
				}
				invPriceData.setSysCode(invPriceAdjust.getSysCode());
				Integer maxSerialNo=invPriceDao.getMaxSerialNo(invPriceAdjust.getSysCode());
				if(maxSerialNo==null){
					invPriceData.setSerialNo(0l);
				}else{
					invPriceData.setSerialNo(Long.valueOf(maxSerialNo+1));
				}
				if(invPriceData.getLastPrice()==null){
					invPriceData.setLastPrice(0.0);
				}
				if(invPriceData.getLastLowPrice()==null){
					invPriceData.setLastLowPrice(0.0);
				}
				invPriceData.setPriceType("1");
				invPriceData.setFlag("2");
				invPriceData.setGrade("0");
				invPriceData.setHighPrice(0.0);
				invPriceData.setBeginDate(invPriceAdjust.getBeginDate());
				if(invPriceAdjust.getEndDate()!=null){
					invPriceData.setEndDate(invPriceAdjust.getEndDate());
				}
				invPriceData.setCompanyCode(invPriceAdjust.getCompanyCode());
				invPriceData.setCompanyName(invPriceAdjust.getCompanyName());
				invPriceData.setApprovalStatus("0");
				invPriceData.setCorpCode(currUser.getCorpCode());
				invPriceData.setCorpName(currUser.getCorpName());
				invPriceData.setCreateBy(currUser);
				invPriceData.setCreateDate(date);
				invPriceData.setUpdateBy(currUser);
				invPriceData.setUpdateDate(date);
				invPriceDao.insert(invPriceData);
			}
		}
		
	}*/
	
	/**
	 * 提交数据
	 * @param invPriceAdjust
	 */
	/*@Transactional(readOnly = false)
	public void approval(InvPriceAdjust invPriceAdjust) {
		//1.处理审核状态
		InvPriceAdjust invPriceMain = new InvPriceAdjust();
		InvPrice invPriceChild=new InvPrice();
		Date date=new Date();
		User currUser = UserUtils.getUser();
		invPriceMain.setSysCode(invPriceAdjust.getSysCode());
		invPriceMain.setApprovalStatus("2");
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			//更新生效日期为当前日期
			invPriceMain.setBeginDate(df.parse(df.format(date)));
			//更新生效日期为当前日期
			invPriceChild.setBeginDate(df.parse(df.format(date)));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		invPriceMain.setApprovalDate(date);
		invPriceMain.setApproval(currUser.getUserCode());
		invPriceMain.setApprovalName(currUser.getUserName());
		invPriceChild.setSysCode(invPriceAdjust.getSysCode());
		invPriceChild.setApprovalStatus("2");
		invPriceChild.setApprovalDate(date);
		invPriceChild.setApproval(currUser.getUserCode());
		invPriceChild.setApprovalName(currUser.getUserName());
		
		dao.updateApproStatus(invPriceMain);
		invPriceDao.updateApproStatus(invPriceChild);
		//2.把上一条同一公司、经销商、商品的status置为1
		InvPrice invPrice=new InvPrice();
		invPrice.setSysCode(invPriceAdjust.getSysCode());
		List<InvPrice> invPriceList=invPriceDao.findList(invPrice);
		if (invPriceList != null && invPriceList.size() > 0) {
			for (int i = 0; i < invPriceList.size(); i++) {
				InvPrice invPriceData=invPriceList.get(i);
				InvPrice lastInvPrice=new InvPrice();
				lastInvPrice.setSysId(invPriceData.getSysId());
				lastInvPrice.setCorpCode(invPriceData.getCorpCode());
				lastInvPrice.setCompanyCode(invPriceData.getCompanyCode());
				lastInvPrice.setInvCode(invPriceData.getInvCode());
				lastInvPrice=invPriceDao.findLastInvPrice(lastInvPrice);
				if(lastInvPrice!=null){
					InvPrice lastInv=new InvPrice();
					lastInv.setSysId(lastInvPrice.getSysId());
					//更新上一条的停用日期为当前日期
					lastInv.setEndDate(date);
					
//					if(lastInvPrice.getEndDate()==null){
//						Date endDate= DateUtils.addDays(invPriceData.getBeginDate(),-1);
//						lastInv.setEndDate(endDate);
//					}
					invPriceDao.updateLastInvPrice(lastInv);
				}
			}
	    }
	}*/
	/**
	 * 删除数据
	 * @param invPriceAdjust
	 */
	@Transactional(readOnly = false)
	public void delete(InvPriceAdjust invPriceAdjust) {
		super.delete(invPriceAdjust);
		dao.deleteDetil(invPriceAdjust);
	}
	/**
	 * 删除子表数据
	 * @param invPriceAdjust
	 */
	@Transactional(readOnly = false)
	public void deleteDetil(InvPriceAdjust invPriceAdjust) {
		dao.deleteDetil(invPriceAdjust);
	}
	@Transactional(readOnly = false)
	public List<Company> findCompanyListByDataScope(String userCode) {
		return dao.findCompanyListByDataScope(userCode);
	}
	
	
	
	/**
	 * 查询列表数据
	 * @param invPriceAdjust
	 * @return
	 */
	public List<InvPriceAdjust> findDetailList(InvPriceAdjust invPriceAdjust) {
		return dao.findDetailList(invPriceAdjust);
	}
	
	@Transactional(readOnly = false)
	public void saveImport(InvPriceAdjust invPriceAdjust) {
		super.save(invPriceAdjust);
	}
	
	
	/**
	 * 导入保存数据（插入或更新）
	 * @param invPriceAdjust
	 */
	/*@Transactional(readOnly = false)
	public void saves(InvPriceAdjust invPriceAdjust) {
		//1.保存主表
		if(invPriceAdjust.getIsNewRecord()==true){
			invPriceAdjust.setSysCode(IdGen.nextId());
			invPriceAdjust.setGrantBillNo(BillTypeUtils.getMaxBillCode(BillTypeUtils.JG, invPriceAdjust.getCompanyCode()));
		}
		invPriceAdjust.setPriceType("1");
		invPriceAdjust.setFlag("2");
		invPriceAdjust.setGrade("0");
		invPriceAdjust.setApprovalStatus("0");
		Date date=new Date();
		User currUser = UserUtils.getUser();
		invPriceAdjust.setCreateDate(date);
		invPriceAdjust.setUpdateDate(date);
		invPriceAdjust.setCreateBy(currUser);
		invPriceAdjust.setUpdateBy(currUser);
		invPriceAdjust.setSysDate(date);
		invPriceAdjust.setCorpCode(currUser.getCorpCode());
		invPriceAdjust.setCorpName(currUser.getCorpName());
		super.save(invPriceAdjust);
		//2.删除子表
		InvPrice invPrice=new InvPrice();
		invPrice.setSysCode(invPriceAdjust.getSysCode());
		invPriceDao.deleteInvPrice(invPrice);
		//3.保存子表
		if (invPriceAdjust.getInvPriceList() != null && invPriceAdjust.getInvPriceList().size() > 0) {
			List<InvPrice> invPriceList=invPriceAdjust.getInvPriceList();
			for (int i = 0; i < invPriceList.size(); i++) {
				InvPrice invPriceData=invPriceList.get(i);
				if (StringUtils.isBlank(invPriceData.getSysId())) {
					invPriceData.setSysId(IdGen.nextId());
				}
				invPriceData.setSysCode(invPriceAdjust.getSysCode());
				Integer maxSerialNo=invPriceDao.getMaxSerialNo(invPriceAdjust.getSysCode());
				if(maxSerialNo==null){
					invPriceData.setSerialNo(0l);
				}else{
					invPriceData.setSerialNo(Long.valueOf(maxSerialNo+1));
				}
				if(invPriceData.getLastPrice()==null){
					invPriceData.setLastPrice(0.0);
				}
				if(invPriceData.getLastLowPrice()==null){
					invPriceData.setLastLowPrice(0.0);
				}
				invPriceData.setPriceType("1");
				invPriceData.setFlag("2");
				invPriceData.setGrade("0");
				invPriceData.setHighPrice(0.0);
				invPriceData.setBeginDate(invPriceAdjust.getBeginDate());
				if(invPriceAdjust.getEndDate()!=null){
					invPriceData.setEndDate(invPriceAdjust.getEndDate());
				}
				invPriceData.setCompanyCode(invPriceAdjust.getCompanyCode());
				invPriceData.setCompanyName(invPriceAdjust.getCompanyName());
				invPriceData.setApprovalStatus("0");
				invPriceData.setCorpCode(currUser.getCorpCode());
				invPriceData.setCorpName(currUser.getCorpName());
				invPriceData.setCreateBy(currUser);
				invPriceData.setCreateDate(date);
				invPriceData.setUpdateBy(currUser);
				invPriceData.setUpdateDate(date);
				invPriceDao.insert(invPriceData);
			}
		}
		
	}*/
	
	
	
	
	
	
}
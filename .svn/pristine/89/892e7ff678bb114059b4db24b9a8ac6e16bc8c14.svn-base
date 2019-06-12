package cn.net.ecode.modules.ass.report.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.report.dao.ReportDao;
import cn.net.ecode.modules.ass.report.entity.Report;

/**
 * 报表信息Service
 * @author tiange
 * @version 2018-10-15
 */
@Service
@Transactional(readOnly = true)
public class ReportService extends CrudService<ReportDao, Report> {
	/**
	 * 获取单条数据
	 * @param report
	 * @return
	 */
	public Report get(Report report) {
		return super.get(report);
	}
	
	/**
	 * 查询列表数据
	 * @param report
	 * @return
	 */
	public List<Report> findList(Report report) {
		return super.findList(report);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param report
	 * @return
	 */
	public Page<Report> findPage(Page<Report> page, Report report) {
		return super.findPage(page, report);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param report
	 */
	@Transactional(readOnly = false)
	public void save(Report report) {
		super.save(report);
	}
	
	/**
	 * 删除数据
	 * @param report
	 */
	@Transactional(readOnly = false)
	public void delete(Report report) {
		super.delete(report);
	}
}

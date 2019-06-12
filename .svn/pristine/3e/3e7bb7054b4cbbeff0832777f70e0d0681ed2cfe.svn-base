/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.location.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 存放地点Entity
 * @author yangjianjun
 * @version 2018-09-29
 */
public class AssLocation extends DataEntity<AssLocation> {

	private static final long serialVersionUID = 1L;
	private String localeCode;		// 存放地点编码
	private String localeName;		// 存放地点名称
	private String extendS1;		// extend_s1
	private String extendS2;		// extend_s2
	
	public AssLocation() {
		super();
	}

	public AssLocation(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="存放地点编码长度不能超过 64 个字符")
	public String getLocaleCode() {
		return localeCode;
	}

	public void setLocaleCode(String localeCode) {
		this.localeCode = localeCode;
	}
	
	@Length(min=0, max=64, message="存放地点名称长度不能超过 64 个字符")
	public String getLocaleName() {
		return localeName;
	}

	public void setLocaleName(String localeName) {
		this.localeName = localeName;
	}
	
	@Length(min=0, max=64, message="extend_s1长度不能超过 64 个字符")
	public String getExtendS1() {
		return extendS1;
	}

	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	
	@Length(min=0, max=64, message="extend_s2长度不能超过 64 个字符")
	public String getExtendS2() {
		return extendS2;
	}

	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
}
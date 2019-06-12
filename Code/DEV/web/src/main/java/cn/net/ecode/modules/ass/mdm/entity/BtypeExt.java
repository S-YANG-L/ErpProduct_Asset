/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 单位机构扩展信息Entity
 * @author 车磊岩
 * @version 2015-09-17
 */
public class BtypeExt extends DataEntity<BtypeExt> {

	private static final long serialVersionUID = 1L;
	private String btypeCode; // 单位机构编码
	private String btypeName; // 单位机构名称
	private String propertyCode; // 性质编码
	private String propertyName; // 单位性质(科研机构、高等院校、事业单位、国有企业、合资企业、民营企业、政府部门)
	private String btypeSorts; // 单位类型（高新技术企业，科技服务业企业，千帆计划企业）
	private Double registerCapital; // 注册资本
	private String btypeUrl; // 单位网址
	private String btypeIntro; // 单位简介
	private String mainBusiness; // 主营业务
	private String coordinate; // 企业坐标
	private String businessScope; // 经营范围
	private String isMarket; // 是否上市公司 1:是0：否
	private String marketNo; // 上市证书编号
	private String scale; // 规模
	private Long peopNum; // 职员总数
	private String tradeSortCode; // 行业类别编码
	private String countryCode; // 国别编码
	private String tradeSortName; // 行业类别/卖方归属
	private String countryName; // 国别名称
	private String provinceCode; // 省编码
	private String provinceName; // 省名称
	private String cityCode; // 市编码
	private String cityName; // 市名称
	private String districtCode; // 区/县 编码
	private String districtName; // 区/县名称
	private String gardenCode; // 所属园区编码
	private String gardenName; // 所属园区名称
	private String incubatorCode; // 所在孵化器编码
	private String incubatorName; // 孵化器名称
	private String incubateStatus; // 孵化状态
	private Date joinIncubateDate; // 入驻孵化器时间
	private String areaCode;//全地址编码
	private String areaName;//全地址名称
	private String marketSortCode;//上市类型编码
	private String marketSortName;//上市类型名称
	private String marketCode;//上市代码
	private String fieldCode;//技术领域编码
	private String fieldName;//技术领域名称
	private String highCertificateCode;//高企证书编码

	public BtypeExt() {
		super();
	}

	public BtypeExt(String btypeCode) {
		super();
		this.btypeCode = btypeCode;
	}

	@Id
	public String getBtypeCode() {
		return btypeCode;
	}

	public void setBtypeCode(String btypeCode) {
		this.btypeCode = btypeCode;
	}

	@Length(min = 1, max = 100, message = "单位机构名称长度必须介于 1 和 100 之间")
	public String getBtypeName() {
		return btypeName;
	}

	public void setBtypeName(String btypeName) {
		this.btypeName = btypeName;
	}

	@Length(min = 0, max = 64, message = "性质编码长度不能大于 64 个字符")
	public String getPropertyCode() {
		return propertyCode;
	}

	public void setPropertyCode(String propertyCode) {
		this.propertyCode = propertyCode;
	}

	@Length(min = 0, max = 100, message = "单位性质(科研机构、高等院校、事业单位、国有企业、合资企业、民营企业、政府部门)长度不能大于 100 个字符")
	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	@Length(min = 0, max = 500, message = "单位类型（高新技术企业，科技服务业企业，千帆计划企业）长度不能大于 500 个字符")
	public String getBtypeSorts() {
		return btypeSorts;
	}

	public void setBtypeSorts(String btypeSorts) {
		this.btypeSorts = btypeSorts;
	}

	public Double getRegisterCapital() {
		return registerCapital;
	}

	public void setRegisterCapital(Double registerCapital) {
		this.registerCapital = registerCapital;
	}

	@Length(min = 0, max = 128, message = "单位网址长度不能大于 128 个字符")
	public String getBtypeUrl() {
		return btypeUrl;
	}

	public void setBtypeUrl(String btypeUrl) {
		this.btypeUrl = btypeUrl;
	}

	@Length(min = 0, max = 2000, message = "单位简介长度不能大于 2000 个字符")
	public String getBtypeIntro() {
		return btypeIntro;
	}

	public void setBtypeIntro(String btypeIntro) {
		this.btypeIntro = btypeIntro;
	}

	@Length(min = 0, max = 2000, message = "主营业务长度不能大于 2000 个字符")
	public String getMainBusiness() {
		return mainBusiness;
	}

	public void setMainBusiness(String mainBusiness) {
		this.mainBusiness = mainBusiness;
	}

	@Length(min = 0, max = 64, message = "企业坐标长度不能大于 64 个字符")
	public String getCoordinate() {
		return coordinate;
	}

	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}

	@Length(min = 0, max = 2000, message = "经营范围长度不能大于 2000 个字符")
	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	@Length(min = 0, max = 1, message = "是否上市公司 1:是0：否长度不能大于 1 个字符")
	public String getIsMarket() {
		return isMarket;
	}

	public void setIsMarket(String isMarket) {
		this.isMarket = isMarket;
	}

	@Length(min = 0, max = 64, message = "上市证书编号长度不能大于 64 个字符")
	public String getMarketNo() {
		return marketNo;
	}

	public void setMarketNo(String marketNo) {
		this.marketNo = marketNo;
	}

	@Length(min = 0, max = 50, message = "规模长度不能大于 50 个字符")
	public String getScale() {
		return scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public Long getPeopNum() {
		return peopNum;
	}

	public void setPeopNum(Long peopNum) {
		this.peopNum = peopNum;
	}

	@Length(min = 0, max = 64, message = "行业类别编码长度不能大于 64 个字符")
	public String getTradeSortCode() {
		return tradeSortCode;
	}

	public void setTradeSortCode(String tradeSortCode) {
		this.tradeSortCode = tradeSortCode;
	}

	@Length(min = 0, max = 64, message = "国别编码长度不能大于 64 个字符")
	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	@Length(min = 0, max = 50, message = "行业类别/卖方归属长度不能大于 50 个字符")
	public String getTradeSortName() {
		return tradeSortName;
	}

	public void setTradeSortName(String tradeSortName) {
		this.tradeSortName = tradeSortName;
	}

	@Length(min = 0, max = 50, message = "国别名称长度不能大于 50 个字符")
	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	@Length(min = 0, max = 64, message = "省编码长度不能大于 64 个字符")
	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	@Length(min = 0, max = 50, message = "省名称长度不能大于 50 个字符")
	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	@Length(min = 0, max = 64, message = "市编码长度不能大于 64 个字符")
	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	@Length(min = 0, max = 50, message = "市名称长度不能大于 50 个字符")
	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	@Length(min = 0, max = 64, message = "区/县 编码长度不能大于 64 个字符")
	public String getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}

	@Length(min = 0, max = 50, message = "区/县名称长度不能大于 50 个字符")
	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	@Length(min = 0, max = 64, message = "所属园区编码长度不能大于 64 个字符")
	public String getGardenCode() {
		return gardenCode;
	}

	public void setGardenCode(String gardenCode) {
		this.gardenCode = gardenCode;
	}

	@Length(min = 0, max = 50, message = "所属园区名称长度不能大于 50 个字符")
	public String getGardenName() {
		return gardenName;
	}

	public void setGardenName(String gardenName) {
		this.gardenName = gardenName;
	}

	@Length(min = 0, max = 64, message = "所在孵化器编码长度不能大于 64 个字符")
	public String getIncubatorCode() {
		return incubatorCode;
	}

	public void setIncubatorCode(String incubatorCode) {
		this.incubatorCode = incubatorCode;
	}

	@Length(min = 0, max = 50, message = "孵化器名称长度不能大于 50 个字符")
	public String getIncubatorName() {
		return incubatorName;
	}

	public void setIncubatorName(String incubatorName) {
		this.incubatorName = incubatorName;
	}

	@Length(min = 0, max = 1, message = "孵化状态长度不能大于 1 个字符")
	public String getIncubateStatus() {
		return incubateStatus;
	}

	public void setIncubateStatus(String incubateStatus) {
		this.incubateStatus = incubateStatus;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getJoinIncubateDate() {
		return joinIncubateDate;
	}

	public void setJoinIncubateDate(Date joinIncubateDate) {
		this.joinIncubateDate = joinIncubateDate;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getMarketSortCode() {
		return marketSortCode;
	}

	public void setMarketSortCode(String marketSortCode) {
		this.marketSortCode = marketSortCode;
	}

	public String getMarketSortName() {
		return marketSortName;
	}

	public void setMarketSortName(String marketSortName) {
		this.marketSortName = marketSortName;
	}

	public String getMarketCode() {
		return marketCode;
	}

	public void setMarketCode(String marketCode) {
		this.marketCode = marketCode;
	}

	public String getFieldCode() {
		return fieldCode;
	}

	public void setFieldCode(String fieldCode) {
		this.fieldCode = fieldCode;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getHighCertificateCode() {
		return highCertificateCode;
	}

	public void setHighCertificateCode(String highCertificateCode) {
		this.highCertificateCode = highCertificateCode;
	}

}
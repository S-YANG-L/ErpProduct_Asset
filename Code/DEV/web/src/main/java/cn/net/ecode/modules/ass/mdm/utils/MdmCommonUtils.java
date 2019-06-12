package cn.net.ecode.modules.ass.mdm.utils;

import cn.net.ecode.common.utils.Reflections;
import cn.net.ecode.common.utils.SpringContextHolder;

import cn.net.ecode.modules.ass.mdm.dao.SelectDao;
import cn.net.ecode.modules.sys.entity.UserDict;

import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.utils
 * @ClassName: MdmCommonUtils
 * @Description: TODO
 * @author: 车磊岩
 * @date: 2015年9月22日 上午10:35:50
 * @Version: V1.0
 */
public class MdmCommonUtils {

	private static final String PROVINCE_CODE = "provinceCode";
	private static final String PROVINCE_NAME = "provinceName";
	private static final String CITY_CODE = "cityCode";
	private static final String CITY_NAME = "cityName";
	private static final String DISTRICT_CODE = "districtCode";
	private static final String DISTRICT_NAME = "districtName";
	public static final String CACHE_USER_DICT_MAP = "userDictMap";
	private static SelectDao selectDao= SpringContextHolder.getBean(SelectDao.class);

	/**
	 * 返回省编码
	 * 
	 * @Title: getProvinceCode
	 * @Description: 返回省编码
	 * @param areaCode
	 * @return
	 */
	public static String getProvinceCode(String areaCode) {
		String[] codes = areaCode.split("/");
		String provinceCode = null;
		if (codes.length > 0) {
			provinceCode = codes[0];
		}
		return provinceCode;
	}

	/**
	 * 返回省编码
	 * 
	 * @Title: getProvinceName
	 * @Description: 返回省名称
	 * @param areaName
	 * @return
	 */
	public static String getProvinceName(String areaName) {
		String[] names = areaName.split("/");
		String provinceName = null;
		if (names.length > 0) {
			provinceName = names[0];
		}
		return provinceName;
	}

	/**
	 * 返回城市编码
	 * 
	 * @Title: getCityCode
	 * @Description: 返回城市编码
	 * @param areaCode
	 * @return
	 */
	public static String getCityCode(String areaCode) {
		String[] codes = areaCode.split("/");
		String cityCode = null;
		if (codes.length > 1) {
			cityCode = codes[1];
		}
		return cityCode;
	}

	/**
	 * 返回城市名称
	 * 
	 * @Title: getCityName
	 * @Description: 返回城市名称
	 * @param areaName
	 * @return
	 */
	public static String getCityName(String areaName) {
		String[] names = areaName.split("/");
		String cityName = null;
		if (names.length > 1) {
			cityName = names[1];
		}
		return cityName;
	}

	/**
	 * 返回区/县编码
	 * 
	 * @Title: getDistrictCode
	 * @Description: 返回区/县编码
	 * @param areaCode
	 * @return
	 */
	public static String getDistrictCode(String areaCode) {
		String[] codes = areaCode.split("/");
		String districtCode = null;
		if (codes.length > 2) {
			districtCode = codes[2];
		}
		return districtCode;
	}

	/**
	 * 返回区/县名称
	 * 
	 * @Title: getDistrictName
	 * @Description: 返回区/县名称
	 * @param areaName
	 * @return
	 */
	public static String getDistrictName(String areaName) {
		String[] names = areaName.split("/");
		String districtName = null;
		if (names.length > 2) {
			districtName = names[2];
		}
		return districtName;
	}

	/**
	 * 给传入的类的省市区编码、名称属性赋值
	 * 
	 * @Title: setAreaVale
	 * @Description: 给传如的实体类的省市区编码，名称赋值
	 * @param type
	 * @param areaCode
	 * @param areaName
	 * @return
	 * @throws
	 * @throws Exception
	 */
	public static <T> T setAreaValue(T bean, String areaCode, String areaName){
		String[] codes = areaCode.split("/");
		String[] names = areaName.split("/");
		Reflections.invokeSetter(bean, PROVINCE_CODE, codes[0]);
		if (codes.length > 1) {
			Reflections.invokeSetter(bean, PROVINCE_NAME, names[0]);
		}
		if (codes.length > 2) {
			Reflections.invokeSetter(bean, CITY_CODE, codes[1]);
		}
		Reflections.invokeSetter(bean, CITY_NAME, names[1]);
		if (names.length > 1) {
			Reflections.invokeSetter(bean, DISTRICT_CODE, codes[2]);
		}
		if (names.length > 2) {
			Reflections.invokeSetter(bean, DISTRICT_NAME, names[2]);
		}
		return bean;
	}
	/**
	 * 获取用户字典标签
	 * @Title: getUserDictList 
	 * @Description: 根据类型编码获取用户字典
	 * @param type
	 * @return
	 */
	public static List<UserDict> getUserDictList(String type){
		UserDict userDict=new UserDict();
		userDict.setDictTypeCode(type);;
		List<UserDict> dictList = selectDao.findUserDictByTypeCode(userDict);
		return dictList;
	}
	/**
	 * 根据区编码返回省编码
	 * @Title: getProvinceCodeDistrictCode 
	 * @Description: 根据区编码返回省编码
	 * @param districtCode
	 * @return
	 */
	public static String getProvinceCodeDistrictCode(String districtCode){
		return selectDao.getProvinceCodeDistrictCode(districtCode);
		
	}
	/**
	 * 根据区编码返回市编码
	 * @Title: getCityCodeDistrictCode 
	 * @Description:  根据区编码返回市编码
	 * @param districtCode
	 * @return
	 */
	public static String getCityCodeDistrictCode(String districtCode){
		return selectDao.getCityCodeDistrictCode(districtCode);
		
	}

}

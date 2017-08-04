package dao;

import java.util.List;

public interface CommonDao {
	public void insertObject(Object obj);
	
	public <T> void deleteObject(Class<T> clazz,long id);
	
	public void updateObject(Object obj);
	
	public <T> T findObjectById(Class<T> clazz,long id);
	
	public <T> T findObjectByAttr(Class<T> clazz, String attr, Object value) ;

	public <T> List<T> getList(Class<T> clazz,String orderBy);

	public <T> List<T> getList(Class<T> clazz,String where,String orderBy,Object... values);
	
	public <T> Long getObjectCount(Class<T> clazz);
	
	public <T> List<T> getObjectList(final Class<T> clazz,final String orderBy,final int pn,final int ps);
	
	public <T> Long getObjectCount(final Class<T> clazz,String where,Object... values);
	
	public <T> List<T> getObjectList(final Class<T> clazz,final String where,final Object[] objArr,final String orderBy,final int pn,final int ps);
	
	/**
	 * 执行sql语句
	 * @param sql
	 * @return
	 */
	public List<Object> getSqlList(final String sql);

	public <T> List<T> getDicInfoListByParentCode(Class<T> clazz,String code);
	
}

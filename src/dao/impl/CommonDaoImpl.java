package dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.CommonDao;


public class CommonDaoImpl extends HibernateDaoSupport implements CommonDao {
	private String getOrderBy(String orderBy){
		String order = " order by id desc";
		if(orderBy!=null && !orderBy.equals("")){
			order = orderBy;
		}
		return order;
	}
	
	public void insertObject(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	
	public <T> void deleteObject(Class<T> clazz,long id){
		this.getHibernateTemplate().delete(findObjectById(clazz,id));
	}
	
	public void updateObject(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	
	public <T> T findObjectById(Class<T> clazz,long id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	@SuppressWarnings("unchecked")
	public <T> T findObjectByAttr(Class<T> clazz, String attr, Object value) {
		List<T> list = this.getHibernateTemplate().find("from "+clazz.getSimpleName()+" where "+attr+"=?",value);
		if(list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> getList(Class<T> clazz,String orderBy){
		String order = getOrderBy(orderBy);
		return this.getHibernateTemplate().find("from "+clazz.getSimpleName()+order);
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> getList(Class<T> clazz,String where,String orderBy,Object... values){
		String order = getOrderBy(orderBy);
		String test=clazz.getSimpleName();
		return this.getHibernateTemplate().find("from "+clazz.getSimpleName()+where+order,values);
	}
	
	public <T> Long getObjectCount(Class<T> clazz){
		return (Long)this.getHibernateTemplate().find("select count(*) from "+clazz.getSimpleName()).get(0);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public <T> List<T> getObjectList(final Class<T> clazz,final String orderBy,final int pn,final int ps){
		return this.getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String order = getOrderBy(orderBy);
				return session.createQuery("from "+clazz.getSimpleName()+order)
							.setFirstResult((pn-1)*ps)
							.setMaxResults(ps)
							.list();
			}
		});
	}
	
	
	public <T> Long getObjectCount(final Class<T> clazz,String where,Object... values){
//		Session session = getSessionFactory().openSession();
//		Transaction tx = session.beginTransaction();
//		session.save(arg0);
//		tx.commit();
//		session.close();
		
		return (Long)this.getHibernateTemplate().find("select count(*) from "+clazz.getSimpleName()+where,values).get(0);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public <T> List<T> getObjectList(final Class<T> clazz,final String where,final Object[] objArr,final String orderBy,final int pn,final int ps){
		return this.getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String order = getOrderBy(orderBy);
				Query query = session.createQuery("from "+clazz.getSimpleName()+where+order);
				for(int i=0;i<objArr.length;i++){
					Object obj = objArr[i];
					if(obj instanceof Integer){
						query.setInteger(i, (Integer)obj);
					}
					if(obj instanceof String){
						query.setString(i, (String)obj);
					}
					if(obj instanceof Double){
						query.setDouble(i, (Double)obj);
					}
					if(obj instanceof Date){
						query.setDate(i, (Date)obj);
					}
					if(obj instanceof Enum){
						query.setString(i, ((Enum)obj).toString());
					}
				}
				query.setFirstResult((pn-1)*ps);
				query.setMaxResults(ps);
				return query.list();
			}
		});
	}
	
	/**
	 * 执行sql语句
	 * @param sql
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Object> getSqlList(final String sql){
		return (List<Object>)this.getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return session.createSQLQuery(sql).list();
			}
		});
	}

	public <T> List<T> getDicInfoListByParentCode(Class<T> clazz,String code) {
		return this.getHibernateTemplate().find("from "+clazz.getSimpleName()+" where parentscode=? and isactive=1",code);
	}
	
	

}

package action;

import java.util.List;

import model.News;
import model.User;

import org.apache.commons.lang.StringUtils;

import util.Alert;
import util.Pager;
import util.Util;

import dao.CommonDao;

/**
 * 新闻公告管理类
 * @author Administrator
 *
 */
public class NewsAction extends BaseAction {

	private static final long serialVersionUID = -4304509122548259589L;

	private CommonDao commDao;

	public CommonDao getCommDao() {
		return commDao;
	}

	public void setCommDao(CommonDao commDao) {
		this.commDao = commDao;
	}
	
	public String addNewsForm(){
		setUrl("news/addnews.jsp");
		setAttribute("status", getParameter("status"));
		return Util.SUCCESS;
	}
	
	//添加
	public String addNews(){
		int status = Integer.parseInt(getParameter("status"));
		News bean = new News();
		bean.setStatus(status);
		bean.setTitle(getParameter("title"));
		bean.setContent(getParameter("content1"));
		commDao.insertObject(bean);
		setAttribute("message", "添加成功");
		setAttribute("status", status);
		setUrl("news/addnews.jsp");
		return Util.SUCCESS;
	}
	
	//删除
	public String deleteNews(){
		long id = Long.parseLong(getParameter("id"));
		News bean = commDao.findObjectById(News.class, id);
		commDao.deleteObject(News.class, id);
		Alert.fresh("gbk", "act_News_querynews?status="+bean.getStatus());
		return null;
	}
	
	//查询
	public String findNews(){
		setUrl("news/findnews.jsp");
		long id = Long.parseLong(getParameter("id"));
		News bean = commDao.findObjectById(News.class, id);
		setAttribute("bean", bean);
		setAttribute("status", bean.getStatus());
		return Util.SUCCESS;
	}
	
	//显示
	public String showNews(){
		setUrl("news/shownews.jsp");
		long id = Long.parseLong(getParameter("id"));
		News bean = commDao.findObjectById(News.class, id);
		setAttribute("bean", bean);
		return Util.SUCCESS;
	}
	//更新
	public String updateNews(){
		setUrl("news/findnews.jsp");
		long id = Long.parseLong(getParameter("id"));
		News bean = commDao.findObjectById(News.class, id);
		bean.setTitle(getParameter("title"));
		bean.setContent(getParameter("content1"));
		commDao.updateObject(bean);
		setAttribute("bean", bean);
		Alert.show("gbk", "修改成功", "act_News_querynews?status="+bean.getStatus());
		return null;
	}
	//查询所有
	public String querynews(){
		int status = Integer.parseInt(getParameter("status"));
		User user = (User)getSession("user");
		setUrl("news/newslist.jsp");
		int currentpage = 1;
		int pagesize = 10;
		if (!StringUtils.isEmpty(getParameter("pagenum"))) {
			currentpage = Integer.parseInt(getParameter("pagenum"));
		}
		setAttribute("status", status);
		StringBuffer where = new StringBuffer(" where status=?");
		Object[] value = createNames(status);
		
		long total = commDao.getObjectCount(News.class, where.toString(), value);
		List<News> list = commDao.getObjectList(News.class, where.toString(), value, " order by id desc", currentpage, pagesize);
		
		setAttribute("list", list);
		setAttribute("pagerinfo", Pager.getPagerNormal(total, pagesize,
				currentpage, "act_News_querynews?status="+status, "共有" + total + "条记录"));	
		
		
		if(user.getRole().getDicscode().equals("D0105") || user.getRole().getDicscode().equals("D0104")){
			if(status==0 || status==2 || status==3){
				setUrl("news/newslist2.jsp");
			}
		}
		if(user.getRole().getDicscode().equals("D0103")){
			if(status==1){
				setUrl("news/newslist2.jsp");
			}
		}
		return Util.SUCCESS;
	}
}

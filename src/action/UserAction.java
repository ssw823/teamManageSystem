package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.News;
import model.PersonInfo;
import model.PersonalAbility;
import model.PersonalAbilityDtl;
import model.SysdicInfo;
import model.User;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import util.Alert;
import util.Pager;
import util.Util;

import dao.CommonDao;
import dao.UserDao;


public class UserAction extends BaseAction {

	private static final long serialVersionUID = -4304509122548259589L;

	private UserDao userDao;
	private CommonDao commDao;

	public CommonDao getCommDao() {
		return commDao;
	}

	public void setCommDao(CommonDao commDao) {
		this.commDao = commDao;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public String index(){
		setUrl("login.jsp");
		return Util.SUCCESS;
	}
	
	public String main(){
		setUrl("body.jsp");
		List<News> list1 = commDao.getList(News.class, " where status=?", " order by id desc", 0);
		if(list1.size()>0){
			setAttribute("news1", list1.get(0));
		}
		List<News> list2 = commDao.getList(News.class, " where status=?", " order by id desc", 1);
		if(list2.size()>0){
			setAttribute("news2", list2.get(0));
		}
		User user = (User)getSession("user");
		setAttribute("user", user);
		return Util.SUCCESS;
	}
	
	public String menu(){
		setUrl("menu.jsp");
		User user = (User)getSession("user");
		setAttribute("user", user);
		return Util.SUCCESS;
	}
	
	//用户登录操作
	public String login() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		try {
			User user = commDao.getList(User.class, " where username=? and password=? and role.dicscode=?", "",username,password,role).get(0);
			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				setUrl("index.jsp");
				return "redirect";
			} else {
				HttpServletResponse response = ServletActionContext.getResponse();
				response.setCharacterEncoding("gbk");response.setContentType("text/html; charset=gbk");
				response.getWriter()
						.print("<script language=javascript>alert('用户名或者密码错误');window.location.href='index';</script>");
			}			
		} catch (Exception e) {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("gbk");response.setContentType("text/html; charset=gbk");
			response.getWriter()
					.print("<script language=javascript>alert('用户名或者密码错误');window.location.href='index';</script>");
		}
		return null;
	}
//用户退出操作
	public String loginout() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		this.setUrl("index");
		return "redirect";
	}
//跳转到修改密码页面
	public String changepwd() {
		this.setUrl("user/password.jsp");
		return SUCCESS;
	}
//修改密码操作
	public void changepwd2() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("user");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String password3 = request.getParameter("password3");
		User bean = userDao.selectBean(" where username= '" + u.getUsername()
				+ "' and password= '" + password1 + "'");
		if (!password2.equals(password3)) {
			response.setCharacterEncoding("gbk");response.setContentType("text/html; charset=gbk");
			response
					.getWriter()
					.print(
							"<script language=javascript>alert('两次输入密码不一致');window.location.href='password.jsp';</script>");
		} else if (bean != null) {
			bean.setPassword(password2);
			userDao.updateBean(bean);
			response.setCharacterEncoding("gbk");response.setContentType("text/html; charset=gbk");
			response
					.getWriter()
					.print(
							"<script language=javascript>alert('success!');window.location.href='password.jsp';</script>");
		} else {
			response.setCharacterEncoding("gbk");response.setContentType("text/html; charset=gbk");
			response
					.getWriter()
					.print(
							"<script language=javascript>alert('原密码错误');window.location.href='password.jsp';</script>");
		}
	}
	
	/**
	 * 球员信息列表
	 * @return
	 */
	public String queryuser(){
		setUrl("user/userlist.jsp");
		int currentpage = 1;
		int pagesize = 10;
		if (!StringUtils.isEmpty(getParameter("pagenum"))) {
			currentpage = Integer.parseInt(getParameter("pagenum"));
		}
		String key = getParameter("key");
		setAttribute("key", key);
		StringBuffer where = new StringBuffer(" where 1=1");
		Object[] value = new Object[0];
		if(!StringUtils.isEmpty(key)){
			where.append(" and username like ?");
			value = createNames("%"+key+"%");
		}
		long total = commDao.getObjectCount(User.class, where.toString(), value);
		List<User> list = commDao.getObjectList(User.class, where.toString(), value, " order by id desc", currentpage, pagesize);
		setAttribute("list", list);
		setAttribute("pagerinfo", Pager.getPagerNormal(total, pagesize,
				currentpage, "act_User_queryuser", "共有" + total + "条记录"));		
		return Util.SUCCESS;
	}	
	
	/**
	 * 添加球员信息
	 * @return
	 */
	public String addUserForm(){
		setUrl("user/adduser.jsp");
		setAttribute("roleList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D01"));
		return Util.SUCCESS;
	}
	
	public String addUser(){
		setAttribute("roleList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D01"));
		setUrl("user/adduser.jsp");
		User bean = new User();
		bean.setUsername(getParameter("username"));
		bean.setPassword(getParameter("userpassword"));
		bean.setRole(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("role")));
		
		User user = commDao.findObjectByAttr(User.class, "username", bean.getUsername());
		if(user!=null){
			Alert.show("gbk", "该用户名已存在", "act_User_addUserForm");
			return null;
		}
		commDao.insertObject(bean);
		setAttribute("message", "添加成功成功");
		return Util.SUCCESS;
	}
	
	/**
	 * 删除球员
	 * @return
	 */
	public String deleteUser(){
		long id = Long.parseLong(getParameter("id"));
		commDao.deleteObject(User.class, id);
		Alert.fresh("gbk", "act_User_queryuser");
		return null;
	}	
	public String findUser(){
		setAttribute("roleList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D01"));
		setUrl("user/finduser.jsp");
		long id = Long.parseLong(getParameter("id"));
		User bean = commDao.findObjectById(User.class, id);
		setAttribute("bean", bean);
		return Util.SUCCESS;
	}
	public String updateUser(){
		long id = Long.parseLong(getParameter("id"));
		User bean = commDao.findObjectById(User.class, id);
		if(!bean.getPassword().equals(getParameter("oldpassword"))){
			setUrl("user/finduser.jsp");
			setAttribute("message", "旧密码输入不相同");
			return Util.SUCCESS;
		}
		bean.setRole(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("role")));
		bean.setPassword(getParameter("userpassword"));
		commDao.updateObject(bean);
		Alert.show("gbk", "success!", "act_User_queryuser");
		return null;
	}	
	
	
	/**
	 * 队员和经理人管理
	 */
	public String queryPersonInfo(){
		setUrl("user/personinfolist.jsp");
		int currentpage = 1;
		int pagesize = 10;
		if (!StringUtils.isEmpty(getParameter("pagenum"))) {
			currentpage = Integer.parseInt(getParameter("pagenum"));
		}
		String key = getParameter("key");
		setAttribute("key", key);
		StringBuffer where = new StringBuffer(" where 1=1 and tuiyi='false'");
		Object[] value = new Object[0];
		if(!StringUtils.isEmpty(key)){
			where.append(" and truename like ?");
			value = createNames("%"+key+"%");
		}
		long total = commDao.getObjectCount(PersonInfo.class, where.toString(), value);
		List<PersonInfo> list = commDao.getObjectList(PersonInfo.class, where.toString(), value, " order by id desc", currentpage, pagesize);
		setAttribute("list", list);
		setAttribute("pagerinfo", Pager.getPagerNormal(total, pagesize,
				currentpage, "act_User_queryPersonInfo", "共有" + total + "条记录"));	
		User user = (User)getSession("user");
		if(user.getRole().getDicscode().equals("D0104")){
			setUrl("user/personinfolist2.jsp");
		}
		return Util.SUCCESS;
	}
	
	public String addPersonInfoForm(){
		setUrl("user/addpersoninfo.jsp");
		setAttribute("sexList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D02"));
		setAttribute("danshenList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D03"));
		return Util.SUCCESS;
	}
	
	public String addPersonInfo(){
		setAttribute("postionList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D04"));
		setAttribute("sexList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D02"));
		setAttribute("danshenList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D03"));		
		setUrl("user/addpersoninfo.jsp");
		PersonInfo bean = new PersonInfo();
		bean.setRole(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("role")));
		bean.setTruename(getParameter("truename"));
		bean.setAge(Integer.parseInt(getParameter("age")));
		bean.setBirthday(getParameter("birthday"));
		bean.setSex(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("sex")));
		bean.setHeight(Integer.parseInt(getParameter("height")));
		bean.setWeight(Integer.parseInt(getParameter("weight")));
		bean.setHobby(getParameter("hobby"));
		bean.setSpecial(getParameter("special"));
		bean.setQq(getParameter("qq"));
		bean.setLongmobile(getParameter("longmobile"));
		bean.setShortmobile(getParameter("shortmobile"));
		bean.setPic(getParameter("pic"));
		bean.setDanshen(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("danshen")));
		if(bean.getRole().getDicscode().equals("D0104")){
			bean.setPostion(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("postion")));
			bean.setTuiyi(getParameter("tuiyi"));
		}
		commDao.insertObject(bean);
		if(bean.getRole().getDicscode().equals("D0104")){
			PersonalAbility pa = new PersonalAbility();
			pa.setPid(bean.getId());
			pa.setAttack(Integer.parseInt(getParameter("attack")));
			pa.setDefend(Integer.parseInt(getParameter("defend")));
			pa.setSpeed(Integer.parseInt(getParameter("speed")));
			pa.setSkill(Integer.parseInt(getParameter("skill")));
			pa.setCons(Integer.parseInt(getParameter("cons")));
			pa.setPower(Integer.parseInt(getParameter("power")));
			commDao.insertObject(pa);
			///
			PersonalAbilityDtl dtl = new PersonalAbilityDtl();
			dtl.setAttack1(Integer.parseInt(getParameter("attack1")));
			dtl.setAttack2(Integer.parseInt(getParameter("attack2")));
			dtl.setAttack3(Integer.parseInt(getParameter("attack3")));
			dtl.setAttack4(Integer.parseInt(getParameter("attack4")));
			dtl.setAttack5(Integer.parseInt(getParameter("attack5")));
			dtl.setAttack6(Integer.parseInt(getParameter("attack6")));
			dtl.setAttack7(Integer.parseInt(getParameter("attack7")));
			dtl.setAttack8(Integer.parseInt(getParameter("attack8")));
			dtl.setAttack9(Integer.parseInt(getParameter("attack9")));
			dtl.setAttack10(Integer.parseInt(getParameter("attack10")));
			dtl.setAttack11(Integer.parseInt(getParameter("attack11")));
			dtl.setAttack12(Integer.parseInt(getParameter("attack12")));
			//
			dtl.setDefend1(Integer.parseInt(getParameter("defend1")));
			dtl.setDefend2(Integer.parseInt(getParameter("defend2")));
			dtl.setDefend3(Integer.parseInt(getParameter("defend3")));
			dtl.setDefend4(Integer.parseInt(getParameter("defend4")));
			dtl.setDefend5(Integer.parseInt(getParameter("defend5")));
			dtl.setDefend6(Integer.parseInt(getParameter("defend6")));
			dtl.setDefend7(Integer.parseInt(getParameter("defend7")));
			dtl.setDefend8(Integer.parseInt(getParameter("defend8")));
			dtl.setDefend9(Integer.parseInt(getParameter("defend9")));
			dtl.setPid(bean.getId());
			commDao.insertObject(dtl);
		}
		setAttribute("message", "添加成功");
		return Util.SUCCESS;
	}
	
	
	public String findPersonInfo(){
		setUrl("user/updatepersoninfo.jsp");
		setAttribute("postionList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D04"));
		setAttribute("sexList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D02"));
		setAttribute("danshenList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D03"));			
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		setAttribute("bean", bean);
		
		PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		setAttribute("pa", pa);
		
		PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		if(dtl==null){
			setAttribute("dtl", new PersonalAbilityDtl());
		}else{
			setAttribute("dtl", dtl);
		}
		return Util.SUCCESS;
	}
	
	public String showPersonInfo(){
		setUrl("user/showpersoninfo.jsp");
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		setAttribute("bean", bean);
		PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		setAttribute("pa", pa);
		PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		if(dtl==null){
			setAttribute("dtl", new PersonalAbilityDtl());
		}else{
			setAttribute("dtl", dtl);
		}
		return Util.SUCCESS;
	}
	
	
	public String updatePersonInfo(){
		setAttribute("postionList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D04"));
		setAttribute("sexList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D02"));
		setAttribute("danshenList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D03"));	
		setUrl("user/updatepersoninfo.jsp");
		
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		bean.setTruename(getParameter("truename"));
		bean.setAge(Integer.parseInt(getParameter("age")));
		bean.setBirthday(getParameter("birthday"));
		bean.setSex(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("sex")));
		bean.setHeight(Integer.parseInt(getParameter("height")));
		bean.setWeight(Integer.parseInt(getParameter("weight")));
		bean.setHobby(getParameter("hobby"));
		bean.setSpecial(getParameter("special"));
		bean.setQq(getParameter("qq"));
		bean.setLongmobile(getParameter("longmobile"));
		bean.setShortmobile(getParameter("shortmobile"));
		bean.setPic(getParameter("pic"));		
		bean.setDanshen(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("danshen")));
		if(bean.getRole().getDicscode().equals("D0104")){
			bean.setPostion(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("postion")));
			bean.setTuiyi(getParameter("tuiyi"));
		}
		commDao.updateObject(bean);
		if(bean.getRole().getDicscode().equals("D0104")){
			PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
			pa.setPid(bean.getId());
			pa.setAttack(Integer.parseInt(getParameter("attack")));
			pa.setDefend(Integer.parseInt(getParameter("defend")));
			pa.setSpeed(Integer.parseInt(getParameter("speed")));
			pa.setSkill(Integer.parseInt(getParameter("skill")));
			pa.setCons(Integer.parseInt(getParameter("cons")));
			pa.setPower(Integer.parseInt(getParameter("power")));
			commDao.updateObject(pa);
			////////////
			PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
			dtl.setAttack1(Integer.parseInt(getParameter("attack1")));
			dtl.setAttack2(Integer.parseInt(getParameter("attack2")));
			dtl.setAttack3(Integer.parseInt(getParameter("attack3")));
			dtl.setAttack4(Integer.parseInt(getParameter("attack4")));
			dtl.setAttack5(Integer.parseInt(getParameter("attack5")));
			dtl.setAttack6(Integer.parseInt(getParameter("attack6")));
			dtl.setAttack7(Integer.parseInt(getParameter("attack7")));
			dtl.setAttack8(Integer.parseInt(getParameter("attack8")));
			dtl.setAttack9(Integer.parseInt(getParameter("attack9")));
			dtl.setAttack10(Integer.parseInt(getParameter("attack10")));
			dtl.setAttack11(Integer.parseInt(getParameter("attack11")));
			dtl.setAttack12(Integer.parseInt(getParameter("attack12")));
			//
			dtl.setDefend1(Integer.parseInt(getParameter("defend1")));
			dtl.setDefend2(Integer.parseInt(getParameter("defend2")));
			dtl.setDefend3(Integer.parseInt(getParameter("defend3")));
			dtl.setDefend4(Integer.parseInt(getParameter("defend4")));
			dtl.setDefend5(Integer.parseInt(getParameter("defend5")));
			dtl.setDefend6(Integer.parseInt(getParameter("defend6")));
			dtl.setDefend7(Integer.parseInt(getParameter("defend7")));
			dtl.setDefend8(Integer.parseInt(getParameter("defend8")));
			dtl.setDefend9(Integer.parseInt(getParameter("defend9")));
			dtl.setPid(bean.getId());
			commDao.updateObject(dtl);
		}		
		setAttribute("message", "success!");
		Alert.show("gbk", "success!", "act_User_findPersonInfo?id="+bean.getId());
		return null;
	}
	
	public String deletePersonInfo(){
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		commDao.deleteObject(PersonInfo.class, id);
		//删除个人能力
		PersonalAbility p1 = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		if(p1!=null){
			commDao.deleteObject(PersonalAbility.class, bean.getId());
		}
		//删除个人能力详细
		PersonalAbilityDtl p2 = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		if(p2!=null){
			commDao.deleteObject(PersonalAbilityDtl.class, bean.getId());
		}
		Alert.fresh("gbk", "act_User_queryPersonInfo");
		return null;
	}
	
	
	/**
	 * 个人能力信息详细
	 */
	public String updateDtl(){
		setUrl("user/finddtl.jsp");
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		bean.setTruename(getParameter("truename"));
		bean.setAge(Integer.parseInt(getParameter("age")));
		bean.setBirthday(getParameter("birthday"));
		bean.setSex(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("sex")));
		bean.setHeight(Integer.parseInt(getParameter("height")));
		bean.setWeight(Integer.parseInt(getParameter("weight")));
		bean.setHobby(getParameter("hobby"));
		bean.setSpecial(getParameter("special"));
		bean.setQq(getParameter("qq"));
		bean.setLongmobile(getParameter("longmobile"));
		bean.setShortmobile(getParameter("shortmobile"));
		bean.setPic(getParameter("pic"));		
		bean.setDanshen(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("danshen")));
		bean.setPostion(commDao.findObjectByAttr(SysdicInfo.class, "dicscode", getParameter("postion")));
//		bean.setTuiyi(getParameter("tuiyi"));
		commDao.updateObject(bean);
		///////////////////////////////////////////////////////
		PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		pa.setPid(bean.getId());
		pa.setAttack(Integer.parseInt(getParameter("attack")));
		pa.setDefend(Integer.parseInt(getParameter("defend")));
		pa.setSpeed(Integer.parseInt(getParameter("speed")));
		pa.setSkill(Integer.parseInt(getParameter("skill")));
		pa.setCons(Integer.parseInt(getParameter("cons")));
		pa.setPower(Integer.parseInt(getParameter("power")));
		commDao.updateObject(pa);
		/////////////////////////////////////////////////////////
		int flag = 0;
		PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		if(dtl==null){
			flag = 1;
			dtl = new PersonalAbilityDtl();
		}
		dtl.setAttack1(Integer.parseInt(getParameter("attack1")));
		dtl.setAttack2(Integer.parseInt(getParameter("attack2")));
		dtl.setAttack3(Integer.parseInt(getParameter("attack3")));
		dtl.setAttack4(Integer.parseInt(getParameter("attack4")));
		dtl.setAttack5(Integer.parseInt(getParameter("attack5")));
		dtl.setAttack6(Integer.parseInt(getParameter("attack6")));
		dtl.setAttack7(Integer.parseInt(getParameter("attack7")));
		dtl.setAttack8(Integer.parseInt(getParameter("attack8")));
		dtl.setAttack9(Integer.parseInt(getParameter("attack9")));
		dtl.setAttack10(Integer.parseInt(getParameter("attack10")));
		dtl.setAttack11(Integer.parseInt(getParameter("attack11")));
		dtl.setAttack12(Integer.parseInt(getParameter("attack12")));
		//
		dtl.setDefend1(Integer.parseInt(getParameter("defend1")));
		dtl.setDefend2(Integer.parseInt(getParameter("defend2")));
		dtl.setDefend3(Integer.parseInt(getParameter("defend3")));
		dtl.setDefend4(Integer.parseInt(getParameter("defend4")));
		dtl.setDefend5(Integer.parseInt(getParameter("defend5")));
		dtl.setDefend6(Integer.parseInt(getParameter("defend6")));
		dtl.setDefend7(Integer.parseInt(getParameter("defend7")));
		dtl.setDefend8(Integer.parseInt(getParameter("defend8")));
		dtl.setDefend9(Integer.parseInt(getParameter("defend9")));
		
		dtl.setPid(id);
		if(flag==1){
			commDao.insertObject(dtl);
		}
		if(flag==0){
			commDao.updateObject(dtl);
		}
		Alert.show("gbk", "success!", "act_User_findDtl?id="+id);
		return null;
	}	
	
	public String findDtl(){
		setUrl("user/finddtl.jsp");
		setAttribute("postionList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D04"));
		setAttribute("sexList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D02"));
		setAttribute("danshenList", commDao.getDicInfoListByParentCode(SysdicInfo.class, "D03"));	
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		setAttribute("bean", bean);
		
		PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		setAttribute("pa", pa);
		
		PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		if(dtl!=null){
			setAttribute("dtl", dtl);
		}else{
			setAttribute("dtl", new PersonalAbilityDtl());
		}
		return Util.SUCCESS;
	}
	
	public String showDtl(){
		setUrl("user/showdtl.jsp");
		long id = Long.parseLong(getParameter("id"));
		PersonInfo bean = commDao.findObjectById(PersonInfo.class, id);
		setAttribute("bean", bean);
		
		PersonalAbility pa = commDao.findObjectByAttr(PersonalAbility.class, "pid", bean.getId());
		setAttribute("pa", pa);
		
		PersonalAbilityDtl dtl = commDao.findObjectByAttr(PersonalAbilityDtl.class, "pid", bean.getId());
		setAttribute("dtl", dtl);
		return Util.SUCCESS;
	}
	
	public String queryDtl(){
		setUrl("user/personinfoDtllist.jsp");
		int currentpage = 1;
		int pagesize = 10;
		if (!StringUtils.isEmpty(getParameter("pagenum"))) {
			currentpage = Integer.parseInt(getParameter("pagenum"));
		}
		String key = getParameter("key");
		setAttribute("key", key);
		StringBuffer where = new StringBuffer(" where tuiyi='true' and role.dicscode='D0104'");
		Object[] value = new Object[0];
		if(!StringUtils.isEmpty(key)){
			where.append(" and truename like ?");
			value = createNames("%"+key+"%");
		}
		
		long total = commDao.getObjectCount(PersonInfo.class, where.toString(), value);
		List<PersonInfo> list = commDao.getObjectList(PersonInfo.class, where.toString(), value, " order by id desc", currentpage, pagesize);
		setAttribute("list", list);
		setAttribute("pagerinfo", Pager.getPagerNormal(total, pagesize,
				currentpage, "act_User_queryDtl", "共有" + total + "条记录"));
		
		User user = (User)getSession("user");
		if(user.getRole().getDicscode().equals("D0104") || user.getRole().getDicscode().equals("D0105")){
			setUrl("user/personinfoDtllist2.jsp");
		}
		return Util.SUCCESS;
	}
}

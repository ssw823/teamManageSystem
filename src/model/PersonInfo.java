package model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
/**
 * 个人信息
 * @author magicyang
 *
 */
@Entity
@Table(name="t_PersonInfo")
public class PersonInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "role",referencedColumnName="dicscode",nullable=false)
	private SysdicInfo role;

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "postion",referencedColumnName="dicscode")
	private SysdicInfo postion;
	
	private String truename;
	
	private String pic;//头像
	
	private String tuiyi = "false";//true,false是否退役

	@Column(nullable=true)
	private int age;
	
	private String birthday;
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "sex",referencedColumnName="dicscode")
	private SysdicInfo sex;

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "danshen",referencedColumnName="dicscode")
	private SysdicInfo danshen;//是否单身
	
	@Column(nullable=true)
	private int height;
	
	@Column(nullable=true)
	private int weight;
	
	private String hobby;//爱好
	private String special;//特长
	private String qq;
	private String longmobile;
	private String shortmobile;
	
	public SysdicInfo getPostion() {
		return postion;
	}
	public void setPostion(SysdicInfo postion) {
		this.postion = postion;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public SysdicInfo getRole() {
		return role;
	}
	public void setRole(SysdicInfo role) {
		this.role = role;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public String getTuiyi() {
		return tuiyi;
	}
	public void setTuiyi(String tuiyi) {
		this.tuiyi = tuiyi;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public SysdicInfo getSex() {
		return sex;
	}
	public void setSex(SysdicInfo sex) {
		this.sex = sex;
	}
	public SysdicInfo getDanshen() {
		return danshen;
	}
	public void setDanshen(SysdicInfo danshen) {
		this.danshen = danshen;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getSpecial() {
		return special;
	}
	public void setSpecial(String special) {
		this.special = special;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getLongmobile() {
		return longmobile;
	}
	public void setLongmobile(String longmobile) {
		this.longmobile = longmobile;
	}
	public String getShortmobile() {
		return shortmobile;
	}
	public void setShortmobile(String shortmobile) {
		this.shortmobile = shortmobile;
	}
	
	
}

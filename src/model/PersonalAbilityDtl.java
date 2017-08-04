package model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 个人能力详细
 * @author magicyang
 *
 */
@Entity
@Table(name="t_PersonalAbilityDtl")
public class PersonalAbilityDtl implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	private long pid;
	
	private int attack1 = 0;//短传
	private int attack2 = 0;//中传
	private int attack3 = 0;//长传
	private int attack4 = 0;//短接
	private int attack5 = 0;//中接
	private int attack6 = 0;//长接
	private int attack7 = 0;//跑动
	private int attack8 = 0;//路线
	private int attack9 = 0;//加速
	private int attack10 = 0;//弹跳
	private int attack11 = 0;//意识
	private int attack12 = 0;//团队合作

	private int defend1 = 0;//防短
	private int defend2 = 0;//防中
	private int defend3 = 0;//防长
	private int defend4 = 0;//防跑
	private int defend5 = 0;//区域
	private int defend6 = 0;//单挑
	private int defend7 = 0;//联防
	private int defend8 = 0;//意识
	private int defend9 = 0;//团队合作
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}
	public int getAttack1() {
		return attack1;
	}
	public void setAttack1(int attack1) {
		this.attack1 = attack1;
	}
	public int getAttack2() {
		return attack2;
	}
	public void setAttack2(int attack2) {
		this.attack2 = attack2;
	}
	public int getAttack3() {
		return attack3;
	}
	public void setAttack3(int attack3) {
		this.attack3 = attack3;
	}
	public int getAttack4() {
		return attack4;
	}
	public void setAttack4(int attack4) {
		this.attack4 = attack4;
	}
	public int getAttack5() {
		return attack5;
	}
	public void setAttack5(int attack5) {
		this.attack5 = attack5;
	}
	public int getAttack6() {
		return attack6;
	}
	public void setAttack6(int attack6) {
		this.attack6 = attack6;
	}
	public int getAttack7() {
		return attack7;
	}
	public void setAttack7(int attack7) {
		this.attack7 = attack7;
	}
	public int getAttack8() {
		return attack8;
	}
	public void setAttack8(int attack8) {
		this.attack8 = attack8;
	}
	public int getAttack9() {
		return attack9;
	}
	public void setAttack9(int attack9) {
		this.attack9 = attack9;
	}
	public int getAttack10() {
		return attack10;
	}
	public void setAttack10(int attack10) {
		this.attack10 = attack10;
	}
	public int getAttack11() {
		return attack11;
	}
	public void setAttack11(int attack11) {
		this.attack11 = attack11;
	}
	public int getAttack12() {
		return attack12;
	}
	public void setAttack12(int attack12) {
		this.attack12 = attack12;
	}
	public int getDefend1() {
		return defend1;
	}
	public void setDefend1(int defend1) {
		this.defend1 = defend1;
	}
	public int getDefend2() {
		return defend2;
	}
	public void setDefend2(int defend2) {
		this.defend2 = defend2;
	}
	public int getDefend3() {
		return defend3;
	}
	public void setDefend3(int defend3) {
		this.defend3 = defend3;
	}
	public int getDefend4() {
		return defend4;
	}
	public void setDefend4(int defend4) {
		this.defend4 = defend4;
	}
	public int getDefend5() {
		return defend5;
	}
	public void setDefend5(int defend5) {
		this.defend5 = defend5;
	}
	public int getDefend6() {
		return defend6;
	}
	public void setDefend6(int defend6) {
		this.defend6 = defend6;
	}
	public int getDefend7() {
		return defend7;
	}
	public void setDefend7(int defend7) {
		this.defend7 = defend7;
	}
	public int getDefend8() {
		return defend8;
	}
	public void setDefend8(int defend8) {
		this.defend8 = defend8;
	}
	public int getDefend9() {
		return defend9;
	}
	public void setDefend9(int defend9) {
		this.defend9 = defend9;
	}
	
	
}

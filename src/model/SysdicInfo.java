package model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_SysdicInfo")
public class SysdicInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)	
	private long id;
	
	@Column(nullable=false,unique=true)
	private String dicscode;
	
	@Column(nullable=false)
	private String dicname;
	
	private String dicvalue1;
	
	private String dicvalue2;
	
	@Column(nullable=true)
	private String parentscode;
	
	@Column(nullable=false)
	private String orderindex;
	
	private String remark;
	
	@Column(nullable=false)
	private int isactive;

	
	public String getDicvalue1() {
		return dicvalue1;
	}

	public void setDicvalue1(String dicvalue1) {
		this.dicvalue1 = dicvalue1;
	}

	public String getDicvalue2() {
		return dicvalue2;
	}

	public void setDicvalue2(String dicvalue2) {
		this.dicvalue2 = dicvalue2;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDicscode() {
		return dicscode;
	}

	public void setDicscode(String dicscode) {
		this.dicscode = dicscode;
	}

	public String getDicname() {
		return dicname;
	}

	public void setDicname(String dicname) {
		this.dicname = dicname;
	}

	public String getParentscode() {
		return parentscode;
	}

	public void setParentscode(String parentscode) {
		this.parentscode = parentscode;
	}

	public String getOrderindex() {
		return orderindex;
	}

	public void setOrderindex(String orderindex) {
		this.orderindex = orderindex;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getIsactive() {
		return isactive;
	}

	public void setIsactive(int isactive) {
		this.isactive = isactive;
	}
	
	
}

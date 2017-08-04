package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="t_user")
public class User implements Serializable{

	private static final long serialVersionUID = -7141419035239709511L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private long id;
	
	private String username;
	
	private String password;
	
	private Date createtime = new Date();
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "role",referencedColumnName="dicscode",nullable=false)
	private SysdicInfo role;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public SysdicInfo getRole() {
		return role;
	}

	public void setRole(SysdicInfo role) {
		this.role = role;
	}
	
}

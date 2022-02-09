package org.eeit131.group5.model;

import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Member")
@Component("member")
public class Member {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "MBID")
	private Integer mbid;
	@Column(name = "MBNAME")
	private String mbname;
	@Column(name = "MBEMAIL")
	private String mbemail;
	@Column(name = "MBPASSWORD")
	private String mbpassword;
	@Column(name = "BIRTHDAY")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date birthday;
	@Column(name = "GENDER")
	private String gender;
	@Column(name = "ADDRESS")
	private String address;
	@Column(name = "PHONE")
	private String phone;
	@JsonIgnore
	@Column(name = "IMAGE")
	private Blob image;
	@Column(name = "CREATETIME")
	// private SimpleDateFormat createTime;
	private Timestamp createTime;

	private boolean enabled;
	@Column(name = "VERIFYCODE", updatable = false)
	private String verifycode;
	@Transient
	private String fileDataUrl;
	private String mimeType;
	@Transient
	private LocalDate localDate;

	public LocalDate getLocalDate() {
		return localDate;
	}

	public void setLocalDate(LocalDate localDate) {
		this.localDate = localDate;
	}

	public String getFileDataUrl() {
		return fileDataUrl;
	}

	public void setFileDataUrl(String fileDataUrl) {
		this.fileDataUrl = fileDataUrl;
	}

	public String getMimeType() {
		return mimeType;
	}

	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}

	public Member() {
		super();
	}

	public Member(Integer mbid, String mbname, String mbemail, String mbpassword, Date birthday, String gender) {
		super();
		this.mbid = mbid;
		this.mbname = mbname;
		this.mbemail = mbemail;
		this.mbpassword = mbpassword;
		this.birthday = birthday;
		this.gender = gender;
	}

	public Member(String mbname, String mbemail, String mbpassword, Date birthday, String gender) {
		super();
		this.mbname = mbname;
		this.mbemail = mbemail;
		this.mbpassword = mbpassword;
		this.birthday = birthday;
		this.gender = gender;
	}

	public Member(Integer mbid) {
		super();
		this.mbid = mbid;
	}

	public Integer getMbid() {
		return mbid;
	}

	public void setMbid(Integer mbid) {
		this.mbid = mbid;
	}

	public String getMbname() {
		return mbname;
	}

	public void setMbname(String mbname) {
		this.mbname = mbname;
	}

	public String getMbemail() {
		return mbemail;
	}

	public void setMbemail(String mbemail) {
		this.mbemail = mbemail;
	}

	public String getMbpassword() {
		return mbpassword;
	}

	public void setMbpassword(String mbpassword) {
		this.mbpassword = mbpassword;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Blob getImage() {
		return image;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

//	public SimpleDateFormat getCreateTime() {
//		return createTime;
//	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getVerifycode() {
		return verifycode;
	}

	public void setVerifycode(String verifycode) {
		this.verifycode = verifycode;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

//	public void setCreateTime(SimpleDateFormat sdf) {
//		this.createTime = sdf;
//	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Member [mbid=" + mbid + ", mbname=" + mbname + ", mbemail=" + mbemail + ", mbpassword=" + mbpassword
				+ ", birthday=" + birthday + ", gender=" + gender + ", address=" + address + ", phone=" + phone
				+ ", image=" + image + ", createTime=" + createTime + ", enabled=" + enabled + ", verifycode="
				+ verifycode + ", fileDataUrl=" + fileDataUrl + ", mimeType=" + mimeType + ", localDate=" + localDate
				+ "]";
	}

}

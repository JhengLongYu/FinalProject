package org.eeit131.group5.model;

import java.sql.Timestamp;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component ("mbEvent")
public class MbEvent {
	String title;
	Timestamp start;
	Timestamp end;
//	String description;
	Map<String,String> extendedProps;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getStart() {
		return start;
	}
	public void setStart(Timestamp start) {
		this.start = start;
	}
	public Timestamp getEnd() {
		return end;
	}
	public void setEnd(Timestamp end) {
		this.end = end;
	}
	public Map<String,String> getExtendedProps() {
		return extendedProps;
	}
	public void setExtendedProps(Map<String,String> extendedProps) {
		this.extendedProps = extendedProps;
	}
//	public String getDescription() {
//		return description;
//	}
//	public void setDescription(String description) {
//		this.description = description;
//	}
	
}	

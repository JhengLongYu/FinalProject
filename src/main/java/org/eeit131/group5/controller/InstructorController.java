package org.eeit131.group5.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.FavoriteInstructors;
import org.eeit131.group5.model.InsSchedule;
import org.eeit131.group5.model.InstructorType;
import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.service.FavoriteInstructorsService;
import org.eeit131.group5.service.InsScheduleService;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.InstructorTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class InstructorController {
	
	@Autowired
	InstructorService instructorService;
	
	@Autowired
	InstructorTypeService instructorTypeService;
	
	@Autowired
	InsScheduleService insScheduleService;
	
	@Autowired
	FavoriteInstructorsService favoriteInstructorsService;
	
	@Autowired
	ServletContext ctx;
	
	@GetMapping("/consultion/addInstructorForm")
	public String AddInstructorForm() {
		return "/consultion/instructorForm";
	}
	
	@PostMapping(value = "/consultion/save", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody List<Instructors> saveData(
			@RequestBody Instructors instructor
			){
		String type=instructor.getType();
		InstructorType insType=instructorTypeService.findByTypeName(type);
		
		if(insType!=null) {
			instructor.setTypeId(insType.getTypeId());
		}else {
			InstructorType newInsType= new InstructorType();
			newInsType.setTypeName(type);
			instructorTypeService.save(newInsType);
			instructor.setTypeId(instructorTypeService.findByTypeName(type).getTypeId());
		}
		
		if(instructor.getFileDataUrl()!=null) {
			int startIndex = "data:".length();
			int endIndex = instructor.getFileDataUrl().indexOf(";");
			String mimeType = instructor.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = instructor.getFileDataUrl().substring(instructor.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				instructor.setCoverImage(new SerialBlob(a));
			} catch (SerialException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			instructor.setMimeType(mimeType) ;
		}else {
			instructor.setCoverImage(null);
			instructor.setMimeType(null) ;
		}
		instructorService.save(instructor);
		return instructorService.findAll();
	}
	
	
	
	
	@GetMapping("/consultion/getCoverImage")
	public ResponseEntity<byte[]> getCoverImage(
			@RequestParam("instructorId") Integer instructorId, Model model
			) {
		ResponseEntity<byte[]> re = null;
		Instructors instructor=instructorService.findById(instructorId);
		HttpHeaders headers = new HttpHeaders();
		if(instructor.getCoverImage()!=null) {
			Blob blob = instructor.getCoverImage();
			MediaType mediaType = MediaType.valueOf(instructor.getMimeType());
			
			try {
				
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				InputStream is = blob.getBinaryStream();
				byte[] b = new byte[81920];
				int len = 0;
				while ((len = is.read(b)) != -1) {
					baos.write(b, 0, len);
				}

				headers.setContentType(mediaType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue()); //叫瀏覽器不要cache這張圖片
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
				
		}else {
			String filename="noProfilePic.png";
			MediaType mimeType = MediaType.valueOf(ctx.getMimeType(filename));
			Resource resource = new ClassPathResource("static/images/" + filename);
			try (
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					InputStream in = resource.getInputStream();
				){
				byte[] b = new byte[819200];
				int len = 0;
				while ((len= in.read(b)) != -1) {
					baos.write(b, 0, len);
				}
				
				headers.setContentType(mimeType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue()); //叫瀏覽器不要cache這張圖片
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
			} catch(Exception ex) {
				ex.printStackTrace();
			}
			System.out.println(instructor.getInstructorId()+"  doesn't have images");
		}
		return re;
	}
	
	
	
	@GetMapping("/consultion/allinstructors")
	public String allinstructors(){
		return "/consultion/Instructors";
	}
	
	@GetMapping("/consultion/findAll")
	public @ResponseBody List<Instructors> findAll(){
		List<Instructors> instructors=instructorService.findAll();
		
		return instructors;
	}
	
	@GetMapping("/consultion/MbfindAll")
	public @ResponseBody List<Instructors> MbfindAll(){
		List<Instructors> instructors=instructorService.findAll();
		List<Instructors> aprrovedIns=new ArrayList<>();
		for(Instructors instructor: instructors) {
			String insStatus=instructor.getInsStatus();
			if(insStatus.equals("已審核")) {
				aprrovedIns.add(instructor);
			}
		}
		return aprrovedIns;
	}
	
	@GetMapping("/consultion/editInstructorForm")
	public String editInstructorForm(@RequestParam Integer instructorId, Model model){
		model.addAttribute("instructorId", instructorId);
		
		return "/consultion/editInstructorForm";
	}
	
	@GetMapping("/consultion/findByInstructorid")
	public @ResponseBody Instructors findByInstructorid(
			@RequestParam Integer instructorId
			){
			return instructorService.findById(instructorId);
	}
	
	
	
	@PutMapping(value = "/consultion/update", produces = { "application/json; charset=UTF-8" })
	public @ResponseBody Map<String,String> update(
			@RequestBody Instructors instructor
			){
		//typename 轉typeId
		InstructorType insType=instructorTypeService.findByTypeName(instructor.getType());
		instructor.setTypeId(insType.getTypeId());
		//status設值
		Instructors ins=instructorService.findById(instructor.getInstructorId());
		instructor.setInsStatus(ins.getInsStatus());
		
		Map<String,String> map = new HashMap<>();
		String result="";
		if(instructor.getFileDataUrl()!=null) {
			int startIndex = "data:".length();
			int endIndex = instructor.getFileDataUrl().indexOf(";");
			String mimeType = instructor.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = instructor.getFileDataUrl().substring(instructor.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				instructor.setCoverImage(new SerialBlob(a));
			} catch (SerialException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			instructor.setMimeType(mimeType) ;
		}else {
			instructor.setCoverImage(null);
			instructor.setMimeType(null) ;
		}
		
		try {
			instructorService.update(instructor);
		    result="修改成功";
		    map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	@PutMapping("/consultion/updateStatus")
	public @ResponseBody Map<String,String> updateStatus(
			@RequestBody Instructors instructor){
		System.out.println(instructor.getInsStatus());
		Instructors ins=instructorService.findById(instructor.getInstructorId());
		ins.setInsStatus(instructor.getInsStatus());
		Map<String,String> map = new HashMap<>();
		String result="";
		
		try {
			instructorService.update(ins);
		    result="修改狀態成功";
		    map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	
	@GetMapping("/consultion/delete")
	public @ResponseBody Map<String,String> delete(
			@RequestParam Integer instructorId, Model model
			) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			instructorService.remove(instructorId);
			result="刪除成功";
			map.put("success", result);
		}catch(Exception e) {
			result=e.getMessage();
			map.put("fail", result);
		}
		return map;
	}
	
	
	
	@GetMapping("/consultionPage")
	public String consultionPage() {
		return "consultion1/consultionPage";
	}
	@GetMapping("/consultion/insProfile/{instructorId}")
	public String insProfilePage(
			@PathVariable Integer instructorId,
			Model model
			) {
		model.addAttribute("instructorId", instructorId);
		return "consultion1/insProfile";
	}
	
	@GetMapping("/consultion/findbyInsId")
	public @ResponseBody Instructors findbyInsId(
			@RequestParam Integer instructorId) {
		return instructorService.findById(instructorId);
	}
	
	
	@GetMapping("/consultion/addInstructorTypePage")
	public String addInstructorTypePage() {
		return "consultion/addInstructorType";
	}
	
	@PostMapping("/consultion/addInsType")
	public @ResponseBody Map<String, String> addInsType(
			@RequestBody InstructorType insType) {
		
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			instructorTypeService.save(insType);
			result="成功新增類別!";
		    map.put("success", result);
		}catch(Exception e){
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	
	@GetMapping("/consultion/findAllInsType")
	public @ResponseBody List<InstructorType> findAllInsType(
			) {
		return instructorTypeService.findAll();
		
	}
	
	@GetMapping("/consultion/deleteInsType")
	public @ResponseBody Map<String, String> deleteInsType(
			@RequestParam Integer typeId
			) {
		Map<String,String> map = new HashMap<>();
		String result="";
		try {
			instructorTypeService.remove(typeId);
			result="成功刪除類別!";
		    map.put("success", result);
		}catch(Exception e){
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	
	
	@PostMapping("/consultion/addSchedule")
	public @ResponseBody Map<String, String> addSchedule(
			@RequestBody InsSchedule insSchedule) {
//		System.out.println("-------------------startTime"+insSchedule.getStartTime());
		Timestamp init=insSchedule.getStartTime();
		Calendar calstart = Calendar.getInstance();
		Calendar calend = Calendar.getInstance();
		
	    
	    
		Map<String,String> map = new HashMap<>();
		String result="";
		try { //(start+i, start+(i+1)) 
			for(int i=0; i<insSchedule.getDuration();i++) {
				InsSchedule schedule= new InsSchedule();
				schedule.setInstructorId(insSchedule.getInstructorId());
				
				calstart.setTimeInMillis(init.getTime());
				calstart.add(Calendar.HOUR, i);;
				long calStart=calstart.getTime().getTime();
				Timestamp startTime= new Timestamp(calStart);
				schedule.setStartTime(startTime);
//				System.out.println("startTime"+startTime);
				
				calend.setTimeInMillis(init.getTime());
				calend.add(Calendar.HOUR, (i+1));
				long calEnd=calend.getTime().getTime();
				Timestamp endTime= new Timestamp(calEnd);
				schedule.setEndTime(endTime);
//				System.out.println("endTime"+endTime);
				
				
				insScheduleService.save(schedule);
			}
			result="成功新增可諮詢時段!";
		    map.put("success", result);
		}catch(Exception e){
			result=e.getMessage();
			map.put("fail",result);
		}
		return map;
	}
	
	@GetMapping("/consultion/findSchedulebyInsNo/{instructorId}")
	public @ResponseBody List<InsSchedule> findbyInsNo(
			@PathVariable Integer instructorId
			){
		List<InsSchedule> schedule=insScheduleService.findByInstructorId(instructorId);
		
		return schedule;
		
	}
	
	@PostMapping("/consultion/addToFavoriteIns")
	public @ResponseBody Map<String,String> addToFavoriteIns(
			@RequestBody FavoriteInstructors favoriteIns
			) {
		Map<String,String> map = new HashMap<>();
		String result="";
		System.out.println(favoriteIns.getMemberId());
		List<FavoriteInstructors> favorIns= favoriteInstructorsService.findByMemberId(favoriteIns.getMemberId());
		if(favorIns.size()!=0) {
			for(int i=0;i<favorIns.size();i++) {
				FavoriteInstructors fav=favorIns.get(i);
				if(fav.getInstructorId()==favoriteIns.getInstructorId()) {
					favoriteInstructorsService.remove(fav.getFavNo());
					result="已取消收藏";
					map.put("fail",result);
					break;
				}else {
					if( i== (favorIns.size()-1) ) {
						try {
							favoriteInstructorsService.save(favoriteIns);
							result="已加入最愛";
						    map.put("success", result);
						    break;
						}catch(Exception e){
							result=e.getMessage();
							map.put("fail",result);
							break;
						}
					}else {
						continue;
					}
				}
			}
		}else {
			try {
				favoriteInstructorsService.save(favoriteIns);
				result="已加入最愛";
			    map.put("success", result);
			}catch(Exception e){
				result=e.getMessage();
				map.put("fail",result);
			}
		}
		
		return map;
		
	}
	
	@GetMapping("/consultion/mbfavoriteInsPage/{mbid}")
	public String mbfavoriteInsPage(
			@PathVariable Integer mbid){
		return "/consultion1/memberCenter_mbFavoritesIns";
	}
	
	@GetMapping("/consultion/mbfavoriteIns/{mbid}")
	public @ResponseBody List<FavoriteInstructors> mbfavoriteIns(
			@PathVariable Integer mbid ){
		
		return favoriteInstructorsService.findByMemberId(mbid);
		
	}
	
	@GetMapping("/consultion/countFavorites/{insId}")
	public @ResponseBody Integer countFavorites(
			@PathVariable Integer insId
			) {
		int count=favoriteInstructorsService.findByInsId(insId);
//		System.out.println("controller內"+insId+":"+count);
		return count;
	}
	
	//模糊查詢
	@GetMapping("/consultion/findbyNameLike/{name}")
	public @ResponseBody List<Instructors> findbyNameLike(
			@PathVariable String name
			) {
		List<Instructors> inss=instructorService.findbyNameLike(name);
//		System.out.println("inss---------------------------"+inss);
			return inss;
		
	}
	@GetMapping("/consultion/findbyTypeId/{typeId}")
	public @ResponseBody List<Instructors> findbyTypeId(
			@PathVariable Integer typeId
			){
		List<Instructors> inss=instructorService.findbyTypeId(typeId);
		return inss;
	}
	
	@GetMapping("/consultion/CountAmount/{typeId}")
	public @ResponseBody Integer CountAmount(
			@PathVariable Integer typeId
			){
		List<Instructors> inss=instructorService.findbyTypeId(typeId);
		int amount=0;
		if (inss!=null) {
			amount=inss.size()+1;
//			System.out.println(typeId+"________________________________"+amount);
		}else {
			amount=0;
		}
		
		return amount;
	}
}

package org.eeit131.group5.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Manager;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.service.ManagerService;
import org.eeit131.group5.service.MemberService;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
@SessionAttributes(names = { "manager","loginStatus_Manager"  })
@Controller        
public class BackLoginController {
	@Autowired
	ManagerService managerService;

	@Autowired
	MemberService memberService;

	@Autowired
	ServletContext ctx;

	// 後台登出的控制器
	@GetMapping("/back/logout")
	public String backLogout(SessionStatus status) {
		status.setComplete();
		return "redirect:/backindex";
	}
	//模糊查詢
			@GetMapping("/findbyNameOrEmail")
			public @ResponseBody List<Member> findbyNameOrEmail(
					@RequestParam String keyword
					) {
				List<Member> keywordVaule=memberService.findbyNameOrEmail(keyword);
				System.out.println("全部的keywordVaule在這"+keywordVaule);
				// member1用來將顯示時間更改為只有日期
				List<Member> member1 = new ArrayList<>();
				for (int i = 0; i < keywordVaule.size(); i++) {
					System.out.println();
					Timestamp tt = keywordVaule.get(i).getCreateTime();
					LocalDate localDate = tt.toLocalDateTime().toLocalDate();
					keywordVaule.get(i).setLocalDate(localDate);
					member1.add(keywordVaule.get(i));
					// System.out.println(localDate);
				}
				// System.out.println("member1=" + member1);
				return member1;
					//return keywordVaule;
			}


	// 在登入時檢查是否有帳號密碼
	@PostMapping("/back/login/checkAccount")
	public @ResponseBody Map<String, String> checkAccount(@RequestBody Manager manager,Model model) {
		Map<String, String> errors = new HashMap<String, String>();

		String name = manager.getName();// 前端來的
		String password = manager.getPassword();

		System.out.println("管理者名稱=" + name);
		System.out.println("管理者密碼=" + password);

		if (name == null || name.length() == 0) {
			errors.put("nameBlank", "請輸入帳號");
			return errors;
		}

		if (password == null || password.length() == 0) {
			errors.put("passwordBlank", "請輸入密碼");
			return errors;
		}

		// 去尋找資料庫帳號密碼是否存在
		Manager mg = managerService.findByName(name);
		System.out.println("資料庫中的manager資料為=" + mg);
	
		if (mg != null) {
	
			if (mg.getPassword().equals(password)) {
				System.out.println("帳號及密碼正確");
				errors.put("mg", "帳號及密碼正確");
				model.addAttribute("manager",mg.getName());
				model.addAttribute("loginStatus_Manager",true);
	
				return errors;//原本的
			} else {
				errors.put("mg", "wrong password");
				System.out.println("密碼錯誤");
				return errors;
			}

		} else {
			System.out.println("資料庫中沒有manager");
			errors.put("mg", "no manager");
			return errors;
		}

	}

	// 找尋全部成員由management_member.jsp 內的dataArea去使用此功能來抓取資料顯示AJAX
	@GetMapping("/findAll")
	public @ResponseBody List<Member> findAll() {
		List<Member> members = memberService.findAll();
		// System.out.println("members=" + members);
		// member1用來將顯示時間更改為只有日期
		List<Member> member1 = new ArrayList<>();
		for (int i = 0; i < members.size(); i++) {
			System.out.println();
			Timestamp tt = members.get(i).getCreateTime();
			LocalDate localDate = tt.toLocalDateTime().toLocalDate();
			members.get(i).setLocalDate(localDate);
			member1.add(members.get(i));
			// System.out.println(localDate);
		}
		// System.out.println("member1=" + member1);
		return member1;
	}

	// 取照片的控制器
	@GetMapping("/getImage")
	public ResponseEntity<byte[]> getCoverImage(@RequestParam("mbid") Integer mbid) {
		ResponseEntity<byte[]> re = null;
		Member member = memberService.findById(mbid);
		HttpHeaders headers = new HttpHeaders();

		if (member.getImage() != null) {
			Blob blob = member.getImage();
			MediaType mediaType = MediaType.valueOf(member.getMimeType());

			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				InputStream is = blob.getBinaryStream();
				byte[] b = new byte[81920];
				int len = 0;
				while ((len = is.read(b)) != -1) {
					baos.write(b, 0, len);
				}
				headers.setContentType(mediaType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue());
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			String filename = "member_0.png";
			MediaType mimeType = MediaType.valueOf(ctx.getMimeType(filename));
			Resource resource = new ClassPathResource("static/images/" + filename);
			try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
					InputStream in = resource.getInputStream();) {
				byte[] b = new byte[81920];
				int len = 0;
				while ((len = in.read(b)) != -1) {
					baos.write(b, 0, len);
				}
				headers.setContentType(mimeType);
				headers.setCacheControl(CacheControl.noCache().getHeaderValue());// 叫瀏覽器不要cache這張圖片
				re = new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.OK);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			System.out.println(member.getMbid() + "  doesn't have images");
		}
		return re;
	}

	// 找尋MBID並帶入參數至下個頁面
	@GetMapping("/findId")
	public String sendEditMemberForm(@RequestParam("mbid") Integer mbid, Model model) {
		model.addAttribute("mbid", mbid);
		// 由memberManagement.jsp內的link連結讓管理者點擊ID可前往會員管理中心更改資料
		return "/login_Back/management_member_edit";
	}

	// 後台修改會員資料頁面 去以MBID找尋該會員資料
	@GetMapping("/memberManagement/{mbid}")
	public @ResponseBody Member findById(@PathVariable Integer mbid) {
		return memberService.findById(mbid);
	}

	// 後台修改會員資料部分
	@PutMapping(value = "/managerUpdate", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody Map<String, String> update(@RequestBody Member member
	// @PathVariable Integer mbid
	) {
		Member member1 = memberService.findById(member.getMbid());
		System.out.println("前端傳來的的obj member=" + member);
		System.out.println("前端傳來的的照片檔案為" + member.getFileDataUrl());

		Map<String, String> map = new HashMap<>();
		String result = "";
		if (member.getFileDataUrl() != null) {
			Integer startIndex = "data:".length();
			Integer endIndex = member.getFileDataUrl().indexOf(";");
			String mimeType = member.getFileDataUrl().substring(startIndex, endIndex);
			String base64 = member.getFileDataUrl().substring(member.getFileDataUrl().indexOf(",") + 1);
			byte[] a = Base64.getDecoder().decode(base64);
			try {
				member.setImage(new SerialBlob(a));
			} catch (SerialException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			member.setMimeType(mimeType);
		} else {
			member.setImage(null);
			member.setMimeType(null);
		}

		try {
			member.setMbpassword(member1.getMbpassword());
			memberService.update(member);
			result = "修改成功";
			map.put("success", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}

		return map;
	}

	@GetMapping("/memberManagement/delete")
	public @ResponseBody Map<String, String> deleteMember(@RequestParam("mbid") Integer mbid) {
		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			memberService.delete(mbid);
			result = "刪除成功";
			map.put("deleteSuccess", result);
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

}

package org.eeit131.group5.controller;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Instructors;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.ReCaptchaResponse;
import org.eeit131.group5.model.Token;
import org.eeit131.group5.service.InstructorService;
import org.eeit131.group5.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
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
import org.springframework.web.client.RestTemplate;

//提升至SESSION等級目前有三樣
@SessionAttributes(names = { "user", "loginStatus", "mbid","insId","insIdStatus" })
@Controller
public class LoginController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	InstructorService instructorService;
	
	@Autowired
	ServletContext ctx;
	@Autowired
	private RestTemplate restTemplate;
	@PostMapping("/robot")
	public @ResponseBody void verifyRobot(@RequestBody  Token token) {
		String url = "https://www.google.com/recaptcha/api/siteverify";
		String secret = "?secret=6LdJdyIcAAAAAJxd0Ttdad73cokSMC1_IhLdcdF5&response="+token.getToken();
		System.out.println(token.getToken());
		ReCaptchaResponse reCaptchaResponse = restTemplate.exchange(url+secret, HttpMethod.POST, null, ReCaptchaResponse.class).getBody();
		if(reCaptchaResponse.isSuccess()) {
		System.out.println("YA");
			//return "redirect:/list";
		} else {
			System.out.println("Failed");
			//return "redirect:/";
		}
	}
	@GetMapping("/memberCenter/{mbid}")
	public @ResponseBody Member findById(@PathVariable Integer mbid) {
		return memberService.findById(mbid);
	}
	
	// 登出的控制器
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:index";
	}

	// 在登入時檢查是否有帳號密碼
	@PostMapping("/login/checkAccount")
	public @ResponseBody Map<String, String> checkAccount(@RequestBody Member member, Model model) {
		Map<String, String> errors = new HashMap<String, String>();
		// System.out.println(member);
		// mbemail是來自請求端輸入的,並且設定為member.取的EMAIL
		String mbemail = member.getMbemail();
		String mbpassword = member.getMbpassword();

		System.out.println(mbemail);
		System.out.println(mbpassword);
		if (mbemail == null || mbemail.length() == 0) {
			errors.put("mbemail", "請輸入帳號!!!");
			return errors;
		}

		if (mbpassword == null || mbpassword.length() == 0) {
			errors.put("mbpassword", "請輸入密碼!!!");
			return errors;
		}

		Member mb = memberService.findByEmail(mbemail);
		System.out.println("mb=" + mb);
		if (mb != null) {
			if (mb.isEnabled()) {
				if (mb.getMbpassword().equals(mbpassword)) {
					// 設定model並且傳回前端座使用

					model.addAttribute("loginStatus", true);
					model.addAttribute("user", mb.getMbname());
					model.addAttribute("mbid", mb.getMbid());
					model.addAttribute("mbemail", mb.getMbemail());
					errors.put("mb", mb.getMbname());
					System.out.println("bingo!!");
					Instructors ins=instructorService.findByMemberId(mb.getMbid());
					if(ins!=null) {
					model.addAttribute("insId", ins.getInstructorId());
					model.addAttribute("insIdStatus", true);
					}else {
						model.addAttribute("insIdStatus", false);	
					}
					return errors;
				} else {
					errors.put("mb", "wrong password");
					System.out.println("wrong password!!");
					return errors;
				}
			} else {
				errors.put("mb", "verifyfailed");//沒開通
				return errors;
			}
		} else {
			System.out.println("error!!");
			errors.put("mb", "false");//沒這個帳號
			return errors;
		}
	}

	// 註冊新增置資料庫
	@PostMapping("/rigesterMember")
	public @ResponseBody Map<String, String> save(@RequestBody Member member) {
		System.out.println("member=" + member);
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		member.setCreateTime(ts);

		Map<String, String> map = new HashMap<>();
		String result = "";
		try {
			memberService.save(member);
			result = "新增成功";
			map.put("success", result);

		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}
		return map;
	}

	// 檢查EMAIL是否註冊,搭配register.jsp的ajax
	@PostMapping("/register/checkEmail")
	public @ResponseBody Map<String, String> existByMbemail(@RequestParam("mbemail") String mbemail) {
		Map<String, String> map = new HashMap<>();
		Member member = memberService.findByEmail(mbemail);
		if (member == null) {
			map.put("mbemail", "");
		} else {
			map.put("mbemail", member.getMbemail());
		}
		return map;
	}

	// 註冊成功後跳轉成功註冊頁面
	@GetMapping("/registerSuccess/{username}/{useremail}")
	public String management(@PathVariable String username, @PathVariable String useremail, Model model) {
		model.addAttribute("username", username);
		model.addAttribute("useremail", useremail);
		return "login_Front/registerSuccess";
	}

	// 後台修改會員資料部分
	@PutMapping(value = "/memberUpdate", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody Map<String, String> update(@RequestBody Member member, Model model
	// @PathVariable Integer mbid
	) {
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
			// memberInfo透過mbid尋找資料
//			Member memberInfo = memberService.findById(member.getMbid());
//			// 因修改基本資料內沒有帳號及密碼，使用memberInfo取的他的email並且set
//			member.setMbemail(memberInfo.getMbemail());
//			member.setMbpassword(memberInfo.getMbpassword());
			memberService.update(member);
			result = "修改成功";
			map.put("success", result);
			model.addAttribute("loginStatus", true);
			model.addAttribute("user", member.getMbname());
			model.addAttribute("mbid", member.getMbid());
		} catch (Exception e) {
			result = e.getMessage();
			map.put("fail", result);
		}

		return map;
	}

}

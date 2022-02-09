package org.eeit131.group5.controller;

import javax.mail.MessagingException;
import javax.persistence.EntityManager;

import org.eeit131.group5.model.Mail;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.repository.MemberRepository;
import org.eeit131.group5.service.MemberService;
import org.eeit131.group5.service.SendMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import net.bytebuddy.utility.RandomString;

@Controller
public class EmailController {

    SendMailService service;
    @Autowired
	MemberService memberService;
    @Autowired
	EntityManager entityManager;
    @Autowired
	MemberRepository memberRepository;

    public EmailController(SendMailService service) {
        this.service = service;
    }
    @GetMapping("/changeEnabled/{verifycode}")
    public @ResponseBody String changeEnabled(@PathVariable String verifycode) {
    	System.out.println(verifycode);
  Member mb = memberService.findByVerifycode(verifycode);
    	if(mb!=null) {
    		System.out.println("更改enabled");
    		boolean verify=memberService.verify(verifycode);
    	return "驗證成功";//index是單純字串,會回傳到前端的AJAX 
    	//去成功畫面
    	}else {
    		return "驗證失敗";
    		//去失敗畫面
    	}
 
    }
    //點選連結前往開通帳號成功畫面,需思考連結亂數碼打錯會跳轉去哪的問題?
    @GetMapping("/verify/{verifycode}")
    public String checkVerifycode(@PathVariable String verifycode,Model model) {
    	System.out.println("有成功寄信出去並且路徑有加驗證碼亂數在路徑");
    	model.addAttribute("verifycode",verifycode);
    	//要加Model attribute,帶著參數前往checkVerifycode 讓AJAX有值能獲得
    	return "login_Front/verifySuccess";
    }

    @PostMapping("/send")//寄送信件出去
    public ResponseEntity<String> sendMail(@RequestBody Mail mail) {
    	Member mb=memberService.findByEmail(mail.getRecipient());
    	String verifycode=mb.getVerifycode();
    	String link="親愛的"+mb.getMbname()+"您好：\n"; 
    	 link+="請點擊以下連結完成會員帳號開通程序：\n";
    	 
    	 link+="http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/verify/"+verifycode+"\n";
//    	 link+="http://localhost:8080/health/verify/"+verifycode+"\n";
    	 link+=" 如果瀏覽器不能自動開啟，請把網址複製到瀏覽器中手動開啟。";
    
    	mail.setMessage(link);
        service.sendMail(mail);
        
        return new ResponseEntity<>("信件已成功寄出", HttpStatus.OK);
    }
    
    @PostMapping("/send/resetPasswordAndSend")//寄送信件出去
    public ResponseEntity<String> resetPasswordAndSend(@RequestBody Mail mail) {
    	Member mb=memberService.findByEmail(mail.getRecipient());
    	
    	String randomCode=RandomString.make(12);
    	mb.setMbpassword(randomCode);
    	String link="親愛的"+mb.getMbname()+"您好：\n";         
    	link+="我們已收到您的密碼重設要求。\n";
    	link+="請輸入新密碼重新登入並至會員中心更改新密碼。 \n";
    	link+="以下是您的密碼 : \n";
    	link+=randomCode+"\n";

    	
    	
    	System.out.println("隨機碼="+randomCode);
    	System.out.println(mb.getMbpassword());
    	mail.setMessage(link);
        service.sendMail(mail);
      
        memberService.update(mb);
        
        return new ResponseEntity<>("信件已成功寄出", HttpStatus.OK);
    }
    @PostMapping("/attachment")
    public ResponseEntity<String> sendAttachmentEmail(@RequestBody Mail mail) throws MessagingException {
        service.sendMailWithAttachments(mail);
        return new ResponseEntity<>("Attachment mail sent successfully", HttpStatus.OK);
    }
}
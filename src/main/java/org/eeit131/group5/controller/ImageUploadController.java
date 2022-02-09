package org.eeit131.group5.controller;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.eeit131.group5.model.ImageUploadVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;



@RestController
@RequestMapping("/images")
public class ImageUploadController {
	 
	private final String imageFilePath = "C:/test/";
	
	@Autowired
	ServletContext servletContext;
	 
	
    @RequestMapping("/ckeditorUpload")
    public @ResponseBody ImageUploadVo ckeditorUpload(@RequestParam("upload") MultipartFile file) throws Exception {
    	System.out.println("開始上傳圖片");
    	// 獲取文件名
        String fileName = file.getOriginalFilename();
        System.out.println(fileName);
        // 獲取文件的后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        System.out.println(suffixName);
        String newFileName = UUID.randomUUID().toString() + suffixName;
        System.out.println(imageFilePath + newFileName);
        System.out.println("上传文件大小 ：{}" + file.getSize());
        FileUtils.copyInputStreamToFile(file.getInputStream(), new File(imageFilePath + newFileName));

        ImageUploadVo imageUploadVo = new ImageUploadVo();
        imageUploadVo.setUploaded(1);
        imageUploadVo.setFileName(newFileName);
//        imageUploadVo.setUrl("http://eeit131health.southeastasia.cloudapp.azure.com:8080/FinalProject/" + newFileName);
        imageUploadVo.setUrl("http://localhost:8080/health/" + newFileName);
        return imageUploadVo;
    } 
    
//    @RequestMapping("/ckeditorUpload")
//    public @ResponseBody ImageUploadVo ckeditorUpload(@RequestParam("upload") MultipartFile file) throws Exception {
//    	System.out.println("開始上傳圖片");
//    	// 獲取文件名
//        String fileName = file.getOriginalFilename();
//        System.out.println(fileName);
//        SimpleDateFormat simplateDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//        String newFileName  = simplateDateFormat.format(new Date()) + fileName;
//        System.out.println(newFileName);
//        System.out.println("上传文件大小 ：{}" + file.getSize());
//        Path path = Paths.get(servletContext.getRealPath("/WEB-INF/uploads/" + newFileName));
//        System.out.println("path" + path);
//        FileUtils.copyInputStreamToFile(file.getInputStream(), new File(path + ""));
//
//        ImageUploadVo imageUploadVo = new ImageUploadVo();
//        imageUploadVo.setUploaded(1);
//        imageUploadVo.setFileName(newFileName);
//        imageUploadVo.setUrl("http://localhost:9596/uploads/" + newFileName);
//        System.out.println("http://localhost:9596/uploads/" + newFileName);
//        return imageUploadVo;
//    }

}

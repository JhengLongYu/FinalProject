package org.eeit131.group5.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.eeit131.group5.model.Food;
import org.eeit131.group5.model.HealthCalculate;
import org.eeit131.group5.model.HealthCenter;
import org.eeit131.group5.model.Member;
import org.eeit131.group5.model.SportConsume;
import org.eeit131.group5.service.HealthCenterService;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HealthCenter_image {

	@Autowired
	HealthCenterService healthCenterService;

	@Autowired
	HealthCalculate healthCalculate;

	@Autowired
	ServletContext ctx;

	// 取照片的控制器
		@GetMapping("/getfoodImage")
		public ResponseEntity<byte[]> getfoodImage(@RequestParam("foodid") Integer id) {
			ResponseEntity<byte[]> re = null;
			System.out.println("foodid = " + id);
			Food food = healthCenterService.findbyfoodid(id);
			System.out.println("food = " + food);
			HttpHeaders headers = new HttpHeaders();

			if (food.getImage() != null) {
				Blob blob = food.getImage();
				MediaType mediaType = MediaType.valueOf(food.getMimeType());

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
				} catch (Exception e ) {
					e.printStackTrace();
				}
			} else {
				String filename = "Feeling Blue-bro.png";
				MediaType mimeType = MediaType.valueOf(ctx.getMimeType(filename));
				Resource resource = new ClassPathResource("static/images/forHealth/forfood/" + filename);
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
				System.out.println(food.getFoodid() + "  doesn't have images");
			}
			return re;
		}

}

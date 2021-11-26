package org.zerock.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/uploadForm")
	public void uploadForm() {} // /uploadForm.jsp로 이동시키는 메소드
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "/Users/sumin/Desktop/Spring/upload";
		
		for(MultipartFile multipartFile:uploadFile) {
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {}
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "/Users/sumin/Desktop/Spring/upload";
		
		// make folder-------------
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("Upload Path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder
		
		
		
		for(MultipartFile multipartFile:uploadFile) {
			
			log.info("---------------------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
		
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			log.info("Only File Name : " + uploadFileName.substring(uploadFileName.indexOf("/") + 1));
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			
			try {
				multipartFile.transferTo(saveFile);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
}

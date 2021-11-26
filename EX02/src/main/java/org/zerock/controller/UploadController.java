package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

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
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "/Users/sumin/Desktop/Spring/upload";
		List<AttachFileDTO> list = new ArrayList<>();
		
		String uploadFolderPath = getFolder();
		// make folder-------------
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("Upload Path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder
		
		
		
		for(MultipartFile multipartFile:uploadFile) {
			
			log.info("---------------------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			log.info("Only File Name : " + uploadFileName.substring(uploadFileName.indexOf("/") + 1));
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					// 썸네일을 만들어주는 메소드 createThumbnail()
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
					thumbnail.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	
}

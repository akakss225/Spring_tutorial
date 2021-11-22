package org.zerock.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
		
	}
	
	// return 값이 VO일경우 produces를 생략 가능 >> 기본값이 JSON과 XML이다.
	@GetMapping(value = "/getSample" )
	public SampleVO getSample() {
		return new SampleVO(113, "rocket", "racoon");
	}
	
}

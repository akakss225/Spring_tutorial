package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

//@RestController
@RequestMapping("/sample/*")
@Log4j
@Controller
public class SampleController {
	
//	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
//	public String getText() {
//		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
//		return "안녕하세요";
//		
//	}
//	
//	// return 값이 VO일경우 produces를 생략 가능 >> 기본값이 JSON과 XML이다.
//	@GetMapping(value = "/getSample" )
//	public SampleVO getSample() {
//		return new SampleVO(113, "rocket", "racoon");
//	}
//	
//	@GetMapping(value = "/getList")
//	public List<SampleVO> getList(){
//		
////		List<SampleVO> list = new ArrayList<SampleVO>();
////		for(int i = 1; i <= 10; i++) {
////			list.add(new SampleVO(i, i+ "First", i + "Last"));
////		}
////		return list;
//		
//		return IntStream.range(1,10).mapToObj(i -> new SampleVO(i, i+"Frist", i + "Last")).collect(Collectors.toList());
//	}
//	
//	@GetMapping(value = "/getMap")
//	public Map<String, SampleVO> getMap(){
//		
//		// upcasting
//		Map<String, SampleVO> map = new HashMap<>();
//		
//		map.put("First",  new SampleVO(111,"groot", "Junior"));
//		
//		return map;
//	}
//	
//	@GetMapping(value = "/getMap2")
//	public Map<String, List<SampleVO>> getMap2(){
//		
//		Map<String, List<SampleVO>> map = new HashMap<>();
//		
//		List<SampleVO> list = new ArrayList<SampleVO>();
//		
//		for(int i = 1; i <= 10; i++) {
//			list.add(new SampleVO(i, i+ "First", i + "Last"));
//		}
//		
//		map.put("First", list);
//		
//		return map;
//	}
//	
//	@GetMapping(value = "/check", params = {"height", "weight"})
//	public ResponseEntity<SampleVO> check(Double height, Double weight){
//		
//		// 문자열 + double = 문자열. >> 일종의 타입 바꿔주기 팁.
//		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
//		
//		ResponseEntity<SampleVO> result = null;
//		
//		if(height < 150) {
//			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
//		}		else {
//			result = ResponseEntity.status(HttpStatus.OK).body(vo);
//		}
//		return result;
//	}
//	
//	@GetMapping("/product/{cat}/{pid}")
//	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
//		return new String[] { "category : " + cat, "productid : " + pid };
//	}
//	
//	@PostMapping("/ticket")
//	public Ticket convert(@RequestBody Ticket ticket) {
//		log.info("convert...... ticket" + ticket);
//		return ticket;
//	}
	
//	security 샘플 코드
	
	@GetMapping("/all")
	public void doAll() {
		// all.jsp이동 목적
	}
	
	@GetMapping("/member")
	public void doMember() {
		// member.jsp이동 목적
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		// admin.jsp이동 목적
	}
	
	
}

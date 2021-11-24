package org.zerock.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	// ServiceImpl 클래스의 모든 메소드가 실행되기 전에 동작
	@Before("execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		// 로그인 여부
		// 시간 logging 등
		
		log.info("==========================");
	}
}

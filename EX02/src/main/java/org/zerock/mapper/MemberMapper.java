package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
	
	// parameter가 security에서 userName이라고 넘어 오는데, 이는 userid와 같은것을 가리킨다.
	public MemberVO read(String userid);
	
	

}

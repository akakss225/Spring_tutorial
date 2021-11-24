package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
	public int register(ReplyVO vo) {
		
		log.info("register......." + vo);
		
		return mapper.insert(vo);
	}

	
	public ReplyVO get(Long rno) {
		
		log.info("get......." + rno);
		
		return mapper.read(rno);
	}


	public int modify(ReplyVO vo) {
		
		log.info("modify......." + vo);
		
		return mapper.update(vo);
	}


	public int remove(Long rno) {
		log.info("remove......." + rno);
		
		return mapper.delete(rno);
	}


	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of a board......." + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}


	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
					mapper.getCountByBno(bno),
					mapper.getListWithPaging(cri, bno)
				);
	}
	
	
}

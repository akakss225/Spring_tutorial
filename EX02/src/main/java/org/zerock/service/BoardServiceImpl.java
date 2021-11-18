package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

// Service 어노테이션이 없다면 500번 에러가 난다.
@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper; // 주입. >> Spring 4.3이상부터는 annotation조차 생략 가능. 단, AllArgsConstructor 어노테이션을 추가해야한다.

	public void register(BoardVO board) {
		log.info("register......" + board);
		mapper.insertSelectKey(board);
	}

	public BoardVO get(Long bno) {
		log.info("get......" + bno);
		return mapper.read(bno);
	}

	public boolean modify(BoardVO board) {
		log.info("modify......" + board);
		return mapper.update(board) == 1;
	}

	public boolean remove(Long bno) {
		log.info("remove......." + bno);
		return mapper.delete(bno) == 1;
	}

//	public List<BoardVO> getList() {
//		log.info("getList.......");
//		return mapper.getList();
//	}
	
	// 글 목록 + 페이징
	public List<BoardVO> getList(Criteria cri){
		log.info("get List with criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	

}

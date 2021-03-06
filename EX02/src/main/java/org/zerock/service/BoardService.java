package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	// 글 등록
	public void register(BoardVO board);
	// 글 상세보기
	public BoardVO get(Long bno);
	// 글 수정
	public boolean modify(BoardVO board);
	// 글 삭제
	public boolean remove(Long bno);
	// 글 목록
//	public List<BoardVO> getList();
	// 글 목록 + 페이징
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
}

package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

// BoardMapper.xml을 이용해서 여러가지 logic을 실행시켜주는 impl
// 기존 MVC Pattern(JSP)에서 DAO의 역할을 수행하는 part임.
public interface BoardMapper {
	// 글 목록
	public List<BoardVO> getList();
	// 글 목록 + 페이징
	public List<BoardVO> getListWithPaging(Criteria cri);
	// 글 등록
	public void insert(BoardVO board);
	// 글 등록
	public void insertSelectKey(BoardVO board);
	// 글 상세보기
	public BoardVO read(Long bno);
	// 글 삭제 >> 영향을 받은 행의 수를 return하기 때문에 return type이 int인 것임.
	public int delete(Long bno);
	// 글 수정 >> delete와 마찬가지.
	public int update(BoardVO board);
	// 글 갯수
	public int getTotalCount(Criteria cri);
}
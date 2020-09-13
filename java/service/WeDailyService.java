package collabo.wato.springboot.web.WeDaily.service;

import java.util.List;
import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;

public interface WeDailyService {
	
	  // 회원가입 
	  void insertUser(WeDailyVO vo) throws Exception; 
	 
	  // 로그인
	  List<WeDailyVO> selectUser(WeDailyVO vo) throws Exception;
	  
	  // 영화찜 insert
	  void movelike(WeDailyVO vo) throws Exception;
	  
	  // 영화찜 delete
	  void deleteLike(WeDailyVO vo) throws Exception;
	  
	  // 찜한 영화 리스트 조회
	  List<WeDailyVO> selectmove(WeDailyVO vo) throws Exception;
	  
	  // 설문조사 insert
	  void insertSatisfaction(WeDailyVO vo) throws Exception;
	  
	  // 회원정보 수정
	  boolean memberUpdate(WeDailyVO vo) throws Exception;
	  
	  // 게시판 등록
	  void boardInsert(WeDailyVO vo) throws Exception;
	  
	  // 커뮤니티 조회
	 List<WeDailyVO> selectBoard(WeDailyVO vo) throws Exception;

	 // board update Page 조회
	 List<WeDailyVO> boardUpdate_select(WeDailyVO vo) throws Exception;
	 
	 // 커뮤니티 update 변경
	 void board_update(WeDailyVO vo) throws Exception;
	 // 게시글 삭제
	 void delete_board(WeDailyVO vo) throws Exception;
	 
	 // 게시판 검색 기능
	 List<WeDailyVO> search(WeDailyVO vo) throws Exception;
	 // 찜한 영화 조회
	 List<WeDailyVO> select_movieLike(WeDailyVO vo) throws Exception;
	 
	 
	 
	 
	
	  
	  
}

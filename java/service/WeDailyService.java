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
	  
}

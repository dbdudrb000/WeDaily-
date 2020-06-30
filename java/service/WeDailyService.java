package collabo.wato.springboot.web.WeDaily.service;

import java.util.List;

import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;

public interface WeDailyService {
	
	  // 회원가입 
	  void insertUser(WeDailyVO vo) throws Exception; 
	 
	  // 로그인
	  List<WeDailyVO> selectUser(WeDailyVO vo) throws Exception;

}

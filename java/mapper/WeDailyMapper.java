package collabo.wato.springboot.web.WeDaily.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;

@Repository
@Mapper
public interface WeDailyMapper {
	
	// 회원가입
	void insertUser(WeDailyVO vo) throws Exception;
	
	// 로그인 
	List<WeDailyVO> selectUser(WeDailyVO vo) throws Exception;

	// 영화찜 insert
	void movelike(WeDailyVO vo) throws Exception;
	
	// 영화찜 delete
	void deleteLike(WeDailyVO vo)throws Exception;
	
	// 영화찜 할 시 (회원의 찜 개수 update)
	void likeplmi(Map<String, String> like) throws Exception;
	
	// 찜한 영화 조회
	List<WeDailyVO> selectmove(WeDailyVO vo) throws Exception;
}

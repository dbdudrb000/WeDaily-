package collabo.wato.springboot.web.WeDaily.mapper;

import java.util.List;

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

}

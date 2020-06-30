package collabo.wato.springboot.web.WeDaily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import collabo.wato.springboot.web.WeDaily.mapper.WeDailyMapper;
import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;

@Service
public class WeDailyServiceImpl implements WeDailyService{
	
	@Autowired
	WeDailyMapper mapper;
	
	// 회원가입 
	@Override
	public void insertUser(WeDailyVO vo) throws Exception {
		
		mapper.insertUser(vo);
	}
	// 로그인
	@Override
	public List<WeDailyVO> selectUser(WeDailyVO vo) throws Exception {
		
		return mapper.selectUser(vo);
	}

}

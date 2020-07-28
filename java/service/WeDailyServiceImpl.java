package collabo.wato.springboot.web.WeDaily.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	//영화 찜 insert
	@Override
	public void movelike(WeDailyVO vo) throws Exception {
		
		String result = "plus";
		String likeid = vo.getLikeid();
		
		Map<String, String> like = new HashMap<String, String>();
		like.put("result", result);
		like.put("likeid", likeid);
		
		System.out.println("service result >> " +like.get("result"));
		System.out.println("service id >> " +like.get("likeid"));
		mapper.likeplmi(like);
		mapper.movelike(vo);
		
	}
	// 영화찜 delete
	@Override
	public void deleteLike(WeDailyVO vo) throws Exception {
		
		
		String result = "minus";
		String likeid = vo.getLikeid();
		
		Map<String, String> like = new HashMap<String, String>();
		like.put("result", result);
		like.put("likeid", likeid);
		
		mapper.likeplmi(like);	
		mapper.deleteLike(vo);
	}
	@Override
	public List<WeDailyVO> selectmove(WeDailyVO vo) throws Exception {
			
		return mapper.selectmove(vo);
	}
	

}

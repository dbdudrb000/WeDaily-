package collabo.wato.springboot.web.WeDaily.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
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
	@Transactional
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
	// 설문조사 insert
	@Override
	public void insertSatisfaction(WeDailyVO vo) throws Exception {
		mapper.insertSatisfaction(vo);
	}
	// 회원정보 수정
	@Override
	public boolean memberUpdate(WeDailyVO vo) throws Exception {
		boolean use = true;
		mapper.memberUpdate(vo);
		
		return use;
	}
	// 게시판 등록
	@Override
	@Transactional
	public void boardInsert(WeDailyVO vo) throws Exception {
		Map<String,String> map = new HashMap<String, String>();
		map.put("result","plus");
		map.put("board_user", vo.getBoard_user());
		
		// 게시판 등록
		mapper.boardInsert(vo);
		
		mapper.memberBoardCount(map);	
	}
	
	/* Main 게시판 조회 */
	@Override
	public List<WeDailyVO> selectBoard(WeDailyVO vo) throws Exception {
		
		return mapper.selectBoard(vo);
	}
	
	// board Update Page 조회
	@Override
	public List<WeDailyVO> boardUpdate_select(WeDailyVO vo) throws Exception{
		
		return mapper.boardUpdate_select(vo);
	}
	
	/* 커뮤니티 update 변경 */
	@Override
	public void board_update(WeDailyVO vo) throws Exception {
		mapper.board_update(vo);
		
	}
	/* 게시글 삭제 */
	@Override
	@Transactional
	public void delete_board(WeDailyVO vo) throws Exception {
		Map<String,String> map = new HashMap<String, String>();
		map.put("result","minus");
		map.put("board_user", vo.getBoard_user());
		
		mapper.memberBoardCount(map);
		
		mapper.delete_board(vo);
	}
	@Override
	public List<WeDailyVO> search(WeDailyVO vo) throws Exception {
		
		return mapper.search(vo);
	}
	/* 찜한 영화 조회 */
	@Override
	public List<WeDailyVO> select_movieLike(WeDailyVO vo) throws Exception {
		
		return mapper.select_movieLike(vo);
	}
	/* 카카오 소셜 로그인 회원 유무 조회 */
	@Override
	public List<WeDailyVO> kakao_memberCheck(WeDailyVO vo) throws Exception{
		
		return mapper.kakao_memberCheck(vo);
	}
	// ID 중복체크
	@Override
	public int idOverlapping(WeDailyVO vo)throws Exception {
		
		return mapper.idOverlapping(vo);
		
	}
	// ID 차직
	@Override
	public String find_id(WeDailyVO vo) throws Exception {
		
		return mapper.find_id(vo);
	}
	
	
	
	

}

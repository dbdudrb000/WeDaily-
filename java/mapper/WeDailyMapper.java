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
	
	// 설문조사 insert
	void insertSatisfaction(WeDailyVO vo)throws Exception;
	
	// 회원정보 수정
	void memberUpdate(WeDailyVO vo) throws Exception;
	
	// 게시판 등록
	void boardInsert(WeDailyVO vo) throws Exception;
	
	// 게시판 등록시 count 증가
	void memberBoardCount(Map<String, String> map) throws Exception;
	
	//게시판 조회
	List<WeDailyVO> selectBoard(WeDailyVO vo) throws Exception;

	// board Update Page  조회
	List<WeDailyVO> boardUpdate_select(WeDailyVO vo) throws Exception;
	
	// 커뮤니티 update 내용 변경
	void board_update(WeDailyVO vo)throws Exception;
	
	// 게시글 삭제
	void delete_board(WeDailyVO vo) throws Exception;
	// 게시판 검색 기능
	List<WeDailyVO> search(WeDailyVO vo) throws Exception;
	// 찜한 영화 조회
	List<WeDailyVO> select_movieLike(WeDailyVO vo) throws Exception;
	
	/* 카카오 소셜 로그인 회원 유무 조회 */
	List<WeDailyVO> kakao_memberCheck(WeDailyVO vo) throws Exception;
	
	// ID 중복체크 
	int idOverlapping(WeDailyVO vo) throws Exception;
	// ID 찾기
	String find_id(WeDailyVO vo) throws Exception;
	

}

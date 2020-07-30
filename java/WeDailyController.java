package collabo.wato.springboot.web.WeDaily;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.compress.utils.IOUtils;
//import org.apache.tomcat.util.json.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jackson.JsonObjectDeserializer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import collabo.wato.springboot.web.WeDaily.service.WeDailyService;
import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;

@Controller
public class WeDailyController {
	
	@Autowired
	WeDailyService service;
	
	public static String sb;//
	  
	    static String getString(String input, String data) // API에서 필요한 문자 자르기.
	    {
	        String[] dataSplit = data.split("{" + input + "}");
	        String[] dataSplit2 = dataSplit[1].split("\"" + input + "\"");
	        return dataSplit2[0];
	    }
	    
	    // JSON API 데이터 정보를 받아오기 위해 필요한  class 
	     static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }

	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	            	System.out.println("getMethod 정상호출");
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	            	System.out.println("getMethod error");
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }
	    
	     static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }
	    
	     static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);

	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();

	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }
	            System.out.println("readBody >>> " + responseBody.toString());
	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
	
	  // JSON API 데이터 정보를 받아오기 위해 필요한  class - END - 
	    
	     // 메인화면 이동하는 controller
	     @RequestMapping("/moveMain")
	     public String moveMain(HttpServletRequest request, HttpServletResponse response) {
	    	 
	    	 return "/main/WeDaily/main";
	     }
	    
	  // 영화검색 Controller 네이버 API
		    @RequestMapping("/moveselect")
		    public String test(HttpServletRequest request, HttpServletResponse response) throws Exception {
		    	// 검색실패 시 팝업창 인코딩을 위해 설정.
		    	response.setContentType("text/html; charset=UTF-8");
		    	
		    	String monetitle = request.getParameter("search");
		    	String userid = request.getParameter("userid");
		    	
		    	String clientId = "aEcAqL0ijo1Ekkj9Mfrr"; //애플리케이션 클라이언트 아이디값"
		        String clientSecret = "JsY0vYGSGy"; //애플리케이션 클라이언트 시크릿값"
		        
		        int display = 1;
		        
		        String text = null;
		        try {
		            text = URLEncoder.encode(monetitle, "UTF-8");
		        } catch (Exception e) {
		            throw new RuntimeException("검색어 인코딩 실패",e);
		        }
		        
		        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text + "&display=" + display + "&";    // json 결과	         

		        Map<String, String> requestHeaders = new HashMap<>();
		        requestHeaders.put("X-Naver-Client-Id", clientId);
		        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		        String responseBody = get(apiURL,requestHeaders);

		        System.out.println("responseBody >> " +responseBody);
		        	    
		        System.out.println("responseBody,toString >> " + responseBody.toString());
		        System.out.println("JSONParser >> " + apiURL);
		        try {
		         
		        JSONParser parser = new JSONParser(); 	         
		        JSONObject jsonObj = (JSONObject) parser.parse(responseBody);	         
		        JSONArray personArray = (JSONArray) jsonObj.get("items");
		        
		        WeDailyVO vo = new WeDailyVO();
		        List<WeDailyVO> naverMove = new ArrayList<WeDailyVO>();
		        /**
		         * Ref : https://developers.naver.com/docs/search/movie/
		         * */ 
				for (int i = 0; i < personArray.size(); i++) {
					
					System.out.println("======== person : " + i + " ========");
					JSONObject personObject = (JSONObject) personArray.get(i);
					System.out.println("actor >> " + personObject.get("actor"));
					System.out.println("title >> " + personObject.get("title"));
					System.out.println("image >> " + personObject.get("image"));
					System.out.println("userRating >> " + personObject.get("userRating"));
					System.out.println("link >> " + personObject.get("link"));
					System.out.println("pubDate >> " + personObject.get("pubDate"));
					
					vo.setTitle( (String) personObject.get("title"));
					vo.setImage((String) personObject.get("image"));
					vo.setActor((String) personObject.get("actor"));
					vo.setMove_rating((String) personObject.get("userRating"));
					vo.setMove_link((String) personObject.get("link"));
					vo.setpubDate((String) personObject.get("pubDate"));
											 
					naverMove.add(vo);
					vo = new WeDailyVO();				
				}
					
				if(naverMove.isEmpty()) {
					PrintWriter out = response.getWriter();
 	        		out.println("<script>alert('검색된 영화가 없습니다.');</script>");
 	        		out.flush();
 	        		
				}else {
					vo.setUserid(userid);
											   // 로그인한 유저 찜 목록을 select  
					List<WeDailyVO> movelist = service.selectmove(vo);
					
					for(int i=0; i <movelist.size(); i++) {
						System.out.println("movelist >> " + movelist.get(i).getMovetitle());
					}
					
					request.setAttribute("movelist", movelist);
					request.setAttribute("naverMove",naverMove);
					return "/main/WeDaily/moveResult2";
				}							
					
		        }catch(Exception e) {
					System.out.println("error: " + e);
				}       	        	   
			
		         return "forward:/moveMain";
		         
		    }
	    
		// 페이지 이동 ( 영화순위 가져오는 API ) 영화진흥회 API
	    @RequestMapping("/moveRanking")
	    public String move2(HttpServletRequest request, HttpServletResponse response)throws Exception {
	    	// 일별,주간,주말 특정 키워드 영화순위를 보여주기 위한 변수
	    	String target = request.getParameter("target");
	    	String daily = "";
    	 	Date today = new Date();     
	        SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	        
	        System.out.println("Date: "+date.format(today));

	        String time = date.format(today);
	        int Yesterday = Integer.parseInt(time) - 1;  
	        
	        List<WeDailyVO> rankArr = new ArrayList<WeDailyVO>();
	    	
	    	if(target.equals("today")) {
	    	System.out.println("일별 로직실행@@");
	        int display = 10;
	        
	        WeDailyVO vo = new WeDailyVO();

	              
	       
	        System.out.println("Yesterday >> " + Yesterday);
	        try {
	            
	            System.out.println("Yesterday >> " + Yesterday);
		        String juganURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=bb67dec08a2eae9eec1bdcc1328fcbce&targetDt=" + Yesterday;    // json 결과	         
		        
		        Map<String, String> requestHeaders = new HashMap<>();																																
		        String responseBody = get(juganURL,requestHeaders);
	     
	            System.out.println("sb >> " + responseBody); 
	            
	            // json 으로 바꾸는중.
	            JSONParser parser = new JSONParser(); 	    
		         
		        JSONObject jsonObj = (JSONObject) parser.parse(responseBody);
		        JSONObject result = (JSONObject) jsonObj.get("boxOfficeResult");		         
		        daily =  (String) result.get("boxofficeType");
		        
		        JSONArray personArray = (JSONArray) result.get("dailyBoxOfficeList");
	            
		        for (int i = 0; i < personArray.size(); i++) {
					
					System.out.println("======== 일별person : " + i + " ========");
					JSONObject personObject = (JSONObject) personArray.get(i);
					System.out.println("rank >> " + personObject.get("rank"));
					System.out.println("openDt >> " + personObject.get("openDt"));
					System.out.println("movieNm >> " + personObject.get("movieNm"));
					System.out.println("openDt >> " + personObject.get("openDt"));
					System.out.println("rankOldAndNew >> " + personObject.get("rankOldAndNew"));
					System.out.println("rankInten >> " + personObject.get("rankInten"));
					System.out.println("누적 관객 >> " + personObject.get("audiAcc"));
					System.out.println("해당 상영횟수 >> " + personObject.get("showCnt"));
					System.out.println("관객 증가횟수 >> " + personObject.get("audiInten"));
					System.out.println("영화대표코드 >> " + personObject.get("movieCd"));
					String title = (String)personObject.get("movieNm");
					title = title.replaceAll("#", "");
					
					vo.setRank((String) personObject.get("rank"));
					vo.setMovieNm(title);
					vo.setOpenDt((String) personObject.get("openDt"));
					vo.setRankOldAndNew((String) personObject.get("rankOldAndNew"));
					vo.setRankInten((String) personObject.get("rankInten"));
					vo.setAudiAcc((String) personObject.get("audiAcc"));
					vo.setShowCnt((String) personObject.get("showCnt"));
					vo.setAudiInten((String) personObject.get("audiInten"));
					vo.setAudiCnt((String) personObject.get("audiCnt"));
					
					rankArr.add(vo);
	            	vo = new WeDailyVO();
		        }
	             
	          
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        request.setAttribute("daily", daily);
	        request.setAttribute("rankArr",rankArr);
	       
	        return "/main/WeDaily/moveRaking";
	        
	    	}else {
	    		int number = 0;
	        // (주간or주말)영화 순위 가져오는 로직 
	    		WeDailyVO vo = new WeDailyVO();
	    		if(target.equals("jugan")) {
	    			number = 0;
	    			System.out.println("주간 로직실행@@");
	    		}else if(target.equals("jumal")) {
	    			number = 1;
	    			System.out.println("주말 로직실행@@");
	    		}
	        try {	         
	        	Yesterday -= 1; 
	        	System.out.println("Yesterday >> " + Yesterday);
		        String juganURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=bb67dec08a2eae9eec1bdcc1328fcbce"+"&weekGb="+number+"&targetDt="+Yesterday;    // json 결과	         
		        
		         Map<String, String> requestHeaders = new HashMap<>();																																
		         String responseBody = get(juganURL,requestHeaders);
		         
		         JSONParser parser = new JSONParser(); 	    
		         
		         JSONObject jsonObj = (JSONObject) parser.parse(responseBody);
		         JSONObject result = (JSONObject) jsonObj.get("boxOfficeResult");		         
		          daily =  (String) result.get("boxofficeType");
		         
		         JSONArray personArray = (JSONArray) result.get("weeklyBoxOfficeList");
		        
		         /* 특정 날짜는 순위 업로드가 안되어 지난주 기준으로 영화순위들을 보여준다. */
		         if(personArray.isEmpty()) {
		        	 System.out.println("이번주 영화순위 업로드 안됌.");
		        	 Yesterday -= 7;
		        	 juganURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=bb67dec08a2eae9eec1bdcc1328fcbce"+"&weekGb="+number+"&targetDt="+Yesterday;
		        	 responseBody = get(juganURL,requestHeaders);
		        	 
		        	 jsonObj = (JSONObject) parser.parse(responseBody);
			         result = (JSONObject) jsonObj.get("boxOfficeResult");		         
			         daily =  (String) result.get("boxofficeType");
			         
			         personArray = (JSONArray) result.get("weeklyBoxOfficeList");
			         
		         }
		         /* */
		         
		         System.out.println("주간 영화 >> " +responseBody);
		         System.out.println("personArray 길이 >> " + personArray.toString());
		         					         
		         for (int i = 0; i < personArray.size(); i++) {
						
					System.out.println("======== person : " + i + " ========");
					JSONObject personObject = (JSONObject) personArray.get(i);
					System.out.println("rank >> " + personObject.get("rank"));
					System.out.println("openDt >> " + personObject.get("openDt"));
					System.out.println("movieNm >> " + personObject.get("movieNm"));
					System.out.println("rankOldAndNew >> " + personObject.get("rankOldAndNew"));
					System.out.println("rankInten >> " + personObject.get("rankInten"));
					System.out.println("누적관객 >> " + personObject.get("audiAcc"));
					System.out.println("해당 상영횟수 >> " + personObject.get("showCnt"));
					System.out.println("관객 증가횟수 >> " + personObject.get("audiInten"));
					System.out.println("영화대표코드 >> " + personObject.get("movieCd"));
					
					String title = (String)personObject.get("movieNm");
					title = title.replaceAll("#", "");
					
					vo.setRank((String)personObject.get("rank"));
	            	vo.setMovieNm(title);
	            	vo.setOpenDt((String)personObject.get("openDt"));
	            	vo.setRankOldAndNew((String) personObject.get("rankOldAndNew"));
					vo.setRankInten((String) personObject.get("rankInten"));
					vo.setAudiAcc((String) personObject.get("audiAcc"));
					vo.setShowCnt((String) personObject.get("showCnt"));
					vo.setAudiInten((String) personObject.get("audiInten"));
					vo.setAudiCnt((String) personObject.get("audiCnt"));
					
	            	rankArr.add(vo);
	            	vo = new WeDailyVO();
				}
	        }catch(Exception e) {
	        	System.out.println("error >> "+ e);
	        }
	        
	        request.setAttribute("daily", daily);
	        request.setAttribute("rankArr", rankArr);
	          
	    	return "/main/WeDaily/moveRaking";
	    	}
	    	
	    }
	    
	    // 로그인 or 회원가입 하는 페이지 이동
	    @RequestMapping("/WeDailyJoinView")
	    public String memberJoin(HttpServletRequest request, HttpServletResponse response) {
	    	
	    	return "/main/WeDaily/login/WeDailyJoin";
	    }
	    
	    // 회원가입 하는 Controller
	    @RequestMapping("/WeDailyjoinLogic")
	    public String join(HttpServletRequest request, HttpServletResponse response)throws Exception {
	    	WeDailyVO vo = new WeDailyVO();
	    	
	    	String id = request.getParameter("idName");
	    	String password = request.getParameter("password");
	    	String nickname = request.getParameter("nickname");
	    	String phone = request.getParameter("phone");
	    	
	    	System.out.println("id >> " + id);
	    	vo.setUserid(id);
	    	vo.setUserpw(password);
	    	vo.setNickname(nickname);
	    	vo.setPhone(phone);
	    	
	    	service.insertUser(vo);

	    	return "redirect:/move";
	    }
	    
	    // 로그인 로직 Controller
	    @RequestMapping("/WeDailyLoginLogic")
	    public String loginlogic(HttpServletRequest request, HttpServletResponse response, WeDailyVO vo, HttpSession session) throws Exception {
	    	response.setContentType("text/html; charset=UTF-8");
	    	
	    	String loginId = request.getParameter("loginId");
	    	String loginPw = request.getParameter("loginPw");
	    	
	    	System.out.println("loginId >> " + loginId);
	    	vo.setUserid(loginId);
	    	vo.setUserpw(loginPw);
	    	
	    	List<WeDailyVO> loginList = service.selectUser(vo);
	    	
	    	if(loginList.isEmpty()) {
	    		PrintWriter out = response.getWriter();
        		out.println("<script>alert('로그인에 실패하였습니다.');</script>");
        		out.flush();
        		
        		return "/main/WeDaily/login/WeDailyJoin";
	    	}else {
	    		session.setAttribute("loginList", loginList.get(0));
		    	
		    	return "redirect:/moveMain";
	    	}
	    		
	    }
	    
	    // 로그아웃 하는 Controller
	    @RequestMapping("/WeDailyLogout")
	    public String logout(HttpServletRequest request, HttpServletResponse response, WeDailyVO vo, HttpSession session) throws Exception {
	    		    	
	    	session.invalidate();   
	    	    	   		
    		return "forward:/moveMain";
	    	
	    }
	    
	    // 로컬 이미지 불러오는 Controller
	    @RequestMapping("/WeDailyimg")
		@ResponseBody
	    public void WeDailyimg(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	
	    	String path = request.getParameter("path");
	    	System.out.println("path >> " + path);
	    	
	    	StringBuilder sb = new StringBuilder();
	    	
	    	sb = new StringBuilder("file:C:\\Users\\dbdud\\Desktop\\이미지\\" + path);
	    	
	    	URL fileUrl = new URL(sb.toString());
			IOUtils.copy(fileUrl.openStream(), response.getOutputStream());
	    	
	    }
	    // 영화  찜 insert
	    @RequestMapping("/movelike")
	    public void movelike(HttpServletRequest request, HttpServletResponse response)throws Exception {
	    	WeDailyVO vo = new WeDailyVO();
	    	
	    	String like = request.getParameter("like");
	    	String title = request.getParameter("title"); 
	    	String moveopen = request.getParameter("moveopen");
	    	String nickname = request.getParameter("nickname");
	    	
	    	vo.setMovetitle(title);
	    	vo.setMoveOpen(moveopen);
	    	vo.setlikeid(nickname);   
	    	
	    	if(like.equals("insert")) {
	    		service.movelike(vo);
	    	}else {
	    		service.deleteLike(vo);
	    		System.out.println("오니?");
	    	}
	    	
	    	
	    }
	    
	    // mypage 이동하는 controller
 		@RequestMapping("/wedailymypage")
 		public String searchtest(HttpServletRequest request, HttpServletResponse response) throws Exception {
 			WeDailyVO vo = new WeDailyVO();
 			String userid = request.getParameter("userid");
 			
 			vo.setUserid(userid);
 			
 			List<WeDailyVO> mypageUser = service.selectUser(vo);
 			
 			if(mypageUser.isEmpty()) {
 				System.out.println("비었음.");
 			}else {
 				System.out.println("정상적으로 처리됨.");
 			}
 			
 			request.setAttribute("mypageUser", mypageUser.get(0));
 			return "/main/WeDaily/mypage/wedailyMypage";
 		}
	 		
	 	
 		
}

	 
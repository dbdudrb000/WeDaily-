package collabo.wato.springboot.web.WeDaily;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.commons.compress.utils.IOUtils;
import org.apache.maven.model.Model;
import org.apache.tomcat.util.http.fileupload.ParameterParser;
import org.apache.velocity.runtime.directive.Parse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
//import org.openqa.selenium.By;
//import org.openqa.selenium.Keys;
//import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
//import org.openqa.selenium.chrome.ChromeDriver;
import org.jsoup.nodes.Document;


//import collabo.wato.springboot.web.WebConfig;
import collabo.wato.springboot.web.WeDaily.service.WeDailyService;
import collabo.wato.springboot.web.WeDaily.vo.WeDailyVO;
//import lombok.var;

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
     public String moveMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
   	
    	 //System.out.println("리소스 >> " + aa);
    	 //request.setAttribute("resource",aa);
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
	        daily = (String)result.get("boxofficeType");
	        
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
	         System.out.println("personArray 길이 >> " + personArray.size());
	         					         
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
    	}
    	
    	
    }
    
    // mypage 이동하는 controller
	@RequestMapping("/wedailymypage")
	public String searchtest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		WeDailyVO vo = new WeDailyVO();
		String userid = request.getParameter("userid");
		String getUserId = (String) request.getAttribute("userid");
		
		if(getUserId != null) {
			vo.setUserid(getUserId);
			System.out.println("정보수정후 돌아옴.");
		}else {
			vo.setUserid(userid);
			System.out.println("메인에서 들어옴.");
		}
		
		
		List<WeDailyVO> mypageUser = service.selectUser(vo);
		
		if(mypageUser.isEmpty()) {
			System.out.println("비었음.");
		}else {
			System.out.println("정상적으로 처리됨.");
		}
		
		request.setAttribute("mypageUser", mypageUser.get(0));
		return "/main/WeDaily/mypage/wedailyMypage";
	}
 		
	// mypage 서비스만족도 설문조사 insert
	@RequestMapping("/inSatisfaction")
	public void inSatisfaction(HttpServletRequest request, HttpServletResponse response)throws Exception {
		WeDailyVO vo = new WeDailyVO();
		
		String Survey = request.getParameter("Survey");
		String userid = request.getParameter("userid");
		
		System.out.println("Survey >> " + Survey);
		System.out.println("userid >> " + userid);
		
		vo.setUserid(userid);
		vo.setSatisfaction(Survey);
		
		service.insertSatisfaction(vo);		
	}
	
	// 회원  정보 update
	@RequestMapping("/memberUpdate")
	public String memberUpdate(HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		WeDailyVO vo = new WeDailyVO();
		
		String userid = request.getParameter("userid").replaceAll("ID : ","");
		String password = request.getParameter("password").replaceAll("PW : ","");
		String phone = request.getParameter("phone").replaceAll("휴대폰 : ","").replaceAll("-","");
		String my_self = request.getParameter("my_self");
		boolean use = false;
		
		vo.setUserid(userid);
		vo.setUserpw(password);
		vo.setPhone(phone);
		vo.setMy_self(my_self);
		
		use = service.memberUpdate(vo);
		if(use) {
			/* 정보수정후 mypage controller로 forward한다. */
			PrintWriter out = response.getWriter();
			out.println("<script>alert('정보수정 완료되었습니다.');</script>");
			out.flush();			
			request.setAttribute("userid",userid);
			
			return "forward:/wedailymypage";	
		}
		
		return"redirect:/wedailymypage";
	}
	
	// Let go reservation Page location
	@RequestMapping("/reservation")
	public String reservation(HttpServletRequest request, HttpServletResponse response) {
		
		return "/main/WeDaily/Reservation/reservation";
	}
	
	// 특정 지역의 상영관 시간표를 크롤링 하는 controller
	@ResponseBody
	@RequestMapping("/movie_screening")
	public HashMap<String, Object> movie_screening(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		List<String> titleList = new ArrayList<String>();
		List<String> movieHall= new ArrayList<String>();
		List<String> movieTime = new ArrayList<String>();
		String str = "";
		
			/* 현재 날짜를 구하는 것 */
		Date time = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
		String today = date.format(time);
				
			/* area : 지역코드 , movies : 상영관 코드  */
		String area = request.getParameter("area");
		String movies = request.getParameter("movies");
	
			// Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링
			// String url = "http://www.cgv.co.kr/movies/"; //크롤링할 url지정
		Document doc = Jsoup.connect("http://www.cgv.co.kr/common/showtimes/iframeTheater.aspx?areacode="+area+"&theatercode="+movies+"&date="+today).get();
		 
        Elements infoList = doc.select(".sect-showtimes .col-times"); // 상영중인 영화 묶음 (안에 시간표, 좌석 다 포함)            
        
        /* 문자열을 넣어주는것은 각 역활이 끝낫다는걸 기준점을 잡기 위헤 넣는 것이다.  */
        
        int time_count = 0;
        for(int a=0; a<infoList.size(); a++) {
        	System.out.println("title >> " + infoList.get(a).select(".info-movie").text());
        	titleList.add(infoList.get(a).select(".info-movie").text());
        	
        	for(int a2=0; a2<infoList.get(a).select(".type-hall .info-timetable").size(); a2++) {
        		System.out.println("상영관 >> " +infoList.get(a).select(".type-hall .info-hall").get(a2).text());
        		movieHall.add(infoList.get(a).select(".type-hall .info-hall").get(a2).text());
        		
        		for(int a22=0; a22 < infoList.get(a).select(".type-hall .info-timetable").get(a2).select("li").size();a22++) {
        			
        			str += infoList.get(a).select(".type-hall .info-timetable li").get(time_count).select("em").text()+" | ";
        		
        			if(infoList.get(a).select(".type-hall .info-timetable li").get(time_count).select("span").text().length() < 7) {
            			str += infoList.get(a).select(".type-hall .info-timetable li").get(time_count).select("span").text();
            		}else {
            			str += infoList.get(a).select(".type-hall .info-timetable li").get(time_count).select("span").text().substring(0,8);
            		}
        			time_count++;
    				System.out.println("시간표1 >> " + str);	
    				movieTime.add(str);
    				str = "";			
        		}
        		movieTime.add("movieTime_checked");
        	}
        	movieHall.add("movieHall_checked");
        	time_count = 0;
        	System.out.println("======================================================");
        }
        
        int time_count2 = 0; 
        int hall_count2 = 0;
        
        for(int k=0; k<titleList.size(); k++) {
        	System.out.println("제목 ::: "+titleList.get(k));    	
        	for(int k2=0; k2<movieHall.size(); k2++) {
        		
        		if(movieHall.get(hall_count2).equals("movieHall_checked")) { 
        			hall_count2++; 
        			System.out.println("hall_ stop!");
        			break; 
        		}
        		
        		System.out.println("상영관 ::: " + movieHall.get(hall_count2));
        		hall_count2++;
        		
        		for(int k3=0; k3<movieTime.size(); k3++) {
        			
        			if(movieTime.get(time_count2).equals("movieTime_checked")) { time_count2 ++; break; }
        			System.out.println("시간표 ::: " + movieTime.get(time_count2));
        			time_count2++;
        		} // 3번째 for문	
        	} //2번째  for문
        }// 1번쨰 for문  
         
        map.put("titleList", titleList);				 
        map.put("movieHall", movieHall);				 
        map.put("movieTime", movieTime);				 
				       
        return map;
	}
	// 커뮤니티 main page location
	@RequestMapping("/community_main")
	public String community_main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		WeDailyVO vo = new WeDailyVO();
		
		String use = request.getParameter("use");
		vo.setBoard_user(request.getParameter("nickname"));
		
		/*  insert = 게시판 등록 
		         아무값도 없을 때 : 게시판 main page
		     */
		if("insert".equals(use)) {
			return"/main/WeDaily/community/community_insert";
		}else {
			List<WeDailyVO> boardList = service.selectBoard(vo);
			request.setAttribute("boardList", boardList);
			return "/main/WeDaily/community/community_main";
		}
		
	} // community_main AND
	
		/* 커뮤니티 게시글 등록 Controller */
	@RequestMapping("/board_insert")
	public String board_insert(HttpServletRequest request, HttpServletResponse response)throws Exception {
		WeDailyVO vo = new WeDailyVO();
	
		vo.setBoard_title(request.getParameter("board_title"));
		vo.setBoard_detail(request.getParameter("board_detail"));
		vo.setBoard_kind(request.getParameter("board_kind"));
		vo.setBoard_user(request.getParameter("board_user"));
		
		service.boardInsert(vo);
		
		return "redirect:/community_main";
	}
	
	// 커뮤니티 게시글 수정 Page 이동 
	@RequestMapping("/board_updatePage")
	public String board_update(HttpServletRequest request, HttpServletResponse response) throws Exception{
		WeDailyVO vo = new WeDailyVO(); 
		int number =  Integer.parseInt(request.getParameter("number")); 
		String nickname = request.getParameter("user");
		
		vo.setBoard_number(number);
		vo.setBoard_user(nickname);
		
		List<WeDailyVO> list = service.boardUpdate_select(vo);
		request.setAttribute("updateList", list.get(0));
		
		return "/main/WeDaily/community/community_update";
	}
	
	// 커뮤니티 Update 로직 수행 Controller
	@RequestMapping("/boardUpdate_logic")
	public String boardUpdate_logic(HttpServletRequest request, HttpServletResponse response)throws Exception {
		WeDailyVO vo = new WeDailyVO();
		int update_number = Integer.parseInt(request.getParameter("update_number"));
		String update_title = request.getParameter("update_title");
		String update_kind = request.getParameter("update_kind");
		String update_user = request.getParameter("update_user");
		String update_detail = request.getParameter("update_detail");
		
		vo.setBoard_number(update_number);
		vo.setBoard_title(update_title);
		vo.setBoard_kind(update_kind);
		vo.setBoard_detail(update_detail);
		vo.setBoard_user(update_user);
		
		service.board_update(vo);
		
		return "redirect:/community_main";
	}
	
	// 게시글 삭제
	@RequestMapping("/delete_board")
	public String delete_board(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		WeDailyVO vo = new WeDailyVO();
		
		vo.setBoard_number(Integer.parseInt(request.getParameter("number")));
		vo.setBoard_user(request.getParameter("user"));
		
		service.delete_board(vo);
		
		PrintWriter out = response.getWriter();
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.flush();			
		
		return "forward:/community_main";
	}
	
	// 특정 게시글을 볼수 있도록 하는 Controller
	@RequestMapping("/board_look")
	public String board_look(HttpServletRequest request, HttpServletResponse response)throws Exception {
		WeDailyVO vo = new WeDailyVO();
		int number = Integer.parseInt(request.getParameter("number"));
		String user = request.getParameter("user");
		
		vo.setBoard_number(number);
		vo.setBoard_user(user);
		List<WeDailyVO> list = service.boardUpdate_select(vo);
		
		request.setAttribute("list", list.get(0));
		return "/main/WeDaily/community/community_look";
	}
	
	// 게시판에서 검색 기능 
	@RequestMapping("/board_search")
	public String board_search(HttpServletRequest request, HttpServletResponse response) throws Exception{
		WeDailyVO vo = new WeDailyVO();
		String use = request.getParameter("kind");
		
		
		
		if(use.equals("제목_내용")) {
			vo.setSearch_title_detail(request.getParameter("kind"));
			vo.setSearch_keyword(request.getParameter("keyword"));
			System.out.println("제목 kind");
		}else if(use.equals("글종류")) {
			vo.setSearch_kind(request.getParameter("kind"));
			vo.setSearch_keyword(request.getParameter("keyword"));
			System.out.println("글종류 kind");
		}else {
			System.out.println("글작성자 kind");
			vo.setSearch_writer(request.getParameter("kind"));
			vo.setSearch_keyword(request.getParameter("keyword"));
		}
		
		
		List<WeDailyVO> searchList = service.search(vo);
		
		if(!searchList.isEmpty()) {
			System.out.println("검색 값 있음.ooooo");
			System.out.println("사이즈 >> "+searchList.size());
		}else {
			System.out.println("검색 값 없음.xxxxx");
		}
		request.setAttribute("boardList", searchList);
		return "/main/WeDaily/community/community_main";
	}
	
	
	// 찜한 영화 list page 이동
	@RequestMapping("/movie_like")
	public String movie_like(HttpServletRequest request, HttpServletResponse response) throws Exception{
		WeDailyVO vo = new WeDailyVO();
		
		vo.setlikeid(request.getParameter("nickname"));
		
		List<WeDailyVO> likeList = service.select_movieLike(vo);
		
		System.out.println("likeLise >> " + likeList.size());
		request.setAttribute("likeList", likeList);
		
		return "/main/WeDaily/mypage/like_movie";
	}
	
	
	// test용 page
	@RequestMapping("/testgo")
	public String testgo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Document doc = Jsoup.connect("http://www.cgv.co.kr/culture-event/event/defaultNew.aspx?mCode=006#1").get();
		 
        Elements infoList = doc.select("#contaniner #contents .cols-content .col-detail event");
        System.out.println("나와라!!! " +infoList.toString());
		return "/main/test";
	}
 		
}



	 
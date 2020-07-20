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
	
	public static StringBuilder sb;//
	  
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
	    
	    
	  // 영화검색 Controller 네이버 API
		    @RequestMapping("/moveselect")
		    public String test(HttpServletRequest request, HttpServletResponse response) throws Exception {
		    	// 검색실패 시 팝업창 인코딩을 위해 설정.
		    	response.setContentType("text/html; charset=UTF-8");
		    	
		    	String monetitle = request.getParameter("search");
		    	
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
		         
			for (int i = 0; i < personArray.size(); i++) {
				
				System.out.println("======== person : " + i + " ========");
				JSONObject personObject = (JSONObject) personArray.get(i);
				System.out.println("actor >> " + personObject.get("actor"));
				System.out.println("title >> " + personObject.get("title"));
				System.out.println("image >> " + personObject.get("image"));
				System.out.println("userRating >> " + personObject.get("userRating"));
				System.out.println("link >> " + personObject.get("link"));
				
				vo.setTitle( (String) personObject.get("title"));
				vo.setImage((String) personObject.get("image"));
				vo.setActor((String) personObject.get("actor"));
				vo.setMove_rating((String) personObject.get("userRating"));
				vo.setMove_link((String) personObject.get("link"));
										 
				naverMove.add(vo);
				vo = new WeDailyVO();				
				}
					
				if(naverMove.isEmpty()) {
					PrintWriter out = response.getWriter();
 	        		out.println("<script>alert('검색된 영화가 없습니다.');</script>");
 	        		out.flush();
				}else {
					request.setAttribute("naverMove",naverMove);
					return "/main/WeDaily/moveResult";
				}							
					
		        }catch(Exception e) {
					System.out.println("error: " + e);
				}       	        	   
			
		         return "forward:/move";
		         
		    }
	    
		// 페이지 이동 ( 영화순위 가져오는 API ) 영화진흥회 API
	    @RequestMapping("/move")
	    public String move2(HttpServletRequest request, HttpServletResponse response)throws Exception {
	    	 
	        int display = 10;
	        
	        WeDailyVO vo = new WeDailyVO();

	        List<WeDailyVO> rankArr = new ArrayList<WeDailyVO>();        
	        Date today = new Date();     
	        SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	        
	        System.out.println("Date: "+date.format(today));

	        String time = date.format(today);
	        int Yesterday = Integer.parseInt(time) - 1;  
	        System.out.println("Yesterday >> " + Yesterday);
	        try {
	            //String text = URLEncoder.encode(monetitle, "utf-8");
	            String apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=bb67dec08a2eae9eec1bdcc1328fcbce&targetDt=" + Yesterday;
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection) url.openConnection();
	            con.setRequestMethod("GET");
	           
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if (responseCode == 200) {
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            } else {
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            sb = new StringBuilder();
	            String line;

	            while ((line = br.readLine()) != null) {
	                sb.append(line + "\n");
	            }

	            br.close();
	            con.disconnect();
	            //System.out.println(sb); 
	            String data = sb.toString();
	            String[] array;
	            array = data.split("\"");
	            String[] rank = new String[display];
	            String[] movieNm = new String[display];
	            String[] openDt = new String[display];	         
	            String[] audiCnt = new String[display];
	            String[] audiAcc = new String[display];
	            
	            String[] category = new String[display];
	            String[] address = new String[display];
	            String[] mapx = new String[display];
	            String[] image = new String[display];
	            String[] actor = new String[display];
	            
	            int k = 0;
	            for (int i = 0; i < array.length; i++) {
	           
	            	 	if (array[i].equals("rank"))
	            		 rank[k] = array[i + 2];
		                if (array[i].equals("movieNm"))
		                	movieNm[k] = array[i + 2];		              
		                if (array[i].equals("openDt"))
		                	openDt[k] = array[i + 2];
		                if (array[i].equals("audiCnt"))
		                	audiCnt[k] = array[i + 2];
		                if (array[i].equals("audiAcc")) {
		                	audiAcc[k] = array[i + 2];
		                	k++;
		                }
		                
	            }
	            System.out.println("여기까지옴?");
				for(int y = 0; y < rank.length; ) {
					 	
	            	System.out.println("rank >> " +rank[y]);
	            	System.out.println("movieNm >> " +movieNm[y]);
	            	System.out.println("openDt >> " +openDt[y]);
	            	
	            	movieNm[y] = movieNm[y].replaceAll("\\#", "");
	            	
	            	vo.setRank(rank[y]);
	            	vo.setMovieNm(movieNm[y]);
	            	vo.setOpenDt(openDt[y]);
	            	vo.setAudiCnt(audiCnt[y]);
	            	vo.setAudiAcc(audiAcc[y]);
	            	rankArr.add(vo);
	            	vo = new WeDailyVO();
	            
	            	y++;
	            }
	                   
	            //System.out.println("sb >> " + sb);	         
	          
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        request.setAttribute("rankArr",rankArr);
	        
	        
	        // 주간 영화 순위 가져오는 로직 @@@@
	        try {	         
	        	Yesterday -= 1; 
	        	System.out.println("Yesterday >> " + Yesterday);
		         String juganURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=bb67dec08a2eae9eec1bdcc1328fcbce"+"&weekGb=0"+"&targetDt="+Yesterday ;    // json 결과	         
		        
		         Map<String, String> requestHeaders = new HashMap<>();																																
		         String responseBody = get(juganURL,requestHeaders);
		         
		         JSONParser parser = new JSONParser(); 	    
		         
		         JSONObject jsonObj = (JSONObject) parser.parse(responseBody);
		         JSONObject result = (JSONObject) jsonObj.get("boxOfficeResult");		         
		         
		         JSONArray personArray = (JSONArray) result.get("weeklyBoxOfficeList");
		        
		         
		         System.out.println("주간 영화 >> " +responseBody);
		         System.out.println("personArray 길이 >> " + personArray.toString());
		         					         
		         for (int i = 0; i < personArray.size(); i++) {
						
					System.out.println("======== person : " + i + " ========");
					JSONObject personObject = (JSONObject) personArray.get(i);
					System.out.println("rank >> " + personObject.get("rank"));
					System.out.println("openDt >> " + personObject.get("openDt"));
									
				}
	        }catch(Exception e) {
	        	System.out.println("error >> "+ e);
	        }
	          
	   
	          // 수정전 메인화면 
	    	//return "/main/WeDaily/WeDailyMain";
	        
	        return "/main/test2";
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
        		
        		return "forward:/move";
	    	}else {
	    		session.setAttribute("loginList", loginList.get(0));
		    	
		    	return "redirect:/move";
	    	}
	    		
	    }
	    
	    // 로그아웃 하는 Controller
	    @RequestMapping("/WeDailyLogout")
	    public String logout(HttpServletRequest request, HttpServletResponse response, WeDailyVO vo, HttpSession session) throws Exception {
	    		    	
	    	session.invalidate();   
	    	    	   		
    		return "forward:/move";
	    	
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
	 
	    
	 // json api 값들을 가져오는데 test
	 		@RequestMapping("/wetest")
	 	    public String mone2(HttpServletRequest request, HttpServletResponse response) throws ParseException {
	 			response.setContentType("text/html; charset=UTF-8");
	 			 	    	
	 	    	
	 	    	String clientId = "aEcAqL0ijo1Ekkj9Mfrr";
	 	        String clientSecret = "JsY0vYGSGy";
	 	        int display = 1;
	 	        int start = 1;
	 	        WeDailyVO vo = new WeDailyVO();
	 	 
	 	        List<WeDailyVO> titleArr = new ArrayList<WeDailyVO>();
	 	       
	 	        try {
	 	            String text = URLEncoder.encode("부산행", "utf-8");
	 	            String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text + "&display=" + display + "&";
	 	            URL url = new URL(apiURL);
	 	            HttpURLConnection con = (HttpURLConnection) url.openConnection();
	 	            con.setRequestMethod("GET");
	 	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	 	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	 	            int responseCode = con.getResponseCode();
	 	            BufferedReader br;
	 	            if (responseCode == 200) {
	 	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	 	            } else {
	 	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	 	            }
	 	            sb = new StringBuilder();
	 	            String line;
	 	 
	 	            while ((line = br.readLine()) != null) {
	 	                sb.append(line + "\n");
	 	            }
	 	 
	 	            br.close();
	 	            con.disconnect();
	 	            System.out.println( "sb >> " +sb); 
	 	            String data = sb.toString();
	 	            String[] array;	           
	 	            array = data.split("\"");	 	     
	 	            
	 	            String[] title = new String[display];
	 	            String[] link = new String[display];
	 	            String[] image = new String[display];
	 	            String[] category = new String[display];
	 	            String[] description = new String[display];
	 	            String[] telephone = new String[display];
	 	            String[] pubDate = new String[display];
	 	            String[] address = new String[display];
	 	            String[] userRating = new String[display];
	 	            String[] mapy = new String[display];
	 	            String[] actor = new String[display];
	 	            System.out.println("array >> " + array.length);
	 	            int k = 0;
	 	            for (int i = 0; i < array.length; i++) {
	 	            	System.out.println("arr i = " + array[i]);
	 	                if (array[i].equals("title"))
	 	                    title[k] = array[i + 2];
	 	                if (array[i].equals("link"))
	 	                    link[k] = array[i + 2];
	 	                if (array[i].equals("category"))
	 	                    category[k] = array[i + 2];
	 	                if (array[i].equals("description"))
	 	                    description[k] = array[i + 2];
	 	                
	 	               
	 	                if (array[i].equals("mapy"))
	 	                	mapy[k] = array[i + 2];
	 	                if (array[i].equals("link"))
	 	                	link[k] = array[i + 2];
	 	                if (array[i].equals("image")) {
	 	                	image[k] = array[i + 2];
	 	                }if(array[i].equals("actor")) {
	 	                	actor[k] = array[i + 2];
	 	                	k++ ;	    
	 	                	System.out.println("i >> "  );
	 	                }	
	 	            }
	 	            
	 	            System.out.println("검색 sb >> " + sb);
	 	           
	 	            int y = 0;
	 	            for(int j = 0; j < title.length; j++) {
	 	            	
	 	            	System.out.println("title >> " +title[j]);
	 	            	System.out.println("image >> " +image[j]);
	 	            	System.out.println("actor >> " +actor[j]);
	 	            	System.out.println("move_link >> " + link[j]);
	 	            	System.out.println("move_rating >> " + userRating[j]);
	 	            		            	
	 	            	vo.setTitle(title[j]);
	 	            	vo.setActor(actor[j]);
	 	            	vo.setImage(image[j]);
	 	            	//vo.setMove_link(link[j]);
	 	            	//vo.setMove_rating(userRating[j]);
	 	            	
	 	            	titleArr.add(vo);
	 	            	vo = new WeDailyVO();
	 	            	y++;
	 	            	
	 	            }
	 	            
	 	            if(title[0] == null) {
	 	            	System.out.println("값이 없음.");
	 	            	PrintWriter out = response.getWriter();
	 	        		out.println("<script>alert('검색된 영화가 없습니다.');</script>");
	 	        		out.flush();
	 	        		return "forward:/move";
	 	            }
	 	           
	 	        } catch (Exception e) {
	 	            System.out.println(e);
	 	        }
	 	       
	             	request.setAttribute("titleArr",titleArr);
	             	return "/main/WeDaily/moveResult";
	             
	 		}
	    
	    
}

	 
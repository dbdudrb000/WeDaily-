package collabo.wato.springboot.web.WeDaily;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

	    // 영화검색 Controller
		@RequestMapping("/moveselect")
	    public String mone2(HttpServletRequest request, HttpServletResponse response) throws ParseException {
			response.setContentType("text/html; charset=UTF-8");
			
	    	String monetitle = request.getParameter("search");
	    	
	    	String clientId = "aEcAqL0ijo1Ekkj9Mfrr";
	        String clientSecret = "JsY0vYGSGy";
	        int display = 10;
	        
	        WeDailyVO vo = new WeDailyVO();
	 
	        List<WeDailyVO> titleArr = new ArrayList<WeDailyVO>();
	       
	        try {
	            String text = URLEncoder.encode(monetitle, "utf-8");
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
	            //System.out.println(sb); 
	            String data = sb.toString();
	            String[] array;
	            array = data.split("\"");
	            
	            String[] title = new String[display];
	            String[] link = new String[display];
	            String[] image = new String[display];
	            String[] category = new String[display];
	            String[] description = new String[display];
	            String[] telephone = new String[display];
	            String[] address = new String[display];
	            String[] mapx = new String[display];
	            String[] mapy = new String[display];
	            String[] actor = new String[display];
	            
	            int k = 0;
	            for (int i = 0; i < array.length; i++) {
	            
	                if (array[i].equals("title"))
	                    title[k] = array[i + 2];
	                if (array[i].equals("link"))
	                    link[k] = array[i + 2];
	                if (array[i].equals("category"))
	                    category[k] = array[i + 2];
	                if (array[i].equals("description"))
	                    description[k] = array[i + 2];
	                if (array[i].equals("telephone"))
	                    telephone[k] = array[i + 2];
	                if (array[i].equals("address"))
	                    address[k] = array[i + 2];
	                if (array[i].equals("mapx"))
	                    mapx[k] = array[i + 2];
	                if (array[i].equals("image")) {
	                	image[k] = array[i + 2];
	                }if(array[i].equals("actor")) {
	                	actor[k] = array[i + 2];
	                	k++;
	                }	         
	            }
	            
	            //System.out.println("sb >> " + sb);
	            
	            for(int j = 0; j < title.length; ) {
	            	
	            	System.out.println("title >> " +title[j]);
	            	System.out.println("image >> " +image[j]);
	            	System.out.println("actor >> " +actor[j]);
	            	       
	            	vo.setTitle(title[j]);
	            	vo.setActor(actor[j]);
	            	vo.setImage(image[j]);
	            	titleArr.add(vo);
	            	vo = new WeDailyVO();
	            	
	            	j++;
	            }
	            
	            if(title[0] == null) {
	            	System.out.println("값이 없음.");
	            	PrintWriter out = response.getWriter();
	        		out.println("<script>alert('검색된 영화가 없습니다.');</script>");
	        		out.flush();
	        		return "forward:/move2";
	            }
	           
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	       
            	request.setAttribute("titleArr",titleArr);
            	return "/main/WeDaily/moveResult";
            
		}
	


		// 페이지 이동 ( 영화순위 가져오는 API )
	    @RequestMapping("/move2")
	    public String move2(HttpServletRequest request, HttpServletResponse response)throws Exception {
	    	 
	        int display = 10;
	        
	        WeDailyVO vo = new WeDailyVO();

	        List<WeDailyVO> rankArr = new ArrayList<WeDailyVO>();        
	        Date today = new Date();     
	        SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	        
	        System.out.println("Date: "+date.format(today));

	        String time = date.format(today);
	        int Yesterday = Integer.parseInt(time) - 1;  
	    
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
	                   
	            System.out.println("sb >> " + sb);	         
	          
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        request.setAttribute("rankArr",rankArr);
	        
	    	return "/main/WeDaily/WeDailyMain";
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
	    	
	    	String id = request.getParameter("id");
	    	String password = request.getParameter("password");
	    	String nickname = request.getParameter("nickname");
	    	String phone = request.getParameter("phone");
	    	
	    	vo.setUserid(id);
	    	vo.setUserpw(password);
	    	vo.setNickname(nickname);
	    	vo.setPhone(phone);
	    	
	    	service.insertUser(vo);
	    	
	    	return "redirect:/move2";
	    }
	    
	    // 로그인 로직 Controller
	    @RequestMapping("/WeDailyLoginLogic")
	    public String loginlogic(HttpServletRequest request, HttpServletResponse response, WeDailyVO vo, HttpSession session) throws Exception {
	    
	    	String loginId = request.getParameter("loginId");
	    	String loginPw = request.getParameter("loginPw");
	    	
	    	vo.setUserid(loginId);
	    	vo.setUserpw(loginPw);
	    	
	    	List<WeDailyVO> loginList = service.selectUser(vo);
	    	
	    	session.setAttribute("loginList", loginList.get(0));
	    	
	    	return "forward:/move2";
	    }
	    
	    // 로그아웃 하는 Controller
	    @RequestMapping("/WeDailyLogout")
	    public String logout(HttpServletRequest request, HttpServletResponse response, WeDailyVO vo, HttpSession session) {
	    	
	    	session.invalidate();    	
	    	
	    	return "redirect:/move2";
	    }
	    
	    
	    
	    
}

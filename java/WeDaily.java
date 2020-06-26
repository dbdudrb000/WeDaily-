package collabo.wato.springboot.web.WeDaily;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class WeDaily {
	
	  public static StringBuilder sb;//
	  
	    static String getString(String input, String data) // API에서 필요한 문자 자르기.
	    {
	        String[] dataSplit = data.split("{" + input + "}");
	        String[] dataSplit2 = dataSplit[1].split("\"" + input + "\"");
	        return dataSplit2[0];
	    }

	//public static void main(String[] args) {
	    @RequestMapping("/move2")
	    public @ResponseBody ArrayList mone2(HttpServletRequest request, HttpServletResponse response) throws ParseException {
	    	
	    	String clientId = "aEcAqL0ijo1Ekkj9Mfrr";
	        String clientSecret = "JsY0vYGSGy";
	        int display = 1;
	        JSONObject moveList = new JSONObject();
	        ArrayList<String> moveArray = new ArrayList<String>();
	 
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
	            System.out.println(sb);   
	            System.out.println("----------------------------");
	            System.out.println("첫번째 타이틀 : " + title[0]);
	            System.out.println("이미지 jpg 파일 : " + image[0]);
	            System.out.println("배우들 : " + actor[0]);
	            
	            
	          /*  JSON 형태로 response 보내는 방식
	            moveList.put("title", title[0]);
	            moveList.put("image", image[0]);
	            moveList.put("actor", actor[0]);
	           */
	            
	            // arrayList 방식으로 response 보내는 것
	            moveArray.add(title[0]);
	            moveArray.add(image[0]);
	            moveArray.add(actor[0]);
	            
	        } catch (Exception e) {
	            System.out.println("에러발생!");
	        }
			return moveArray;
		}
	
		
		
		
		
	

}

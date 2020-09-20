package collabo.wato.springboot.web.WeDaily.kakao_login;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class KakaoController {
	private final static String K_CLIENT_ID = "04435a605d8f61228735e6e8a84ba25b"; //이런식으로 REDIRECT_URI를 써넣는다. // //
	
	private final static String K_REDIRECT_URI = "http://localhost:8080/kakaologin.do";

	public static String getAuthorizationUrl(HttpSession session) { 
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + K_CLIENT_ID + "&redirect_uri=" + K_REDIRECT_URI + "&response_type=code"; 
		
		return kakaoUrl; 
	}
		/* 
		 * getAccessToken 클래스는 사용자의 정보를 가져오기 위한 토큰값을 만드는 것이다.
		 * */
	public static JsonNode getAccessToken(String autorize_code) {

		final String RequestUrl = "https://kauth.kakao.com/oauth/token"; 
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>(); 
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code")); 
		postParams.add(new BasicNameValuePair("client_id", "04435a605d8f61228735e6e8a84ba25b")); // REST API KEY 
		postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8080/kakaologin.do")); // 리다이렉트 URI 
		postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정중 얻은 code 값 
		System.out.println("autorize_code >> " + autorize_code);
		final HttpClient client = HttpClientBuilder.create().build(); 
		final HttpPost post = new HttpPost(RequestUrl); 
		JsonNode returnNode = null;
		
		try { 
			post.setEntity(new UrlEncodedFormEntity(postParams)); 
			final HttpResponse response = client.execute(post); // JSON 형태 반환값 처리 
			ObjectMapper mapper = new ObjectMapper(); 
			returnNode = mapper.readTree(response.getEntity().getContent()); 
		} catch (UnsupportedEncodingException e) { 
			e.printStackTrace(); 
		} catch (ClientProtocolException e) { 
			e.printStackTrace(); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		} finally {  
			// clear resources
		} 
			System.out.println("returnNode 1 >> " + returnNode);
			return returnNode; 
		}
	
	/* 
	 *  getKakaoUserInfo 클래스는 토큰값을 이용해서 사용자의 정보를 받아온다. 
	 * */
	public static JsonNode getKakaoUserInfo(JsonNode accessToken) { 
		String RequestUrl = "https://kapi.kakao.com/v2/user/me"; 
		HttpClient client = HttpClientBuilder.create().build(); 
		HttpPost post = new HttpPost(RequestUrl); // add header 
		post.addHeader("Authorization", "Bearer " + accessToken); 
		JsonNode returnNode = null; 
		
		try { 
			final HttpResponse response = client.execute(post); // JSON 형태 반환값 처리 
			ObjectMapper mapper = new ObjectMapper(); 
			returnNode = mapper.readTree(response.getEntity().getContent()); 
		} catch (ClientProtocolException e) { 
			e.printStackTrace(); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		} finally { 
			// clear resources 
		} 
			System.out.println("returnNode 2 >> " + returnNode);
			return returnNode;
	} 

	
	/*private final static String K_CLIENT_ID = "04435a605d8f61228735e6e8a84ba25b";
    private final static String K_REDIRECT_URI = "http://localhost:8080/kakaologin.do";
    
	public static String getAuthorizationUrl(HttpSession session) {
      String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + K_CLIENT_ID + "&redirect_uri=" + K_REDIRECT_URI + "&response_type=code";
      	return kakaoUrl;
    }

    public static String getAccessToken(String autorize_code) {

      final String RequestUrl = "https://kauth.kakao.com/oauth/token";
      final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
      postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
      postParams.add(new BasicNameValuePair("client_id", K_CLIENT_ID)); // REST API KEY
      postParams.add(new BasicNameValuePair("redirect_uri", K_REDIRECT_URI)); // 리다이렉트 URI
      postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값
      
      final HttpClient client = HttpClientBuilder.create().build();
      final HttpPost post = new HttpPost(RequestUrl);
      JsonNode returnNode = null;

      try {

        post.setEntity(new UrlEncodedFormEntity(postParams));
        final HttpResponse response = client.execute(post);
        final int responseCode = response.getStatusLine().getStatusCode();

        // JSON 형태 반환값 처리

        ObjectMapper mapper = new ObjectMapper();
        returnNode = mapper.readTree(response.getEntity().getContent());

      } catch (UnsupportedEncodingException e) {

        e.printStackTrace();

      } catch (ClientProtocolException e) {

        e.printStackTrace();

      } catch (IOException e) {

        e.printStackTrace();

      } finally {
        // clear resources
      }
      return returnNode.get("access_token").toString();
    }

    public static JsonNode getKakaoUserInfo(String autorize_code) {

      final String RequestUrl = "https://kapi.kakao.com/v1/user/me";
      //String CLIENT_ID = K_CLIENT_ID; // REST API KEY
      //String REDIRECT_URI = K_REDIRECT_URI; // 리다이렉트 URI
      //String code = autorize_code; // 로그인 과정중 얻은 토큰 값
      final HttpClient client = HttpClientBuilder.create().build();
      final HttpPost post = new HttpPost(RequestUrl);
      String accessToken = getAccessToken(autorize_code);
      // add header
      post.addHeader("Authorization", "Bearer " + accessToken);

      JsonNode returnNode = null;

      try {

        final HttpResponse response = client.execute(post);
        final int responseCode = response.getStatusLine().getStatusCode();
        System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
        System.out.println("Response Code : " + responseCode);

        // JSON 형태 반환값 처리
        ObjectMapper mapper = new ObjectMapper();
        returnNode = mapper.readTree(response.getEntity().getContent());
        System.out.println("returnNode >> " + returnNode);
      } catch (UnsupportedEncodingException e) {

        e.printStackTrace();
      } catch (ClientProtocolException e) {

        e.printStackTrace();
      } catch (IOException e) {

        e.printStackTrace();
      } finally {

        // clear resources
      }
      return returnNode;
    } */
		

	
	
}

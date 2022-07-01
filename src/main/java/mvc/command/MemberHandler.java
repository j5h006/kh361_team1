package mvc.command;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdbc.connection.ConnectionProvider;

import model.dao.MemberDAO;
import model.dto.MemberDTO;
import model.service.MemberService;

public class MemberHandler implements CommandHandler {
	
	MemberService memberService = MemberService.getInstance();

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) {
		
		String fromPath = req.getRequestURI().substring(req.getContextPath().length());
        String toPath = null;
        
        if(fromPath.equals("/login.do")) {            
            toPath = "WEB-INF/view/member/login.jsp";
            
        }else if(fromPath.equals("/submitLogin.do")){	
	    	
	    	MemberDTO member = new MemberDTO();
	    	HttpSession session = req.getSession();
	    	
	    	String id = req.getParameter("mId");
	    	String pw = req.getParameter("pw");    
	    	
	    	member = memberService.submitLogin(id, pw);	    	
	    	if(member != null) {	    		
	    		session.setAttribute("member", member);		    	
		    	toPath = "WEB-INF/view/index.jsp";
	    	}else{
	    		req.setAttribute("msg", "로그인 오류!! 아디와 비번 확인해주세요~!");
                req.setAttribute("url", "login.do");    
	    		toPath = "WEB-INF/view/alert.jsp";
	    	}	  	
	    	
	    }else if(fromPath.equals("/logout.do")) {
	    	HttpSession session = req.getSession();
    		session.invalidate();
            toPath = "WEB-INF/view/index.jsp";   
            
	    }else if(fromPath.equals("/signUp.do")) {
            toPath = "WEB-INF/view/member/signUp.jsp";   
            
	    }else if(fromPath.equals("/submitSignUp.do")) {
	    	
	    	MemberDTO member = new MemberDTO();
	    	
	    	member.setmId(req.getParameter("mId"));
	    	member.setPw(req.getParameter("pw"));
	    	member.setmName(req.getParameter("mName"));
	    	member.setEmail(req.getParameter("email"));
	    	member.setPhone(req.getParameter("phone"));
	    	member.setAddress(req.getParameter("address"));
	    	
	    	memberService.submitSignUp(member);
	    	
	    	req.setAttribute("msg", "회원가입되었습니다. 환영합니다~~~~");
            req.setAttribute("url", "WEB-INF/view/index.jsp");    
            
            // 회원가입됬으면 로그인도 해주자.
    		toPath = "WEB-INF/view/alert.jsp";
            
	    }else if(fromPath.equals("/checkUniqueId.do")) {
	    	
	    	String inputedId = req.getParameter("mId");
	    	boolean result = memberService.checkUniqueId(inputedId);
	    	req.setAttribute("result", result);
	    	
	    	toPath = "WEB-INF/view/member/checkUniqueId.jsp";
	    		
	    }else if(fromPath.equals("/forgetPwd.do")) {						
            toPath = "WEB-INF/view/member/forgetPwd.jsp";   
            
	    }else if(fromPath.equals("/checkEmail.do")) {						
            
	    	//회원 정보 확인, DB이메일과 입력값 비교
	    	MemberDTO member = new MemberDTO();
	    	
	    	String mId = req.getParameter("mId");		
	    	String email = req.getParameter("email");	
	    	member = memberService.checkEmail(mId);		
	    	
	    	if(member == null || !member.getEmail().equals(email)) {  	
	    		req.setAttribute("msg", "회원정보를 찾을 수 없습니다. 아이디와 이메일을 다시 확인해주세요.");
	    		req.setAttribute("url", "forgetPwd.do");    
		    	toPath = "WEB-INF/view/alert.jsp";		
	    	} else {
	    		
	    		//메일 서버 설정 (시연할 때 사용할 계정)
	    		String host = "smtp.naver.com";
	    		String user = "kh361team1@naver.com"; 
	    		String password = "kh361team1!!";
	    	
	    		// 메일 받을 주소
	    		String to_email = member.getEmail();
	    	
	    		// SMTP 서버 정보 설정
	    		Properties props = new Properties();
	    		props.put("mail.smtp.host", host);
	    		props.put("mail.smtp.port", 465);
	    		props.put("mail.smtp.auth", "true");
	    		props.put("mail.smtp.ssl.enable", "true");
	    	
	    		// 인증 번호 생성기
	    		StringBuffer temp = new StringBuffer();
	    		Random rnd = new Random();
	    		for (int i = 0; i < 10; i++) {
	    			int rIndex = rnd.nextInt(3);
	    			switch (rIndex) {
	    			case 0:
	    				// a-z
	    				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
	    				break;
	    			case 1:
	    				// A-Z
	    				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	    				break;
	    			case 2:
	    				// 0-9
	    				temp.append((rnd.nextInt(10)));
	    				break;
	    			}	
	    		}
	    		String AuthenticationKey = temp.toString();
	    		System.out.println(AuthenticationKey);
	    		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	    			protected PasswordAuthentication getPasswordAuthentication() {
	    				return new PasswordAuthentication(user, password);
	    			}
	    		});
	    
	    		//메일 전송
	    		try {
	    			MimeMessage msg = new MimeMessage(session);
	    			msg.setFrom(new InternetAddress(user, "밀슐랭"));
	    			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
	    		
	    			//메일 제목과 내용
	    			msg.setSubject("[인증코드 확인] 안녕하세요! 밀키트 쇼핑몰 밀슐랭입니다");
	    			msg.setText("인증코드: " + temp);
	    			Transport.send(msg);
	    			System.out.println("이메일 전송");
	    		} catch (Exception e) {
	    			e.printStackTrace();// TODO: handle exception
	    		}
	    		HttpSession saveKey = req.getSession();
	    		saveKey.setAttribute("AuthenticationKey", AuthenticationKey); 
	    	
	    		req.setAttribute("mId", mId);
	    		toPath = "WEB-INF/view/member/changePwd.jsp";
				}
	   
	    }else if(fromPath.equals("/changePwd.do")){
            
			//DB정보 변경 후 alert 뜨고 로그인창으로
			MemberDTO member = new MemberDTO();
			String mId = req.getParameter("mId");
			String pw = req.getParameter("pw");
	    	member.setPw(pw);
			memberService.changePwd(mId, pw);
			
			req.setAttribute("msg", "비밀번호가 정상적으로 변경되었습니다");
            req.setAttribute("url", "login.do"); 
    		toPath = "WEB-INF/view/alert.jsp";
			
	    }else{
            toPath = "WEB-INF/view/error.jsp";
        }
		return toPath;
	}

}

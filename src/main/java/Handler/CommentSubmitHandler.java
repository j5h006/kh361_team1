package Handler;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Member.MemberPage;
import Service.CommentSubmitPage;
import Service.CommentWriteService;
import dto.CommentDTO;
import model.dto.MemberDTO;
import mvc.command.CommandHandler;

public class CommentSubmitHandler implements CommandHandler {

	
	private static final String FORM_VIEW = "/aviato/product-single.jsp";
	private CommentWriteService commentWriteService = new CommentWriteService();
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		if(req.getMethod().equalsIgnoreCase("POST")) {
				return processSubmit(req,res);
		}else if(req.getMethod().equalsIgnoreCase("GET")) {
				return processForm(req,res);
		}else {
			res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;
		}
	}
	
	private String processForm(HttpServletRequest req, HttpServletResponse res) {
		return FORM_VIEW;
	}
	
	private String processSubmit(HttpServletRequest req,HttpServletResponse res) throws IOException {
		Map<String,Boolean> errors = new HashMap<>();
		
		req.setAttribute("errors", errors);
		
		MemberDTO member = (MemberDTO)req.getSession(false).getAttribute("member");
		
		System.out.println(member.getmId()+"CommentSubmitHandlerCheck");//troubleshooting1.
		
		
		CommentDTO submitReq = createSubmitRequest(member, req);
		
		submitReq.validate(errors);
		
		int CommentrNo = commentWriteService.submit(submitReq);
		req.setAttribute("CommentrNo", CommentrNo); // 수정삭제용
		
		if(!errors.isEmpty()) {
			return FORM_VIEW;//urlString
		}
		//res.sendRedirect("/aviato/product-single.jsp");
		
		return "/product-single.test";//urlString
	}

	private CommentDTO createSubmitRequest(MemberDTO memberdto, HttpServletRequest req) {

		Date date = new Date();
		System.out.println(memberdto.getmId()+req.getParameter("reviews")+"createSubmitRequestCheck");//troubleshooting2

		return new CommentDTO(memberdto, req.getParameter("reviews"), date);
		
	}

}

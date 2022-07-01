package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class IndexHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) {
		//req.setAttribute("hello", "안녕하세요!");
		//return "/WEB-INF/view/login/loginForm.jsp";
		return "/WEB-INF/view/index.jsp";
	}

}

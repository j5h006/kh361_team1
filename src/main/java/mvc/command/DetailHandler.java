package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class DetailHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) {
		//req.setAttribute("hello", "안녕하세요!");
		return "/WEB-INF/view/shop/productDetail.jsp";
	}

}

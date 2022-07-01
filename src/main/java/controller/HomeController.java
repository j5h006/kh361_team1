package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class HomeController extends HttpServlet{    
    
    private static final long serialVersionUID = 1L;
    

    public void init(ServletConfig config) throws ServletException{        
        
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doHandler(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doHandler(request, response);
    }
 
    
    private void doHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/index.jsp");
        dispatcher.forward(request, response);
    }
}
 
package com.myproject.mavenproject2.servlet;

import com.myproject.mavenproject2.dao.UserDao;
import com.myproject.mavenproject2.entities.UserEntity;
import com.myproject.mavenproject2.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
          
            try
            {
                //Coding area
                String useEmail = request.getParameter("user_email");
                String password = request.getParameter("password");
                
                //Validations
                
                
                // Authentication
                
                UserDao userDao = new UserDao(FactoryProvider.getFactory());
                UserEntity  user= userDao.getUserByEmailAndPassword(useEmail, password);
                
                HttpSession httpSession = request.getSession();
                
               
                if(user==null)
                {
                    httpSession.setAttribute("message","Invalid Details!! Try with another one");
                    response.sendRedirect("login.jsp");
                   return;
                }
                else
                {
                    out.println("<H3>Welcome!!"+user.getUserName()+"</h3>");
                    
                    //login
                    httpSession.setAttribute("current-user", user);
                    
                    if(user.getUserType().equals("admin")){
                        //admin:admin_user.jsp
                        
                        response.sendRedirect("admin_user.jsp");
                    }
                    else if(user.getUserType().equals("normal")){
                        //normal:normal_user.jsp
                        
                        response.sendRedirect("normal_user.jsp");
                    }
                    else{
                        out.println("<h3><We have not identified user type/h3>");
                    }
                    
                    
                }
            }
            catch(Exception e){
                
            }
        }
    }

     

}

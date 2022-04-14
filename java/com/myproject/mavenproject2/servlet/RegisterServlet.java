 
package com.myproject.mavenproject2.servlet;

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
import org.hibernate.Session;
import org.hibernate.Transaction;

 
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
         
            try{
                
                String userName = request.getParameter("user_name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phoneNo = request.getParameter("phone");
                String userAddress = request.getParameter("address");
                
                long userPhone = Long.parseLong(phoneNo);
                
                //Validations
                if(userName.isEmpty()){
                    out.println("user name is blank");
                    
                }
                
                // Creating user object to store data
                
                UserEntity user = new UserEntity(userName,email,password,userPhone,"default.jpg",userAddress,"normal");
                
                Session sess = FactoryProvider.getFactory().openSession();
                Transaction tr = sess.beginTransaction();
                int userId = (int)sess.save(user);
                
                tr.commit();
                sess.close();
                
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message","Registration Successful!! User Id is  "+userId);
                response.sendRedirect("register.jsp");
                return;
            }
            catch(Exception e){
          
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

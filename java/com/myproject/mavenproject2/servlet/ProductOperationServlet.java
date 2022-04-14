package com.myproject.mavenproject2.servlet;

import com.myproject.mavenproject2.dao.CategoryDao;
import com.myproject.mavenproject2.dao.ProductDao;
import com.myproject.mavenproject2.entities.Category;
import com.myproject.mavenproject2.entities.Product;
import com.myproject.mavenproject2.helper.FactoryProvider;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //Add category
            //Add product
            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {
                // Fetching category data */

                String catTitle = request.getParameter("catTitle");
                String catDescription = request.getParameter("cateDescription");
                Category category = new Category();
                category.setCategoryTitle(catTitle);
                category.setCategoryDescription(catDescription);

                // Category save in db
                CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = catDao.saveCategory(category);

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category saved!! and id is: " + catId);
                response.sendRedirect("admin_user.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {

                String prodName = request.getParameter("prodname");
                String prodDescription = request.getParameter("prodDescription");
                int prodPrice = Integer.parseInt(request.getParameter("prodprice"));
                int prodDescount = Integer.parseInt(request.getParameter("proddescount"));
                int prodQuantity = Integer.parseInt(request.getParameter("prodquantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");

                Product p = new Product();

                p.setpName(prodName);
                p.setpDesc(prodDescription);
                p.setpPrice(prodPrice);
                p.setpDiscount(prodDescount);
                p.setpQuantity(prodQuantity);
                p.setePhoto(part.getSubmittedFileName());

                //Get category by id
                CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = catDao.getCategoryById(catId);

                p.setCategory(category);

                //product save
                ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
                pDao.saveProduct(p);
                out.println("-Product saved");
                
                //pic upload
                //Find the path to upload photo
                
                String path = "C:/Users/Kumari/Desktop/myProject/Mycart/src/main/webapp/Image"+File.separator+"product"+File.separator+part.getSubmittedFileName();
                
                FileOutputStream file = new FileOutputStream(path);
                
                InputStream input = part.getInputStream();
                byte[] is = new byte[input.available()];
                
                input.read(is);
                file.write(is);

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "product saved!! ");
                response.sendRedirect("admin_user.jsp");
                return;

            }
        }

    }

}

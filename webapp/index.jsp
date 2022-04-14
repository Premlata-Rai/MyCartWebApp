<%@page import="com.myproject.mavenproject2.helper.Helper"%>
<%@page import="com.myproject.mavenproject2.dao.ProductDao"%>
<%@page import="com.myproject.mavenproject2.entities.Category"%>
<%@page import="com.myproject.mavenproject2.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.myproject.mavenproject2.dao.CategoryDao"%>
<%@page import="com.myproject.mavenproject2.helper.FactoryProvider" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <%@include  file ="Components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>

        <div class="container-fluid"> 
            <div class="row mt-3 mx-2">
                <%                    String catValue = request.getParameter("Category");
                    ProductDao prod = new ProductDao(FactoryProvider.getFactory());
                    List<Product> allProd = null;
                    if (catValue == null || catValue.trim().equals("All products")) {
                        allProd = prod.getAllProducts();

                    } else {

                        allProd = prod.getAllProductsByName(catValue);
                    }

                    CategoryDao cat = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> list = cat.getCategories();

                %>
                <!--Show Categories-->
                <div class="col-md-2">

                    <div class="list-group mt-4">

                        <a href="index.jsp?Category=All products" class="list-group-item list-group-item-action active">
                            All products
                        </a>

                        <% for (Category c : list) {

                        %>

                        <a href="index.jsp?Category=<%= c.getCategoryTitle()%>" class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>
                        <%}
                        %>

                    </div>
                </div>

                <!--Show product-->

                <div class="col-md-10 ">

                    <!--row-->
                    <div class="row mt-4  ">

                        <!--Coll-12-->
                        <div class="col-md-12">

                            <div class="card-columns">
                                <!-- traversing products-->

                                <%
                                    for (Product p : allProd) {


                                %>
                                <!--product card-->
                                <div class="card product-card">

                                    <div class="container text-center">
                                        <img class="card-img-top " src="Image/product/<%= p.getePhoto()%>" style="max-height:170px; max-width: 100%; width: auto" alt="Card image cap">
                                    </div>
                                    <div class="card-body">

                                        <h5 class="card-title"><%= p.getpName()%></h5>

                                        <p class="card-text">
                                            <%= Helper.get10Words(p.getpDesc())%>
                                        </p>

                                    </div>

                                    <div class="card-footer text-center">
                                        <div>
                                            <button class="btn custom_bg text-white" onclick="add_to_cart(<%=p.getpId()%>, '<%=p.getpName()%>',<%= p.getPriceAfterApplyingDescount()%>)">Add to cart</button>
                                            <button class="btn btn-outline-success ">&#8377;<%= p.getPriceAfterApplyingDescount()%>/- <span class="text-secondary descount-label"><%=p.getpPrice()%>&#8377;<%=p.getpDiscount()%>% off</span></button>
                                        </div>
                                    </div>
                                </div>

                                <%}
                                    if (allProd.size() == 0) {
                                        out.println("<h3>No item in this category</h3>");
                                    }
                                %>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <%@include file="Components/common_modals.jsp" %>
                   
        </body>
      </html>

<%@page import="java.util.Map"%>
<%@page import="com.myproject.mavenproject2.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.myproject.mavenproject2.entities.Category"%>
<%@page import="com.myproject.mavenproject2.dao.CategoryDao"%>
<%@page import="com.myproject.mavenproject2.helper.FactoryProvider"%>
<%@page import="com.myproject.mavenproject2.entities.UserEntity" %>
<%
    UserEntity user = (UserEntity) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin user");
            response.sendRedirect("login.jsp");
            return;
        }

    }

%>


<!--Product category-->
<%  CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = catDao.getCategories();
    // getting count
    Map map = Helper.getCounts(FactoryProvider.getFactory());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin panel</title>
        <%@include file="Components/common_css_js.jsp" %>
    </head>
    <body class="admin">
        <%@include file="Components/navbar.jsp" %>
        <div class="container">

            <div class="container-fluid mt-3">
                <%@include file="Components/message.jsp" %>
            </div>
            <div class ="row mt-3">

                <!--First col-->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center">
                            <img src="Image/users.png" class="img-fluid rounded-circle" style=" max-width:100px">
                            <h1><%= map.get("userCount") %></h1>
                            <h1 class="text-upercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <!--Second col-->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center " >
                            <img src="Image/menu.png" class="img-fluid rounded-circle" style=" max-width:100px">
                            <h1><%=list.size()%></h1>
                            <h1 class="text-upercase text-muted">Category</h1>
                        </div>
                    </div>

                </div>
                <!--Third col-->
                <div class="col-md-4">

                    <div class="card" >
                        <div class="card-body text-center" >
                            <img src="Image/product.png" class="img-fluid rounded-circle" style=" max-width:100px">
                            <h1><%= map.get("productCount") %></h1>
                            <h1 class="text-upercase text-muted">Products</h1>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Second row-->
            <div class ="row mt-3">
                <!--Second row, First col-->
                <div class="col-md-6">

                    <div class="card">
                        <div class="card-body text-center" data-toggle="modal" data-target="#add-category-modal">
                            <img src="Image/keys.png" class="img-fluid rounded-circle" style=" max-width:100px">
                            <p class="mt-2">Click here to add new category</p>
                            <h1 class="text-upercase text-muted">Add category</h1>
                        </div>
                    </div>
                </div>
                <!--Second row, Second col-->
                <div class="col-md-6" >

                    <div class="card">
                        <div class="card-body text-center " data-toggle="modal" data-target="#add-product-modal" >
                            <img src="Image/plus.png" class="img-fluid rounded-circle" style=" max-width:100px">
                            <p class="mt-2">Click here to add new product</p>
                            <h1 class="text-upercase text-muted">Add new product</h1>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!-- add category Modal -->

        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom_bg text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details !!</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden"  name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category name">

                            </div>

                            <div class="form-group">
                                <textarea style="height:350px" class="form-control"  placeholder="Enter category description" name="cateDescription" required></textarea>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-success">Add category</button>
                                <button type="button" class="btn btn-outline-warning " data-dismiss="modal">Close</button>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- add product Modal -->

        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom_bg text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details !!</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden"  name="operation" value="addproduct">
                            <div class="form-group">
                                <input type="text" class="form-control" name="prodname" placeholder="Enter product name">

                            </div>
                            <div class="form-group">
                                <textarea style="height:150px" class="form-control"  placeholder="Enter product description" name="prodDescription" required></textarea>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="prodprice" placeholder="Enter product price name">

                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="proddescount" placeholder="Enter product descount name">

                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" name="prodquantity" placeholder="Enter product quantity name">

                            </div>

                            <div class="form-group">
                                <select  name="catId" class="form-control"  id="">
                                    <% for (Category c : list) {

                                    %>
                                    <option value="<%= c.getCategoryId()%>"> <%= c.getCategoryTitle()%> </option>

                                    <%}%>
                                </select>

                            </div>


                            <!--Product file-->
                            <div class="form-group">
                                <label for="pPic">Select picture of product</label>
                                <br>
                                <input type="file" name="pPic" id="pPic"  required>

                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-success">Add product</button>
                                <button type="button" class="btn btn-outline-warning " data-dismiss="modal">Close</button>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="Components/common_modals.jsp" %>

    </body>
</html>

 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include  file ="Components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>

        <div class="container-fluid ">
            <div class="row mt-3">
                <div class="col-md-4 offset-md-4">

                    <div class="card">
                        <%@include file="Components/message.jsp" %>
                        <div class="card-body" px-5>
                            <div class="container text-center">
                                <img src="Image/add_friend.png" style="max-width:100px" class="img-fluid " alt="Responsive image">
                            </div>

                            <h3 class="text-center my-3">Sign up Here!!</h3>
                            <form method="post" action="RegisterServlet">
                                <div class="form-group">
                                    <label for="name">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">

                                </div>
                                <div class="form-group">
                                    <label for="name">User Email</label>
                                    <input name ="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter here">

                                </div>
                                <div class="form-group">
                                    <label for="name">password</label>
                                    <input name="password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter here">

                                </div>
                                <div class="form-group">
                                    <label for="name">phone</label>
                                    <input name="phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter here">

                                </div>
                                <div class="form-group">
                                    <label for="name">User Address</label>
                                    <textarea name ="address" style="height: 50px" class="form-control" id="address"  placeholder="Enter here"></textarea>

                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Register</button>
                                    <button class="btn btn-outline-warning">Reset</button>

                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

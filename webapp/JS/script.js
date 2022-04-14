function add_to_cart(pid, pname, price) {

    let cart = localStorage.getItem("cart");
    if (cart === null)
    {

        //no cart yet
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        showToast("Item added to cart");

    } else {
        //cart is already present
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId === pid);

        if (oldProduct)
        {
            //We have to increase the quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId === oldProduct.productId)
                {
                    item.productQuantity = oldProduct.productQuantity;
                }
            });
            localStorage.setItem("cart", JSON.stringify(pcart));
            showToast("Product increased to cart");
           
            //showToast("hello");
        } else {
            //We have to add the product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            showToast("Another Product added to cart");
         
        }
    }
    updateCart();
    
}
// update cart
function updateCart() {

    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart === null || cart.length === 0)
    {
        console.log("Cart is Empty !!");
        $(".cart-items").html("(0)");

        $(".cart-body").html("<h3>Cart does not have any item</h3>");
        $(".checkout-btn").addClass('disabled');

    } else
    {
        //there is something in cart to show
        console.log(cart);
        $(".cart-items").html(`(${cart.length})`);

        let table = `
 
         <table class="table">
             <thead class="thead-ligth">
                  <tr>
                  <th>Item name</th>
                  <th>Price</th>
                  <th>Quantity</th>
                  <th>Total Price</th>
                  <th>Action</th>
                  
                  </tr>
        
        </thead>
            
       
       `;
          let totalprice = 0;
          cart.map((item) => {
            
            table+= `
        
        <tr>
        <td>${item.productName}</td>
        <td>${item.productPrice}</td>
        <td>${item.productQuantity}</td>
        <td>${item.productQuantity * item.productPrice}</td>
        <th><button class="btn btn-danger btn-sm" onclick='deleteItemFromCart(${item.productId})'>Remove</button></th>
        </tr>
        
        `
            totalprice += item.productPrice * item.productQuantity;
    })
        table = table +`
        <tr><td colspan ='5' class = "text-right font-weight-bold m-5">Total price : ${totalprice}</td></tr>
        </table>`
       
         $(".cart-body").html(table);
         $(".checkout-btn").removeClass('disabled');
        
    }

}


// delete item
function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item) => item.productId != pid);
    localStorage.setItem('cart',JSON.stringify(newcart));
    updateCart()
    showToast("Product removed from cart");
}

//toast function

function showToast(content)
{
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
      $("#toast").removeClass("display"); 
    }, 2000);
}
$(document).ready(function () {
    updateCart()
})

function goToCheckout(){
    window.location = "checkout.jsp";
}





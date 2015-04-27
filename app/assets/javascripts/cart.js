simpleCart.currency({
    code: "INR" ,
    name: "Indian Rupee" ,
    symbol: "Rs"
});

simpleCart({
	// array representing the format and columns of the cart,
	// see the cart columns documentation
	cartColumns: [
		{ attr: "name", label: false},
		{ view: "decrement", text: "<i class='fa fa-minus-circle'></i>", label: false},
        { attr: "quantity", label: false},
        { view: "increment", text: "<i class='fa fa-plus-circle'></i>", label: false},
		{ view: "remove", text: "<i class='fa fa-trash-o'></i>", label: false},
		{ view: "currency", attr: "price", label: false}
	],

	// "div" or "table" - builds the cart as a 
	// table or collection of divs
	cartStyle: "div", 

	// how simpleCart should checkout, see the 
	// checkout reference for more info 
	checkout: { 
		type: "SendForm" , 
		url: 'http://localhost:3000/checkout',
		method: 'GET',
		success: "success.html",
		cancel: 'Cancel.html',
		extra_data: {
         storename: "FitnessPapa Store",
         cartid: "12321321"
        }
	},

	// set the currency, see the currency 
	// reference for more info
	currency: "INR",

	// collection of arbitrary data you may want to store 
	// with the cart, such as customer info
	data: {},

	// set the cart langauge 
	// (may be used for checkout)
	language: "english-us",

	// array of item fields that will not be 
	// sent to checkout
	excludeFromCheckout: [],

	// custom function to add shipping cost
	shippingCustom: null,

	// flat rate shipping option
	shippingFlatRate: 0,

	// added shipping based on this value 
	// multiplied by the cart quantity
	shippingQuantityRate: 0,

	// added shipping based on this value 
	// multiplied by the cart subtotal
	shippingTotalRate: 0,

	// tax rate applied to cart subtotal
	taxRate: 0,

	// true if tax should be applied to shipping
	taxShipping: false,

	// event callbacks 
	beforeAdd			: null,
	afterAdd			: null,
	load				: null,
	beforeSave		: null,
	afterSave			: null,
	update			: null,
	ready			: null,
	checkoutSuccess	: null,
	checkoutFail		: null,
	beforeCheckout		: null,
        beforeRemove           : null
});


simpleCart.bind("afterCreate", function(){
   $cart_table = $(".simpleCart_items")
   $cart_table.addClass("table").addClass("table-hover")
});

simpleCart.bind('update' , function(){
  $('.cart_value').html(simpleCart.items().length);
});

simpleCart.bind( 'afterAdd' , function( item ){
   $('.dropdown-toggle').dropdown('toggle');
});

$('document').ready(function(){
	window.cart_drop = new Drop({
	  target: document.querySelector('.drop-target'),
	  content: $('.cart-target')[0],
	  position: 'bottom left',
	  classes: 'drop-theme-arrows-bounce-dark',
	  openOn: null
	});

	$('.drop-target').on('click', function(){
		cart_drop.toggle();
	})
});


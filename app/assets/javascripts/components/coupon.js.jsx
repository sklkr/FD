var CouponContainer = React.createClass({
  getInitialState: function(){
    return {
     active: false,
     amount: '0'
    }
  },
  couponUrl: function(){
  return $.post('coupons.js', {id: this.refs.couponcode.getDOMNode().value});
  },
  sendCoupon: function(){
   this.couponUrl().then(function(data){
     if(data.active){
       swal(data.coupon, 'Coupon code applied successfully.', 'success');
       this.setState({active: true, amount: data.amount});
     }else{
       swal('Oops..!', 'Coupon code not valid. Please check your code once again', 'error');
     }
		}.bind(this));
  },
	render: function(){

		var formState = this.state.active ? "form-inline hidden" : "form-inline" ;
		var spanState = this.state.active ? "label label-success" : "hidden" ;
    var hider = { display: 'none' };

		return(
      <div>
        <div className={formState} style={hider}>
          <input type="text"  placeholder="Coupon Code?" ref="couponcode" className="form-control" style={{ marginRight: '12px'}} />
          <input type="submit" className="btn btn-success" onClick={this.sendCoupon}/>
        </div>
        <span className={spanState}> Discount amount {this.state.amount} /- applied </span>
      </div>
		);
	}
})


var couponContainer = React.render(
	<CouponContainer />,
	document.getElementById('coupon-container')
)

var CouponContainer = React.createClass({
  getInitialState: function(){
    return {
     active: false,
     amount: '0'
    }
  },
  couponUrl: function(){
    return $.post('/coupons.js', {id: this.refs.couponcode.getDOMNode().value});
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
    var hider = { display: 'block' };

		return(
      <div>
        <div className={formState} style={hider}>
          <div class="form-group" style={{marginBottom: '8px'}}>
            <input type="text"  placeholder="Coupon Code?" ref="couponcode" className="form-control" style={{ marginRight: '12px'}} />
            <input type="submit" value='Apply' className="btn btn-success" onClick={this.sendCoupon} style={{marginTop: '12px'}}/>
          </div>
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

var ServiceContainer = React.createClass({
	getInitialState: function(){
		return {
			activities: ["Gym", "Yoga", "Dance", "Swim", "Aerobics", "Zumba", "Pillatees", "Martial Art", "Boxing", "Strength training"],
			services: []
		}
	},
	loadServices: function(){
		return $.post('/api/services');
	},

	reloadServices: function(){
		var place_name = (this.state.place_name_cont_any.getPlace() == undefined) ? this.state.defaultLocation : this.state.place_name_cont_any.getPlace().name;
		return $.post('/api/services', { place_name_cont_any: place_name, center_type_in: JSON.stringify(this.state.center_type_in.getValue()) });
	},

	componentWillMount: function(){
		this.loadServices().then(function(data){
			this.setState({
				services: data.services[0],
				defaultLocation: 'Bengaluru'
			});
			this.renderFilter();
		}.bind(this));
	},

	renderFilter: function(){
		window.search_input = document.getElementById('cities');
		this.setState({
			center_type_in: $('.magicsuggest').magicSuggest([]),
			place_name_cont_any: new google.maps.places.Autocomplete(window.search_input),
			}, function(){
				google.maps.event.addListener(this.state.place_name_cont_any, 'place_changed', function(){
					this.startSearching();
				}.bind(this));
			}.bind(this));
		
		this.setState({
			filtershow: true
		});

		$(this.state.center_type_in).on('selectionchange', function(e, m) {
			this.startSearching();
		}.bind(this));
	},

	startSearching: function(){
		this.reloadServices().then(function(data){
			this.setState({
				services: data.services[0],
				defaultLocation: 'Bengaluru',
			});
		}.bind(this));
	},

	render: function(){
		var services = this.state.services.map(function(service){
			return <Service key={service.id} service={service}/>;
		}.bind(this));

		var noresults = {
			display: (this.state.services.length == 0) ? 'block' : 'none',
  			border: "1px solid #e3e3e3",
  			padding: "22px 20px",
  			minHeight: "219px",
  			background: "aliceblue",
		};
		
		return(
			<div className="row">
			  <div className='col-xs-12'><h3 className='text-center' id='heading'>Services</h3></div>
			  <div className="col-sm-4 col-xs-12">
			  	<Search activities={this.state.activities}/>
			  </div>
			  <div className="col-sm-8 col-xs-12" id="services">
			  	{ services }
			  	<div id='noresults' style={noresults}>
			  		<p>No services matches your search criteria. Try search around with different location and activities to get search results.</p>
			  	</div>
			  </div>
			</div>
		);
	}
})

var Service = React.createClass({
	
	render: function(){
		var url = "/book_service/info?service=" + this.props.service.slug;

		return(
	      <div className="list-item">
            <div className="row">
              <div className="col-sm-8">
                <h4 className="group inner list-group-item-heading"><a href={this.props.service.center_path} className='center' target='_blank'>{ this.props.service.center_name }</a> <i className='fa fa-external-link linker'></i> - {this.props.service.name}</h4>
                <p><small className="m-right20"><i className="fa fa-map-marker">&nbsp;</i>{ this.props.service.place_name }</small></p>
                <p><i className='fa fa-clock-o'></i> { this.props.service.duration } Minutes <span className='label label-info'>{ this.props.service.center_type }</span></p> 
                <p></p>  
              </div>
              <div className="col-sm-4">
                <span className='pull-right'>
                  <p className="currency text-right"><i className='fa fa-rupee'>&nbsp;</i>{ this.props.service.selling_price }/-</p>
                  <a className="btn btn-primary" href={url}>Buy Now</a></span>  
              </div>
            </div>
          </div>
	 	);
	}
});

var Search = React.createClass({
	handleSearch: function(){
		// no need of this function
		clearTimeout(window.wto);
	    window.wto = setTimeout(function() {
			this.props.onSearch();	
	    }.bind(this), 1000);
	},
	
	render: function(){
		return(
			<fieldset className="search-container" id="center-search-container" >
	            <div className="row">
	                <div className="col-xs-12 m-bottom20">
	                    <label htmlFor="location">CITY / LOCATION</label>
	                    <div>
	                      <input id="cities" type="text" name="q[place_name_cont_any]" ref='place_name_cont_any' placeholder={this.props.defaultloc} className="ui-autocomplete-input form-control form-square" />
	                    </div>
	                </div>
	                <div className="col-xs-12 m-bottom20">
	                  <label htmlFor="facilities">ACTIVITIES</label>
	                  <select name="center_type_in" className="magicsuggest" placeholder="Choose.." onChange={this.handleSearch}>
	                  	{this.props.activities.map(function(act) {
	                  	    return <option value={act}>{act}</option>;
	                  	})}
	                  </select>
	                </div>
	            </div>
			</fieldset>
		);	
	}
})

var serviceContainer = React.render(
	<ServiceContainer />,
	document.getElementById('services-container')
)

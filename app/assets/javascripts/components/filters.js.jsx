var SearchContainer = React.createClass({
	getInitialState: function(){
		return {
			fpclasses: [],
			fpstudios: [],
			isFpclass: true,
			isFpstudio: false,
			isCalendar: true,
			recursivedates_ondate_eq: LocalTime.strftime(new Date(), '%Y-%m-%d'),
			dates: [],
			searchfields: {place_name_cont_any: '', center_type_in: ''},
			activities: ["Gym", "Yoga", "Dance", "Swim", "Aerobics", "Zumba", "Pillatees", "Martial Art", "Boxing", "Strength training"],
			loaded: false,
			filtershow: false
		}
	},
	loadClasses: function(){
		return $.post('api/search/classes.json');
	},

	reloadClasses: function(){
		return $.post('api/search/classes.json', { place_name_cont_any: this.state.place_name_cont_any.getPlace().name, center_type_in: JSON.stringify(this.state.center_type_in.getValue()), recursivedates_ondate_eq: this.state.recursivedates_ondate_eq });
	},
	loadStudios: function(){
		return $.post('api/search.json');
	},
	reloadStudios: function(){
		return $.post('api/search.json', { place_name_cont_any: this.state.place_name_cont_any.getPlace().name, center_type_in: JSON.stringify(this.state.center_type_in.getValue()) });
	},

	componentWillMount: function(){
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1],
				loaded: true
			});
			this.renderCalendar();
			this.renderFilter();
		}.bind(this));
	},

	classesUpdater: function(){
		this.setState({
			isFpclass: true,
			isFpstudio: false,
			isCalendar: true,
			loaded: false
		});
		if(this.state.place_name_cont_any.getPlace() == undefined){
			sweetAlert('Location/City', 'Please choose your location before going to search');
			document.getElementById('cities').select();
		}else{
			this.reloadClasses().then(function(data){
				this.setState({
					fpclasses: data.filters[0],
					dates: data.filters[1],
					loaded: true
				});
			}.bind(this));	
		}
	},

	studiosUpdater: function(){
		this.setState({
			isFpstudio: true,
			isFpclass: false,
			isCalendar: false
		});
		this.reloadStudios().then(function(data){
			this.setState({
				fpstudios: data.filters
			});
		}.bind(this));
	},

	renderCalendar: function(){
		$("#sd-calendar").owlCarousel({
	      items : 7, //10 items above 1000px browser width
	      pagination: false,
	      rewindNav: false,
	      navigation: true,
	      navigationText: [
	       "<i class='icon-chevron-left icon-white'><</i>",
	       "<i class='icon-chevron-right icon-white'>></i>"
	      ],
  		});
	},

	renderFilter: function(){
		window.search_input = document.getElementById('cities');
		this.setState({
			center_type_in: $('.magicsuggest').magicSuggest([]),
			place_name_cont_any: new google.maps.places.Autocomplete(window.search_input),
		});
		this.setState({
			filtershow: true
		})
	},

	componentDidMount: function(){
		document.getElementById('cities').select();
	},
	
	startSearching: function(){
		this.state.isFpclass ? this.classesUpdater() : this.studiosUpdater()
	},

	classesFetch: function(){
		this.setState({
			isFpclass: true,
			isFpstudio: false,
			isCalendar: true,
			loaded: false
		});
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1],
				loaded: true
			})
		}.bind(this));
	},
	studiosFetch: function(){
		this.setState({
			isFpstudio: true,
			isFpclass: false,
			isCalendar: false
		});
		this.loadStudios().then(function(data){
			this.setState({
				fpstudios: data.filters
			})
		}.bind(this));
	},

	handleCal: function(cal){
		this.setState({recursivedates_ondate_eq: cal}, function(){
			this.classesUpdater();
		}.bind(this));
	},
	
	toggleFilter: function(){
	 $("#center-search-container").toggleClass("hidden-xs");
	},

	loadMore: function(){
		debugger;
	},

	render: function(){
		var fpclasses = this.state.fpclasses.map(function(data){
			return <ClassRow key={data.key} date={data.date} fpclass={data.fpclass} start_time={data.time} status={data.status} />;
		}.bind(this));

		var fpstudios = this.state.fpstudios.map(function(fpstudio){
			return <StudioRow key={fpstudio.id} fpstudio={fpstudio} />;
		});

		var rendercalendar = this.state.dates.map(function(date){
			return <Calendar key={date} date={date} onCalendar={this.handleCal} current_date={this.state.recursivedates_ondate_eq} />;
		}.bind(this));
		
		var classStyle = {
			display: this.state.isFpclass ? 'block' : 'none'
		};

		var studioStyle = {
			display: this.state.isFpstudio ? 'block' : 'none'
		};

		var calendarStyle = {
			display: this.state.isCalendar ? 'block' : 'none',
			marginBottom: '20px'
		};


		return(
			<div className="panel hasMtop">
		        <div className="panel-heading">
		          <div className="visible-xs pull-right"><a href="#" onClick={this.toggleFilter}><i className="fa fa-sliders fa-2x"></i></a></div>
		          <div className="cd-pricing-switcher" id="cd-switcher">
		          	<Toggler onStudios={this.studiosFetch} onClasses={this.classesFetch} />
		          </div>
		        </div>
		        <div className="panel-body">
		          <div className="clearfix">
		          	<Search activities={this.state.activities} onSearch={this.startSearching} show={this.state.filtershow} />
		          </div>
		          <div className="clearfix" style={calendarStyle}>
		          	<div className="week1">
		          	  <div id="sd-calendar" className="owl-carousel owl-theme">
		          	      { rendercalendar }
		          	  </div>
		          	</div>
		          </div>
		        </div>
		        <div className="clearfix" id="classes-section" style={classStyle}>
		            <Loader loaded={this.state.loaded} color="#CCC" opacity="0">
		            <div className="table-responsive">
		            	<table className="table table-hover table-striped" id="classes-content">
			            	<thead>
			            		<tr>
			            			<th>Class</th>
			            			<th>Center</th>
			            			<th>Timing</th>
			            			<th>Location</th>	
			            			<th></th>
			            		</tr>
			            	</thead>
			            	<tbody>
			            		{ fpclasses }
			            	</tbody>
			            </table>
			            <div class='circle'>
			            	<a onClick={this.loadMore}>Load more</a>
			            </div>
			        </div>
			        </Loader>
		        </div>
		        <div className="clearfix" id="centers-section" style={studioStyle}>
		        	{ fpstudios }
		        </div>
		    </div>
		);
	}
})


var Toggler = React.createClass({
	handleStudios: function(){
		$('.cd-switch').css({transform: 'translateX(0%)'});
		this.props.onStudios()
	},

	handleClasses: function(){
		$('.cd-switch').css({transform: 'translateX(95%)'});
		this.props.onClasses()
	},
	
	render: function(){
		return(
			<p className="fieldset">
				<input type="radio" name="duration" value="monthly" id="monthly" onClick={this.handleStudios} />
				<label htmlFor="monthly">STUDIO</label>
				<input type="radio" name="duration" value="yearly" id="yearly" defaultChecked='true' onClick={this.handleClasses} />
				<label htmlFor="yearly">CLASSES</label>
				<span className="cd-switch"></span>
			</p>
		);
	}
})

var Search = React.createClass({
	handleSearch: function(){
		this.props.onSearch();	
	},
	
	render: function(){
		var show = {
			display: this.props.show ? 'block' : 'none'
		};

		return(
			<fieldset className="search-container hidden-xs" id="center-search-container" style={show}>
	            <div className="row">
	                <div className="col-md-4 col-xs-12 m-bottom20">
	                    <label htmlFor="location">LOCATION</label>
	                    <div>
	                      <input id="cities" type="text" name="q[place_name_cont_any]" ref='place_name_cont_any' placeholder="Type Locality or Landmark" className="ui-autocomplete-input form-control form-square" />
	                    </div>
	                </div>
	                <div className="col-md-4 col-xs-12 m-bottom20">
	                  <label htmlFor="facilities">ACTIVITIES</label>
	                  <select name="center_type_in" className="magicsuggest">
	                  	{this.props.activities.map(function(act) {
	                  	    return <option value={act}>{act}</option>;
	                  	})}
	                  </select>
	                </div>
	                <div className="col-md-4 col-xs-12">
	                  <label htmlFor="">&nbsp;</label>
	                  <div>
	                    <input className="btn btn-default" name="commit" type="submit" value="  Search  "  onClick={this.handleSearch} />
	                  </div>
	                </div>
	            </div>
			</fieldset>
		);	
	}
})

var ClassRow = React.createClass({
	reserveConfirm: function(){
		return $.get(this.props.fpclass.class_path, { date: this.props.date, time: this.props.start_time });
	},
	
	confirmReserve: function(){
		this.reserveConfirm().then(function(data){
			/* to get confirmation box at reserve button*/
		});	
	},

	render: function(){
		var timerange = moment(this.props.start_time, 'HH:mm').format('h:mm') + "  -  " + moment(this.props.start_time, 'HH:mm').add(this.props.fpclass.duration, 'm').format('h:mm a');
		var seatsfull = this.props.status == this.props.fpclass.seats;
		var disabler = seatsfull ? 'disabled' : '';
		var reserveText = seatsfull ? 'Fulfilled' : 'Reserve'; 

		return(
			<tr>
				<td><h5>
					<a onClick={this.confirmReserve} className={'blue ' + disabler}>{this.props.fpclass.capname}</a>
				</h5></td>
				<td><h5><a href={this.props.fpclass.center_path} className='blue'>{this.props.fpclass.center_name}</a></h5></td>
				<td> <div className="marginer">{ timerange }</div> </td>
				<td> <div className="marginer">{this.props.fpclass.place_name}</div> </td>
				<td className="text-center">
					<a className={"btn btn-primary reserve-btn " + disabler} onClick={this.confirmReserve}>{reserveText}</a>
				</td>
			</tr>
		);
	}
})

var StudioRow = React.createClass({
	
	render: function(){
		return(
			<div className="list-item clearfix">
			  <div className="col-xs-12 col-sm-4 img-box">
			    <a href={this.props.fpstudio.details_path}><img alt={this.props.fpstudio.capname} className="group list-group-image img-responsive" src={this.props.fpstudio.image_path} /></a>
			  </div>
			  <div className="col-xs-12 col-sm-8 cnt-box">
			    <a href={this.props.fpstudio.details_path}><h4 className="group inner list-group-item-heading">{this.props.fpstudio.capname}</h4></a>
			    <p><small className="m-right20"><i className="fa fa-map-marker">&nbsp;</i>{this.props.fpstudio.place_name}</small></p>
			    <p className="group inner list-group-item-text">{this.props.fpstudio.detailed_desc}</p>
			  </div>
			</div>
		);
	}
})

var Calendar = React.createClass({
	dateFormat: function(){
		return LocalTime.strftime(new Date(this.props.date), "%b %d");
	},
	dateFormatfull: function(){
		return LocalTime.strftime(new Date(this.props.date), "%Y-%m-%d");
	},
	handleCalendar: function(e){
		this.props.onCalendar(e.target.dataset.cdate);
	},
	render: function(){
		var dateClasses = (this.props.date == this.props.current_date)? "label label-success" : "label" ;

		return(
	      <div className="item">
		    <a ref='calcordo' className={dateClasses} onClick={this.handleCalendar} data-cdate={this.dateFormatfull()}>{this.dateFormat()}</a>
		  </div>
	 	);
	}
})

var searchContainer = React.render(
	<SearchContainer />,
	document.getElementById('search-container')
)

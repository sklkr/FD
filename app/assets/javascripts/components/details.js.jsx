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
			loaded: false,
			filtershow: false,
			pageNumber: 1,
			loadMoreText: 'LOAD MORE',
			loadMore: false,
			defaultLocation: '',
			time_filter: ''
		}
	},
	loadClasses: function(){
		return $.post('/api/search/classes.json', { centers_slug_eq: $("#center-slug").data('url') });
	},

	reloadClasses: function(){
		return $.post('/api/search/classes.json', { recursivedates_ondate_eq: this.state.recursivedates_ondate_eq, centers_slug_eq: $("#center-slug").data('url') });
	},

	updateClasses: function(){
		var place_name = (this.state.place_name_cont_any.getPlace() == undefined) ? this.state.defaultLocation : this.state.place_name_cont_any.getPlace().name;
		return $.post('/api/search/classes.json', { time_filter: this.state.time_filter.val(), page: this.state.pageNumber, place_name_cont_any: place_name, center_type_in: JSON.stringify(this.state.center_type_in.getValue()), recursivedates_ondate_eq: this.state.recursivedates_ondate_eq });
	},

	loadStudios: function(){
		var place_name = (this.state.place_name_cont_any.getPlace() == undefined) ? this.state.defaultLocation : this.state.place_name_cont_any.getPlace().name;
		return $.post('/api/search.json', {place_name_cont_any: place_name});
	},
	reloadStudios: function(){
		var place_name = (this.state.place_name_cont_any.getPlace() == undefined) ? this.state.defaultLocation : this.state.place_name_cont_any.getPlace().name;
		return $.post('/api/search.json', { place_name_cont_any: place_name, center_type_in: JSON.stringify(this.state.center_type_in.getValue()) });
	},

	componentWillMount: function(){
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1],
				loaded: true,
				defaultLocation: data.filters[3]
			});
			this.renderCalendar();
		}.bind(this));
	},

	classesUpdater: function(){
		this.setState({
			isFpclass: true,
			isFpstudio: false,
			isCalendar: true,
			loaded: false,
			pageNumber: 1
			//loadMore: true,
		});
		// if(this.state.place_name_cont_any.getPlace() == undefined){
		// 	sweetAlert('Location/City', 'Please choose your location before going to search');
		// 	document.getElementById('cities').select();
		// }else{
		this.reloadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1],
				loaded: true
			});
			if(data.filters[0].length == 0){
				this.setState({
					// loadMore: false
				});
			}
		}.bind(this));
		// }
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

	startSearching: function(){
		this.state.isFpclass ? this.classesUpdater() : this.studiosUpdater()
	},

	classesFetch: function(){
		this.setState({
			isFpclass: true,
			isFpstudio: false,
			isCalendar: true,
			loaded: false,
			pageNumber: 1
			// loadMore: true,
		});
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1],
				loaded: true
			});
			if(data.filters[0].length == 0){
				this.setState({
					// loadMore: false
				});
			}
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
		this.setState({
			loadMoreText: "LOADING ..."
		});
		// if(this.state.place_name_cont_any.getPlace() == undefined){
		// 	sweetAlert('Location/City', 'Please choose your location before going to search');
		// 	document.getElementById('cities').select();
		// } else {
			this.updateClasses().then(function(data){
				mergeData = this.state.fpclasses.concat(data.filters[0]);

				if(data.filters[0].length == 0){
					this.setState({
						loadMore: false
					})
				}else{
					this.setState({
						fpclasses: mergeData,
						loadMoreText: "LOAD MORE",
						pageNumber: this.state.pageNumber + 1
					});
				}
			}.bind(this));	
		// }
	},

	render: function(){
		var fpclasses = this.state.fpclasses.map(function(data){
			return <ClassRow key={data.id} date={data.date} fpclass={data} start_time={data.time} status={data.status} />;
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

		var loadMoreStyle = {
			display: this.state.loadMore ? 'block' : 'none',
		}


		return(
			<div className="panel hasMtop">
		        <div className="panel-body">
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

var Search = React.createClass({
	handleSearch: function(){
		// no need of this function
		clearTimeout(window.wto);
	    window.wto = setTimeout(function() {
			this.props.onSearch();	
	    }.bind(this), 1000);
	},
	
	render: function(){
		var show = {
			display: this.props.show ? 'block' : 'none'
		};

		var timeStyle = {
			display: this.props.isfpclass ? 'block' : 'none'
		};

		return(
			<fieldset className="search-container hidden-xs" id="center-search-container" style={show}>
	            <div className="row">
	                <div className="col-md-4 col-xs-12 m-bottom20" style={timeStyle} >
	                    <input type="text" id="time_filter" name="time_filter" onChange={this.handleSearch} />
	                </div>
	                <div className="col-md-4 col-xs-12 m-bottom20">
	                    <label htmlFor="location">LOCATION</label>
	                    <div>
	                      <input id="cities" type="text" name="q[place_name_cont_any]" ref='place_name_cont_any' placeholder={this.props.defaultloc} className="ui-autocomplete-input form-control form-square" />
	                    </div>
	                </div>
	                <div className="col-md-4 col-xs-12 m-bottom20">
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
				<td> <div className="marginer">{ timerange }</div> </td>
				<td> <div className="marginer">{this.props.fpclass.place_name}</div> </td>
				<td className="text-center">
					<a className={"btn btn-primary reserve-btn " + disabler} onClick={this.confirmReserve}>{reserveText}</a>
				</td>
			</tr>
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
	document.getElementById('fpclasses')
)

var SearchContainer = React.createClass({
	getInitialState: function(){
		return {
			isFpclass: true,
			fpclasses: [],
			isCalendar: true,
			recursivedates_ondate_eq: LocalTime.strftime(new Date(), '%Y-%m-%d'),
			dates: [],
			searchfields: {place_name_cont_any: '', center_type_in: ''}
		}
	},
	loadClasses: function(){
		return $.post('/api/search/classes.json', { centers_slug_eq: $("#center-slug").data('url') });
	},

	reloadClasses: function(){
		return $.post('/api/search/classes.json', { recursivedates_ondate_eq: this.state.recursivedates_ondate_eq, centers_slug_eq: $("#center-slug").data('url') });
	},

	componentWillMount: function(){
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1]
			});
			this.renderCalendar();
		}.bind(this));
	},

	classesUpdater: function(){
		this.setState({
			isFpclass: true,
			isCalendar: true
		});
		
		this.reloadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1]
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

	componentDidMount: function(){
	},
	
	startSearching: function(){
		this.state.isFpclass ? this.classesUpdater() : this.studiosUpdater()
	},

	classesFetch: function(){
		this.setState({
			isFpclass: true,
			isCalendar: true
		});
		this.loadClasses().then(function(data){
			this.setState({
				fpclasses: data.filters[0],
				dates: data.filters[1]
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

	render: function(){
		var fpclasses = this.state.fpclasses.map(function(fpclass){
			return <HandleRow fpclassbase={fpclass} datebase={this.state.recursivedates_ondate_eq} />;
		}.bind(this));

		var rendercalendar = this.state.dates.map(function(date){
			return <Calendar key={date} date={date} onCalendar={this.handleCal} current_date={this.state.recursivedates_ondate_eq} />;
		}.bind(this));
		
		var classStyle = {
			display: this.state.isFpclass ? 'block' : 'none'
		};

		var calendarStyle = {
			display: this.state.isCalendar ? 'block' : 'none',
			marginBottom: '20px'
		};

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
		            <div className="table-responsive">
		            	<table className="table table-hover table-striped" id="classes-content">
			            	{ fpclasses }
			            </table>
			        </div>
		        </div>
		    </div>
		);
	}
})

var HandleRow = React.createClass({
	render: function(){
		var fpclassrow = this.props.fpclassbase.timings.map(function(time){
			return <ClassRow date={this.props.datebase} fpclass={this.props.fpclassbase} start_time={time} />;
		}.bind(this));

		return(
			<tbody id="listers">
			 {fpclassrow}
			</tbody>
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
		
		return(
			<tr>
				<td><h5>
					<a onClick={this.confirmReserve} className='blue'>{this.props.fpclass.capname}</a>
				</h5></td>
				<td> <div className="marginer">{ timerange }</div> </td>
				<td className="text-center">
					<a className="btn btn-primary reserve-btn" onClick={this.confirmReserve} >Reserve</a>
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

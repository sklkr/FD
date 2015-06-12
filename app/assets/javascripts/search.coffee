# $('.magicsuggest').magicSuggest([])
# window.search_input = document.getElementById('cities')
# # window.city_name = new google.maps.places.Autocomplete(window.search_input)###

# $('#monthly').on 'change', ->
# 	$('#studio-linker').trigger('click')
# 	return

# $('#yearly').on 'change', ->
# 	$("#class-linker").trigger("click")
# 	return

# # React Modules starting stage
# DOM = React.DOM

# # Toggle Component
# CdSwitcher = React.createClass
# 	displayName: 'cd-switcher'
# 	getInitialState: ->
# 		{
# 			centers_place_name_cont_any: ''
# 		}

# 	getStudios: ->
# 		$.ajax
# 			url: 'api/search',
# 			type: 'POST',
# 			dataType: 'JSON',
# 			contentType: 'application/json',
# 			processData: false,
# 			data: JSON.stringify({q: @state})
# 		.then (response) ->
# 			React.render(studioBox({studios: response.filters}),document.getElementById('centers-section'))
# 		.fail ->
# 			alert("Something went wrong..! Please refresh and try again")

# 	getClasses: ->
# 		$.ajax
# 			url: 'api/search/classes',
# 			type: 'POST',
# 			dataType: 'JSON',
# 			contentType: 'application/json',
# 			processData: false,
# 			data: JSON.stringify({q: @state})
# 		.then (response) ->
# 			console.log(response)
# 		.fail ->
# 			alert("Something went wrong..! Please refresh and try again")

# 	render: ->
# 		DOM.p
# 			className: 'fieldset'
# 			DOM.input
# 				type: 'radio'
# 				name: 'duration'
# 				value: 'monthly'
# 				id: 'monthly'
# 				onChange: @getClasses

# 			DOM.label
# 				htmlFor: 'monthly'
# 				"STUDIO"

# 			DOM.input
# 				type: 'radio'
# 				name: 'duration'
# 				value: 'yearly'
# 				id: 'yearly'
# 				checked: true
# 				onChange: @getStudios

# 			DOM.label
# 				htmlFor: 'yearly'
# 				"CLASSES"

# 			DOM.span
# 				className: 'cd-switch'


# # Filter form for Studio
# StudioFilterForm = React.createClass
# 	displayName: 'studio-filter-form'
# 	getInitialState: ->
# 		{
# 			place_name_cont_any: ''
# 			center_type_in: ''
# 			experiences_id_in: ''
# 		}

# 	getDefaultProps: ->
# 		experiences: {}

# 	getStudios: ->
# 		$.ajax
# 			url: 'api/search',
# 			type: 'POST',
# 			dataType: 'JSON',
# 			contentType: 'application/json',
# 			processData: false,
# 			data: JSON.stringify({q: @state})

# 	fieldChanged: (fieldName, event) ->
# 		stateUpdate = {}
# 		stateUpdate[fieldName] = event.target.value
# 		@setState(stateUpdate)

# 	render: ->
# 		DOM.form
# 			className: 'center_search'
# 			id: 'center_search'
# 			DOM.div
# 				className: 'row'
# 				DOM.div
# 					className: 'col-md-3 col-xs-12 m-bottom20'
# 					DOM.label
# 						htmlFor: 'location'
# 						'LOCATION'
# 					DOM.div
# 						{}
# 						DOM.input
# 							id: 'cities'
# 							type: 'text'
# 							name: 'place_name_cont_any'
# 							placeholder: 'Type Locality or Landmark'
# 							className: 'ui-autocomplete-input form-control form-square'
# 							value: @state.place_name_cont_any
# 							onChange: @fieldChanged.bind(null, 'place_name_cont_any')

# 				DOM.div
# 					className: 'col-md-3 col-xs-12 m-bottom20'
# 					DOM.label
# 						htmlFor: 'facilities'
# 						'ACTIVITIES'
# 					DOM.div
# 						{}
# 						DOM.select
# 							className: 'magicsuggest'
# 							onChange: @fieldChanged.bind(null, 'center_type_in')
# 							name: 'center_type_in'
# 							DOM.option
# 								value: 'Gym'
# 								'Gym'
# 							DOM.option
# 								value: 'Yoga'
# 								'Yoga'
# 							DOM.option
# 								value: 'Dance'
# 								'Dance'
# 							DOM.option
# 								value: 'Swim'
# 								'Swim'
# 							DOM.option
# 								value: 'Aerobics'
# 								'Aerobics'
# 							DOM.option
# 								value: 'Zumba'
# 								'Zumba'
# 							DOM.option
# 								value: 'Pilates'
# 								'Pilates'
# 							DOM.option
# 								value: 'Martial Arts'
# 								'Martial Arts'
# 							DOM.option
# 								value: 'Boxing'
# 								'Boxing'
# 							DOM.option
# 								value: 'Strength Training'
# 								'Strength Training'

# 				DOM.div
# 					className: 'col-md-3 col-xs-12 m-bottom20'
# 					DOM.label
# 						htmlFor: 'amenities'
# 						'AMENITIES'
# 					DOM.div
# 						{}
# 						DOM.select
# 							className: 'magicsuggest'
# 							name: 'experiences_id_in'
# 							onChange: @fieldChanged.bind(null, 'experiences_id_in')
# 							DOM.option
# 								value: '3'
# 								'Air Conditioning'
# 							DOM.option
# 								value: '6'
# 								'Change Room'
# 							DOM.option
# 								value: '2'
# 								'Four Wheeler'
# 							DOM.option
# 								value: '10'
# 								'Kids Play Area'
# 							DOM.option
# 								value: '6'
# 								'Locker'
# 							DOM.option
# 								value: '5'
# 								'Rest Room'
# 							DOM.option
# 								value: '4'
# 								'Shower'
# 							DOM.option
# 								value: '8'
# 								'Steam & Sauna'
# 							DOM.option
# 								value: '11'
# 								'Swimming pool'
# 							DOM.option
# 								value: '9'
# 								'Two Wheeler'
# 							DOM.option
# 								value: '1'
# 								'Wifi'

# 				DOM.div
# 					className: 'col-md-3 col-xs-12'
# 					DOM.label
# 						htmlFor: '&nbsp;'
# 					DOM.div
# 						{}
# 						DOM.input
# 							className: 'btn btn-default'
# 							value: 'SEARCH'
# 							onClick: @getStudios


# # Studio single box
# StudioBox = React.createClass
# 	displayName: 'studio-box'			
	
# 	getInitialState: ->
# 		{
# 			studio: {
# 				listitem: @props.studios[0].name
# 			}
# 		}
# 	render: ->
# 		DOM.div
# 			className: 'testing'
# 			for studio in @props.studios
# 				DOM.div
# 					className: 'list-item clearfix'
# 					DOM.div
# 						className: 'col-xs-12 col-sm-4 img-box'
# 						DOM.a
# 							href: "//fitnesspapa.com/details/" + studio.slug
# 							DOM.img
# 								className: 'group list-group-image img-responsive'
# 								src: "//d1djl7kr085bc1.cloudfront.net/store/" + studio.image_id
# 								''
# 					DOM.div
# 						className: 'col-xs-12 col-sm-8 cnt-box'
# 						DOM.a
# 							href: "//fitnesspapa.com/details/" + studio.slug
# 							DOM.h4
# 								className: 'group inner list-group-item-heading'
# 								studio.name
# 							DOM.p null,
# 								DOM.small
# 									className: 'm-right20'
# 									DOM.i
# 										className: 'fa fa-map-marker'
# 										"&nbsp;"
# 									DOM.span null,
# 										studio.place_name
# 							DOM.p
# 								className: 'group inner list-group-item-text'
# 								"fsdf sdaf sadfasdfas fasdfsdf"

# # Fpclass Box								
# FpclassBox = React.createClass
# 	displayName: 'Fpclassbox'

# 	getInitialState: ->
# 		{
# 			fpclasses: []
# 		}
# 	componentDidMount: ->
# 		$.post 'api/search/classes.json', ((result) ->
# 		  lastGist = result[0]
# 		  if @isMounted()
# 		    @setState
# 		      fpclasses: result.filters
# 		  return
# 		).bind(this)

# 	render: ->
# 		DOM.thead null,
# 			DOM.tr null,
# 				DOM.th null,
# 					"Center"
# 				DOM.th null,
# 					"Class"
# 				DOM.th null,
# 					"Time"
# 				DOM.th null,
# 					"Area"	
# 				DOM.th null,
# 					""
# 		DOM.tbody
# 			id: 'listers'
# 			for fpclass in @state.fpclasses		
# 				console.log(fpclass)
# 				DOM.tr null,
# 					DOM.td null,
# 						DOM.h5 null,
# 							DOM.a
# 								href: fpclass.center_path
# 								fpclass.capname
# 					DOM.td null,
# 						DOM.h5 null,
# 							DOM.a
# 								href: fpclass.center_path
# 								fpclass.centers_slug
# 					DOM.td null,
# 						LocalTime.relativeTimeAgo(new Date(new Date + 60 * 1000 * 5))
# 					DOM.td null,
# 						"center"
# 					DOM.td
# 						className: 'text-center'
# 						DOM.a
# 							className: 'btn btn-primary reserve-btn'
# 							href: fpclass.center_path
# 							"Reserve"
# 						DOM.br null,
# 							""
# 						DOM.span
# 							className: 'fp-count'
# 							fpclass.remaining_seats + "Seats left"

		
# studioFilterForm = React.createFactory(StudioFilterForm)
# cdSwitcher = React.createFactory(CdSwitcher)
# studioBox = React.createFactory(StudioBox)
# fpclassBox = React.createFactory(FpclassBox)


# ###container = document.getElementById('centers-section')
# studios = JSON.parse(container.dataset.studios)
# React.render(
# 	studioBox({studios: studios}),
# 	container
# )###

# fpcontainer = document.getElementById('classes-content')
# React.render(
# 	fpclassBox(),
# 	fpcontainer
# )

# React.render(
# 	cdSwitcher(),
# 	document.getElementById('cd-switcher')
# )

# React.render(
# 	studioFilterForm(),
# 	document.getElementById('center-search-container')
# )
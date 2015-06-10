$('.magicsuggest').magicSuggest([])
window.search_input = document.getElementById('cities')
window.city_name = new google.maps.places.Autocomplete(window.search_input)

$('#monthly').on 'change', ->
	$('#studio-linker').trigger('click')
	return

$('#yearly').on 'change', ->
	$("#class-linker").trigger("click")
	return

# React Modules starting stage
DOM = React.DOM

# Toggle Component
CdSwitcher = React.createClass
	displayName: 'cd-switcher'
	getInitialState: ->
		{
			centers_place_name_cont_any: 'sdf'
		}

	getStudios: ->
		$.ajax
			url: 'api/search',
			type: 'POST',
			dataType: 'JSON',
			contentType: 'application/json',
			processData: false,
			data: JSON.stringify({q: @state})

	getClasses: ->
		$.ajax
			url: 'api/search/classes',
			type: 'POST',
			dataType: 'JSON',
			contentType: 'application/json',
			processData: false,
			data: JSON.stringify({q: @state})

	render: ->
		DOM.p
			className: 'fieldset'
			DOM.input
				type: 'radio'
				name: 'duration'
				value: 'monthly'
				id: 'monthly'
				onChange: @getStudios

			DOM.label
				htmlFor: 'monthly'
				"STUDIO"

			DOM.input
				type: 'radio'
				name: 'duration'
				value: 'yearly'
				id: 'yearly'
				onChange: @getClasses

			DOM.label
				htmlFor: 'yearly'
				"CLASSES"

			DOM.span
				className: 'cd-switch'


# Filter form for Studio
StudioFilterForm = React.createClass
	displayName: 'studio-filter-form'
	getInitialState: ->
		{
			place_name_cont_any: ''
			center_type_in: ''
			experiences_id_in: ''
		}

	getDefaultProps: ->
		experiences: {}

	getStudios: ->
		$.ajax
			url: 'api/search',
			type: 'POST',
			dataType: 'JSON',
			contentType: 'application/json',
			processData: false,
			data: JSON.stringify({q: @state})

	fieldChanged: (fieldName, event) ->
		stateUpdate = {}
		stateUpdate[fieldName] = event.target.value
		@setState(stateUpdate)

	render: ->
		DOM.form
			className: 'center_search'
			id: 'center_search'
			DOM.div
				className: 'row'
				DOM.div
					className: 'col-md-3 col-xs-12 m-bottom20'
					DOM.label
						htmlFor: 'location'
						'LOCATION'
					DOM.div
						{}
						DOM.input
							id: 'cities'
							type: 'text'
							name: 'place_name_cont_any'
							placeholder: 'Type Locality or Landmark'
							className: 'ui-autocomplete-input form-control form-square'
							value: @state.place_name_cont_any
							onChange: @fieldChanged.bind(null, 'place_name_cont_any')

				DOM.div
					className: 'col-md-3 col-xs-12 m-bottom20'
					DOM.label
						htmlFor: 'facilities'
						'ACTIVITIES'
					DOM.div
						{}
						DOM.select
							className: 'magicsuggest'
							onChange: @fieldChanged.bind(null, 'center_type_in')
							name: 'center_type_in'
							DOM.option
								value: 'Gym'
								'Gym'
							DOM.option
								value: 'Yoga'
								'Yoga'
							DOM.option
								value: 'Dance'
								'Dance'
							DOM.option
								value: 'Swim'
								'Swim'
							DOM.option
								value: 'Aerobics'
								'Aerobics'
							DOM.option
								value: 'Zumba'
								'Zumba'
							DOM.option
								value: 'Pilates'
								'Pilates'
							DOM.option
								value: 'Martial Arts'
								'Martial Arts'
							DOM.option
								value: 'Boxing'
								'Boxing'
							DOM.option
								value: 'Strength Training'
								'Strength Training'

				DOM.div
					className: 'col-md-3 col-xs-12 m-bottom20'
					DOM.label
						htmlFor: 'amenities'
						'AMENITIES'
					DOM.div
						{}
						DOM.select
							className: 'magicsuggest'
							name: 'experiences_id_in'
							onChange: @fieldChanged.bind(null, 'experiences_id_in')
							DOM.option
								value: '3'
								'Air Conditioning'
							DOM.option
								value: '6'
								'Change Room'
							DOM.option
								value: '2'
								'Four Wheeler'
							DOM.option
								value: '10'
								'Kids Play Area'
							DOM.option
								value: '6'
								'Locker'
							DOM.option
								value: '5'
								'Rest Room'
							DOM.option
								value: '4'
								'Shower'
							DOM.option
								value: '8'
								'Steam & Sauna'
							DOM.option
								value: '11'
								'Swimming pool'
							DOM.option
								value: '9'
								'Two Wheeler'
							DOM.option
								value: '1'
								'Wifi'

				DOM.div
					className: 'col-md-3 col-xs-12'
					DOM.label
						htmlFor: '&nbsp;'
					DOM.div
						{}
						DOM.input
							className: 'btn btn-default'
							value: 'SEARCH'
							onClick: @getStudios



# Studio index div
StudioIndexBoxes = React.createClass
	displayName: 'studio-boxes'
	
	getInitialState: ->
		{
			studios: [
				{id: 1, name: 'newrelic', src: 'https://fitnesspapa.com/assets/bg-1.png'},
				{id: 2, name: 'newrelicv2', src: 'https://fitnesspapa.com/assets/bg-1.png'}
			]
		}

	render: ->
		DOM.div null,
			for person in @state.studios
				studioIndexBox
					studio: person
		

StudioIndexBox = React.createClass
	displayName: 'studio-box'			
	
	render: ->
		DOM.div
			className: 'list-item clearfix'
			DOM.div
				className: 'col-xs-12 col-sm-4 img-box'
				DOM.a
					href: @props.person.src
					DOM.img
						alt: ''
						className: 'group list-group-image img-responsive'
						src: @props.person.src
			# DOM.div
			# 	className: 'col-xs-12 col-sm-8 cnt-box'
			# 	DOM.a
			# 		href: ''
			# 		DOM.h4
			# 			className: 'group inner list-group-item-heading'
			# 			@props.person.name
			# 		DOM.p null,
			# 			DOM.small
			# 				className: 'm-right20'
			# 				DOM.i
			# 					className: 'fa fa-map-marker'
			# 					"&nbsp;"
			# 				DOM.span null,
			# 					@props.person.name
			# 		DOM.p
			# 			className: 'group inner list-group-item-text'
			# 			@props.person.name
					

studioFilterForm = React.createFactory(StudioFilterForm)
cdSwitcher = React.createFactory(CdSwitcher)
studioIndexBox = React.createFactory(StudioIndexBox)
studioIndexBoxes = React.createFactory(StudioIndexBoxes)

React.render(
	cdSwitcher(),
	document.getElementById('cd-switcher')
)

React.render(
	studioFilterForm(),
	document.getElementById('center-search-container')
)

React.render(
	studioIndexBoxes(),
	document.getElementById('centers-section')
)

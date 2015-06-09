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

	getStudios: (event) ->
		window.sidd = this
		window.sid = event
		@setState(place_name_cont_any: event.target.value)
		$.ajax
			url: 'api/search',
			type: 'POST',
			dataType: 'JSON',
			contentType: 'application/json',
			processData: false,
			data: JSON.stringify({q: @state})

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
							onChange: @getStudios

				DOM.div
					className: 'col-md-3 col-xs-12 m-bottom20'
					DOM.label
						htmlFor: 'facilities'
						'ACTIVITIES'
					DOM.div
						{}
						DOM.select
							className: 'magicsuggest'
							onChange: @getStudios
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


studioFilterForm = React.createFactory(StudioFilterForm)

cdSwitcher = React.createFactory(CdSwitcher)

React.render(
	cdSwitcher(),
	document.getElementById('cd-switcher')
)

React.render(
	studioFilterForm(),
	document.getElementById('center-search-container')
)

Wmsb.Models.BusAssignment = Backbone.Model.extend
  initialize: (attributes) ->
    @set 'latLng', new google.maps.LatLng(@get('latitude'), @get('longitude'))
    @set 'history', _.map(attributes.history, (point) ->
      new google.maps.LatLng point.lat, point.lng
    )

    arrow =
      path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW

    @set 'path', new google.maps.Polyline
      path: @get 'history'
      icons: [
        {
          icon: arrow
          offset: '100%'
        }
      ]

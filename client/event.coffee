Template.event.volunteers = () ->
  event = getEventData()
  spots = event.volunteers
  while(spots.length < event.num_slots)
    spots.push({profile: { picture: "http://newton.physics.uiowa.edu/~sbaalrud/empty_profile.gif"}})
  return spots

Template.event.eventData = () ->
  getEventData()

Template.event.attending = () ->
  event = getEventData()
  isAttending = false
  _(event.volunteers).each( (volunteer) ->
    if(volunteer._id == Meteor.user()._id)
      isAttending = true
  )
  return isAttending

Template.event.events({
  'click .signup': () ->
    eventId = getEventData()._id
    Events.update({_id:eventId}, $push:{volunteers:Meteor.user()})
  'click .unsignup': () ->
    eventId = getEventData()._id
    Events.update({_id:eventId}, $pull:{volunteers:Meteor.user()})
})

getEventData = () ->
  url = Backbone.history.fragment
  eventId = url.slice(url.indexOf('/')+1)
  Events.findOne({_id:eventId})

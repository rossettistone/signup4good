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

Template.event.slotsAvailable = () ->
  event = getEventData()
  return event.num_slots > event.volunteers.length

Template.event.events({
  'click .orglink': () ->
    event = getEventData()
    orgId = event.org_id
    router.navigate 'organization/'+orgId, {trigger: true}
  'click .signup': () ->
    event = getEventData()
    eventId = event._id
    Events.update({_id:eventId}, $push:{volunteers:Meteor.user()})
    Meteor.call('sendEventRegEmail', Meteor.user().services.facebook.email, event.event_name)
  'click .unsignup': () ->
    event = getEventData()
    eventId = event._id
    Events.update({_id:eventId}, $pull:{volunteers:Meteor.user()})
    Meteor.call('sendEventUnregEmail', Meteor.user().services.facebook.email, event.event_name)
});

Template.messages.events({
  'click .postmessage': () ->
    eventId = getEventData()._id
    message = $('.messagecontent').val()
    Events.update({_id:eventId}, $push:{messages:{user:Meteor.user(), content:message}})
})

Template.messages.allMessages = () ->
  eventId = getEventData()._id
  return Events.findOne({_id:eventId}).messages

getEventData = () ->
  # TODO: this is firing too soon if the app loads on /events page
  # url = Backbone.history.fragment
  # eventId = url.slice(url.indexOf('/')+1)
  eventId = Session.get('eventId')
  Events.findOne({_id:eventId})

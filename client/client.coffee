Template.homePage.getUsers = () ->
  # database query here
  allUsers = Meteor.users.find().fetch();
  return _(allUsers).map( (user) ->
    return user
  )

Template.homePage.getOrganizations = () ->
  Organizations.find({}).fetch()

Template.homePage.getEvents = (skip, limit) ->
  Events.find({}, {skip:skip, limit:limit}).fetch()

Template.topnav.events({
  'click .home': () ->
    router.navigate 'home', {trigger: true}
  'click .register': () ->
    $('.signup').modal()
  'click .sign-out': () ->
    router.navigate 'sign_out', {trigger: true}
})

Template.front_event.events({
  'click .btn': () ->
    router.navigate 'event/'+this._id, {trigger: true},
})

Template.router.showHomePage = () ->
  Session.get('currentPage') == 'homePage'

Template.router.showRegistrationPage = () ->
  Session.get('currentPage') == 'registrationPage'

Template.router.showEventPage = () ->
  Session.get('currentPage') == 'eventPage'

Template.event.volunteers = () ->
  event = getEventData()
  spots = event.volunteers
  while(spots.length < event.num_slots)
    spots.push({name: "Wally"})
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

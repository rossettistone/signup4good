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
  url = Backbone.history.fragment
  eventId = url.slice(url.indexOf('/')+1)
  event = Events.findOne({_id:eventId})
  event.volunteers
  # return [{name: "Bob"},{name: "Crissy"},{name: "Larry"},{name: "Bianca"},{name: "Miles"},{name: "Bob"},{name: "Bob"},{name: "Bob"},{name: "Crissy"},{name: "Larry"},{name: "Bianca"},{name: "Miles"},{name: "Bob"},{name: "Bob"}]

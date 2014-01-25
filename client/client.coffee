Template.homePage.users = () ->
  # database query here
  allUsers = Meteor.users.find().fetch();
  return _(allUsers).map( (user) ->
    return user
  )

Template.homePage.organizations = () ->
  Organizations.find({}).fetch()

Template.homePage.events = () ->
  Events.find({}).fetch()

Template.topnav.events({
  'click .home': () ->
    router.navigate 'home', {trigger: true}
  'click .register': () ->
    router.navigate 'registration', {trigger: true}
})


Template.router.showHomePage = () ->
  Session.get('currentPage') == 'homePage'

Template.router.showRegistrationPage = () ->
  Session.get('currentPage') == 'registrationPage'

Template.router.showEventPage = () ->
  Session.get('currentPage') == 'eventPage'

Template.event.volunteers = () ->
  return [{name: "Bob"},{name: "Crissy"},{name: "Larry"},{name: "Bianca"},{name: "Miles"},{name: "Bob"},{name: "Bob"},{name: "Bob"},{name: "Crissy"},{name: "Larry"},{name: "Bianca"},{name: "Miles"},{name: "Bob"},{name: "Bob"}]


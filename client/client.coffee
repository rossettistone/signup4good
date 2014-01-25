
Template.content.users = () ->
  # database query here
  allUsers = Meteor.users.find().fetch();
  return _(allUsers).map( (user) ->
    return user
  )

Template.content.organizations = () ->
  # database query here
  Organizations.find({}).fetch()
  # return "Welcome to signup."

Template.content.events = () ->
  # database query here
  return "Welcome to signup."

Template.topnav.events({
  'click .getstarted': () ->
    Session.set 'registration', true
})

Template.content.showRegistration = () ->
  Session.get 'registration'

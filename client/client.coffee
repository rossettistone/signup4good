
Template.content.users = () ->
  # database query here
  allUsers = Meteor.users.find().fetch();
  return _(allUsers).map( (user) ->
    return user
  )

Template.content.organizations = () ->
  Organizations.find({}).fetch()

Template.content.events = () ->
  Events.find({}).fetch()

Template.topnav.events({
  'click .getstarted': () ->
    Session.set 'registration', true
})

Template.content.showRegistration = () ->
  Session.get 'registration'

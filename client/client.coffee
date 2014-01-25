Template.content.users = () ->
    # database query here
    allUsers = Meteor.users.find().fetch();
    return _(allUsers).map( (user) ->
      return user
    )

Template.content.organizations = () ->
    # database query here
    return "Welcome to signup."

Template.content.events = () ->
    # database query here
    return "Welcome to signup."

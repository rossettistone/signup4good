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
    $('.signup-modal').modal()
  'click .sign-out': () ->
    router.navigate 'sign_out', {trigger: true}
})

Template.front_event.events({
  'click .btn': () ->
    router.navigate 'event/'+this._id, {trigger: true},
})

Template.router.events({
  'click #login-buttons': () ->
    radio = $('input[name="signup-type"]:checked')
    radio_text = radio.parent().text()
    login_text = $('#login-buttons').text()
    if(radio_text.toLowerCase().indexOf('organization') != -1 &&
       login_text.toLowerCase().indexOf('facebook') != -1)
      form = radio.closest('form')
      org_html = ('<form id="org-form">\n' +
       '<input class="name" placeholder="Organization name">\n' +
       '<input class="number" placeholder="Phone number">\n' +
       '<input id="org-form-submit" type="submit">\n' +
       '</form>\n')
      form.append(org_html)
    else
      $('#org-form').remove()
    # $(radio.closest('.modal')).modal('hide')

  'click  #org-form-submit': (e) ->
    e.preventDefault()
    org_name = $('#org-form > .name').val()
    phone_number = $('#org-form > .number').val()
    
    $('.modal').modal('hide')
})

Template.router.showHomePage = () ->
  Session.get('currentPage') == 'homePage'

Template.router.showRegistrationPage = () ->
  Session.get('currentPage') == 'registrationPage'

Template.router.showEventPage = () ->
  Session.get('currentPage') == 'eventPage'

Template.router.showOrganizationPage = () ->
  Session.get('currentPage') == 'organizationPage'

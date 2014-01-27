Template.homePage.getUsers = () ->
  # database query here
  allUsers = Meteor.users.find().fetch();
  return _(allUsers).map( (user) ->
    return user
  )

Template.homePage.getOrganizations = () ->
  return Organizations.find({}).fetch()

Template.homePage.getEvents = (skip, limit) ->
  Events.find({}, {skip:skip, limit:limit}).fetch()

Template.topnav.events({
  'click .home': () ->
    router.navigate 'home', {trigger: true}
  'click .register': () ->
    $('.signup-modal').modal()
  'click .sign-out': () ->
    router.navigate 'sign_out', {trigger: true}
  'click .aboutus': () ->
    router.navigate 'aboutus', {trigger: true}
  'click .homepageLink': () ->
    router.navigate 'home', {trigger: true}
})

Template.front_event.events({
  'click .btn': () ->
    router.navigate 'event/'+this._id, {trigger: true}
})

Template.homePage.events({
  'click .orglink': () ->
    router.navigate 'organization/'+this._id, {trigger: true}
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
       '<input class="address" placeholder="Address">\n' +
       '<input id="org-form-submit" type="submit">\n' +
       '</form>\n')
      form.append(org_html)
    else
      $('#org-form').remove()
      $(radio.closest('.modal')).modal('hide')

  'click #org-form-submit': (e) ->
    console.log('submit clicked')

    e.preventDefault()
    org_name = $('#org-form > .name').val()
    phone_number = $('#org-form > .number').val()
    address = $('#org-form > .address').val()
    new_org = {
      'point_of_contact':'Max Org',
      address:'555 Foo Lane',
      email:'foo@bar.org',
      phone:'555-555-5555',
      description:'We are an awesome organization that does good things.',
      waitlist:[],
      event_ids:[]
    }
    new_org.org_name = org_name
    new_org.phone = phone_number
    new_org.address = address
    id_ = Organizations.insert(new_org)
    $('.modal').modal('hide')
    console.log('id:', id_)
    router.navigate('organization/' + id_, {trigger:true})
})

Template.router.showHomePage = () ->
  Session.get('currentPage') == 'homePage'

Template.router.showRegistrationPage = () ->
  Session.get('currentPage') == 'registrationPage'

Template.router.showEventPage = () ->
  Session.get('currentPage') == 'eventPage'

Template.router.showOrganizationPage = () ->
  Session.get('currentPage') == 'organizationPage'

Template.router.showAboutUs = () ->
  Session.get('currentPage') == 'aboutUsPage'

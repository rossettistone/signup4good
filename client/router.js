var Router = Backbone.Router.extend({
  routes: {
    '':                 'home', //this will be http://your_domain/
    'home':             'home', //this will be http://your_domain/
    'registration':     'registration',  // http://your_domain/registration
    'event/:id':        'event',
    'organization/:id':        'organization',
    'sign_out':         'sign_out'
  },

  home: function () {
    // Your homepage code
    Session.set('currentPage', 'homePage');
  },

  event: function (id) {
    // Registration page/modal
    Session.set('currentPage', 'eventPage');
    Session.set('eventId', id);
  },

  organization: function (id) {
    // Registration page/modal
    Session.set('currentPage', 'organizationPage');
    Session.set('organizationId', id);
  },

  sign_out: function() {
    Meteor.logout()
  }
});

router = new Router();

Meteor.startup(function () {
  Backbone.history.start({pushState: true});
});

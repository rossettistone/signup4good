var Router = Backbone.Router.extend({
  routes: {
    '':                 'home', //this will be http://your_domain/
    'home':             'home', //this will be http://your_domain/
    'registration':     'registration',  // http://your_domain/registration
    'event/:id':        'event'
  },

  home: function () {
    // Your homepage code
    Session.set('currentPage', 'homePage');
  },

  registration: function () {
    // Registration page/modal
    Session.set('currentPage', 'registrationPage');
  },

  event: function (id) {
    // Registration page/modal
    Session.set('currentPage', 'eventPage');
    Session.set('eventId', id);
  }

});

router = new Router();

Meteor.startup(function () {
  Backbone.history.start({pushState: true});
});
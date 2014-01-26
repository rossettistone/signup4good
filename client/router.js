var Router = Backbone.Router.extend({
  routes: {
    "":                 "home", //this will be http://your_domain/
    "home":             "home", //this will be http://your_domain/
    "registration":     "registration",  // http://your_domain/registration
    "login":            "login",
    "sign_out":         "sign_out"
  },

  home: function() {
    // Your homepage code
    Session.set('currentPage', 'homePage');
  },

  registration: function() {
    // Registration page/modal
    Session.set('currentPage', 'registrationPage');
  },

  login: function() {
    // Registration page/modal
    Session.set('currentPage', 'loginPage');
  },

  sign_out: function() {
    Meteor.logout()
  }
});

router = new Router;

Meteor.startup(function () {
  Backbone.history.start({pushState: true});
});

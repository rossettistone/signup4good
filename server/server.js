Accounts.onCreateUser(function(options, user) {
    if (options.profile) {
        options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
        user.profile = options.profile;
    }
    return user;
});

function default_event(org_id) {
  return {
    name:'Best Event Ever', num_slots:10, type:'management',
    is_one_time:false, address:'88 Baz Boulevard', org_id:org_id
  }
}

Meteor.startup(function () {
  Orgs = new Meteor.Collection("orgs");
  Events = new Meteor.Collection("events");

  // Organizations can create accounts
  //   Org name
  //   Point of Contact Name
  //   Physical Address
  //   Email Address
  //   Phone
  //   Waitlist (cap?)

  // Event
  //   -Number of slots
  //   -Type of activity
  //   -One-time or repeating
  //   -Location


  // code to run on server at startup
  if (Organization.find().count() === 0) {

    function default_org() {
      return  {
        'point_of_contact':'Max Org',
        address:'555 Foo Lane', email:'foo@bar.org', phone:'555-555-5555',
        waitlist:[], event_ids:[]}
      }
    }

    default_event = {
      name:'Best Event Ever', num_slots:10, type:'management',
      is_one_time:false, address:'88 Baz Boulevard', org_id:org_id}

    var default_events = []
    var names = ['Default Event 1', 'Default Event 2']


    var names = ["Foo Org", "Bar Org", "Baz Org"]
    for (var i = 0; i < names.length; i++) {
      default_org['name'] = names[i]

      Event.insert(default_org)
    }

    var names = ["Foo Org", "Bar Org", "Baz Org"];
    for (var i = 0; i < names.length; i++) {
      default_org['name'] = names[i]
      Organization.insert(default_org)
    }
  }


});

Accounts.onCreateUser(function(options, user) {
    if (options.profile) {
        options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
        user.profile = options.profile;
    }
    return user;
});

function create_event(org_id) {
  return {
    event_name:'best event ever',
    num_slots:10, type:'management', is_one_time:true, org_id:[org_id]
  }
}

Meteor.startup(function () {
  Org = new Meteor.Collection("orgs");
  Event = new Meteor.Collection("events");

  // Organizations can create accounts
  //   Email Address
  //   Phone
  //   Waitlist (cap?)

  // Event
  //   -Number of slots
  //   -Type of activity
  //   -One-time or repeating
  //   -Location

  // code to run on server at startup
  if (Org.find().count() === 0) {
    default_org = {
      'point_of_contact':'Max Org',
      address:'555 Foo Lane', email:'foo@bar.org', phone:'555-555-5555',
      waitlist:[], event_ids:[]
    }

    var org_names = ['Foo Org', 'Bar Org', 'Baz Org'];
    for (var i = 0; i < org_names.length; i++) {
      default_org['name'] = org_names[i]
      Org.insert(default_org, function (err, org_id) {
        var event_names = ['Foo Event', 'Bar Event', 'Baz Event']
        for(var i = 0; i < event_names; i++) {
          new_event = create_event(org_id)
          new_event.name = event_names[i]
          Event.insert(new_event)
          Org.update(
            {_id:org_id}, 
            {$push:{event_ids:new_event._id}})
        }
      })
    }
  }

  // if (Volunteer.find().count() === 0) {
  //   default_volunteer = {
  //     'name':'Bob Volun',
  //     address:'777 Bar Road', email:'bar@volun.com', phone:'555-555-5555',
  //     waitlist:[]}

  //   var names = ["Foo Org", "Bar Org", "Baz Org"];
  //   for (var i = 0; i < names.length; i++) {
  //     default_org['name'] = names[i]
  //     Volunteer.insert(default_org)
  //   }
  // }
});

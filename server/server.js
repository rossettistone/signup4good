process.env.MAIL_URL = "smtp://signup4good:signup4good@smtp.sendgrid.net:465";

Accounts.onCreateUser(function(options, user) {
    if (options.profile) {
        options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
        user.profile = options.profile;
    }

    Email.send({from:'info@signup4good.com',
                to:[user.services.facebook.email,'mark.a.rossetti@gmail.com'],
                subject:'Welcome to Sign Up for Good!',
                text:'Thanks for signing up. It\'s time to get volunteering!'});

    return user;
});

function create_event(org_id) {
  image_names = [
    'kids.jpg', 'ladies.jpg', 'pantry.jpg', 'plants.jpg', 'plants.jpg',
    'tutor.jpg', 'yard.jpg']

  return {
    event_name:'best event ever',
    num_slots:10, type:'management', is_one_time:true, org_id:[org_id],
    description:'This is a test description.  It continues for some time.',
    image_name:image_names[Math.floor(Math.random() * image_names.length)],
    user_ids:[]
  }
}

Meteor.startup(function () {

  // Organizations can create accounts
  //   Email Address
  //   Phone
  //   Waitlist (cap?)

  // Event
  //   -Number of slots
  //   -Type of activity
  //   -One-time or repeating
  //   -Location

  // Organizations.remove({})
  // Events.remove({})

  var event_names = {
    'Foo Org':['Foo Event', 'Bar Event', 'Baz Event'],
    'Color Org':['Red Event', 'Blue Event', 'Green Event'],
    'Shape Org':['Square event', 'Triangle event', 'circle event']
  }

  // code to run on server at startup
  if (Organizations.find().count() === 0) {
    default_org = {
      'point_of_contact':'Max Org',
      address:'555 Foo Lane', email:'foo@bar.org', phone:'555-555-5555',
      waitlist:[], event_ids:[]
    }

    _(Object.keys(event_names)).each(function (org_name) {
      default_org.org_name = org_name
      Organizations.insert(default_org, function (err, org_id) {
        _(event_names[org_name]).each(function (event_name) {
          new_event = create_event(org_id)
          new_event.event_name = event_name
          Events.insert(new_event)
          Organizations.update(
            {_id:org_id},
            {$push:{event_ids:new_event._id}})
        })
      })
    })
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

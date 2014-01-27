Template.organization.organizationData = function () {
  var orgId = getOrgData()._id;
  return Organizations.findOne({_id: orgId});
};

Template.organization.getEvents = function () {
  var orgId = getOrgData()._id;
  var eventIds = Organizations.findOne({_id: orgId}).event_ids;
  var allEvents = _(eventIds).map(function (id) {
    return Events.findOne({_id: id});
  });
  return allEvents;
};

Template.createEvent.events({
  'click .btn-primary': function (e) {
    e.preventDefault();
    var orgId = getOrgData()._id;
    var eventname = $('.form-eventname').val();
    var eventtype = $('.form-eventtype').val();
    var date = $('.form-date').val();
    var description = $('.form-description').val();
    var numattendees = $('.form-numattendees').val().toString();

    // create a new event record
    var newEvent = Events.insert({
      event_name: eventname,
      num_slots: numattendees,
      type: eventtype,
      is_one_time: true,
      org_id: orgId,
      description: description,
      image_name: 'test.jpg',
      volunteers: []
    });

    // add the event to the organization's record
    Organizations.update(
      {_id:orgId},
      {$push:{event_ids:newEvent._id}
    });
  }
})

function getOrgData () {
  // TODO: this is firing too soon if the app loads on /events page
  // var url = Backbone.history.fragment;
  // var orgId = url.slice(url.indexOf('/')+1);
  var orgId = Session.get('organizationId');
  return Organizations.findOne({_id:orgId});
};

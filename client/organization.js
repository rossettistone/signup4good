Template.organization.organizationData = function () {
  orgId = getOrgData()._id;
  Organizations.findOne({_id: orgId});
};

Template.organization.getEvents = function () {
  orgId = getOrgData()._id;
  eventIds = Organizations.findOne({_id: orgId}).event_ids;
  _(eventIds).map(function (id) {
    return Events.findOne({_id: id});
  });
};

function getOrgData () {
  // TODO: this is firing too soon if the app loads on /events page
  url = Backbone.history.fragment
  orgId = url.slice(url.indexOf('/')+1)
  return Organizations.findOne({_id:orgId})
};

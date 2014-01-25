Accounts.onCreateUser(function(options, user) {
  if (options.profile) {
      options.profile.picture = getFbPicture(user.services.facebook.accessToken);
      user.profile = options.profile;
  }
  return user;
});

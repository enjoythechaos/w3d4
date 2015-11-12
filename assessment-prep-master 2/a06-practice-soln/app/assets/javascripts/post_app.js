window.PostApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new PostApp.Routers.Router({
      $rootEl: $("#content"),
      posts: PostApp.Collections.posts
    });
    Backbone.history.start();
  }
};

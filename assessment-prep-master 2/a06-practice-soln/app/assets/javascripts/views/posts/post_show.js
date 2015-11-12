PostApp.Views.PostShow = Backbone.View.extend({
  template: JST["posts/show"],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var renderedContent = this.template({
      post: this.model
    });
    this.$el.html(renderedContent);
    return this;
  }
});

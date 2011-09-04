$(function(){

  window.Holding = Backbone.Model.extend({
    url:"/trackers",
  });

  window.HoldingView = Backbone.View.extend({
    el: $("#new_holding"),
    events: {
      "click .click" : "submit"
    },
    initialize: function(){
      this.model.view = this;
    },
    submit: function(){
      this.model.save({content: this.serialize()});
    },
    serialize : function() {
      return {
        shares: this.$("#holding_shares").val(),
        ticker_id: this.$("#holding_ticker").val()
      };
    }
  });

});

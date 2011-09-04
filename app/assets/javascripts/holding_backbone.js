$(function(){

  window.Buy = Backbone.Model.extend({
    url:"/buys",
  });

  window.BuyView = Backbone.View.extend({
    el: $("#new_buy"),
    events: {
      "click .click" : "submit"
    },
    initialize: function(){
      this.model.view = this;
    },
    submit: function(){
      this.model.save({content: this.serialize()});
      this.model = new Buy;
    },
    serialize : function() {
      return {
        shares: this.$("#buy_shares").val(),
        ticker_id: this.$("#buy_ticker").val()
      };
    }
  });

  window.Sell = Backbone.Model.extend({
    url:"/sells",
  });

  window.SellView = Backbone.View.extend({
    el: $("#new_sell"),
    events: {
      "click .click" : "submit"
    },
    initialize: function(){
      this.model.view = this;
    },
    submit: function(){
      this.model.save({content: this.serialize()});
      this.model = new Sell;
    },
    serialize : function() {
      return {
        shares: this.$("#sell_shares").val(),
        ticker_id: this.$("#sell_ticker").val()
      };
    }
  });

});

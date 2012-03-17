class window.AddStockHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          StockHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#stock_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#stock_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#stock_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#stock_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#stock_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

class window.AddFundHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          FundHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        fund_holding: {
          fund_ticker_id: this.$("#fund_holding_fund_ticker_id").val(),
          starting_units: this.$("#fund_holding_starting_units").val(),
          starting_price: this.$("#fund_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#fund_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#fund_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#fund_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#fund_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#fund_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

class window.AddEtfHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          EtfHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        etf_holding: {
          etf_ticker_id: this.$("#etf_holding_etf_ticker_id").val(),
          starting_shares: this.$("#etf_holding_starting_shares").val(),
          starting_price: this.$("#etf_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#etf_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#etf_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#etf_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#etf_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#etf_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

class window.AddBondHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          BondHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#stock_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#stock_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#stock_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#stock_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#stock_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

class window.AddCdHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          CdHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#stock_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#stock_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#stock_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#stock_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#stock_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

class window.AddStockHoldingView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          StockHoldings.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        stock_holding: {
          stock_ticker_id: this.$("#stock_holding_stock_ticker_id").val(),
          starting_shares: this.$("#stock_holding_starting_shares").val(),
          starting_price: this.$("#stock_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#stock_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#stock_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#stock_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#stock_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#stock_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }


class window.AddPortfolioView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          Portfolios.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        portfolio: {
          name: this.$("#portfolio_name").val(),
          portfolio_plan_id: this.$("#portfolio_portfolio_plan").val(),
          portfolio_strategy_id: this.$("#portfolio_portfolio_strategy").val()
        }
      }




#bond

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
        bond_holding: {
          name: this.$("#bond_holding_name").val(),
          cusip: this.$("#bond_holding_cusip").val(),
          purchase_price: this.$("#bond_holding_purchase_price").val(),
          coupon: this.$("#bond_holding_coupon").val(),
          starting_quantity: this.$("#bond_holding_starting_quantity").val(),
          frequency: this.$("#bond_holding_frequency").val(),
          face_value: this.$("#bond_holding_face_value").val(),
          expected_yield: this.$("#bond_holding_expected_yield").val(),
          'purchased_at(1i)': this.$("#bond_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#bond_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#bond_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#bond_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#bond_holding_purchased_at_5i").val(),
          'matures_at(1i)': this.$("#bond_holding_matures_at_1i").val(),
          'matures_at(2i)': this.$("#bond_holding_matures_at_2i").val(),
          'matures_at(3i)': this.$("#bond_holding_matures_at_3i").val(),
          'matures_at(4i)': this.$("#bond_holding_matures_at_4i").val(),
          'matures_at(5i)': this.$("#bond_holding_matures_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }




  #CD

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
        cd_holding: {
          name: this.$("#cd_holding_name").val(),
          cusip: this.$("#cd_holding_cusip").val(),
          purchase_price: this.$("#cd_holding_purchase_price").val(),
          coupon: this.$("#cd_holding_coupon").val(),
          starting_quantity: this.$("#cd_holding_starting_quantity").val(),
          frequency: this.$("#cd_holding_frequency").val(),
          face_value: this.$("#cd_holding_face_value").val(),
          expected_yield: this.$("#cd_holding_expected_yield").val(),
          'purchased_at(1i)': this.$("#cd_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#cd_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#cd_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#cd_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#cd_holding_purchased_at_5i").val(),
          'matures_at(1i)': this.$("#cd_holding_matures_at_1i").val(),
          'matures_at(2i)': this.$("#cd_holding_matures_at_2i").val(),
          'matures_at(3i)': this.$("#cd_holding_matures_at_3i").val(),
          'matures_at(4i)': this.$("#cd_holding_matures_at_4i").val(),
          'matures_at(5i)': this.$("#cd_holding_matures_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }

  #ETF

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
          starting_units: this.$("#etf_holding_starting_units").val(),
          starting_price: this.$("#etf_holding_starting_price").val(),
          'purchased_at(1i)': this.$("#etf_holding_purchased_at_1i").val(),
          'purchased_at(2i)': this.$("#etf_holding_purchased_at_2i").val(),
          'purchased_at(3i)': this.$("#etf_holding_purchased_at_3i").val(),
          'purchased_at(4i)': this.$("#etf_holding_purchased_at_4i").val(),
          'purchased_at(5i)': this.$("#etf_holding_purchased_at_5i").val(),
          portfolio_id: @model.get('portfolio_id')
        }
      }




  #fund

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


  #multi

class window.AddMultiHoldingView extends Backbone.View

    el: '#facebox'

    submit: =>
      @model.save(this.serialize(),
          { success : (model, resp)->
            MultiHoldings.add(model)
          }
      );

    serialize: =>
      return {
          authenticity_token: this.$("input[name=authenticity_token]").val(),
          multi_holding: {
            name: this.$("#multi_holding_name").val(),
            portfolio_id: @model.get('portfolio_id')
          }
        }




#stock

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



$ ->

  $('.add-holding').live('click', (e) ->
    portfolio = Portfolios.get($(@).attr('data-portfolio-id'))
    securityName = $(@).attr('data-security-name')
    className = capitaliseFirstLetter(securityName)+'HoldingModel'
    viewName = 'Add'+capitaliseFirstLetter(securityName)+'HoldingView'

    $.facebox({div:'#add-'+securityName+'-form'});

    $('#facebox .create_link').click( ->
      holding = new window[className]({portfolio_id:portfolio.id});
      view = new window[viewName]({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );




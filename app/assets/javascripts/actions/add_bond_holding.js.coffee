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


$ ->

  $('.add-cd').live('click', (e) ->
    portfolio = Portfolios.get($(this).attr('data-portfolio-id'))

    $.facebox({div:'#add-cd-form'});

    $('#facebox .create_link').click( ->
      holding = new CdHoldingModel({portfolio_id:portfolio.id});
      view = new AddCdHoldingView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );
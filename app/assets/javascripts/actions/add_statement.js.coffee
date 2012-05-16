
#bond

class window.AddMultiStatementView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          MultiStatements.add(model)
        }
    );

  serialize: =>
    return {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        multi_statement: {
          fund_ticker_id: this.$("#multi_statement_fund_tracker_id").val(),
          contributions: this.$("#multi_statement_contributions").val(),
          starting_balance: this.$("#multi_statement_starting_balance").val(),
          ending_balance: this.$("#multi_statement_ending_balance").val(),
          multi_holding_id: @model.get('holding_id'),
          'started_on(1i)': this.$("#bond_holding_started_on_1i").val(),
          'started_on(2i)': this.$("#bond_holding_started_on_2i").val(),
          'started_on(3i)': this.$("#bond_holding_started_on_3i").val(),
          'started_on(4i)': this.$("#bond_holding_started_on_4i").val(),
          'started_on(5i)': this.$("#bond_holding_started_on_5i").val(),
          'ended_on(1i)': this.$("#bond_holding_ended_on_1i").val(),
          'ended_on(2i)': this.$("#bond_holding_ended_on_2i").val(),
          'ended_on(3i)': this.$("#bond_holding_ended_on_3i").val(),
          'ended_on(4i)': this.$("#bond_holding_ended_on_4i").val(),
          'ended_on(5i)': this.$("#bond_holding_ended_on_5i").val()
        }
      }


$ ->

  $('.add-multi-statement').live('click', (e) ->
    holding = MultiHoldings.get($(@).attr('data-holding-id'))

    $.facebox({div:'#add-multi-statement-form'});

    $('#facebox .create_link').click( ->
      holding = new MultiStatementModel({holding_id:holding.id});
      view = new AddMultiStatementView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );
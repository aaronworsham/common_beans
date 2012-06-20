
class window.AddMultiStatementView extends Backbone.View

  el: '#facebox'

  submit: =>
    @model.save(this.serialize(),
        { success : (model, resp)->
          MultiStatements.add(model)
        }
    );

  serialize: =>
    params = {
        authenticity_token: this.$("input[name=authenticity_token]").val(),
        multi_statement: {
          fund_ticker_id: this.$("#multi_statement_fund_tracker_id").val(),
          contributions: this.$("#multi_statement_contributions").val(),
          starting_balance: this.$("#multi_statement_starting_balance").val(),
          started_on: this.$("input[name=started_on]").val(),
          ending_balance: this.$("#multi_statement_ending_balance").val(),
          ended_on: this.$("input[name=ended_on]").val(),
          multi_holding_id: @model.get('holding_id'),
          multi_statement_allocations_attributes: []
        }
      }
    for fund in $('#facebox .multi_statement_fund_form')
      do (fund) ->
        console.log(fund)
        id = $(fund).attr('data-form-id')
        params['multi_statement']['multi_statement_allocations_attributes'].push({
          fund_ticker_id : $(fund).find("#fund_"+id+"_ticker_id").val(),
          allocation_percentage : $(fund).find("#fund_"+id+"_allocation_percentage").val()
        })
    console.log(params)
    return params


$ ->

  $('.add-multi-statement').live('click', (e) ->
    holding = MultiHoldings.get($(@).attr('data-holding-id'))

    $.facebox({div:'#add-multi-statement-form'});
    $("#facebox .date_picker").datepicker();
    $('#facebox .create_link').click( ->
      holding = new MultiStatementModel({holding_id:holding.id});
      view = new AddMultiStatementView({model:holding});
      view.submit();
      $(document).trigger('close.facebox')
    );


  );

  $('#facebox .add_multi_statement_fund').live('click',(e) ->
    next_id = $('#facebox .multi_statement_fund_form').size()
    elem = ich.add_multi_statement_fund_template({id: next_id});
    $('#facebox #multi_statement_funds').append(elem);

  )
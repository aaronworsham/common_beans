class window.ProfileTrustView extends Backbone.View

  tagName: "tr"

  submit: =>
    @model.save(this.serialize());

  serialize: =>
    return {
      authenticity_token: $("meta[name='csrf-token']").attr('content')
    }

  render: ->
    elem = $(@el).append(ich.trust_template(@model.toJSON()));
    $(elem).hide();
    $(".trust_table").append(elem);
    $(elem).fadeIn("slow");


class window.ProfileTrustedByView extends Backbone.View

  tagName: "tr"

  submit: =>
    @model.save(this.serialize());

  serialize: =>
    return {
      authenticity_token: $("meta[name='csrf-token']").attr('content')
    }

  render: ->
    elem = $(@el).append(ich.trusted_by_template(@model.toJSON()));
    $(elem).hide();
    $(".trusted_by_table").append(elem);
    $(elem).fadeIn("slow");
describe "A jQuery ajax test", ->
  it "should make AJAX request", ->
    resp = ->
      $.ajax
        type: "GET"
        url: "/"
        contentType: "application/json; charset=utf-8"
        dataType: "json"
        async: false
        success: (data) ->
            ret=1;
            return ret;
        error: ->
           return ret;
    expect(resp()).toBe(1)

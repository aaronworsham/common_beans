(function() {
  describe("A jQuery ajax test", function() {
    return it("should make AJAX request", function() {
      var resp;
      resp = function() {
        return $.ajax({
          type: "GET",
          url: "/",
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          async: false,
          success: function(data) {
            var ret;
            ret = 1;
            return ret;
          },
          error: function() {
            return ret;
          }
        });
      };
      return expect(resp()).toBe(1);
    });
  });
}).call(this);

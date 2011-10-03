beforeEach(function() {
  this.addMatchers({
    toBePlaying: function(expectedSong) {
      var player = this.actual;
      return player.currentlyPlayingSong === expectedSong
          && player.isPlaying;
    }
  })




});

$(function(){
  jasmine.getFixtures().fixturesPath = '/jasmine/fixtures';
  preloadFixtures('tracker_fixtures.html');
  loadFixtures('tracker_fixtures.html');
  ich.grabTemplates()
})


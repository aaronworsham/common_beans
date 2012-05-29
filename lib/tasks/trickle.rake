namespace :cb do
  namespace :trickle do

    desc 'Update protfolios'
    task :portfolios => :environment do



      while(1)
        count = Portfolio.where("points_updated_at < ?", Date.today).count
        minutes_left = Time.parse('23:59:59') - Time.now
        if count == 0
          break
        #slow
        elsif (count/100).ceil < (minutes_left/10).ceil
          batch = 100
          wait = 600
        #mid
        elsif (count/100).ceil < (minutes_left/5).ceil
          batch = 100
          wait = 300
        #fast
        else
          batch = 1000
          wait = 300
        end

        array = Portfolio.where("points_updated_at < ?", Date.today).limit(batch)
        array.each do |p|
          p.populate_points
        end
        sleep(wait)
      end


    end
  end
end
desc 'Send birthday wishes'

task send_wishes: :environment do
  Team.all.each { |team| puts "HAPPY BIRTHDAY: #{team.domain}" }
end

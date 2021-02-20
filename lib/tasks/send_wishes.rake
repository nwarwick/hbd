# frozen_string_literal: true

desc 'Send birthday wishes'

task send_wishes: :environment do
  Team.all.each do |team|
    client = Slack::Web::Client.new(token: team.oauth_token)
    client.auth_test
    user_list = []
    team.users.born_today.each { |user| user_list.push("<@#{user.slack_id}>") }
    total_birthday_count = user_list.length
    send_message(user_list, total_birthday_count, client, team.channel) if total_birthday_count > 0
  end
end

private

def send_message(user_list, total_birthday_count, client, channel)
  message =
    case total_birthday_count
    when 1
      "Happy birthday #{user_list.join('')}!"
    when 2
      "Happy birthday #{user_list.join(' and ')}!"
    else
      "Happy birthday #{
        user_list.slice(0, total_birthday_count - 1).join(', ')
      } and #{user_list.last}!"
    end

  client.chat_postMessage(channel: channel, text: message, link_names: true)
end

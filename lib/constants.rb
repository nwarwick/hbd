module Constants
  SLACK_COMMAND_RESPONSE = {
    "text": 'How can I help you?',
    "attachments": [
      {
        "fallback": 'You are unable to choose a game',
        "callback_id": 'wopr_game',
        "color": '#3AA3E3',
        "attachment_type": 'default',
        "actions": [
          {
            "name": 'game', "text": 'Chess', "type": 'button', "value": 'chess'
          },
          {
            "name": 'add_birthday',
            "text": 'Add your birthday',
            "style": 'success',
            "type": 'button',
            "value": 'war'
          }
        ]
      }
    ]
  }.freeze
end

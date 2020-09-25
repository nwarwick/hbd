module Constants
  SLACK_COMMAND_RESPONSE = {
    "text": 'How can I help you?',
    "attachments": [
      {
        "fallback": 'You are unable to choose a game',
        "callback_id": 'birthday_handler',
        "color": '#3AA3E3',
        "attachment_type": 'default',
        "actions": [
          {
            "name": 'view_birthdays',
            "text": 'View birthdays',
            "type": 'button',
            "value": 'view_birthdays'
          },
          {
            "name": 'add_birthday',
            "text": 'Add your birthday',
            "style": 'primary',
            "type": 'button',
            "value": 'add_birthday'
          }
        ]
      }
    ]
  }.freeze
end

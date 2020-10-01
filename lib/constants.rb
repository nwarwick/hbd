module Constants
  # TODO: Update the response to display a modal along with a datepicker https://github.com/nwarwick/hbd/issues/8
  # TODO: Update the response to allow viewing of birthdays https://github.com/nwarwick/hbd/issues/9 (lower priority)
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

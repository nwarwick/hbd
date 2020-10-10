# frozen_string_literal: true

module Constants
  # TODO: Update the response to allow viewing of birthdays https://github.com/nwarwick/hbd/issues/9 (lower priority)
  # TODO: use datepicker as input to prevent invalid birthday submissions
  SLACK_DATEPICKER = {
    "type": 'modal',
    "callback_id": 'datepicker-form',
    "title": { "type": 'HBD', "text": 'HBD', "emoji": true },
    "submit": { "type": 'plain_text', "text": 'Submit', "emoji": true },
    "close": { "type": 'plain_text', "text": 'Cancel', "emoji": true },
    "elements": [
      { "type": 'text', "label": 'Enter your birthday!', "name": 'birthday' }
    ]
  }.freeze
end

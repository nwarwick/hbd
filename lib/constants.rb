# frozen_string_literal: true

module Constants
  SLACK_DATEPICKER = [
    {
      "type": 'section',
      "block_id": 'datepicker-block',
      "text": { "type": 'mrkdwn', "text": 'Tell me your birthday!' },
      "accessory": {
        "type": 'datepicker',
        "initial_date": "1990-01-01",
        "placeholder": {
          "type": 'plain_text', "text": 'Select a date', "emoji": true
        },
        "action_id": 'datepicker-action'
      }
    }
  ].freeze

  SLACK_SUCCESS_MESSAGE = [
    {
      "type": 'section',
      "text": {
        "type": 'mrkdwn', "text": 'Thank you for submitting your birthday 🎉'
      }
    }
  ].freeze
end

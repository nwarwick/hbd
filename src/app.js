import axios from 'axios'

const { SLACK_OAUTH_TOKEN } = process.env

async function run() {
  const res = axios.post(
    'https://slack.com/api/chat.postMessage',
    {
      channel: '#general',
      text: 'Hello, World!',
    },
    { headers: { authorization: `Bearer ${SLACK_OAUTH_TOKEN}` } },
  )
  console.log(`response: ${res}`)
}
run().catch((err) => console.log(err))

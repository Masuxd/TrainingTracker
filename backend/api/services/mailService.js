require('dotenv').config();
const formData = require('form-data');
const Mailgun = require('mailgun.js');
const mailgun = new Mailgun(formData);
const mg = mailgun.client({username: process.env.MAILGUN_USERNAME, key: process.env.MAILGUN_API_KEY});
const mailgunDomain = process.env.MAILGUN_DOMAIN;

function sendEmail(to, subject, html) {
  const message = {
    from: `Training Tracker <mailgun@${mailgunDomain}>`,
    to,
    subject,
    html
  };

  return mg.messages.create(mailgunDomain, message)
    .then(msg => console.log(msg)) // logs response data
    .catch(err => console.log(err)); // logs any error
}

module.exports = sendEmail;
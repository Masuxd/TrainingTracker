const formData = require('form-data');
const Mailgun = require('mailgun.js');
const mailgun = new Mailgun(formData);
const mg = mailgun.client({username: 'api', key: process.env.MAILGUN_API_KEY});

function sendEmail(to, subject, html) {
  const message = {
    from: 'Training Tracker <mailgun@sandbox72842d4bf7f2428485d1d19e4d0d64b6.mailgun.org>',
    to,
    subject,
    html
  };

  return mg.messages.create(process.env.MAILGUN_DOMAIN, message)
    .then(msg => console.log(msg)) // logs response data
    .catch(err => console.log(err)); // logs any error
}

module.exports = sendEmail;
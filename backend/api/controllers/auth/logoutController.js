const express = require('express');
const session = require('express-session');


const logout = async (req, res) => {
    req.session.destroy(err => {
        if (err) {
          return res.sendStatus(500);
        }
        res.clearCookie('connect.sid');
        res.sendStatus(200);
      });
};

module.exports = {
  logout,
};
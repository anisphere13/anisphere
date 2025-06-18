const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const {storeSensitiveUserData} = require('./user');
const {createSupportTicket} = require('./support');
const {sendNotification} = require('./notifications');
const {sendMessage} = require('./messaging');

module.exports = {
  storeSensitiveUserData,
  createSupportTicket,
  sendNotification,
  sendMessage,
};

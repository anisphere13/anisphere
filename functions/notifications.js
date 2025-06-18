const functions = require('firebase-functions');

exports.sendNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required.');
  }

  // TODO: Implement notification dispatch logic
  return {status: 'sent'};
});

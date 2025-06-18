const functions = require('firebase-functions');

exports.createSupportTicket = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required.');
  }

  // TODO: Save ticket info to Firestore or handle support logic
  return {status: 'received'};
});

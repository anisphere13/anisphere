const functions = require('firebase-functions');

exports.sendMessage = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required.');
  }

  // TODO: Implement message handling logic
  return {status: 'queued'};
});

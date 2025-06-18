const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Processes tasks from 'supportQueue' collection in batches
exports.processSupportQueue = functions.pubsub
  .schedule('every 5 minutes')
  .onRun(async () => {
    const batchSize = 10;
    const snapshot = await admin
      .firestore()
      .collection('supportQueue')
      .orderBy('createdAt')
      .limit(batchSize)
      .get();

    if (snapshot.empty) return null;

    const batch = admin.firestore().batch();
    snapshot.docs.forEach((doc) => {
      const data = doc.data();
      // TODO: offline queue fallback when Firestore not reachable
      batch.set(admin.firestore().collection('support').doc(), data);
      batch.delete(doc.ref);
    });
    await batch.commit();
    return null;
  });

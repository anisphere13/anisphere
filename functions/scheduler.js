const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Scheduled function: purge old temp data daily
exports.dailyCleanup = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async () => {
    const cutoff = Date.now() - 24 * 60 * 60 * 1000;
    const batch = admin.firestore().batch();
    const query = admin
      .firestore()
      .collection('temp')
      .where('createdAt', '<', cutoff);

    const snapshots = await query.get();
    snapshots.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
  });

// Scheduled function: trigger push notification relaunch every morning
exports.dailyRelaunch = functions.pubsub
  .schedule('0 8 * * *')
  .timeZone('Europe/Paris')
  .onRun(async () => {
    // TODO: offline queue integration for push relaunch
    const message = {
      notification: {
        title: 'AniSphère',
        body: 'Pensez à mettre à jour le suivi de vos animaux !',
      },
      topic: 'all',
    };
    await admin.messaging().send(message);
  });

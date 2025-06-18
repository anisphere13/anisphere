const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.storeSensitiveUserData = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "L'utilisateur doit être connecté.");
  }

  const uid = context.auth.uid;

  await admin.firestore().collection("cloud_users").doc(uid).set({
    nom: data.nom || null,
    prenom: data.prenom || null,
    email: data.email || null,
    telephone: data.telephone || null,
    adresse: data.adresse || null,
    consentementIA: data.consentementIA || false,
    premium: data.premium || false,
    dateDernierContact: new Date().toISOString()
  }, { merge: true });

  return { status: "success", message: "Données utilisateur stockées." };
});

// Scheduled tasks and queue processors
exports.dailyCleanup = require('./scheduler').dailyCleanup;
exports.dailyRelaunch = require('./scheduler').dailyRelaunch;
exports.processSupportQueue = require('./supportQueue').processSupportQueue;
exports.iaApi = functions.https.onRequest(require('./ia').router);

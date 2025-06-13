/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require("firebase-functions");
const admin = require("firebase-admin");

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

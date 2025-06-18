const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');

const router = express();
router.use(express.json());

function createBatchHandler(collection) {
  return async (req, res) => {
    const {category} = req.params;
    const items = Array.isArray(req.body.items) ? req.body.items : [req.body];
    const batch = admin.firestore().batch();
    items.forEach((item) => {
      const ref = admin
        .firestore()
        .collection('ia_categories')
        .doc(category)
        .collection(collection)
        .doc();
      batch.set(ref, {
        ...item,
        receivedAt: new Date().toISOString(),
      });
    });
    await batch.commit();
    functions.logger.info(
      `Received ${items.length} ${collection} for ${category}`
    );
    res.status(200).json({status: 'ok', received: items.length});
  };
}

const uploadHandler = createBatchHandler('uploads');
const feedbackHandler = createBatchHandler('feedbacks');

router.post('/ia_categories/:category/uploads', uploadHandler);
router.post('/ia_categories/:category/feedbacks', feedbackHandler);

module.exports = {router, uploadHandler, feedbackHandler};

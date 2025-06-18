const assert = require('node:assert');
const {test} = require('node:test');

let setCalls;
const fakeBatch = {
  set: (r, d) => setCalls.push(d),
  commit: async () => {},
};
const fakeDb = {
  batch: () => fakeBatch,
  collection: () => ({
    doc: () => ({
      collection: () => ({
        doc: () => ({}),
      }),
    }),
  }),
};
const fakeAdmin = { firestore: () => fakeDb };
require.cache[require.resolve('firebase-admin')] = {exports: fakeAdmin};
const {uploadHandler, feedbackHandler} = require('../ia');

test('uploadHandler stores batch items', async () => {
  setCalls = [];
  const req = {params: {category: 'test'}, body: {items: [{a:1},{b:2}]} };
  const res = {status: () => res, json: (d) => {res.body = d;}};
  await uploadHandler(req, res);
  assert.equal(setCalls.length, 2);
  assert.deepEqual(res.body, {status: 'ok', received: 2});
});

test('feedbackHandler works with single object', async () => {
  setCalls = [];
  const req = {params: {category: 'test'}, body: {foo: 'bar'} };
  const res = {status: () => res, json: (d) => {res.body = d;}};
  await feedbackHandler(req, res);
  assert.equal(setCalls.length, 1);
  assert.deepEqual(res.body, {status: 'ok', received: 1});
});

module.exports = {
  env: {
    node: true,
    es2022: true,
  },
  extends: [
    "eslint:recommended",
  ],
  parserOptions: {
    ecmaVersion: 2022,
  },
  rules: {
    "no-unused-vars": "warn",
    "no-console": "warn",
  },
};

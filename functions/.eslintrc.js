module.exports = {
  env: {
    node: true,
    es2020: true,
  },
  extends: [
    "eslint:recommended"
  ],
  parserOptions: {
    ecmaVersion: 2020,
  },
  rules: {
    // Personnalise ici si besoin :
    "no-unused-vars": "warn",
    "no-console": "off",
  },
};

module.exports = {
  parser: 'babel-eslint',
  env: {
    browser: true,
    commonjs: true,
    es6: true,
    node: true,
    jest: true
  },
  extends: ['eslint:recommended'],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    sourceType: 'module'
  },
  plugins: ['react'],
  rules: {
    'linebreak-style': ['error', 'unix'],
    'no-console': [
      'warn',
      { allow: ['clear', 'info', 'error', 'dir', 'trace'] }
    ]
  }
};

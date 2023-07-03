module.exports = {
  plugins: ["@typescript-eslint"],
  extends: [
    "airbnb-base",
    "airbnb-typescript/base",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "prettier",
  ],
  env: {
    node: true,
    browser: true,
    jest: true,
  },
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: "./tsconfig.json",
  },
  rules: {},
  overrides: [
    {
      files: ["*.js"],
      rules: {
        // Allow CJS until ESM support improves
        "@typescript-eslint/no-var-requires": "off",
      },
    },
  ],
};

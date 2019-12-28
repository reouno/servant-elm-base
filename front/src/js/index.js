'use strict';

const {Elm} = require('../elm/Main.elm');
const mountNode = document.getElementById('main');
const app = Elm.Main.init({node: mountNode});

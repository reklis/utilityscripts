#!/usr/bin/env node

/*global require, process, Buffer, console */

(function () {
  'use strict';

  var util = require('util');

  console.log(util.inspect(new Buffer(process.argv[2], 'base64').toString('utf-8')));

}());
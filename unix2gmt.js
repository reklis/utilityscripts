#!/usr/bin/env node

var d = new Date(parseInt(process.argv[2], 10));
console.log(d.toGMTString());

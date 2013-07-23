#!/usr/bin/env node

var NSTimeIntervalSince1970, nstime, dateobj, unixtime;

nstime = parseFloat(process.argv[2]);

NSTimeIntervalSince1970 = 978307200;
unixtime = 1000 * (nstime + NSTimeIntervalSince1970);
dateobj = new Date(unixtime);

console.log('nstime: ' + nstime);
console.log('date: ' + dateobj);
console.log('as unix millis: ' + dateobj.getTime());

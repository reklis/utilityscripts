#!/usr/bin/env node

process.stdin.on('data', function (d) {
  process.stdout.write('' + map(d));
});

function map (d) {
  o = eval(process.argv[2]);
  return o;
}

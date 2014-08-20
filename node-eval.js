#!/usr/bin/env node

try {

  process.stdin.on('data', function (d) {
    process.stdout.write('' + map(d));
  });

  process.on('uncaughtException', function () {
    process.exit(1);
  });

  function map (d) {
    o = eval(process.argv[2]);
    return o;
  }

} catch (ex) {
  process.exit(2);
}

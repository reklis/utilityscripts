#!/usr/bin/env python

import sys
from mmap import mmap,ACCESS_READ
from xlrd import open_workbook # http://www.python-excel.org/

file_name=sys.argv[1]

wb = open_workbook(file_name)

s = wb.sheets()[0]

r_count = s.nrows
c_count = s.ncols

for row in range(r_count):

    for col in range(c_count):
        cell_value = unicode(s.cell(row, col).value)
        encoded_value = cell_value.encode('ascii', 'xmlcharrefreplace')

        if 0 != col:
            sys.stdout.write('\t')

        v = encoded_value.strip()
        try:
            f = float(v)
            i = int(f)
            if f == i:
                sys.stdout.write(str(i))
            else:
                sys.stdout.write(str(f))
        except:
            sys.stdout.write(str(v))

    sys.stdout.write('\n')

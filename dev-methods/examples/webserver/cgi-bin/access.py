#! /usr/bin/env python

import MySQLdb

db = MySQLdb.connect(host='localhost',
		     user='austin',
		     passwd='test',
		     db='shirts4mike')

print "Content-type: text/html"
print
print "<title>Shirts for Mike</title>"

cur = db.cursor()

cur.execute("SELECT * FROM products")

print "<h1>Products</h1>"
print '<table style="width:100%">'
print "    <tr>"
print "        <th>Number</th>"
print "        <th>Description</th>"
print "    </tr>"
for row in cur.fetchall():
    print "    <tr>"
    print "        <th>"+str(row[0])+"</th>"
    print "        <td>"+str(row[1])+"</td>"
    print "    </tr>"
print '</table>'

cur.execute("SELECT * FROM products")
print "<ol>"
for row in cur.fetchall():
    print "    <li>"
    print row[1]
    print "    </li>"
print "</ol>"

print "&copy; 2015 by me"

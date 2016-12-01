#!/usr/bin/python
import base64
import os
import argparse

 
parser = argparse.ArgumentParser(description='Glitch script #1')
parser.add_argument('-i','--input', help='Input file name',required=True)
parser.add_argument('-o','--output',help='Output file name', required=True)
args = parser.parse_args()
 

inputfile = ''


f = ''
with open(args.input, 'rb') as imageFile:
   f = str(base64.b64encode(imageFile.read()))
a=''
for y in f:
   a+=y
unique=set(a)

import random
FindChar = random.sample(set(unique),1)
ReplaceChar = random.sample(set(unique),1)

f = open(args.input, 'rb') as imgText

print (f)
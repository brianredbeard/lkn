#!/bin/sh

grep -v "#" gregkh_symbols.txt | grep -v "^$" | wc


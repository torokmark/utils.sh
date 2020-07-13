#!/usr/bin/env bash

source "../lib/map.sh"

map create fruits
map add fruits apple 12
map add fruits pear 20
len=$( map size fruits )
echo -e "size = $len"

keys=$( map keys fruits )
echo -e "keys = ( $keys )"

values=$( map values fruits )
echo -e "values = ( $values )"

map create fruits

len=$( map size fruits )
echo -e "size = $len"




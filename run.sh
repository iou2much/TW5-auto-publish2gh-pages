#!/bin/sh
set -e

#tiddlywiki_script=$(readlink -f $(which tiddlywiki))
tiddlywiki_script=/usr/local/bin/tiddlywiki

if [ -n "$NODE_MEM" ]; then
    # Based on rule of thumb from:
    # http://fiznool.com/blog/2016/10/01/running-a-node-dot-js-app-in-a-low-memory-environment/
    mem_node_old_space=$((($NODE_MEM*4)/5))
    NODEJS_V8_ARGS="--max_old_space_size=$mem_node_old_space $NODEJS_V8_ARGS"
fi

if [ ! -d wiki ]; then
  /usr/bin/env node $NODEJS_V8_ARGS $tiddlywiki_script wiki --init server
fi

exec /usr/bin/env node $NODEJS_V8_ARGS $tiddlywiki_script wiki --server 8080 $:/core/save/all text/plain text/html ${USERNAME:-user} ${PASSWORD:-'wiki'} 0.0.0.0


#!/bin/bash
cd /var/node


if [[ "$SKIP_NPM" = "" ]]; then
	echo "running npm install"
	npm install
	npm install -g nodemon
else
	echo "skipping npm install"
fi

if [ ! -d "node_modules" ]; then
  echo "node_modules doenst exist - installing"
  npm install
  npm install -g nodemon
  
  if [[ "$NODEMON" = "" ]]; then
	echo "installing tsnode"
	npm install typescript ts-node
  fi
fi

#/polling.sh /var/node &
echo "stating indexts (/node.sh)"

#if nodemon isnt set use node runner
if [[ "$NODEMON" = "" ]]; then
	echo "starting with node"
	node -r ts-node/register --inspect=0.0.0.0:4747 ./index.ts
else
	echo "starting with nodemon"
	nodemon --inspect=0.0.0.0:4747 -e js,ts,json ./index.ts
fi

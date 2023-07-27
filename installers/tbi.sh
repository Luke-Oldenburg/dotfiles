#!/bin/bash
tar -xvf $1 -C $2
cd $2
./configure
make
sudo make install
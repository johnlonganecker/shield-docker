#!/bin/sh

./bin/shield-schema -t postgres -d postgres://postgres:postgres@postgres:5432/shield
./bin/shieldd -c shieldd.conf --log-level info
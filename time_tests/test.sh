#!/bin/bash

iterations=$1

parallel time ./tester ::: $(seq $1) ::: $2

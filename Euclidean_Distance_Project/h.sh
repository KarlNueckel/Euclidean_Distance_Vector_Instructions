#!/bin/bash

dim=1000
loops=1000000

taskset -c 6 ./vec $dim $loops & 
#taskset -c 8 ./vec $dim $loops &

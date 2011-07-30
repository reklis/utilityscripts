#!/bin/bash

sudo ipfw pipe 1 config bw 15KByte/s
sudo ipfw add 1 pipe 1 src-ip 204.8.254.58

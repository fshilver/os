#!/bin/bash

wget https://dl.influxdata.com/telegraf/releases/telegraf-1.11.0-1.x86_64.rpm
sudo yum localinstall -y telegraf-1.11.0-1.x86_64.rpm

#!/bin/bash

# Czasami potrzebujemy przekazac stdout do pliku, ale musimy uzyc sudo

# Takie polecenie wywali nam Permission denied
sudo echo 'my.server 10.23.11.20' >> /etc/hosts

# Jak to zrobic aby zadzialalo?
# Z pomoca przychodzi polecenie `tee` 
echo 'my.server 10.23.11.20' | sudo tee -a /etc/hosts


# Jak chcesz wykonac zdalna komende, ujmij po prostu ja w cudzyslow:
ssh root@10.23.11.20 "ps aux | head -3"

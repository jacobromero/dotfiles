#!/bin/bash

aerospace list-windows --all | grep -m 1 "Thunderbird" | cut -d " " -f 1 | xargs aerospace focus --window-id

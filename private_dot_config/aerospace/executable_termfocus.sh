#!/bin/bash

aerospace list-windows --all | grep "WezTerm" | cut -d " " -f 1 | xargs aerospace focus --window-id
#!/bin/bash

aerospace list-windows --all | grep "Cursor" | cut -d " " -f 1 | xargs aerospace focus --window-id
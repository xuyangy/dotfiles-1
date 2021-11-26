#!/bin/bash
bemenu < /dev/null | xargs trans --no-ansi > /tmp/translation.txt && kitty less /tmp/translation.txt

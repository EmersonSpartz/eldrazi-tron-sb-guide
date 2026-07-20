#!/usr/bin/env bash
set -e
URL="https://emersonspartz.github.io/eldrazi-tron-sb-guide/"
html=$(curl -sf "$URL")
for needle in "Mengucci" "Lucas Giggs" "Cardsrealm" "Disruptor Flute" "Togores &middot; Jul 2026" "Giltspire" "Boros Ponza" "Torpor Orb"; do
  grep -q "$needle" <<< "$html" || { echo "FAIL: missing '$needle'"; exit 1; }
done
mus=$(grep -c '<div class="mu\(\s\+open\)\?">' <<< "$html")
bodies=$(grep -c '<div class="mu-body">' <<< "$html")
[ "$mus" = "$bodies" ] || { echo "FAIL: mu/body mismatch ($mus vs $bodies)"; exit 1; }
echo "PASS: all strings present + mu/body balanced ($mus each)"

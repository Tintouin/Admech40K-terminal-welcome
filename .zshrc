
# ═══════════════════════════════════════
# ++ ADEPTUS MECHANICUS TERMINAL INIT ++
# ═══════════════════════════════════════

function imperial_date() {
  local year=$(date '+%Y')
  local day=$(date '+%j')   # day of the year (1-365)
  local millennium=$(( (year / 1000) + 1 ))
  local year_in_millenium=$(printf '%03d' $(( year % 1000 )))
  local fraction=$(printf '%03d' $(( (day * 1000) / 365 )))

  echo "0${fraction}${year_in_millenium}.M${millennium}"
}

function mech_sep() {
  local sep=""
  for i in {1..$COLUMNS}; do
    # Random char between U+1D306 et U+1D356
    local code=$(( 0x1D306 + RANDOM % (0x1D356 - 0x1D306 + 1) ))
    sep+=$(printf '%b' "\\U$(printf '%08X' $code)")
  done
  echo "$sep"
}

if command -v fortune &>/dev/null; then
  local sep=$(mech_sep)
  local txt1="++ PRAISE THE OMNISSIAH ++"
  local txt2="++ ADMINISTRATUM V43Φ.🜌.🜓  |  Ψ  $(imperial_date) ++"
  local pad1=$(( (COLUMNS - ${#txt1}) / 2 ))
  local pad2=$(( (COLUMNS - ${#txt2}) / 2 ))

  echo ""
  printf "%${pad1}s%s\n" "" "$txt1"
  echo ""
  printf "%${pad2}s%s\n" "" "$txt2"
  echo "$sep"
  echo ""
  fortune mechanicus
  echo ""
  echo "$sep"
  echo ""
fi

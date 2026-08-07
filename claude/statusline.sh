#!/bin/bash
input=$(cat)

# Parse all values in a single jq call (pipe-delimited to handle spaces in model name)
IFS='|' read -r MODEL DIR PCT TOTAL_TOKENS RATE_5H RATE_7D RESETS_5H RESETS_7D HAS_RATE_LIMITS HAS_API_ACTIVITY <<< \
  "$(echo "$input" | jq -r '[
    .model.display_name,
    .workspace.current_dir,
    (.context_window.used_percentage // 0 | floor),
    (.context_window.context_window_size // 0 | tonumber? // 0),
    (.rate_limits.five_hour.used_percentage // "" | if . == "" then "" else floor end),
    (.rate_limits.seven_day.used_percentage // "" | if . == "" then "" else floor end),
    (.rate_limits.five_hour.resets_at // ""),
    (.rate_limits.seven_day.resets_at // ""),
    (if .rate_limits then "yes" else "no" end),
    (if .context_window.current_usage then "yes" else "no" end)
  ] | join("|")')"

# Colors
CYAN='\033[36m'
RED='\033[31m'
RESET='\033[0m'

# Git branch
BRANCH=""
if git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=" | 🔀 ${RED}$(git -C "$DIR" branch --show-current 2>/dev/null)${RESET}"
fi

# Progress bar
FILLED=$((PCT / 10))
BAR=$(printf "%${FILLED}s" | tr ' ' '#')$(printf "%$((10 - FILLED))s" | tr ' ' '-')

# Context total formatted as k/m
TOTAL_FMT=""
if [ "$TOTAL_TOKENS" -ge 1000000 ] 2>/dev/null; then
    TOTAL_FMT="/$((TOTAL_TOKENS / 1000000))M"
elif [ "$TOTAL_TOKENS" -ge 1000 ] 2>/dev/null; then
    TOTAL_FMT="/$((TOTAL_TOKENS / 1000))k"
fi

# Rate limits or fast mode
RATE=""
if [ "$HAS_RATE_LIMITS" = "no" ] && [ "$HAS_API_ACTIVITY" = "yes" ]; then
    RATE=" | FAST 🔥"
elif [ -n "$RATE_5H" ]; then
    NOW=$(date +%s)
    RESET_5H_REL=""
    if [ "$RATE_5H" -ge 50 ] 2>/dev/null && [ -n "$RESETS_5H" ]; then
        REM_5H=$(( RESETS_5H - NOW ))
        H5=$(( REM_5H / 3600 ))
        M5=$(( (REM_5H % 3600) / 60 ))
        RESET_5H_REL=" ~${H5}h${M5}m"
    fi
    RESET_7D_REL=""
    if [ "$RATE_7D" -ge 50 ] 2>/dev/null && [ -n "$RESETS_7D" ]; then
        REMAINING=$(( RESETS_7D - NOW ))
        DAYS=$(( REMAINING / 86400 ))
        if [ "$DAYS" -lt 1 ]; then
            H7=$(( REMAINING / 3600 ))
            M7=$(( (REMAINING % 3600) / 60 ))
            RESET_7D_REL=$(printf " ~%d:%02d" "$H7" "$M7")
        else
            HOURS=$(( (REMAINING % 86400) / 3600 ))
            RESET_7D_REL=" ~${DAYS}d${HOURS}h"
        fi
    fi
    EXTRA=""
    if [ "$RATE_5H" -ge 100 ] 2>/dev/null || [ "$RATE_7D" -ge 100 ] 2>/dev/null; then
        EXTRA=" 💸"
    fi
    RATE=" | ⚡ ${RATE_5H}%/5h${RESET_5H_REL} ${RATE_7D}%/7d${RESET_7D_REL}${EXTRA}"
fi

echo -e "[$MODEL] ${CYAN}${DIR##*/}${RESET}$BRANCH | 🧠 $BAR $PCT%$TOTAL_FMT$RATE"

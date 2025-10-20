

usage() {
  cat <<EOF
Usage: $0 -p PRINCIPAL -r RATE -t TIME
  -p PRINCIPAL   Principal amount (number)
  -r RATE        Annual interest rate (percentage, e.g., 5 for 5%)
  -t TIME        Time period in years (number)
Example:
  $0 -p 1000 -r 5 -t 2
EOF
  exit 1
}

while getopts "p:r:t:h" opt; do
  case $opt in
    p) P="$OPTARG" ;;
    r) R="$OPTARG" ;;
    t) T="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

if [[ -z "$P" || -z "$R" || -z "$T" ]]; then
  echo "Error: missing arguments."
  usage
fi

re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $P =~ $re && $R =~ $re && $T =~ $re ]]; then
  echo "Error: arguments must be numeric."
  usage
fi

SI=$(echo "scale=4; ($P * $R * $T) / 100" | bc -l)
echo "Principal: $P"
echo "Rate: $R%"
echo "Time: $T years"
echo "Simple Interest: $SI"

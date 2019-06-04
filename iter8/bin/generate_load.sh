#!/bin/sh

FREQUENCY=2
OPTIONS="-Is"
DURATION="10s"
URL=

# process options
while [ $# -gt 0 ]; do
  case "${1}" in
    --url)
      URL="${2}"
      shift; shift
      ;;
    -f|--frequency)
      FREQUENCY="${2}"
      shift; shift
      ;;
    -d|--duration)
      DURATION="${2}"
      shift; shift
      ;;
    -o|--options)
      OPTIONS="${2}"
      shift; shift
      ;;
    *) echo "WARNING: Ignoring unknown option: ${1}"
      shift
      ;;
  esac
done

echo "URL       = $URL"
echo "OPTIONS   = $OPTIONS"
echo "DURATION  = $DURATION"
echo "FREQUENCY = $FREQUENCY"

generate {
  while sleep $FREQUENCY ; do
    curl $OPTIONS $URL
  done
}

#timeout $DURATION generate
#timeout $DURATION while sleep $FREQUENCY ; do curl $OPTIONS $URL ; done
while sleep $FREQUENCY ; do curl $OPTIONS $URL ; done
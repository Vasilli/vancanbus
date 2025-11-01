#!/usr/bin/with-contenv bashio

DEVICE="$(bashio::config 'device')"
BITRATE="$(bashio::config 'bitrate')"

echo "Start VAN CanBus"
echo "Config: DEVICE=$DEVICE BITRATE=$BITRATE"

# Print current status
ip link show "$DEVICE"

# If the device is already up, bring it down first.
if [ "$(cat "/sys/class/net/$DEVICE/operstate")" == "up" ]; then
  ip link set "$DEVICE" down
fi

ip link set "$DEVICE" up type can bitrate "$BITRATE"

# Print current status
ip link show "$DEVICE"


### docker exec -it addon_local_van_can_bus /bin/bash
python -m http.server 8000



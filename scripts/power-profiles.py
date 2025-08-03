#!/usr/bin/env python3
"""
toggle-power-profile: cycle UPower power profiles via D-Bus.

Usage:
  toggle-power-profile [next|prev]

Default is "next".  Left-click → next, right-click → prev.
"""

import sys

try:
    import dbus
except ImportError:
    sys.exit("Error: install python-dbus (e.g. pacman -S python-dbus)")


def find_proxy():
    """Try both old and new service/interface names."""
    bus = dbus.SystemBus()
    candidates = [
        # old name
        (
            "net.hadess.PowerProfiles",
            "net.hadess.PowerProfiles",
            "/net/hadess/PowerProfiles",
        ),
        # new name (UPower >= 0.20)
        (
            "org.freedesktop.UPower.PowerProfiles",
            "org.freedesktop.UPower.PowerProfiles",
            "/org/freedesktop/UPower/PowerProfiles",
        ),
    ]
    for dest, iface, path in candidates:
        try:
            obj = bus.get_object(dest, path)
            props = dbus.Interface(obj, "org.freedesktop.DBus.Properties")
            # test availability
            props.GetAll(iface)
            return props, dest, iface
        except dbus.exceptions.DBusException:
            continue
    sys.exit("Error: power-profiles-daemon not found on system bus")


def main():
    direction = "next"
    if len(sys.argv) > 1:
        arg = sys.argv[1].lower()
        if arg in ("-h", "--help"):
            print(__doc__)
            return
        if arg in ("prev", "previous", "-p", "--prev"):
            direction = "prev"
        elif arg in ("next", "n", "-n", "--next"):
            direction = "next"
        else:
            sys.exit(f"Unknown arg '{sys.argv[1]}'; use next|prev")

    props, dest, iface = find_proxy()
    all_props = props.GetAll(iface)  # returns a dict: {property_name: variant}
    active = str(all_props["ActiveProfile"])
    profiles = all_props["Profiles"]  # this is a dbus.Array of dbus.Dict

    # extract list of profile names in order
    profile_list = []
    for entry in profiles:
        # entry is a dict { "Profile": <dbus.String>, "Driver": <dbus.String> }
        name = entry.get("Profile")
        if name is not None:
            profile_list.append(str(name))

    if not profile_list:
        sys.exit("Error: no profiles found")

    try:
        idx = profile_list.index(active)
    except ValueError:
        sys.exit(f"Error: active profile '{active}' not in {profile_list!r}")

    if direction == "next":
        new_idx = (idx + 1) % len(profile_list)
    else:  # prev
        new_idx = (idx - 1) % len(profile_list)

    new_profile = profile_list[new_idx]
    # set the new profile
    props.Set(dest, "ActiveProfile", dbus.String(new_profile))


if __name__ == "__main__":
    main()

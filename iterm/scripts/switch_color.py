#!/usr/bin/env python3

import asyncio
import iterm2
import sys


async def main(connection):
    theme = sys.argv[1] or "dark"
    if "dark" == theme:
        preset = await iterm2.ColorPreset.async_get(connection, "gruvbox-dark")
    else:
        preset = await iterm2.ColorPreset.async_get(connection, "gruvbox-light")

    # Update the list of all profiles and iterate over them.
    profiles = await iterm2.PartialProfile.async_query(connection)
    for partial in profiles:
        # Fetch the full profile and then set the color preset in it.
        profile = await partial.async_get_full_profile()
        await profile.async_set_color_preset(preset)


try:
    iterm2.run_until_complete(main)
except:
    print("Fail to switch iterm theme, please do so manually")

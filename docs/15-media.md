# Media applications

## Spotify

Install Spotify through Arch's official `spotify-launcher` package:

```sh
sudo ./scripts/install-packages packages/51-media.txt
```

`spotify-launcher` is maintained in Arch's `extra` repository. It downloads,
verifies, and launches Spotify's official Linux client, so this setup does not
need an AUR helper or an unreviewed AUR build recipe for Spotify.

Start Spotify from Rofi or from a terminal:

```sh
spotify-launcher
```

The downloaded Spotify client, account credentials, cache, and playback state
remain machine-local and must not be committed to this repository.

# Music Rating Prompter

An AppleScript stay-open application for macOS that prompts you to rate each Apple Music song when it finishes playing.

When a track ends and has no rating (0 stars), a dialog appears so you can assign 1–5 stars. Tracks that already have a rating are left alone.

## Requirements

- macOS
- [Apple Music](https://www.apple.com/apple-music/) (the app formerly known as iTunes)
- Automation permission for Music

## Quick start

Download the latest pre-built Universal application from [GitHub Releases](https://github.com/gamebits/music-rating-prompter/releases), unzip it, and open `Music Rating Prompter.app`.

The app runs in the background and stays open until you quit it from the menu bar or Dock.

## Build from source

The source file is `MusicRatingPrompter.applescript` in this repository. Because the script uses an `on idle` handler, it must be compiled as a **stay-open application**.

### Option 1: Script Editor

1. Open `MusicRatingPrompter.applescript` in **Script Editor** (included with macOS).
2. Choose **File → Export** (or **File → Save as Application** on older macOS versions).
3. Set **File Format** to **Application**.
4. Enable **Stay open after run handler**. This is required — without it, the app launches and quits immediately, and the rating prompt will never appear.
5. Save as `Music Rating Prompter.app`.

To produce a Universal binary for distribution, use the architecture options available in Script Editor’s export dialog, then attach the `.app` (or a zip of it) to a [GitHub Release](https://github.com/gamebits/music-rating-prompter/releases).

### Option 2: Command line

From the repository root on a Mac:

```bash
chmod +x build.sh
./build.sh
```

This runs `osacompile` with the stay-open flag and produces `Music Rating Prompter.app` in the current directory. The command-line build targets the architecture of the Mac you run it on; use Script Editor if you need a Universal binary for Releases.

## First launch

macOS may ask you to grant Automation permission so Music Rating Prompter can control **Music**.

You can review or change these later in **System Settings → Privacy & Security**.

## Usage

1. Launch `Music Rating Prompter.app`. You should see a notification confirming it is running, and its icon should appear in the Dock.
2. Play music in Apple Music as usual.
3. When a song finishes and has 0 stars, choose a rating from the dialog or dismiss it to skip.
4. Quit the app when you no longer want prompts (it does not exit on its own).

## Troubleshooting

**The app seems to do nothing after launch**

- Confirm you exported with **Stay open after run handler** enabled. Without this option, the app exits immediately and never monitors Music.
- Look for a startup notification ("Monitoring Apple Music for unrated tracks.") and the app icon in the Dock.
- Launch the app *before* or during playback so it can record the current track.

**No rating prompt appears**

- The track must have **0 stars** in your library. Already-rated songs are skipped.
- Let the song play through to the end (or into its final few seconds) before skipping or stopping.
- Grant **Automation** permission for Music in **System Settings → Privacy & Security → Automation**.
- Open **Console.app**, filter for `Music Rating Prompter`, and check for error messages.

**Testing from Script Editor**

Use **File → Export** to create the application. Do not use **Run** in Script Editor to test idle behavior — the script only polls Music when saved as a stay-open application and launched from Finder.

## License

This project is licensed under the [GNU General Public License v2.0](LICENSE).

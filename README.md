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
4. Enable **Stay open after run handler**.
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

1. Launch `Music Rating Prompter.app`.
2. Play music in Apple Music as usual.
3. When a song finishes and has 0 stars, choose a rating from the dialog or dismiss it to skip.
4. Quit the app when you no longer want prompts (it does not exit on its own).

## License

This project is licensed under the [GNU General Public License v2.0](LICENSE).

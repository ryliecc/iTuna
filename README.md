# iTuna – Guitar Tuner for macOS

iTuna is a lightweight, real-time guitar and instrument tuner for macOS that lives in your menu bar. It detects pitch through your microphone and shows which string needs tuning. Works for standard tuning guitars.

## Features

- Menu bar app for macOS
- Real-time pitch detection via built-in microphone
- Supports standard tuning guitar (multiple instruments like guitar, bass, ukulele, ... coming soon)
- Semi-circle meter for easy tuning (left = flat, right = sharp)
- Smooths measurements for stable readings

## Screenshots

*Coming soon*

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ryliecc/iTuna.git
    ```
2. Open the project in Xcode and run as a macOS app.
3. Allow microphone access when prompted. The tuner will not work without it.

## Usage

- Click the guitar icon in the menu bar to open the tuner popover.
- Press "Start Listening" to enable microphone input.
- Play a string on your instrument – the app will show the detected frequency and the nearest note.
- Watch the semi-circle needle to see if the string is too low or too high.
- Press "Stop Listening" when finished.

## Requirements

- macOS 14.0 or later
- Xcode 15 or later
- Microphone access enabled in app capabilities (Hardened Runtime + Audio Input)

## License

MIT License © [Rylie Castell]

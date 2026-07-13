![Platform](https://img.shields.io/badge/platform-macOS-blue)
![Swift](https://img.shields.io/badge/Swift-6-orange)
![License](https://img.shields.io/badge/license-MIT-green)

# Echo

Echo is a native macOS voice dictation app that lets you hold a hotkey, speak naturally, and instantly paste polished text into any application.

It combines on-device speech recognition with Apple Intelligence to produce clean, well-formatted transcripts while keeping the experience fast, private, and completely local.

---

## Features

- 🎙️ Push-to-talk voice dictation
- ✨ Transcript cleanup using Apple Foundation Models
- 📝 Automatic grammar, punctuation, and formatting correction
- 📋 Automatically pastes into the active application
- 🖥️ Native macOS menu bar application
- 🌊 Live recording overlay
- 🔄 Automatic updates powered by Sparkle
- 🔒 On-device speech recognition powered by WhisperKit

---

## Tech Stack

- Swift
- SwiftUI
- AppKit
- AVFoundation
- Apple Foundation Models
- WhisperKit
- Sparkle

---

## Requirements

- macOS 26 or later
- Xcode 17 or later
- Apple Silicon Mac
- Apple Intelligence enabled (for transcript cleanup)

---

## Local Setup

### Clone the repository

```bash
git clone https://github.com/shivamvk/echo.git
cd echo
```

### Open the project

Open `echo.xcodeproj` in Xcode.

### Resolve Swift Packages

Xcode will automatically resolve all Swift Package dependencies.

WhisperKit manages the required speech recognition models automatically, so no additional model setup is required.

---

## Project Structure

```
echo
├── docs
├── scripts
├── ThirdParty
├── echo
├── echo.xcodeproj
└── README.md
```

---

## Contributing

Contributions are welcome.

If you'd like to contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Open a Pull Request.

For larger changes, please open an issue first so we can discuss the proposed approach.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

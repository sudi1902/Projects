# NFL Island 🏈

An iOS app that rotates through all 32 NFL team names in the **Dynamic Island** with animated transitions, powered by ActivityKit Live Activities.

## What it does

Tap **Start Rotation** and the app launches a Live Activity. Every 3 seconds the next NFL team is pushed to the Dynamic Island, where it slides in with a push transition in the team's colors:

- **Compact view** (island's normal state): team abbreviation on the left, 🏈 on the right — both animate on every rotation
- **Expanded view** (long-press the island): full team name, a team-color badge, a "Team N of 32" counter, and a live ticking elapsed timer
- **Minimal view** (when another Live Activity shares the island): team abbreviation
- **Lock Screen**: a banner tinted with the current team's primary color

The ticking timer keeps the island moving continuously even between team changes.

## Requirements

- Xcode 15 or later
- iOS 16.2+ deployment target
- **Dynamic Island requires an iPhone 14 Pro or newer** (or the iPhone 15 Pro/16 Pro simulators). On other devices the Live Activity still appears on the Lock Screen.

## Getting started

1. Open `NFLIsland.xcodeproj` in Xcode.
2. Select the **NFLIsland** target → Signing & Capabilities → choose your development team. Do the same for the **NFLIslandWidget** target.
3. (Optional) Change the bundle identifiers from `com.example.NFLIsland` / `com.example.NFLIsland.NFLIslandWidget` to your own. The widget's identifier must stay prefixed by the app's.
4. Select the **NFLIsland** scheme and run on a Dynamic Island-capable device or simulator.
5. Tap **Start Rotation**, then swipe up to go home — watch the island.

## Project structure

```
NFLIsland/
├── NFLIsland.xcodeproj
├── Shared/                          # Compiled into both targets
│   ├── NFLTeams.swift               # All 32 teams with brand colors
│   └── TeamActivityAttributes.swift # Live Activity data model
├── NFLIsland/                       # App target
│   ├── NFLIslandApp.swift
│   ├── ContentView.swift            # Start/stop UI, mirrors the current team
│   ├── ActivityManager.swift        # Starts the activity, rotates teams on a timer
│   └── Info.plist                   # NSSupportsLiveActivities
└── NFLIslandWidget/                 # Widget extension target
    ├── NFLIslandWidgetBundle.swift
    ├── TeamLiveActivity.swift       # Dynamic Island + Lock Screen UI
    └── Info.plist                   # widgetkit-extension point
```

## How the animation works

Live Activities don't allow free-running animations, so movement comes from three sanctioned mechanisms:

1. **State updates** — `ActivityManager` pushes a new `ContentState` every 3 seconds; iOS animates the change in the island.
2. **Transitions** — each text view is keyed with `.id(teamIndex)` and given `.transition(.push(...))`, so the old name slides out while the new one slides in. The counter uses `.contentTransition(.numericText())`.
3. **Live timer** — `Text(date, style: .timer)` renders a system-driven timer that ticks every second with no updates needed.

## Limitations worth knowing

- The rotation timer runs in the app process, so teams keep rotating while the app is **foregrounded or briefly backgrounded**. iOS suspends the app after a while in the background, which pauses rotation (the island keeps showing the last team and the ticking timer). For rotation that survives suspension you'd drive updates with ActivityKit **push notifications** from a server.
- iOS ends Live Activities automatically after up to 8 hours.
- Team names and abbreviations are used for identification; this project is not affiliated with or endorsed by the NFL.

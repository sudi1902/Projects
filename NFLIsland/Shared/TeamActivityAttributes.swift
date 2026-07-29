import ActivityKit
import Foundation

/// Shared between the app (which starts/updates the Live Activity) and the
/// widget extension (which renders it in the Dynamic Island).
struct TeamActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        /// Index into `NFLTeams.all` for the team currently on screen.
        var teamIndex: Int
        /// When this state was pushed, used for transition timing.
        var updatedAt: Date
    }

    /// When the rotation was started; drives the live ticking timer.
    var startedAt: Date
}

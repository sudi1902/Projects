import ActivityKit
import SwiftUI

/// Starts, updates, and ends the NFL team Live Activity.
///
/// While the activity is running, a timer rotates through all 32 teams and
/// pushes each one as a new content state. iOS animates the change inside the
/// Dynamic Island using the transitions declared in the widget extension.
@MainActor
final class ActivityManager: ObservableObject {
    @Published private(set) var isRunning = false
    @Published private(set) var currentIndex = 0
    @Published var errorMessage: String?

    /// Seconds each team stays on screen before sliding to the next.
    let rotationInterval: TimeInterval = 3

    private var activity: Activity<TeamActivityAttributes>?
    private var timer: Timer?

    var currentTeam: NFLTeam { NFLTeams.team(at: currentIndex) }

    func start() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            errorMessage = "Live Activities are disabled. Enable them in Settings > NFL Island."
            return
        }
        stop()

        currentIndex = Int.random(in: 0..<NFLTeams.all.count)
        let attributes = TeamActivityAttributes(startedAt: .now)
        let state = TeamActivityAttributes.ContentState(teamIndex: currentIndex, updatedAt: .now)

        do {
            activity = try Activity.request(
                attributes: attributes,
                content: ActivityContent(state: state, staleDate: nil)
            )
            errorMessage = nil
            isRunning = true
            scheduleTimer()
        } catch {
            errorMessage = "Could not start Live Activity: \(error.localizedDescription)"
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false

        guard let activity else { return }
        self.activity = nil
        let finalState = TeamActivityAttributes.ContentState(teamIndex: currentIndex, updatedAt: .now)
        Task {
            await activity.end(
                ActivityContent(state: finalState, staleDate: nil),
                dismissalPolicy: .immediate
            )
        }
    }

    private func scheduleTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: rotationInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.advance()
            }
        }
    }

    private func advance() {
        guard let activity else { return }
        withAnimation {
            currentIndex = (currentIndex + 1) % NFLTeams.all.count
        }
        let state = TeamActivityAttributes.ContentState(teamIndex: currentIndex, updatedAt: .now)
        Task {
            await activity.update(ActivityContent(state: state, staleDate: nil))
        }
    }
}

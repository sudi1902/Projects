import ActivityKit
import SwiftUI
import WidgetKit

/// Renders the rotating NFL team Live Activity in the Dynamic Island and on
/// the Lock Screen. Each content-state update (a new team) animates in with a
/// push transition, and the elapsed timer ticks continuously for constant
/// movement even between updates.
struct TeamLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TeamActivityAttributes.self) { context in
            LockScreenView(context: context)
        } dynamicIsland: { context in
            let team = NFLTeams.team(at: context.state.teamIndex)

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    AbbreviationBadge(team: team)
                        .padding(.leading, 4)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("🏈")
                        .font(.title2)
                        .id(context.state.teamIndex)
                        .transition(.push(from: .top).combined(with: .opacity))
                        .padding(.trailing, 4)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(team.fullName)
                        .font(.system(.title3, design: .rounded).weight(.heavy))
                        .foregroundStyle(team.secondaryColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .id(context.state.teamIndex)
                        .transition(.push(from: .trailing).combined(with: .opacity))
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Text("Team \(context.state.teamIndex + 1) of \(NFLTeams.all.count)")
                            .contentTransition(.numericText())
                        Spacer()
                        Text(context.attributes.startedAt, style: .timer)
                            .monospacedDigit()
                            .frame(maxWidth: 60, alignment: .trailing)
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
                }
            } compactLeading: {
                Text(team.abbreviation)
                    .font(.system(.subheadline, design: .rounded).weight(.heavy))
                    .foregroundStyle(team.secondaryColor)
                    .id(context.state.teamIndex)
                    .transition(.push(from: .bottom).combined(with: .opacity))
            } compactTrailing: {
                Text("🏈")
                    .id(context.state.teamIndex)
                    .transition(.push(from: .top).combined(with: .opacity))
            } minimal: {
                Text(team.abbreviation)
                    .font(.system(size: 11, weight: .heavy, design: .rounded))
                    .foregroundStyle(team.secondaryColor)
                    .minimumScaleFactor(0.5)
                    .id(context.state.teamIndex)
                    .transition(.push(from: .bottom).combined(with: .opacity))
            }
            .keylineTint(team.primaryColor)
        }
    }
}

/// Circular team-color badge shown in the expanded leading region.
private struct AbbreviationBadge: View {
    let team: NFLTeam

    var body: some View {
        Text(team.abbreviation)
            .font(.system(.footnote, design: .rounded).weight(.heavy))
            .foregroundStyle(.white)
            .padding(8)
            .background(
                Circle().fill(
                    LinearGradient(
                        colors: [team.primaryColor, team.primaryColor.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            )
            .id(team.id)
            .transition(.scale.combined(with: .opacity))
    }
}

/// Banner shown on the Lock Screen and on devices without a Dynamic Island.
private struct LockScreenView: View {
    let context: ActivityViewContext<TeamActivityAttributes>

    var body: some View {
        let team = NFLTeams.team(at: context.state.teamIndex)

        HStack(spacing: 12) {
            AbbreviationBadge(team: team)

            VStack(alignment: .leading, spacing: 2) {
                Text(team.fullName)
                    .font(.system(.headline, design: .rounded).weight(.heavy))
                    .foregroundStyle(.white)
                    .id(context.state.teamIndex)
                    .transition(.push(from: .trailing).combined(with: .opacity))
                Text("Team \(context.state.teamIndex + 1) of \(NFLTeams.all.count)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                    .contentTransition(.numericText())
            }

            Spacer()

            Text(context.attributes.startedAt, style: .timer)
                .font(.caption.monospacedDigit())
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxWidth: 60, alignment: .trailing)
        }
        .padding(16)
        .activityBackgroundTint(team.primaryColor.opacity(0.85))
        .activitySystemActionForegroundColor(.white)
    }
}

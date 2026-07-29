import SwiftUI

struct ContentView: View {
    @StateObject private var manager = ActivityManager()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [manager.currentTeam.primaryColor, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.8), value: manager.currentIndex)

            VStack(spacing: 24) {
                Spacer()

                Text("🏈")
                    .font(.system(size: 72))

                VStack(spacing: 8) {
                    Text(manager.isRunning ? manager.currentTeam.fullName : "NFL Island")
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .contentTransition(.numericText())
                        .animation(.spring(duration: 0.5), value: manager.currentIndex)

                    Text(manager.isRunning
                         ? manager.currentTeam.abbreviation
                         : "All 32 teams, rotating in your Dynamic Island")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.horizontal)

                Spacer()

                if let error = manager.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.yellow)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Button {
                    manager.isRunning ? manager.stop() : manager.start()
                } label: {
                    Text(manager.isRunning ? "Stop Rotation" : "Start Rotation")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(manager.isRunning ? Color.red : Color.white)
                        .foregroundStyle(manager.isRunning ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 24)

                Text("Teams rotate every \(Int(manager.rotationInterval))s while the app is running. Swipe up to see the names slide through the Dynamic Island (iPhone 14 Pro or later).")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    ContentView()
}

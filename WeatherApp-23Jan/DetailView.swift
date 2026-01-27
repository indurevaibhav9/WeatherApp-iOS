import SwiftUI

struct DetailView: View {
    let location: Location
    @StateObject private var viewModel = DetailViewModel()

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(location.name)
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                Image(systemName: location.weather.icon)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.yellow)

                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    Text(viewModel.temperatureText)
                        .font(.title)
                        .foregroundStyle(.gray)
                }

                Spacer()
            }
            .padding()
        }
        .task {
            await viewModel.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
    }
}

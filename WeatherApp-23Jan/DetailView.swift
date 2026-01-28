import SwiftUI
import CoreData

struct DetailView: View {

    let location: Location
    @StateObject private var viewModel: DetailViewModel

    // MARK: - Init
    init(location: Location, context: NSManagedObjectContext) {
        self.location = location
        _viewModel = StateObject(
            wrappedValue: DetailViewModel(context: context)
        )
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Text(location.name)
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                Image(systemName: viewModel.conditionIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .foregroundStyle(.yellow)

                Text(viewModel.conditionText)
                    .font(.title2)
                    .foregroundStyle(.white)

                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)

                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)

                } else {
                    VStack(spacing: 16) {

                        Text(viewModel.temperatureText)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(.white)

                        HStack(spacing: 40) {

                            WeatherInfoView(
                                icon: "wind",
                                value: viewModel.windText,
                                title: "Wind"
                            )

                            WeatherInfoView(
                                icon: "humidity.fill",
                                value: viewModel.humidityText,
                                title: "Humidity"
                            )
                        }
                    }
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

//
//  MainScreen.swift
//  Fav8
//
//  Created by Vasileios Zotikas on 2022-12-07.
//

import Combine
import Fav8Server
import SwiftUI

struct MainScreen: View, LoadableListView {
    let colorOne: Color = .init(
        #colorLiteral(red: 0.6461197734, green: 0.1092272475, blue: 0.2935471833, alpha: 1))
    let colorTwo: Color = .init(
        #colorLiteral(red: 0.1326819658, green: 0.1122616902, blue: 0.1552955806, alpha: 1))

    private let fetchStationsUseCase: FetchStationsUseCase

    @State var viewAdapter: ViewAdapter

    init(
        fetchStationsUseCase: FetchStationsUseCase = FetchStationsInteractor(),
        viewAdapter: ViewAdapter)
    {
        self.fetchStationsUseCase = fetchStationsUseCase
        _viewAdapter = .init(initialValue: viewAdapter)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [colorOne, colorTwo]))
                .ignoresSafeArea()
            content
                .refreshable {
                    getStations()
                }
        }
    }

    @ViewBuilder var content: some View {
        switch viewAdapter.stations {
        case .notRequested:
            notRequestedView { getStations() }
        case .isLoading:
            loadingListView
        case .loaded(let result):
            loadedView(result: result)
        }
    }

    @ViewBuilder private func loadedView(result: Result<[RadioStation], RepositoryError>) -> some View {
        switch result {
        case .success(let stations):
            station(stations: stations)
        case .failure(let error):
            ErrorModal(errorMsg: error.localizedDescription)
        }
    }

    @ViewBuilder func station(stations: [RadioStation]) -> some View {
        VStack {
            ScrollView {
                ForEach(stations, id: \.self) { station in
                    StationButtonView(station: station)
                }
            }
        }
    }

    // MARK: - Side effects

    private func getStations() {
        let cancelBag = CancelBag()

        viewAdapter.stations.setIsLoading(cancelBag: cancelBag)

        fetchStationsUseCase.fetchStations()
            .sinkToLoadable {
                viewAdapter.stations = $0
            }
            .store(in: cancelBag)
    }
}

// MARK: - ViewAdapter

extension MainScreen {
    struct ViewAdapter {
        var stations: Loadable<[RadioStation], RepositoryError>
        //        {
        //            didSet {
        //                updateStationsIfNeeded()
        //            }
        //        }

        init(stations: Loadable<[RadioStation], RepositoryError> = .notRequested) {
            self.stations = stations
        }

        //        mutating func updateStationsIfNeeded() {
        //            switch stations {
        //            case .isLoading:
        //                stationList = [RadioStation(name: "Station Name", url: "Station Url")]
        //            case .loaded(let result):
        //                switch result {
        //                case .success(let response):
        //                    stationList = [response]
        //                case .failure:
        //                    stationList = []
        //                }
        //            default:
        //                stationList = [RadioStation(name: "Station Name", url: "Station Url")]
        //            }
        //        }
    }
}

// struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
// }

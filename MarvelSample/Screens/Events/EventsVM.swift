//
//  EventsVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import Foundation

class EventsVM: BaseListVM<Event, EventItemVM> {
    init(service: APIServiceProtocol = APIService(requestGenerator: APIRequestGenerator())) {
        super.init(navigationTitle: "Events",
                   endPoint: APIEndpoints.events.rawValue,
                   service: service,
                   emptyDataTitle: "Couldn't find any comic",
                   errorTitle: "Error in fetching comics")
    }
    
    override func parseData(json: Any) {
        guard let dict = json as? NSDictionary else {
            return
        }
        guard let data = dict["data"] as? NSDictionary else {
            return
        }
        guard let results = data["results"] as? [NSDictionary] else {
            return
        }
        var newEvents: [Event] = []
        var newEventItems: [EventItemVM] = []
        for item in results {
            if let event = Event(dict: item) {
                newEvents.append(event)
                newEventItems.append(EventItemVM(event: event))
            }
        }
        self.data.append(contentsOf: newEvents)
        listItems.value.append(contentsOf: newEventItems)
    }
}

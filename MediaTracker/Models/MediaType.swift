import Foundation
import SwiftUI

enum MediaType: String, Codable, CaseIterable, Identifiable {
    case book, show, movie, podcast, game, article

    var id: String { rawValue }
    var label: String { rawValue.capitalized }

    // TODO: pick the SF Symbol for each type (browse them in the SF Symbols app)
    var symbol: String {
        switch self {
        case .book: "book.fill"
        case .show: "tv.fill"
        case .movie: "film.fill"
        case .podcast: "mic.fill"
        case .game: "gamecontroller.fill"
        case .article: "doc.text.fill"
        }
    }

    // TODO: what does an optional "amount" mean for each type? (pages, episodes, ...)
    var unit: String {
        switch self {
        case .book: "pages"
        case .show: "episodes"
        case .movie: "minutes"
        case .podcast: "episodes"
        case .game: "hours"
        case .article: "articles"
        }
    }
    
    var color: Color {
        switch self {
        case .book: .blue
        case .show: .yellow
        case .movie: .red
        case .podcast: .green
        case .game: .purple
        case .article: .orange
        }
    }
}

/// NOT stored. Derived from an item's entries (see MediaItem.status).
enum ItemStatus: CaseIterable {
    case inProgress, planned, finished, dropped

    // TODO: display names, and decide section order for the library
    var label: String {
        switch self {
        case .inProgress: "In Progress"
        case .planned: "Planned"
        case .finished: "Finished"
        case .dropped: "Dropped"
        }
    }
}

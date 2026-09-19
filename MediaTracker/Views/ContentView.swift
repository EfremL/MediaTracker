import SwiftUI
import SwiftData

enum AppTab: Hashable {
    case home, calendar, library
}

struct ContentView: View {
    @State private var selectedTab: AppTab = .home
    
       var body: some View {
           TabView(selection: $selectedTab) {
               HomeView(onOpenCalendar: { selectedTab = .calendar })
                   .tabItem { Label("Home", systemImage: "house") }
                   .tag(AppTab.home)
    
               CalendarView()
                   .tabItem { Label("Calendar", systemImage: "calendar") }
                   .tag(AppTab.calendar)
    
               LibraryView()
                   .tabItem { Label("Library", systemImage: "books.vertical") }
                   .tag(AppTab.library)
           }
       }
}



#Preview {
    ContentView()
        .modelContainer(PreviewData.container)
}


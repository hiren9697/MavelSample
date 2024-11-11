# Sample app build with Marvel's API 

- iOS app built to learn automated test cases, I have written unit and snapshot tests
- This app uses marvel's free APIs: https://developer.marvel.com

# Credits:

UI / Design credit goes to designer: https://www.figma.com/@moses_m
You can check design here: https://www.figma.com/community/file/1218121517690628123

Icons credit
1. Empty box: Ghozi Muhtarom - Flaticon - https://www.flaticon.com/free-icons/empty
2. Network error: ADI_ICONS - Flaticon - https://www.flaticon.com/free-icon/file_17597096?term=cloud+error&page=1&position=2&origin=search&related_id=17597096


# Functionalities:

- Walkthrough screen which displays for the only first time as usual
- TabBar with comics, characters and events screens, on selecting list item app displays respective detail screen
- List screen has pagination and pull to refresh features
- Comic list item displays thumbnail and title of comic, on selecting comic app displays comic detail screen which consists thumbnail, title, description, characters and creators
- Character list item displays photo and name of character, on selecting character app displays character detail screen which consists photo, name, description, comics and seris of character
- Events list item displays thumbnail, title and description of event, on selecting event app displays event detail screen which consists thumbnail, title, description, characters, creators and comics of event
 
 
# Classes:

## Walkthrough
- WalkthroughVC is view conroller file for walkthrough
- WalkthroughCC is collection view cell displayed in walkthrough
- WalkthroughVM is view model file
- WalkthroughItemVM is view model file for walkthrough item or cell

## TabBar
- TabBarController is tab bar controller file for tab bar
- TabBarVM is view model file
- TabBarItemVM is view model file for tab bar items

## Common
- ParentVC is view controller file with functionality of show / hide loader implemented, Other view controller files confirm this class to have loader functionality

## List helper / Parent classes
### APIDataListable
- Protocol defines properties and methods for view model class with list functionality with associated types Data(model class for list item) and ItemVM(view model class for list item)
### ThumbnailTitleItemViewModel
- Protocol defines properties and methods for view model class for list item
- List item can be lazy loadable means it can start data loading from server when user scrolls to that item
### BaseCollectionVC<ViewModel: APIDataListable>
- View controller class with list functionality impelemented with collection view
- Implemented pull to refresh and pagination functionalites
- Contains a generic 'ViewModel' which must confirm to 'APIDataListable'
- Other class can confirms this class to have common collection view functionality, child classes must implement some methods
- Manages data fetch state
### BaseTableVC<ViewModel: APIDataListable>
- View controller class with list functionality implemented with table view
- Implemented pull to refresh and pagination functionalites
- Contains a generic 'ViewModel' which must confirm to 'APIDataListable'
- Other class can confirm this class to have common table view functionality, child classes must implement some methods
- Manages data fetch state
### ThumbnailTitleCC<ViewModel: ThumbnailTitleItemViewModel>
- Collection view class with UI components thumbnail, title, loader and error view
- Manages state for data fetch if there is
- Manages lazy loading means it initiate data load from server when user scrolls to that item
### HorizontalThumbnailTitleGridViewModelProtocol
- Protocol defines properties for view model class for horizontal grid
- Contains associated type ItemViewModel which must confirms to ThumbnailTitleItemViewModel
### ThumbnailTitleHorizontalGridView<ViewModel: HorizontalThumbnailTitleGridViewModelProtocol>
- Class for horizontal grid with item containts thumbnail image and title label
- Contains a genric 'ViewModel' which must confirms to 'HorizontalThumbnailTitleGridViewModelProtocol'
### GenericHorizontalThumbnailTitleGridViewModel<ItemModel: ThumbnailTitleItemViewModel>: HorizontalThumbnailTitleGridViewModelProtocol
- Generic view model class for horizontal gird with thumbnail image and title label
- Contains a generic ItemModel which must confirms to ThumbnailTitleItemViewModel


## Comics
### ComicsVC: BaseCollectionVC<ComicsVM>
- View controller class confirms to BaseCollectionVC with ComicsVM as generic type parameter
- Uses ThumbnailTitleCC<ComicItemVM> with collection view
### ComicsVM: BaseListVM<Comic, ComicItemVM>
- View model class confirms to BaseListVM with Comic(Data) and ComicItemVM(ListItemVM) as generic type parameters
### ComicItemVM: ThumbnailTitleItemViewModel
- View model class for single item of comic list
### ComicDetailVC: ParentVC
- View controller class consists thumbnail image view, title label, description label, characters grid and creators grid
- Description label is hidden when description is empty
- Reusable class 'ThumbnailTitleHorizontalGridView' is used for characters and creators
### ComicDetailVM
- View model class used for comic detail screen

## Characters
### CharactersVC: BaseCollectionVC<CharactersVM>
- View controller class confirms to BaseCollectionVC with CharacterVM as generic type parameter
- Uses ThumbnailTitleCC<CharacterItemVM> with collection view
### CharactersVM: BaseListVM<Character, CharacterItemVM>
- View model class confirms to BaseListVM with Character(Data) and CharacterItemVM(ListItemVM) as geneirc type parameters
### CharacterItemVM
- View model class for single item of character list
### CharacterDetailVC: ParentVC
- View controller class consists thumbnail image view, title label, comics grid and series grid
- Reusable class 'ThumbnailTitleHorizontalGridView' is used for comics and series
### CharacterDetailVM
- View model class used for character detail screen

## Event
### EventsVC: BaseTableVC<EventsVM>
- View controller class for events and confirms to BaseTableVC with EventsVM as generic type parameter
- Uses EventItemTC with table view
### EventsVM: BaseListVM<Event, EventItemVM>
- View model class confirms to BaseListVM with Event(Data) and EventItemVM(ListItemVM) as generic type parameters
### EventDetailVC: ParentVC
- View controller class for event detail screen
- Contains thumbnail image, title label, description label, characters grid, creators grid and comic grid
- Description label is hidden if description is empty
### EventDetailVM
- View model class used for event detail screen

## Third party libraries
### MarvelSample(iOS App)
- Kingfisher: To load image from server
### MarvelSampleTests(Unit tests)
- SnapshotTesting: To support snapshot testing


# Notes:

- Diagrams are drawn in draw.io
- Not used '.receive(on: DispatchQueue.main)' operator with subscribers, Because facing issues in unit tests, Instead used function 'gauranteeMainThread(:)'


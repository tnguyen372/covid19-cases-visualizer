# COVID-19 Cases Visualizer
- Base code derived from Beau Nouvelle's SwiftUI Covid 19 SwiftUI App Tutorial. Modified for my own use. 
- Utilizes the COVID-19 API built by Kyle Redelinghuys: https://covid19api.com/. 
- API Data is sourced from the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University: https://github.com/CSSEGISandData/COVID-19
- NOTE: UNITED STATES IS THE ONLY COUNTRY IN THE COUNTRY SELECTOR VIEW THAT DOES NOT WORK. APP WILL CRASH. 


## Features
- Dashboard that provides an summary overview of confirmed, active, and recovered COVID-19 cases worldwide and specific country cases
- Country selector button that lets user select every country. Select a country to display the respective country's confirmed, active, and recovered cases in the dashboard. Also gives a quick number preview of the country's confirmed and recovered cases during selection
- Line/Multi-Line interactive graphs depicting averages for confirmed, active, and recovered cases in selected country for visual comparisons. Also includes bar graph interactive representation of country total cases since first recorded case. Uses SwiftUI Charts package
- On restart, displays the last selected country's case data for quick access 

## Technologies Used
- Swift for UI
- SwiftUI Charts provided by https://github.com/AppPear/ChartView 

## Members
Thomas Nguyen

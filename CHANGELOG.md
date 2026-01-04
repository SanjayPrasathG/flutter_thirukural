# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-01-04

### Added
- **Web Routes**: Added `ThirukuralRoutes` class with named constants for easy web navigation URL support.
- **Thiruvalluvar Image**: Added beautiful circular framed Thiruvalluvar image to all Kural cards.
- **Olai Chuvadi UI**: Redesigned Kural cards to mimic the traditional palm leaf manuscript (Olai Chuvadi) look.
- **Improved Kural Formatting**: Kural text is now split into 4 words (first line) and remaining (second line) for traditional readability.
- **Model Exports**: Exported `Kural` model class for easier type usage.
- **Comprehensive Documentation**:
  - Added dartdoc comments to all public APIs
  - Added example code to model classes
  - Improved README with web routes section

### Fixed
- **Dart File Conventions**: Fixed all naming conventions to use `lowerCamelCase`
  - Updated `UrlServices` constants from `SCREAMING_SNAKE_CASE` to `camelCase`
  
- **Display Logic**: Fixed condition logic in single kural screens
  - Kural cards now properly display when data is loaded
  - Uses `isLoaded` flag check instead of just error message check

### Changed
- Added `const` keyword to improve performance
- Moved example code to `/example` directory for pub.dev
- Improved API service documentation

---

## [1.1.0] - 2026-01-04

### Added
- **Pagination**: All list screens now have proper pagination with 10 items per page
  - Page navigation controls with first/prev/next/last buttons
  - Page number buttons for quick navigation
  - Page info showing "Showing X-Y of Z Kurals"
  - Chapter lists paginated with 20 items per page

- **Enhanced Kural Card Design**: Completely redesigned card UI with premium aesthetics
  - Gradient headers with Kural number in both Tamil and English
  - Beautifully styled Kural text section with decorative quote icons
  - Separate cards for Tamil and English explanations with color-coded icons
  - Metadata section with icons for Section and Chapter information
  - Smooth expand/collapse animations for list items

- **New Typography**: Added proper Tamil font support
  - Using Poppins for English text
  - Using Noto Sans Tamil for Tamil text
  - Better text hierarchy with proper sizing and weights

- **Improved Loading States**: Enhanced loading screen with styled progress indicator

- **Better Error Display**: Redesigned error widget with icon and styled container

### Changed
- All screens now use a consistent light gray (#F8F9FA) background
- Cards have subtle shadows and gradients for depth
- Section and chapter list items now have gradient number badges
- Header sections in screens show context (date, kural number, chapter name)
- Better responsive design for all screen sizes

### UI Improvements
- Cards have smooth elevation and shadow effects
- Color-coded accent colors for different sections (purple for Tamil, teal for English)
- Animated rotation on expand/collapse icons
- Better spacing and padding throughout

---

## [1.0.1] - 2026-01-04

### Fixed
- **Critical Bug**: Fixed infinite loader issue when importing the package into external apps
  - Widgets are now self-contained with built-in `ProviderScope` and `ResponsiveBreakpoints`
  - No additional setup required by users - just import and use!
  
- **Critical Bug**: Fixed asset images not loading in external apps
  - Updated all image asset paths to use package prefix (`packages/flutter_thirukural/...`)
  
- **Bug**: Fixed back button not working in external apps
  - Replaced GetX navigation with native Flutter `Navigator.of(context).pop()`
  - Back button now works in any app regardless of whether GetX is used
  
- **Bug**: Fixed `isKuralByNumLoaded` never being set to `true` after successful API response
  - `ThirukuralByNumber` widget now correctly shows content after loading

- **Bug**: Fixed unnecessary reloads in `AllKuralsScreen`
  - Removed incorrect `useEffect` dependency that caused repeated API calls

### Changed
- All exported widgets are now fully self-contained and handle their own configuration
- Removed unnecessary dependencies: `get`, `cupertino_icons`, `toastification`, `loading_animation_widget`
- Updated package description to be clearer
- Improved code documentation with comprehensive dartdoc comments

---

## [1.0.0+1] - 2025-12-21

### Added
- Initial release of flutter_thirukural
- `ThirukuralOfTheDay` - Display Kural of the Day by date
- `ThirukuralByNumber` - Display Kural by number (1-1330)
- `AllThirukurals` - Browse all 1330 Kurals
- `ThirukuralsInRange` - Display Kurals in a number range
- `ThirukuralBySectionNames` - Browse by section (Paal)
- `ThirukuralByTamilChapterNames` - Browse by Tamil chapter names
- `ThirukuralByEnglishChapterNames` - Browse by English chapter names
- Responsive design for mobile, tablet, and desktop
- Pull-to-refresh functionality
- Expandable cards for detailed Kural information

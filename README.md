# <img src="Workflow/icon.png" width="45" align="center" alt="icon"> Archive Page

An [Alfred](https://www.alfredapp.com) Workflow for archiving a webpage with the Wayback Machine.

## Installation

You can download the [latest release](https://github.com/Jython1415/alfred-archive-page/releases) (the `.alfredworkflow`) file, and add it to your list of workflows in Alfred (see [Alfred documentation on Workflows](https://www.alfredapp.com/help/workflows/)).

## Usage

Archive a webpage by using the keyword "way" and passing in the URL. If the URL is already in your clipboard, you can use the workflow as a Universal Action instead.

- <kbd>↩&#xFE0E;</kbd> Archive and copy the archive URL to clipboard.
- <kbd>⌘</kbd><kbd>↩&#xFE0E;</kbd> Open the Wayback Machine website for archiving. No automatic copy to clipboard.
- <kbd>⌥</kbd><kbd>↩&#xFE0E;</kbd> Copy the resulting URL in markdown format: `[archive](<URL>)`

## Feedback

Please provide feedback in [the dedicated topic on the Alfred "Share Your Workflows" forum](https://www.alfredforum.com/forum/3-share-your-workflows/).

## Roadmap

- [x] Add status updates for when the content is copied to the clipboard
- [x] Add meaningful updates for possible error codes (not yet released)
- [ ] Change the default behavior to make it optional to pass in a URL (see Wayback When for how this would work)

### Improvements Under Consideration

- [ ] Switch to returning a URL instantly with the archiving being completed in the background (must be reliable)
- [ ] Add different archive sites as a backup

## Acknowledgements

- I heavily referenced the [Wayback When](https://github.com/alfredapp/wayback-when-workflow) workflow. In fact, the first version of my workflow was built on a duplicate of the Wayback When workflow.
- I also referenced the README of Wayback When for styling this README.
- Thank you [FireFingers21](https://www.alfredforum.com/profile/27846-firefingers21/) for initial review of the workflow.
- The icon was downloaded from [UXWing](https://uxwing.com).

# <img src="Workflow/icon.png" width="45" align="center" alt="icon"> Archive Page

An [Alfred](https://www.alfredapp.com) Workflow for archiving a webpage with the Wayback Machine.

## Installation

You can download the [latest release](https://github.com/Jython1415/alfred-archive-page/releases) (the `.alfredworkflow`) file, and add it to your list of workflows in Alfred (see [Alfred documentation on Workflows](https://www.alfredapp.com/help/workflows/)).

## Usage

Archives the frontmost browser tab using Internet Archive's Wayback Machine. Alternatively, you can pass in a URL as an argument, or perform the action from Alfred clipboard history with the Universal Action.

- <kbd>↩&#xFE0E;</kbd> Archive and copy the archive URL to clipboard.
- <kbd>⌘</kbd><kbd>↩&#xFE0E;</kbd> Skip the check for existing snapshots. Directly request to create a new one.
- <kbd>⌥</kbd><kbd>↩&#xFE0E;</kbd> Copy the resulting URL in markdown format: `[archive](<URL>)`
- <kbd>⌃</kbd><kbd>↩&#xFE0E;</kbd> Open the Wayback Machine website for archiving. No automatic copy to clipboard.

## Settings

- **Keyword**
  - Set this to whatever is most convenient for you
- **Snapshot Tolerance**
  - This determines how old an existing snapshot has to be for the workflow to create a new snaptshot
- **Maximum Wait for Requests**
  - Stops the workflow from getting stuck while waiting for a response
- **Always On Logging?**
  - Turn on logs in the workflow data folder

## Feedback

Please provide feedback in [the dedicated topic on the Alfred "Share Your Workflows" forum](https://www.alfredforum.com/forum/3-share-your-workflows/).

## Roadmap

✅ Done
🚧 Work in Progress

- ✅ Notifications for when the content is copied to the clipboard
- ✅ Error code detection with appropriate notifications
- ✅ Passing is the URL is optional
- ✅ Configurable keyword
- ✅ "Always on" logging (configurable and off by default)
- ✅ Prompt to notify the developer when there is an unexpected error
- ✅ Skip creating a new archive if there is already a snapshot within the configured timeframe
- External triggers for key functionalities
- Failed snapshot requests are saved for retrying
- A "search" URL is returned instantly while the snapshot is completed in the background
- Helpful and configurable sounds

## Acknowledgements

- I heavily referenced the [Wayback When](https://github.com/alfredapp/wayback-when-workflow) workflow. In fact, the first version of my workflow was built on a duplicate of the Wayback When workflow.
- I also referenced the README of Wayback When for styling this README.
- Thank you [FireFingers21](https://www.alfredforum.com/profile/27846-firefingers21/) for initial review of the workflow.
- The icon was downloaded from [UXWing](https://uxwing.com).

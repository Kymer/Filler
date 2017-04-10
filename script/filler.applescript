// The goal of this script is to automate setting a certain value in the commit field of Applications such as Tower or SourceTree.
// This script will extract a ticket name from the currently active branch and insert it in the commit field.


// Configurable properties

var supportedApplications = {								// The application name as shown in the menu bar when being run
	TOWER: 'Tower',
	SOURCETREE: 'SourceTree'
}
var currentApplication = supportedApplications.TOWER		// The application for which the script should run
var debugMode = false										// When enabled, error messages will be shown in a dialog message
var refreshInterval = 0.5									// Number of seconds between each refresh interval
var ticketProperties = {									// Various properties which describe the Jira ticket name (e.g. TMA-1952)
	prefix: 'TMA',
	delimiter: '-',
	numberOfDigits: 4
}


// Handlers

function run() {
	tryPrefillingCommitMessage()
}

function idle() {
	tryPrefillingCommitMessage()
	return refreshInterval
}


// Script starting point

function tryPrefillingCommitMessage() {
	try {
		let commitField = getCommitFieldForApplicationWithName(currentApplication)
		let branchName = getActiveBranchNameForApplicationWithName(currentApplication)
		let ticketName = getTicketNameFromBranchName(branchName, ticketProperties)
		prefillCommitFieldWithMessage(ticketName, commitField)
	} catch (error) {
		handleError(error)
	}
}


// Commit field handling

function prefillCommitFieldWithMessage(message, commitField) {
	if (!message || !commitField.exists()) { return }
	if (commitField.value().length == 0 || commitField.value().includes(message)) { return }
	
	commitField.value = `${message}: ` + commitField.value()
}

function getCommitFieldForApplicationWithName(name) {
	const applicationView = getApplicationViewForApplicationWithName(name)
	
	switch (name) {
	
		case supportedApplications.TOWER:
			return applicationView.windows[0].splitterGroups[0].splitterGroups[0].textFields[1]
			break
			
		case supportedApplications.SOURCETREE:
			return applicationView.windows[0].splitterGroups[0].splitterGroups[0].splitterGroups[0].scrollAreas[0].textAreas[0]
			break
			
		default:
			return null
	}
}


// Branch name handling

function getActiveBranchNameForApplicationWithName(name) {
	const applicationView = getApplicationViewForApplicationWithName(name)
	
	switch (name) {
	
		case supportedApplications.TOWER:
			return applicationView.windows[0].splitterGroups[0].splitterGroups[0].buttons[0].title()
			break
			
		case supportedApplications.SOURCETREE:
			return applicationView.windows[0].splitterGroups[0].splitterGroups[0].splitterGroups[0].checkboxes[0].title()
			break
			
		default:
			return null
	}
}

function getTicketNameFromBranchName(branchName, ticketProperties) {
	const regEx = `${ticketProperties.prefix}${ticketProperties.delimiter}[0-9]{${ticketProperties.numberOfDigits}}`
	const matches = branchName.match(regEx)
	return (matches && matches.length > 0 ? matches[0] : null)
}


// Helper functions

function getApplicationViewForApplicationWithName(name) {
	return Application('System Events').processes[name]
}


// Error handling

function handleError(error) {
	if (!debugMode) { return } // If not in debug mode: fail silently
	displayDialogWithMessage(`Oh no, something went wrong 😦\n\n⚠️ ERROR\n${error.message}\n\n${error.stack}`)
}

function displayDialogWithMessage(messageToDisplay) {
	const app = Application.currentApplication()
	app.includeStandardAdditions = true
	app.displayDialog(messageToDisplay, { buttons: ["Ok"] })
}
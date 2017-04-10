// The goal of this script is to automate setting a certain value in the commit field of Applications such as Tower or SourceTree.
// This script will extract a ticket name from the currently active branch and insert it in the commit field.


// Current supported applications

const applications = {
	Tower: {
		process: getProcess('Tower'),
		get commitField() { return this.process.windows[0].splitterGroups[0].splitterGroups[0].textFields[1] },
		get branchName() { return this.process.windows[0].splitterGroups[0].splitterGroups[0].buttons[0].title() }
	},
	SourceTree: {
		process: getProcess('SourceTree'),
		get commitField() { return this.process.windows[0].splitterGroups[0].splitterGroups[0].splitterGroups[0].scrollAreas[0].textAreas[0] },
		get branchName() { return this.process.windows[0].splitterGroups[0].splitterGroups[0].splitterGroups[0].checkboxes[0].title() }
	}
}


// Configurable properties

const selectedApplication = applications.Tower		// The application for which the script should run
const debugMode = false								// When enabled, error messages will be shown in a dialog message
const refreshInterval = 0.5							// Number of seconds between each refresh interval
const ticketProperties = {							// Various properties which describe a ticket name (e.g. TMA-1952)
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
		const ticketName = getTicketNameFromBranchName(selectedApplication.branchName, ticketProperties)
		insertValueInCommitField(ticketName, selectedApplication.commitField)
	} catch (error) {
		handleError(error)
	}
}


// Helper functions

function insertValueInCommitField(message, commitField) {
	if (!message || !commitField.exists()) { return }
	if (commitField.value().length == 0 || commitField.value().includes(message)) { return }
	
	commitField.value = `${message}: ` + commitField.value()
}

function getTicketNameFromBranchName(branchName, ticketProperties) {
	const regEx = `${ticketProperties.prefix}${ticketProperties.delimiter}[0-9]{${ticketProperties.numberOfDigits}}`
	const matches = branchName.match(regEx)
	return (matches && matches.length > 0 ? matches[0] : null)
}

function getProcess(name) {
	return Application('System Events').processes.byName(name)
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
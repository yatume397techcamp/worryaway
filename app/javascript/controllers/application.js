// \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\javascript\controllers\application.js

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\app\javascript\controllers\hello_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}

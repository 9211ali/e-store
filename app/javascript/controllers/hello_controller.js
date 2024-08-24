import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("importmaps and javascript bundler");
    
    this.element.textContent = "Hello Saad Ali!"
  }
}

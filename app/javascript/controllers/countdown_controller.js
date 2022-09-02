import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    date: String,
    refreshInterval: { type: Number, default: 1000 },
    expiredMessage: { type: String, default: "The hackathon has begun!" }
  }

  connect() {
    this.endTime = new Date(this.dateValue).getTime()

    this.update()
    this.timer = setInterval(() => {
      this.update()
    }, this.refreshIntervalValue)
  }

  disconnect() {
    this.stopTimer()
  }

  update() {
    let distance = this.difference();

    let days = Math.floor(distance / (1000 * 60 * 60 * 24));
    let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((distance % (1000 * 60)) / 1000);

    // Display the result in the element with id="demo"
    this.element.textContent = `${days} days ${hours} hours and ${minutes} minutes`;

    // If the count down is finished, write some text
    if (distance < 0) {
      this.element.textContent = this.expiredMessageValue;
      this.stopTimer()
    }
  }

  difference() {
    return this.endTime - new Date().getTime()
  }

  stopTimer() {
    if (this.timer) {
      clearInterval(this.timer)
    }
  }
}

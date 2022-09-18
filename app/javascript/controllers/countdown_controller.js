import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    date: String,
    prefix: String,
    suffix: String,
    refreshInterval: { type: Number, default: 1000 },
    expiredMessage: { type: String, default: "The hackathon has ended!" }
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

    let count = [this.prefixValue]
    if (days > 0) { count.push(`${days} days`) }
    if (hours > 0) { count.push(`${hours} hours`) }
    if (minutes > 0) { count.push(`${minutes} minutes`) }
    count.push(this.suffixValue)

    // If the count down is finished, write some text
    if (distance < 0) {
      this.element.textContent = this.expiredMessageValue;
      this.stopTimer()
    } else {
      // Display the result in the element
      this.element.textContent = count.join(" ");
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

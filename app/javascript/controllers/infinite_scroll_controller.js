import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    this.loadMore()
                }
            })
        })
        this.observer.observe(this.element)
    }

    disconnect() {
        this.observer.disconnect()
    }

    loadMore() {
        const link = this.element.querySelector("a")
        if (link) {
            link.click()
        }
    }
}

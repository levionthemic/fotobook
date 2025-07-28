import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.handleScroll = this.initObserver.bind(this)
        window.addEventListener('scroll', this.handleScroll, { once: true })
    }

    disconnect() {
        this.observer?.disconnect()
        window.removeEventListener('scroll', this.handleScroll)
    }

    initObserver() {
        this.observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    this.loadMore()
                }
            })
        }, {
            rootMargin: "100px"
        })
        this.observer.observe(this.element)
    }

    loadMore() {
        const link = this.element.querySelector("a")
        if (link) {
            link.click()
        }
    }
}

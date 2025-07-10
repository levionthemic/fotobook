// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function () {
    console.log("turbo loaded")
})

// users/edit
document.addEventListener('turbo:load', () => {
    const inputUpload = document.querySelector('#avatar-upload')
    const avatarSubmit = document.querySelector('#avatar-submit')
    const imagePreview = document.querySelector('#image-preview')
    if (inputUpload) {
        inputUpload.addEventListener('change', (e) => {
            const file = inputUpload.files[0]
            if (file) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    avatarSubmit.classList.remove('d-none')
                    inputUpload.parentElement.classList.add('d-none')

                    imagePreview.src = e.target.result
                }

                reader.readAsDataURL(file)
            } else {
                avatarSubmit.classList.add('d-none')
            }
        })
    }
})

// feed/discover
document.addEventListener("turbo:load", () => {
    // Tab label
    document.querySelectorAll(".tab-label").forEach(label => {
        label.addEventListener("click", e => {
            e.preventDefault()
            const url = e.currentTarget.dataset.url;
            if (url) Turbo.visit(url);
        });
    });

    const modal = document.getElementById("viewFeed");
    const titleEl = modal.querySelector(".modal-title");
    const descEl = modal.querySelector("#modal-photo-description");
    const imageEl = modal.querySelector("#modal-photo-image");

    const carouselEl = modal.querySelector("#carouselExample");
    const carouselInner = carouselEl?.querySelector(".carousel-inner");

    document.querySelectorAll(".feeds-list__item--image").forEach(item => {
        item.addEventListener("click", () => {
            // Reset
            document.querySelectorAll(".modal-backdrop").forEach((el, index) => {
                if (index > 0) el.remove();
            });

            const title = item.dataset.title;
            const description = item.dataset.description;
            const imageArray = item.dataset.images ? JSON.parse(item.dataset.images) : null;

            titleEl.textContent = title;
            descEl.textContent = description;

            if (imageArray && imageArray.length > 0) {
                // Ẩn single image
                carouselEl.style.display = "block";

                // Xoá cũ
                carouselInner.innerHTML = "";

                imageArray.forEach((url, index) => {
                    const div = document.createElement("div");
                    div.className = "carousel-item" + (index === 0 ? " active" : "");
                    div.innerHTML = `<img src="${url}" class="d-block w-100" alt="carousel image">`;
                    carouselInner.appendChild(div);
                });

            } else {
                // Single image
                imageEl.src = item.dataset.image;
                imageEl.style.display = "block";
                descEl.style.display = "block";
                carouselEl.style.display = "none";
            }
        });
    });
});
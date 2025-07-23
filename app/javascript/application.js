// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// users/edit
document.addEventListener('turbo:load', () => {
    console.log("turbo loaded")

    document.querySelector(".header__user--logout").addEventListener("click", (e) => {
        // Reset
        document.querySelectorAll(".modal-backdrop").forEach((el, index) => {
            if (index > 0) el.remove();
        });
    })


    if (location.pathname.match(new RegExp(/^\/(?:admin\/)?users\/\d+\/edit$/))) {
        console.log('ok')
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
    }

    if (location.pathname === '/' || location.pathname === '/discover') {
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

                    imageArray.forEach(({ url }, index) => {
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
    }

    if (location.pathname.match(new RegExp(/^\/users\/\d+\/photos\/new$/))) {
        const inputUpload = document.querySelector('#image-upload')
        const preview = document.querySelector('#image-preview')

        if (inputUpload) {
            inputUpload.addEventListener('change', () => {
                const file = inputUpload.files[0]
                if (file) {
                    const reader = new FileReader()
                    reader.onload = (e) => {
                        preview.src = e.target.result
                        preview.style.display = 'block'
                    }

                    reader.readAsDataURL(file)
                } else {
                    preview.src = '#'
                    preview.style.display = 'none'
                }
            })
        }

    }

    if (location.pathname.match(new RegExp(/^\/(?:admin\/)?photos\/\d+\/edit$/))) {
        const closeIcon = document.getElementById("close-icon");
        const imageUpload = document.getElementById("image-upload");
        const preImagePreview = document.getElementById("pre-image-preview");
        const plusIcon = document.getElementById("plus-icon");
        if (closeIcon) {
            closeIcon.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                closeIcon.classList.add("d-none");
                preImagePreview.classList.add("d-none");
                plusIcon.classList.remove("d-none");
                imageUpload.style.pointerEvents = "auto";
            })
        }
        if (preImagePreview) {
            preImagePreview.addEventListener("click", (e) => {
                if (imageUpload.style.pointerEvents === "none") {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        }
        if (imageUpload) {
            imageUpload.addEventListener('click', (e) => {
                imageUpload.value = '';
            });
            imageUpload.addEventListener("change", (e) => {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader()
                    reader.onload = (e) => {
                        preImagePreview.src = e.target.result
                        preImagePreview.classList.remove("d-none");
                        closeIcon.classList.remove("d-none");

                        imageUpload.style.pointerEvents = "none";
                        plusIcon.classList.add("d-none");
                    }

                    reader.readAsDataURL(file)
                } else {
                    preImagePreview.src = '#'
                    closeIcon.classList.add("d-none");
                    preImagePreview.classList.add("d-none");
                    plusIcon.classList.remove("d-none");
                    imageUpload.removeAttribute("disabled");
                }
            })
        }
    }

    if (location.pathname.match(new RegExp(/^\/users\/\d+\/albums\/new$/))) {
        const inputUpload = document.querySelector('#image-upload')
        const imagePreviewList = document.querySelector('.image-preview-list')

        if (inputUpload) {
            inputUpload.addEventListener('change', () => {
                const file = inputUpload.files[0]
                if (file) {
                    const reader = new FileReader()
                    const imagePreview = document.createElement('img')
                    reader.onload = (e) => {
                        imagePreview.classList.add('image-preview', 'rounded', 'object-cover')
                        imagePreview.src = e.target.result
                        imagePreview.style.display = 'block'
                    }
                    imagePreviewList.insertBefore(imagePreview, inputUpload.parentElement)

                    reader.readAsDataURL(file)
                }
            })
        }

    }
})

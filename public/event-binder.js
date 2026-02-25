// event-binder.js
class EventBinder extends Pagination {
    bindEvents() {
        document.getElementById("closeModal").addEventListener("click", () => {
            document.getElementById("districtModal").classList.add("hidden");
            this.closeAllAccordions();
            const searchInput = document.getElementById("institutionSearch");
            if (searchInput) {
                searchInput.value = '';
            }
            this.resetFiltersUI();
        });

        document.getElementById("districtModal").addEventListener("click", (e) => {
            if (e.target.id === "districtModal") {
                this.resetFiltersUI();
            }
        });

        document.getElementById("institutionSearch").addEventListener("input", (e) => {
            const searchInput = document.getElementById("institutionSearch");
            if (searchInput) {
                searchInput.addEventListener("input", this.debounce((e) => {
                    this.applyCombinedFilters();
                }, 250));
            }
        });

        document
            .getElementById("closeInstitutionModal")
            .addEventListener("click", () => {
                document.getElementById("institutionModal").classList.add("hidden");
                this.clearInstitutionForm();
            });

        document
            .getElementById("cancelInstitution")
            .addEventListener("click", () => {
                document.getElementById("institutionModal").classList.add("hidden");
                this.clearInstitutionForm();
            });

        document.getElementById("applyFilters").addEventListener("click", () => {
            this.applyCombinedFilters();
        });

        document.getElementById("resetFilters").addEventListener("click", () => {
            document
                .querySelectorAll('.filter-group-accordion input[type="checkbox"]')
                .forEach(cb => (cb.checked = false));

            const searchInput = document.getElementById("institutionSearch");
            if (searchInput) searchInput.value = '';

            this.displayInstitutions(this.allInstitutions);
        });

        document.getElementById("prevPageTop")?.addEventListener("click", () => {
            this.handlePrevPage();
        });
        document.getElementById("nextPageTop")?.addEventListener("click", () => {
            this.handleNextPage();
        });

        document.getElementById("prevPageBottom")?.addEventListener("click", () => {
            this.handlePrevPage();
        });
        document.getElementById("nextPageBottom")?.addEventListener("click", () => {
            this.handleNextPage();
        });

        document.querySelectorAll('.pagination').forEach(pagination => {
            pagination.addEventListener("click", (e) => {
                if (e.target.classList.contains('pagination-number')) {
                    const page = parseInt(e.target.dataset.page);
                    this.handlePageClick(page);
                }
            });
        });

        document.querySelectorAll(".accordion-toggle").forEach(btn => {
            btn.addEventListener("click", () => {
                btn.classList.toggle("active");
                const content = btn.nextElementSibling;
                content.classList.toggle("open");
            });
        });

        document.querySelectorAll('.type-filter-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                const btn = e.target;
                const type = btn.dataset.type;
                const allButtonType = 'all';

                if (type === allButtonType) {
                    const isActive = btn.classList.contains('active');
                    if (isActive) {
                        btn.classList.remove('active');
                        document.querySelectorAll('.type-filter-btn').forEach(b => b.classList.remove('active'));
                        document.querySelectorAll('.filter-group-accordion input[type="checkbox"]').forEach(cb => cb.checked = false);
                    } else {
                        document.querySelectorAll('.type-filter-btn').forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        document.querySelectorAll('.filter-group-accordion input[type="checkbox"]').forEach(cb => cb.checked = false);
                    }
                } else {
                    const allButton = document.querySelector(`.type-filter-btn[data-type="${allButtonType}"]`);
                    allButton.classList.remove('active');

                    btn.classList.toggle('active');

                    const checkbox = document.querySelector(`.filter-group-accordion input[type="checkbox"][value="${type}"]`);
                    if (checkbox) {
                        checkbox.checked = btn.classList.contains('active');
                    }

                    const activeButtons = Array.from(document.querySelectorAll('.type-filter-btn'))
                        .filter(b => b.dataset.type !== allButtonType && b.classList.contains('active'));
                    if (activeButtons.length === 0) {
                        allButton.classList.add('active');
                    }
                }

                this.applyCombinedFilters();
            });
        });

        const toggleFiltersBtn = document.getElementById("toggleFilters");
        const filtersPanel = document.getElementById("filtersSection");
        const filtersOverlay = document.getElementById("filtersOverlay");
        const applyFiltersBtn = document.getElementById("applyFilters");
        const resetFiltersBtn = document.getElementById("resetFilters");

        if (toggleFiltersBtn && filtersPanel && filtersOverlay) {
            toggleFiltersBtn.addEventListener("click", () => {
                filtersPanel.classList.add("active");
                filtersOverlay.classList.add("active");
                document.body.style.overflow = "hidden";
            });

            filtersOverlay.addEventListener("click", () => {
                filtersPanel.classList.remove("active");
                filtersOverlay.classList.remove("active");
                document.body.style.overflow = "";
            });
        }
        if (applyFiltersBtn) {
            applyFiltersBtn.addEventListener("click", () => {
                filtersPanel.classList.remove("active");
                filtersOverlay.classList.remove("active");
                document.body.style.overflow = "";
            });
        }

        if (resetFiltersBtn) {
            resetFiltersBtn.addEventListener("click", () => {
                filtersPanel.classList.remove("active");
                filtersOverlay.classList.remove("active");
                document.body.style.overflow = "";
            });
        }
    }
}
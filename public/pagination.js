// pagination.js
class Pagination extends FilterManager {
    constructor() {
        super();
        this.currentPage = 1;
        this.itemsPerPage = 10;
        this.totalPages = 0;
        this.displayedInstitutionsFull = [];
    }

    displayInstitutions(institutions) {
        this.totalPages = Math.ceil(institutions.length / this.itemsPerPage);
        this.currentPage = 1;

        const debugInfo = document.getElementById("debugInfo");
        const institutionCount = document.getElementById("institutionCount");

        if (institutionCount) {
            institutionCount.textContent = `(${institutions.length})`;
        }

        if (institutions.length === 0) {
            document.getElementById("institutionsList").innerHTML = '<p class="text-muted">Учреждения не найдены</p>';

            const paginationTop = document.getElementById("paginationTop");
            const paginationBottom = document.getElementById("paginationBottom");
            if (paginationTop) paginationTop.classList.add("hidden");
            if (paginationBottom) paginationBottom.classList.add("hidden");
            if (debugInfo) debugInfo.style.display = 'none';
            return;
        }

        if (debugInfo) {
            debugInfo.style.display = 'block';
        }

        this.displayedInstitutionsFull = institutions.slice();
        this.totalPages = Math.ceil(this.displayedInstitutionsFull.length / this.itemsPerPage);
        this.currentPage = 1;

        this.showCurrentPage();
        this.updatePagination();
    }

    showCurrentPage() {
        const source = Array.isArray(this.displayedInstitutionsFull) ? this.displayedInstitutionsFull : [];
        const startIndex = (this.currentPage - 1) * this.itemsPerPage;
        const endIndex = startIndex + this.itemsPerPage;
        this.displayedInstitutions = source.slice(startIndex, endIndex);

        const list = document.getElementById("institutionsList");
        const debugInfo = document.getElementById("debugInfo");

        if (this.displayedInstitutions.length === 0) {
            list.innerHTML = '<p class="text-muted">Учреждения не найдены</p>';
            if (debugInfo) debugInfo.style.display = 'none';
        } else {
            list.innerHTML = this.displayedInstitutions.map((inst) => this.createInstitutionCard(inst)).join('');
            if (debugInfo) debugInfo.style.display = 'block';

            if (debugInfo) {
                const start = startIndex + 1;
                const end = Math.min(endIndex, source.length);
                debugInfo.textContent = `Показано ${start}-${end} из ${source.length} учреждений (Страница ${this.currentPage} из ${this.totalPages})`;
            }
        }

        if (this.isAdmin) {
            this.bindAdminActions();
        }
    }

    updatePagination() {
        const paginationTop = document.getElementById("paginationTop");
        const paginationBottom = document.getElementById("paginationBottom");
        const numbersTop = document.getElementById("paginationNumbersTop");
        const numbersBottom = document.getElementById("paginationNumbersBottom");

        if (!paginationTop || !paginationBottom || !numbersTop || !numbersBottom) {
            console.error('Pagination elements not found');
            return;
        }

        if (this.totalPages <= 1) {
            paginationTop.classList.add("hidden");
            paginationBottom.classList.add("hidden");
            return;
        }

        paginationTop.classList.remove("hidden");
        paginationBottom.classList.remove("hidden");

        numbersTop.innerHTML = this.generatePaginationNumbers();
        numbersBottom.innerHTML = this.generatePaginationNumbers();

        this.updatePaginationButtons();
    }

    updatePaginationButtons() {
        const prevButtons = document.querySelectorAll('.pagination-prev');
        const nextButtons = document.querySelectorAll('.pagination-next');

        prevButtons.forEach(btn => {
            if (btn) btn.disabled = this.currentPage === 1;
        });

        nextButtons.forEach(btn => {
            if (btn) btn.disabled = this.currentPage === this.totalPages;
        });
    }

    generatePaginationNumbers() {
        const current = this.currentPage;
        const total = this.totalPages;

        if (total <= 5) {
            return Array.from({ length: total }, (_, i) => i + 1)
                .map((page) => this.createPageButton(page, page === current))
                .join("");
        }

        let pages = [];
        pages.push(1);

        let start = Math.max(2, current - 1);
        let end = Math.min(total - 1, current + 1);

        if (current <= 3) {
            end = Math.min(4, total - 1);
        } else if (current >= total - 2) {
            start = Math.max(total - 3, 2);
        }

        if (start > 2) pages.push("...");
        for (let i = start; i <= end; i++) pages.push(i);
        if (end < total - 1) pages.push("...");
        if (total > 1) pages.push(total);

        return pages
            .map((page) => {
                if (page === "...")
                    return `<span class="pagination-ellipsis">...</span>`;
                return this.createPageButton(page, page === current);
            })
            .join("");
    }

    createPageButton(page, isActive = false) {
        return `<button class="pagination-number ${isActive ? "active" : ""
            }" data-page="${page}">${page}</button>`;
    }

    handlePrevPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.showCurrentPage();
            this.updatePagination();
            this.scrollToInstitutions();
        }
    }

    handleNextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.showCurrentPage();
            this.updatePagination();
            this.scrollToInstitutions();
        }
    }

    handlePageClick(page) {
        if (page !== this.currentPage) {
            this.currentPage = page;
            this.showCurrentPage();
            this.updatePagination();
            this.scrollToInstitutions();
        }
    }

    scrollToInstitutions() {
        const institutionsSection = document.querySelector(".institutions-section");
        if (institutionsSection) {
            institutionsSection.scrollIntoView({
                behavior: "smooth",
                block: "start",
            });
        }
    }
}
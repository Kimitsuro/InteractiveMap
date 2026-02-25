// district-handler.js
class DistrictHandler extends MapLoader {
    handleDistrictClick(e, districtName) {
        this.currentDistrictName = districtName;
        this.openDistrictModal(districtName);
    }

    openDistrictModal(districtName) {
        document.getElementById("districtModal").classList.remove("hidden");
        document.getElementById('regionName').textContent = districtName;
        const districtId = this.districtIdMap[districtName];
        this.loadRegionLinks(districtId);

        this.loadInstitutionsForDistrict(districtName);
        const searchInput = document.getElementById("institutionSearch");
        this.resetFiltersUI();
        if (searchInput) searchInput.value = '';
        this.loadDistrictSVG(districtName);
    }

    async loadDistrictSVG(districtName) {
        const svgModal = document.querySelector("#districtModal .region-image");
        if (!svgModal) return;

        try {
            const mainSvg = document.querySelector("#mapWrapper svg");
            if (!mainSvg) return;

            let regionGroup = mainSvg.querySelector(
                `g[data-region-name="${districtName}"]`
            );
            if (!regionGroup && districtName === "Липецк (город)") {
                regionGroup = mainSvg.querySelector("#lipeck");
            }
            if (!regionGroup && districtName === "г. Елец") {
                regionGroup = mainSvg.querySelector("#elets");
            }

            if (regionGroup) {
                const clone = regionGroup.cloneNode(true);
                const polygon = clone.querySelector("polygon");

                if (polygon) {
                    const a = 1.4420655,
                        b = 0,
                        c = 0,
                        d = 1.4420655,
                        e = -45.179089,
                        f = -121.84611;
                    const pointsStr = polygon.getAttribute("points");
                    const pointPairs = pointsStr.match(/[0-9.-]+,[0-9.-]+/g) || [];

                    let txs = [],
                        tys = [];
                    pointPairs.forEach((pair) => {
                        const [xStr, yStr] = pair.split(",");
                        const x = parseFloat(xStr),
                            y = parseFloat(yStr);
                        const tx = a * x + c * y + e;
                        const ty = b * x + d * y + f;
                        txs.push(tx);
                        tys.push(ty);
                    });

                    if (txs.length > 0) {
                        const minX = Math.min(...txs);
                        const maxX = Math.max(...txs);
                        const minY = Math.min(...tys);
                        const maxY = Math.max(...tys);
                        const w = maxX - minX;
                        const h = maxY - minY;
                        const padding = 0.05;
                        const offsetX = padding * w;
                        const offsetY = padding * h;
                        const paddedW = w + 2 * offsetX;
                        const paddedH = h + 2 * offsetY;

                        svgModal.setAttribute("viewBox", `0 0 ${paddedW} ${paddedH}`);
                        svgModal.setAttribute("preserveAspectRatio", "xMidYMid meet");

                        const newPoints = [];
                        for (let i = 0; i < pointPairs.length; i++) {
                            const nx = txs[i] - minX + offsetX;
                            const ny = tys[i] - minY + offsetY;
                            newPoints.push(`${nx.toFixed(2)},${ny.toFixed(2)}`);
                        }

                        polygon.setAttribute("points", newPoints.join(" "));
                        clone.removeAttribute("transform");
                        polygon.style.fill = this.districtColors[districtName];
                        polygon.style.stroke = "black";
                        polygon.style.strokeWidth = "2";
                        polygon.classList.add("region");

                        svgModal.innerHTML = "";
                        svgModal.appendChild(clone);
                        return;
                    }
                }

                svgModal.innerHTML = "";
                svgModal.appendChild(clone);
            } else {
                svgModal.innerHTML =
                    '<text x="50%" y="50%" text-anchor="middle" dy=".3em" fill="#27ae60" font-size="16">SVG не найден</text>';
            }
        } catch (error) {
            console.error("Error loading district SVG:", error);
            svgModal.innerHTML =
                '<text x="50%" y="50%" text-anchor="middle" dy=".3em" fill="#e74c3c" font-size="16">Ошибка загрузки</text>';
        }
    }

    async loadRegionLinks(districtId) {
        const linksDiv = document.getElementById('regionLinks');
        if (!linksDiv) return;
        linksDiv.innerHTML = '';

        try {
            const response = await fetch(`/api/get_links.php?district_id=${districtId}`);
            if (!response.ok) throw new Error('HTTP ' + response.status);
            const data = await response.json();
            if (data.links && data.links.length > 0) {
                linksDiv.innerHTML = data.links.map(link =>
                    `<a href="${link.linktoinstitution}" target="_blank" class="region-link">${link.linksto}</a>`
                ).join('<br>');
            }
        } catch (e) {
            linksDiv.innerHTML = '<span class="text-muted">Нет ссылок для региона</span>';
        }
    }

    resetFiltersUI() {
        document.querySelectorAll('.filter-group-accordion input[type="checkbox"]').forEach((cb) => {
            cb.checked = false;
        });
        this.closeAllAccordions();
    }

    closeAllAccordions() {
        const accordionToggles = document.querySelectorAll(".accordion-toggle");
        const accordionContents = document.querySelectorAll(".accordion-content");

        accordionToggles.forEach(toggle => {
            toggle.classList.remove("active");
        });

        accordionContents.forEach(content => {
            content.classList.remove("open");
        });
    }
}
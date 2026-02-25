// map-loader.js
class MapLoader extends LipetskMapBase {
    async loadMap() {
        try {
            const response = await fetch("map.svg");
            const svgText = await response.text();
            const mapWrapper = document.getElementById("mapWrapper");
            mapWrapper.innerHTML = svgText;
            this.setupMapInteractivity();
        } catch (error) {
            console.error("Error loading map:", error);
            document.getElementById("mapWrapper").innerHTML = '<p class="text-center text-muted">Ошибка загрузки карты</p>';
        }
    }

    setupMapInteractivity() {
        const svg = document.querySelector("#mapWrapper svg");
        if (!svg) return;

        const groups = svg.querySelectorAll("g[id][data-region-name]");
        const originalOrder = Array.from(groups);
        const colors = [
            "#e57878", "#d88953", "#f7dc71", "#cfe672",
            "#8ee157", "#81ec81", "#60e094", "#84f2dc",
            "#7cc6d8", "#66a2fd", "#7171f8", "#b98cfb",
            "#b956d2", "#ea7cd4", "#f14d8f", "#FF6347",
            "#D2B48C", "#87CEEB", "#9932CC", "#FF69B4",
        ];

        let hideTimeout;
        groups.forEach((group, index) => {
            const regionId = group.id;
            const regionName =
                group.getAttribute("data-region-name") ||
                this.getDistrictName(regionId);
            const color = colors[index % colors.length];
            this.districtColors[regionName] = color;
            const polygons = group.querySelectorAll("polygon, path, circle, rect");

            polygons.forEach((polygon) => {
                if (!polygon.id) {
                    polygon.id = `${regionId}-shape-${index}`;
                }
                polygon.classList.add("district");
                polygon.style.fill = color;
                polygon.setAttribute("tabindex", "0");
                polygon.setAttribute("role", "button");

                if (!this.animationPlayed) {
                    polygon.style.transform = "scale(0)";
                    polygon.style.opacity = "0";
                    polygon.style.transition = "transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.4s ease-out";
                }

                this.districts[polygon.id] = {
                    name: regionName,
                    element: polygon,
                    group: group,
                };

                polygon.addEventListener("click", (e) => {
                    e.stopPropagation();
                    this.handleDistrictClick(e, regionName);
                });

                polygon.addEventListener("mouseenter", (e) => {
                    e.stopPropagation();
                    if (hideTimeout) clearTimeout(hideTimeout);
                    this.showTooltip(e, regionName);
                });

                polygon.addEventListener("mouseout", (e) => {
                    e.stopPropagation();
                    hideTimeout = setTimeout(() => {
                        this.hideTooltip();
                    }, 100);
                });

                polygon.addEventListener("mousemove", (e) => {
                    e.stopPropagation();
                    this.updateTooltipPosition(e);
                });

                polygon.addEventListener("keydown", (e) => {
                    if (e.key === "Enter" || e.key === " ") {
                        e.preventDefault();
                        e.stopPropagation();
                        this.handleDistrictClick(e, regionName);
                    }
                });
            });
        });

        if (!this.animationPlayed) {
            setTimeout(() => {
                this.animateDistrictsAppearance();
                this.animationPlayed = true;
            }, 300);
        }
    }

    animateDistrictsAppearance() {
        const svg = document.querySelector("#mapWrapper svg");
        if (!svg) return;

        const districts = svg.querySelectorAll(".district");
        const centerX = svg.viewBox.baseVal.width / 2;
        const centerY = svg.viewBox.baseVal.height / 2;

        districts.forEach((district, index) => {
            const bbox = district.getBBox();
            const districtCenterX = bbox.x + bbox.width / 2;
            const districtCenterY = bbox.y + bbox.height / 2;

            const deltaX = districtCenterX - centerX;
            const deltaY = districtCenterY - centerY;
            const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
            const directionX = deltaX / distance;
            const directionY = deltaY / distance;

            const startOffset = Math.min(distance * 0.1, 50);

            district.style.transition = 'transform 0.8s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.6s ease-out';
            district.style.transform = `translate(${directionX * startOffset}px, ${directionY * startOffset}px) scale(0.8)`;
            district.style.opacity = "0";

            setTimeout(() => {
                district.style.transform = "translate(0, 0) scale(1)";
                district.style.opacity = "1";

                setTimeout(() => {
                    district.style.transition = 'transform 0.3s ease-out, filter 0.3s ease-out, stroke-width 0.3s ease-out';
                }, 800);
            }, 100 + index * 40);
        });
    }

    populateLegend() {
        const legendList = document.getElementById("legendList");
        if (!legendList) return;

        const sortedDistricts = Object.values(this.districts).sort();
        legendList.innerHTML = sortedDistricts
            .map((name) => {
                const color = this.districtColors[name];
                return `
          <li class="legend-item" data-district-name="${name}">
            <div class="color-swatch" style="background-color: ${color};"></div>
            <span>${name}</span>
          </li>
        `;
            })
            .join("");
        document.querySelectorAll(".legend-item").forEach((item) => {
            item.addEventListener("click", () => {
                const name = item.dataset.districtName;
                this.currentDistrictName = name;
                this.openDistrictModal(name);
            });
        });
    }

    showTooltip(e, districtName) {
        const tooltip = document.getElementById("tooltip");
        tooltip.textContent = districtName;
        tooltip.classList.remove("hidden");
    }

    hideTooltip() {
        document.getElementById("tooltip").classList.add("hidden");
    }

    updateTooltipPosition(e) {
        const tooltip = document.getElementById("tooltip");
        if (!tooltip) return;

        tooltip.style.left = (e.clientX + 20) + "px";
        tooltip.style.top = (e.clientY - 20) + "px";
    }
}
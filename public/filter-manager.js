// filter-manager.js
class FilterManager extends InstitutionManager {
    constructor() {
        super();
        this.currentPage = 1;
        this.itemsPerPage = 10;
        this.totalPages = 0;
        this.allInstitutions = [];
        this.displayedInstitutions = [];
    }

    applyCombinedFilters() {
        const searchInput = document.getElementById("institutionSearch");
        const searchTerm = searchInput ? searchInput.value.trim() : "";
        const q = this.normalizeString(searchTerm);

        const selectedTypes = Array.from(
            document.querySelectorAll('.filter-group-accordion input[value^="preschool"], .filter-group-accordion input[value^="school"], .filter-group-accordion input[value^="spo"], .filter-group-accordion input[value^="vo"]')
        )
            .filter(cb => cb.checked)
            .map(cb => cb.value);

        const selectedAges = Array.from(
            document.querySelectorAll('.filter-group-accordion input[value^="1.5-"], .filter-group-accordion input[value^="3-"], .filter-group-accordion input[value^="5-"], .filter-group-accordion input[value^="7+"]')
        )
            .filter(cb => cb.checked)
            .map(cb => cb.value);

        const selectedConditions = Array.from(
            document.querySelectorAll('.filter-group-accordion input[value="hearing_impairment"], .filter-group-accordion input[value="vision_impairment"], .filter-group-accordion input[value="musculoskeletal_impairment"], .filter-group-accordion input[value="speech_impairment"], .filter-group-accordion input[value="mental_retardation"], .filter-group-accordion input[value="autism"], .filter-group-accordion input[value="multiple_disorders"]')
        )
            .filter(cb => cb.checked)
            .map(cb => cb.value);

        const aoopSelected = document.querySelector('.filter-group-accordion input[value="aoop"]:checked');

        const synonyms = {
            preschool: ['детсад', 'детскийсад', 'садик', 'дс', 'сад'],
            school: ['школа', 'шк', 'сош', 'лицей', 'гимназия'],
            school_internat: ['интернат', 'школаинтернат'],
            spo: ['спо', 'техникум', 'колледж', 'училище'],
            vo: ['во', 'вуз', 'университет', 'институт', 'академия']
        };

        const numberMatch = (searchTerm || '').match(/\d+/);
        const queryNumber = numberMatch ? numberMatch[0] : null;

        const source = Array.isArray(this.allInstitutions) ? this.allInstitutions : [];

        const filtered = source.filter(inst => {
            if (selectedTypes.length && !selectedTypes.includes(inst.type)) return false;

            if (selectedAges.length && inst.range_min && inst.range_max) {
                const matchAge = selectedAges.some(age => {
                    if (age.includes('-')) {
                        const [minStr, maxStr] = age.split('-');
                        const min = parseFloat(minStr);
                        const max = parseFloat(maxStr);

                        if (age === "1.5-3") {
                            return inst.range_min <= max && inst.range_max >= min;
                        } else {
                            return inst.range_min <= max && inst.range_max >= min;
                        }
                    } else if (age.includes('+')) {
                        const min = parseInt(age);
                        return inst.range_max >= min;
                    }
                    return false;
                });
                if (!matchAge) return false;
            }

            if (selectedConditions.length) {
                const hasCond = inst.conditions?.some(c => selectedConditions.includes(c));
                if (!hasCond) return false;
            }

            if (aoopSelected && (!inst.aoop_programs || inst.aoop_programs.length === 0)) return false;

            if (!q) return true;

            const name = this.normalizeString(inst.name || '');
            const desc = this.normalizeString(inst.description || '');
            const director = this.normalizeString((inst.director && (inst.director.name || inst.director.full_name)) || '');
            const website = this.normalizeString(inst.website || '');
            const instNumber = (inst.name || '').match(/\d+/)?.[0] || null;

            if (name.includes(q) || desc.includes(q) || director.includes(q) || website.includes(q)) return true;
            if (queryNumber && instNumber && instNumber === queryNumber) return true;

            for (const [type, words] of Object.entries(synonyms)) {
                for (const w of words) {
                    if (this.normalizeString(searchTerm).includes(w) && inst.type === type) {
                        if (!queryNumber) return true;
                        if (instNumber && queryNumber === instNumber) return true;
                    }
                }
            }
            return false;
        });

        this.displayInstitutions(filtered);
    }

    normalizeString(str) {
        if (!str) return '';
        return String(str)
            .toLowerCase()
            .replace(/ё/g, 'е')
            .replace(/№/g, '')
            .replace(/[^a-zа-я0-9]/gi, '');
    }

    debounce(fn, delay = 250) {
        let timer;
        return (...args) => {
            clearTimeout(timer);
            timer = setTimeout(() => fn.apply(this, args), delay);
        };
    }
}
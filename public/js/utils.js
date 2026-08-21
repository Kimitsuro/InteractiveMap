// ============================================================
// utils.js — Вспомогательные методы LipetskMap
// ============================================================

Object.assign(LipetskMap.prototype, {
    showPageLoader() {
      const pageLoader = document.getElementById("pageLoader");
      if (pageLoader) {
        pageLoader.style.display = 'flex';
      }
    },
  
    hidePageLoader() {
      const pageLoader = document.getElementById("pageLoader");
      if (pageLoader) {
        pageLoader.style.opacity = '0';
        setTimeout(() => {
          pageLoader.style.display = 'none';
        }, 300);
      }
    },
  
    showModalLoader() {
      const modalLoader = document.getElementById("modalLoader");
      if (modalLoader) {
        modalLoader.classList.remove("hidden");
      }
    },
  
    hideModalLoader() {
      const modalLoader = document.getElementById("modalLoader");
      if (modalLoader) {
        modalLoader.classList.add("hidden");
      }
    },
  
    normalizeString(str) {
      if (typeof StringUtils !== 'undefined') {
        return StringUtils.normalizeString(str);
      }
      if (!str) return '';
      return String(str)
        .toLowerCase()
        .replace(/ё/g, 'е')
        .replace(/№/g, '')
        .replace(/[^a-zа-я0-9]/gi, '');
    },
  
    debounce(fn, delay = 250) {
      let timer;
      return (...args) => {
        clearTimeout(timer);
        timer = setTimeout(() => fn.apply(this, args), delay);
      };
    },

    getDistrictNameVariants(name) {
      if (!name) return [];
      const variants = new Set([name]);
      if (/ округ$/u.test(name)) {
        variants.add(name.replace(/ округ$/u, ' район'));
      }
      if (/ район$/u.test(name)) {
        variants.add(name.replace(/ район$/u, ' округ'));
      }
      return [...variants];
    },

    registerDistrictIdMapping(name, id) {
      this.getDistrictNameVariants(name).forEach((variant) => {
        this.districtIdMap[variant] = id;
      });
    },

    resolveDistrictId(name) {
      for (const variant of this.getDistrictNameVariants(name)) {
        if (this.districtIdMap[variant] != null) {
          return this.districtIdMap[variant];
        }
      }
      return null;
    },

    resolveMapDistrictName(name) {
      for (const variant of this.getDistrictNameVariants(name)) {
        if (this.districtColors[variant]) {
          return variant;
        }
      }
      return name;
    },

    getDistrictColor(name) {
      for (const variant of this.getDistrictNameVariants(name)) {
        if (this.districtColors[variant]) {
          return this.districtColors[variant];
        }
      }
      return '#cccccc';
    },

    getListPage() {
      const modal = document.getElementById('districtModal');
      const fromDataset = modal?.dataset.listPage ? parseInt(modal.dataset.listPage, 10) : null;
      const page = fromDataset || this.listPage || this.currentPage || 1;
      return Number.isFinite(page) && page > 0 ? page : 1;
    },

    setListPage(page) {
      const normalized = Math.max(1, parseInt(page, 10) || 1);
      this.listPage = normalized;
      this.currentPage = normalized;
      const modal = document.getElementById('districtModal');
      if (modal) {
        modal.dataset.listPage = String(normalized);
      }
      return normalized;
    },

    // Коды районных центров Липецкой области (5 цифр + 5 цифр номера).
    // Липецк — отдельно: 4742 + 6 цифр.
    getLipetskDistrictAreaCodes() {
      return [
        '47461', // Грязи
        '47462', // Добринка
        '47463', // Доброе
        '47464', // Лев Толстой
        '47465', // Данков
        '47466', // Лебедянь
        '47467', // Елец
        '47468', // Долгоруково
        '47469', // Красное
        '47471', // Задонск
        '47472', // Усмань
        '47473', // Волово
        '47474', // Тербуны
        '47475', // Чаплыгин
        '47476', // Становое
        '47477', // Хлевное
        '47478', // Измалково
      ];
    },

    formatPhoneLocalPart(local) {
      if (local.length === 7) {
        return `${local.slice(0, 3)}-${local.slice(3, 5)}-${local.slice(5, 7)}`;
      }
      if (local.length === 6) {
        return `${local.slice(0, 2)}-${local.slice(2, 4)}-${local.slice(4, 6)}`;
      }
      if (local.length === 5) {
        return `${local.slice(0, 1)}-${local.slice(1, 3)}-${local.slice(3, 5)}`;
      }
      return local;
    },

    normalizePhone(phone) {
      if (!phone || !String(phone).trim()) {
        return null;
      }

      const value = String(phone).trim();
      if (/[^0-9+\s()\-–—]/u.test(value)) {
        throw new Error('Телефон содержит недопустимые символы. Разрешены только цифры, +, пробелы, скобки и дефисы.');
      }

      const hasPlus = value.startsWith('+');
      const digits = value.replace(/\D/g, '');

      if (!digits) {
        throw new Error('Укажите номер телефона цифрами.');
      }

      if (digits.length === 6 && !hasPlus && digits[0] !== '7' && digits[0] !== '8') {
        return digits;
      }

      let normalizedDigits = digits;
      if (normalizedDigits.length === 11 && normalizedDigits[0] === '8') {
        normalizedDigits = `7${normalizedDigits.slice(1)}`;
      }

      if (normalizedDigits.length === 11 && normalizedDigits[0] === '7') {
        return `+7${normalizedDigits.slice(1)}`;
      }

      if (normalizedDigits.length === 10) {
        return `+7${normalizedDigits}`;
      }

      if (hasPlus && value.startsWith('+7') && normalizedDigits.length === 11 && normalizedDigits[0] === '7') {
        return `+7${normalizedDigits.slice(1)}`;
      }

      throw new Error('Неверный формат телефона. Укажите +7 и 10 цифр или домашний номер из 6 цифр.');
    },

    formatPhoneForDisplay(phone) {
      if (!phone || !String(phone).trim()) {
        return phone || '';
      }

      let normalized;
      try {
        normalized = this.normalizePhone(phone);
      } catch {
        return String(phone);
      }

      if (!normalized) {
        return '';
      }

      if (/^\d{6}$/.test(normalized)) {
        return this.formatPhoneLocalPart(normalized);
      }

      const match = normalized.match(/^\+7(\d{10})$/);
      if (!match) {
        return String(phone);
      }

      const national = match[1];

      // Мобильный: +7 (9XX) XXX-XX-XX
      if (national[0] === '9') {
        return `+7 (${national.slice(0, 3)}) ${national.slice(3, 6)}-${national.slice(6, 8)}-${national.slice(8, 10)}`;
      }

      // Липецк: +7 (4742) XX-XX-XX
      if (national.startsWith('4742')) {
        return `+7 (4742) ${this.formatPhoneLocalPart(national.slice(4))}`;
      }

      // Районные центры области: +7 (474XX) X-XX-XX
      for (const area of this.getLipetskDistrictAreaCodes()) {
        if (national.startsWith(area)) {
          return `+7 (${area}) ${this.formatPhoneLocalPart(national.slice(5))}`;
        }
      }

      // Прочий городской: +7 (XXX) XXX-XX-XX
      return `+7 (${national.slice(0, 3)}) ${national.slice(3, 6)}-${national.slice(6, 8)}-${national.slice(8, 10)}`;
    },

    getInvalidPhoneCharacters(value) {
      return [...new Set(String(value).replace(/[0-9+\s()\-–—]/gu, '').split(''))].filter(Boolean);
    },

    formatEmailForDisplay(email) {
      if (!email || !email.includes('@')) return email || '';
      const at = email.indexOf('@');
      const local = email.slice(0, at);
      const domain = email.slice(at + 1);
      const decodedDomain = domain.split('.').map((label) => {
        if (!/^xn--/i.test(label)) return label;
        const unicode = this.decodePunycodeLabel(label.slice(4));
        return unicode !== null ? unicode : label;
      }).join('.');
      return `${local}@${decodedDomain}`;
    },

    decodePunycodeLabel(input) {
      const BASE = 36;
      const T_MIN = 1;
      const T_MAX = 26;
      const SKEW = 38;
      const DAMP = 700;
      const INITIAL_BIAS = 72;
      const INITIAL_N = 128;

      const adapt = (delta, numPoints, firstTime) => {
        let d = firstTime ? Math.floor(delta / DAMP) : delta >> 1;
        d += Math.floor(d / numPoints);
        let k = 0;
        while (d > ((BASE - T_MIN) * T_MAX) >> 1) {
          d = Math.floor(d / (BASE - T_MIN));
          k += BASE;
        }
        return k + Math.floor(((BASE - T_MIN + 1) * d) / (d + SKEW));
      };

      let output = [];
      let n = INITIAL_N;
      let bias = INITIAL_BIAS;
      let i = 0;
      const delim = input.lastIndexOf('-');
      if (delim > 0) {
        output = [...input.slice(0, delim)];
      }
      let idx = delim + 1;

      while (idx < input.length) {
        const oldi = i;
        let w = 1;
        for (let k = BASE; ; k += BASE) {
          if (idx >= input.length) return null;
          const cp = input.charCodeAt(idx++);
          let digit;
          if (cp >= 48 && cp <= 57) digit = cp - 22;
          else if (cp >= 65 && cp <= 90) digit = cp - 65;
          else if (cp >= 97 && cp <= 122) digit = cp - 97;
          else return null;
          i += digit * w;
          const t = k <= bias ? T_MIN : Math.min(T_MAX, k - bias);
          if (digit < t) break;
          w *= BASE - t;
        }
        const outLen = output.length + 1;
        bias = adapt(i - oldi, outLen, oldi === 0);
        n += Math.floor(i / outLen);
        i %= outLen;
        output.splice(i, 0, String.fromCodePoint(n));
        i++;
      }
      return output.join('');
    },

    escapeHtml(text) {
      if (typeof StringUtils !== 'undefined') {
        return StringUtils.escapeHtml(text);
      }
      if (text == null) return '';
      return String(text)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
    },

    sanitizeUrl(url) {
      if (typeof StringUtils !== 'undefined') {
        return StringUtils.sanitizeUrl(url);
      }
      if (!url) return '';
      try {
        const parsed = new URL(String(url).trim());
        if (parsed.protocol === 'http:' || parsed.protocol === 'https:') {
          return parsed.href;
        }
      } catch {
        return '';
      }
      return '';
    },

    renderTruncatedLink(url, className = 'external-link') {
      const safeUrl = this.sanitizeUrl(url);
      if (!safeUrl) return '';
      const safe = this.escapeHtml(safeUrl);
      return `<a href="${safe}" target="_blank" rel="noopener noreferrer" class="${className}" title="${safe}">${safe}</a>`;
    },

    expandMedicalAbbreviations(text) {
      if (!text) return text;
      const replacements = [
        [/\(РАС\)/g, '(расстройство аутистического спектра)'],
        [/\(ЗПР\)/g, '(задержка психического развития)'],
        [/\(ТНР\)/g, '(тяжелые нарушения речи)'],
        [/\(ТМНР\)/g, '(тяжелые и множественные нарушения развития)'],
        [/\(ОВЗ\)/g, '(ограниченные возможности здоровья)'],
        [/\bс РАС\b/g, 'с расстройством аутистического спектра'],
        [/\bс ЗПР\b/g, 'с задержкой психического развития'],
        [/\bс ТНР\b/g, 'с тяжелыми нарушениями речи'],
        [/\bс ОВЗ\b/g, 'с ограниченными возможностями здоровья'],
        [/\bпрограмма РАС\b/gi, 'программа расстройства аутистического спектра'],
        [/\bпрограмма ЗПР\b/gi, 'программа задержки психического развития'],
        [/\bпрограмма ТНР\b/gi, 'программа тяжелых нарушений речи'],
        [/\bдля детей с РАС\b/gi, 'для детей с расстройством аутистического спектра'],
        [/\bдля детей с ЗПР\b/gi, 'для детей с задержкой психического развития'],
        [/\bдля детей с ТНР\b/gi, 'для детей с тяжелыми нарушениями речи'],
        [/\bобучающихся с РАС\b/gi, 'обучающихся с расстройством аутистического спектра'],
        [/\bобучающихся с ЗПР\b/gi, 'обучающихся с задержкой психического развития'],
        [/\bобучающихся с ТНР\b/gi, 'обучающихся с тяжелыми нарушениями речи'],
        [/\b, ТМНР\b/g, ', тяжелые и множественные нарушения развития'],
      ];
      let result = String(text);
      for (const [pattern, replacement] of replacements) {
        result = result.replace(pattern, replacement);
      }
      return result;
    },

    getInstitutionTypeLabel(type) {
      const labels = {
        preschool: 'Дошкольное образовательное учреждение',
        school: 'Общеобразовательная школа',
        school_internat: 'Школа-интернат',
        spo: 'Среднее профессиональное образование',
        vo: 'Высшее образование',
      };
      return labels[type] || type;
    },

    getConditionLabel(code) {
      const labels = {
        hearing_impairment: 'Нарушения слуха',
        vision_impairment: 'Нарушения зрения',
        musculoskeletal_impairment: 'Нарушения опорно-двигательного аппарата',
        speech_impairment: 'Нарушения речи',
        autism: 'Расстройство аутистического спектра',
        mental_retardation: 'Умственная отсталость',
        intellectual_impairment: 'Нарушение интеллекта',
        psychic_development_delay: 'Задержка психического развития',
        multiple_disorders: 'Множественные нарушения',
      };
      return labels[code] || code;
    },

    getAdmissionLabel(code) {
      const labels = {
        certificate: 'Свидетельство об обучении',
        attestat: 'Аттестат',
      };
      return labels[code] || code;
    },
  
  });